Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D94B78B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 21:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiBOTfV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 14:35:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiBOTfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 14:35:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE769B91E9;
        Tue, 15 Feb 2022 11:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44BB2B81C66;
        Tue, 15 Feb 2022 19:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E5CC340EB;
        Tue, 15 Feb 2022 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953708;
        bh=j3MB4eWyGs+b6k4/lCq/v3mpk3aMuCyi+sHhwEInd4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hj4fnlYc053KVhcFhbyhQAZmIlWxbU+bBwfbrJ4xk92Z6soYRDKXJgQPQd+VVpFnz
         H1kssRhM28lzyo2B8OprE2gIEma9ibmYeaOEVTZzXqKW6+0LPTK7BTxU8ZZLymsu2a
         +yd/+6pRhsxir/Ns67YJGrZK/nscByaqYy+xCzoukRkd3rFHJND3sX4HXgTpkmXd0l
         fs7YeIk2161IXneBTrMAG3JqxAwsunjihxA6Mp6GePUgXClwkNyab3fyOYu4SJhG0K
         L3p26kfPfw5FLSO7+XUzQUMeenkmkfpJMy9LLDgrk5sr8R07aOVIEOpjSGvltrGd2/
         9rgsaiNQs5G2A==
Date:   Tue, 15 Feb 2022 20:35:41 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/sgx: Ensure enclave data available during
 debug print
Message-ID: <YgwAjf7oauR4F54J@iki.fi>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 10:23:58AM -0800, Reinette Chatre wrote:
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
