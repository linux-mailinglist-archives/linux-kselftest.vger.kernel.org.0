Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8194A0047
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350559AbiA1SnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:43:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:22689 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237624AbiA1SnE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395384; x=1674931384;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0ttcunwAGH2xmbuztc03gm7UXUtl7LXOSyi4HYFHOU8=;
  b=RbThspp58cZB7OneL9TRh5TXomvx29rHKc/dQvlIUCfnNmpOqUidxlva
   uhk/swyJa578okLCi+ZyIGW1coMueSU3zHPS6u3h7unBTd5uIL0pPIZem
   WH4J6ILDoK6kP9mVqEP4pNH+m++61kjUIYBsQEg52PLgawFL23gFkqOrA
   UvyXqovT6sKIY8bxJn+nWMLVIvMtlqSprp9MxE2cvxxe8dZ4iAv7vMix4
   mMvqNOo4fg8xrkI+U6EO9WmDxgPr7QZ5tPgL9KSRutpl/UFPjONC9aZG6
   UaZzLM1FU75ZVCUN+eJwbtbk+TPKljMU7/33uKqayOt5fZd39PoQ7PUnh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307905373"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307905373"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:43:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697179925"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:43:03 -0800
Message-ID: <df2248d2-eb61-22d6-3a51-d8091f9eaad6@intel.com>
Date:   Fri, 28 Jan 2022 10:43:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/4] selftests/sgx: Fix segfault upon early test failure
In-Reply-To: <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 10:23, Reinette Chatre wrote:
> A segfault is encountered if there happens to be an
> early failure of any of the SGX tests. One way to
> reproduce this is to remove the enclave binary
> "test_encl.elf" that will trigger early enclave loading
> failure followed by a segfault.
> 
> The segfault occurs within encl_delete() that cleans up
> after an enclave by umapping its mapped regions and closing
> the file descriptor to the SGX driver. As integrated with
> the kselftest harness encl_delete() is called upon exit
> from every test, irrespective of test success. encl_delete()
> is also called to clean up if an error is encountered during
> enclave loading.
> 
> encl_delete() is thus responsible for cleaning any amount of
> enclave state - including state that has already been cleaned.
> 
> encl_delete() starts by accessing encl->segment_tbl that may
> not have been created yet due to a very early failure or may
> already be cleaned up because of a failure encountered after
> encl->segment_tbl was created.
> 
> Ensure encl->segment_tbl is valid before attempting to access
> memory offset from it. The offset with which it is accessed,
> encl->nr_segments, is initialized after encl->segment_tbl and
> thus considered valid to use after the encl->segment_tbl check
> succeeds.

I'm thinking we can be a bit more concise about the problem:

== Background ==

The SGX selftests track parts of the enclave binaries in an array:
encl->segment_tbl[].  That array is dynamically allocated early (but not
first) in the test's lifetime.  The array is referenced at the end of
the test in encl_delete().

== Problem ==

encl->segment_tbl[] can be NULL if the test fails before its allocation.
 That leads to a NULL-pointer-dereference in encl_delete().  This is
triggered during early failures of the selftest like if the enclave
binary ("test_encl.elf") is deleted.

--

I think it's also best to refer to this as a NULL-pointer problem rather
than a segfault.   The segfault is really just the fallout from the NULL
pointer, *not* the primary problem.

> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/sgx/load.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 9d4322c946e2..006b464c8fc9 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -21,7 +21,7 @@
>  
>  void encl_delete(struct encl *encl)
>  {
> -	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> +	struct encl_segment *heap_seg;
>  
>  	if (encl->encl_base)
>  		munmap((void *)encl->encl_base, encl->encl_size);
> @@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
>  	if (encl->fd)
>  		close(encl->fd);
>  
> -	munmap(heap_seg->src, heap_seg->size);
> -
> -	if (encl->segment_tbl)
> +	if (encl->segment_tbl) {
> +		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> +		munmap(heap_seg->src, heap_seg->size);

This probably deserves a comment linking heap_seg->src and
encl->segment_tbl together. They _look_ independent here.

>  		free(encl->segment_tbl);
> +	}
>  
>  	memset(encl, 0, sizeof(*encl));
>  }

