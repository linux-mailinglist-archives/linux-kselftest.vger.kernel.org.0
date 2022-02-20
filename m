Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A264BD0D0
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiBTTFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 14:05:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 14:05:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9894C7B0;
        Sun, 20 Feb 2022 11:05:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06C9C60EB4;
        Sun, 20 Feb 2022 19:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E299C340E8;
        Sun, 20 Feb 2022 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383900;
        bh=wWRwXjGz3j9MQhhwOBN0uya0GMecjvhd3lO/pLBB/ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOaouRpkDLfqg1AltY7pcTj3rzlZS8RABSiqwqPHcaEmdO/pk9GQF+EFjtkvd8thm
         13/Znf48URkiqCIuKulMT+ehsQ0/gqY845EPvztGnIqRSBhkAfeiacZAx9zjLT12he
         LO/r/HkXdGxJeXLvOSZbenZs2sI0GppWJA9ALX1DkAvaR8wtk4zqc5AUgNpTBcOp1u
         p/ZGAGcCF21tNhY8vAyIs49v/J7uZXDtyBK/KSRJ7WoMUkbCSvy2ZY6tdGDuvdv9XC
         xhxPGLBWJZG7jZnv7OKSmMdCDv0tM5NvR/lDBe4tPvnzvkbzUvDN77NxeNyllbM53T
         cW2Nj15kSdX6Q==
Date:   Sun, 20 Feb 2022 20:05:34 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 4/4] selftests/sgx: Remove extra newlines in test
 output
Message-ID: <YhKQ/i+Vx3BlkThT@iki.fi>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 01, 2022 at 02:47:06PM -0800, Reinette Chatre wrote:
> The TH_LOG() macro is an optional debug logging function made
> available by kselftest itself. When TH_LOG_ENABLED is set it
> prints the provided message with additional information and
> formatting that already includes a newline.
> 
> Providing a newline to the message printed by TH_LOG() results
> in a double newline that produces irregular test output.
> 
> Remove the unnecessary newlines from the text provided to
> TH_LOG().
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Add Acked-by from Dave.
> 
>  tools/testing/selftests/sgx/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index b0bd95a4730d..dd74fa42302e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -146,7 +146,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  
>  	if (!encl_load("test_encl.elf", encl, heap_size)) {
>  		encl_delete(encl);
> -		TH_LOG("Failed to load the test enclave.\n");
> +		TH_LOG("Failed to load the test enclave.");
>  		return false;
>  	}
>  
> @@ -204,7 +204,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  		fclose(maps_file);
>  	}
>  
> -	TH_LOG("Failed to initialize the test enclave.\n");
> +	TH_LOG("Failed to initialize the test enclave.");
>  
>  	encl_delete(encl);
>  
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
