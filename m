Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A84BD127
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 21:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiBTUBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 15:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBTUBt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 15:01:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36B49F98;
        Sun, 20 Feb 2022 12:01:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD10360EFE;
        Sun, 20 Feb 2022 20:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D226C340E8;
        Sun, 20 Feb 2022 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645387287;
        bh=wg1p9stEmumoOoN0O4TSONQBrkXJ9MkXn8oRaQeXvMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gt4zYsBh1j5htQGIzMtRlLPM/A96SzCZWd1xpFqS3fFP2CNnlcPSFDBYFUT0SsFmG
         Qs5vwmvvcwCRNpg7mk/Lxu4UEQrTZW3NKnxq25U7HPnE/+VtN9V2BK6K65Hvsw+hPt
         xij6A8IUNiOFWhP4saLq4epR4suFcy+j3LzHyUm3Ufa+Ux4JNw0aYHS0Uhzx+O+Sz1
         bfwZ/0BY7quWSUAmYIBIfTi6o8PCa12xuecR72PJaeCNLtXvzSwU+SIjFpuL89vkjZ
         Iohfk+YGPTU+YY3RkP4PslaKf4CCJiCiYNGAjDsG5NhvZjZAaLdsZSJEASGULrSnGR
         TqkBPxSqFx3ug==
Date:   Sun, 20 Feb 2022 21:02:05 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon
 early test failure
Message-ID: <YhKePZv8tsgKYGfK@iki.fi>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 01, 2022 at 02:47:03PM -0800, Reinette Chatre wrote:
> == Background ==
> 
> The SGX selftests track parts of the enclave binaries in an array:
> encl->segment_tbl[]. That array is dynamically allocated early
> (but not first) in the test's lifetime. The array is referenced
> at the end of the test in encl_delete().
> 
> == Problem ==
> 
> encl->segment_tbl[] can be NULL if the test fails before its
> allocation. That leads to a NULL-pointer-dereference in encl_delete().
> This is triggered during early failures of the selftest like if the
> enclave binary ("test_encl.elf") is deleted.
> 
> == Solution ==
> 
> Ensure encl->segment_tbl[] is valid before attempting to access
> its members. The offset with which it is accessed, encl->nr_segments,
> is initialized before encl->segment_tbl[] and thus considered valid
> to use after the encl->segment_tbl[] check succeeds.
> 
> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Rewrite commit message (Dave).
> 
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

BR, Jarkko
