Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9EA4B7559
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiBOTjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 14:39:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiBOTjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 14:39:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B7BF45;
        Tue, 15 Feb 2022 11:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978A561758;
        Tue, 15 Feb 2022 19:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE11C340EB;
        Tue, 15 Feb 2022 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953941;
        bh=nDxaLKVnY/Q/9k9SG0O1zGYGRkz0Ak4nfPyxLLVRLb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=buzQVg/FJm9sogfWwhGTDPsUi0xQCebq8s91at2pb9PynIW/zF7wKDVySEnrMBH28
         Q6fMoomCjjl4PQojHbf8SQhQas1IZn40RrLoTuaZtIPDsevy+7dEhn1xmx2ZzDJl79
         iQQyvHozMwKvYEeGDRARTtnKpmufL5INKPcNCRbmyg7U2/od0B1FeBQA26s+CBxKbK
         1QREHoEsNKltry1p3WJBQzdUGVrQ/fgsrnw3bq9eOEiK/pt3qrjgli0vId0H3+7cuj
         JSl9CURDFTLi2X6C0ZPvQ/9C7XeARjVnnM5qvpUpU/F9HnkWnw8NQB1e/NjFo8U2BG
         dBD5iWAgZ68Zw==
Date:   Tue, 15 Feb 2022 20:39:34 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests/sgx: Fix segfault upon early test failure
Message-ID: <YgwBdmOnIMCQBhwX@iki.fi>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 10:23:56AM -0800, Reinette Chatre wrote:
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

Nit: textwidth=75

Not something I would NAK but just saying.

> 
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
>  		free(encl->segment_tbl);
> +	}
>  
>  	memset(encl, 0, sizeof(*encl));
>  }
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org> 

I tested this by a minor code mod to trigger to failure case.

/Jarkko
