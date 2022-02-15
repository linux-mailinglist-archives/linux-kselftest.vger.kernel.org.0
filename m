Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08474B766F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiBOTdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 14:33:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiBOTdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 14:33:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79477C1CB8;
        Tue, 15 Feb 2022 11:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33202B818F3;
        Tue, 15 Feb 2022 19:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F63C340EB;
        Tue, 15 Feb 2022 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953619;
        bh=iV859f3/SUiq6YzUfzQsclkDUgox9qj54ZIp88l2Dc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m270OW0R9+gTAnPa9PyTkMQj4oayzBqtlZ+jtmRbENnEW7zsQcgn9BpjQyl7HKta3
         uaAIBtiXidKlSV6IU6I+NkrJUDxFTnNew7jR6v5WnKLxOxYYmsffyJkNxidGsOtdaH
         +8YPEWnzjqSYf+Y7GZzlWKw+Pr+jpqAvtwlpF8nRta3xSIP2XRxObqbG7Esg6sfcW1
         YHJxXRe6H26Sv5RaUeTva/LrHeSoVLVnLEcdk/zAisIKx91xBrEHKBqZFDxfRypHqI
         LCHPDnfAK+3VA3opocfZK8/tWZTKMTt2yA/bHtJ9Z18LrJquRqn/Cvu0QRqb/xiwf+
         TewWc7WSDMKMw==
Date:   Tue, 15 Feb 2022 20:34:13 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Remove extra newlines in test output
Message-ID: <YgwANUl7mIDkX8Po@iki.fi>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <699e4e1382e005386722bc296602d1b270a28b1e.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699e4e1382e005386722bc296602d1b270a28b1e.1643393473.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 10:23:59AM -0800, Reinette Chatre wrote:
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
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
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

Sorry for the super slow latency. The reason has been job transition, and
also getting SGX remote attestation to work with a non-Intel stack.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko



