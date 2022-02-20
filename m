Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861464BD0CF
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiBTTEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 14:04:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTEp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 14:04:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAE377F5;
        Sun, 20 Feb 2022 11:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18C76B80DB7;
        Sun, 20 Feb 2022 19:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06134C340E8;
        Sun, 20 Feb 2022 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383860;
        bh=/ilkU1mHc5LHes6Ux+N23fMJXwb/0J6ITgR8xnMYjLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNJ68/RMYX8peHBrWyPYiizwhiV+3bYryHU8K3Mzi1xtzm+wJjoqA/wSDZZohmqbg
         wSr0JbqVb/V1BLuIIZsyZ+KYTWHQAT+yAvJLUqmWClXzLsfJpMYfjbpOXByKjQhOy3
         XpcW9xTQKj/kTJYFxfIsUxJ9EOkI6hI+W4thwTIltB74kBgBvQcRN70CAPUg7Z4VQv
         7ajzGKOi8BOEMfAcbefOeIMdW6aFe+WBJ8Bz0xSgG701+rXG77Tt4Pk8jdpM/74S7N
         W4zcbn1r7CJi15zDEEJd2RFpr5tdrIsUJ0+3EB8kvz7tc/zfjKhpORMXueil/nkNZp
         mKwYqpX1N/jIQ==
Date:   Sun, 20 Feb 2022 20:04:59 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 3/4] selftests/sgx: Ensure enclave data available
 during debug print
Message-ID: <YhKQ29FLQYzVeDLQ@iki.fi>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaaeeb9122916d831942fc8a3043c687137314c1.1643754040.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 01, 2022 at 02:47:05PM -0800, Reinette Chatre wrote:
> In support of debugging the SGX tests print details from
> the enclave and its memory mappings if any failure is encountered
> during enclave loading.
> 
> When a failure is encountered no data is printed because the
> printing of the data is preceded by cleanup of the data.
> 
> Move the data cleanup after the data print.
> 
> Fixes: 147172148909 ("selftests/sgx: Dump segments and /proc/self/maps only on failure")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V1.
> 
>  tools/testing/selftests/sgx/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index a7cd2c3e6f7e..b0bd95a4730d 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -186,8 +186,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  	return true;
>  
>  err:
> -	encl_delete(encl);
> -
>  	for (i = 0; i < encl->nr_segments; i++) {
>  		seg = &encl->segment_tbl[i];
>  
> @@ -208,6 +206,8 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  
>  	TH_LOG("Failed to initialize the test enclave.\n");
>  
> +	encl_delete(encl);
> +
>  	return false;
>  }
>  
> -- 
> 2.25.1
> 

LGTM

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
