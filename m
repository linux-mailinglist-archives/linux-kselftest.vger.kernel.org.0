Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB44BD12C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiBTUGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 15:06:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiBTUGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 15:06:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612DC4B86F;
        Sun, 20 Feb 2022 12:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF3960EC5;
        Sun, 20 Feb 2022 20:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D6C340E8;
        Sun, 20 Feb 2022 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645387559;
        bh=2cppNPZpgF4RmbAOVD9rQTVohiAwNWLrRbqbsVsBqCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niY8cZECU6OPPbsI/aUzCuTvxDlM4M06j26qCpW1iJvk+u5ZIbu5zG9zBa+fHRz6W
         iaHf0opGsL/jVGiJLJkGPmAZK8XQrJa2nZQjZmbcbe+KqLZ3PJAP7pDvkx2vUs6XMg
         h7lYgq7x4D+r2ZMBUYqR+2hSbFbL7T916kkk09wr4GIfdAz1gXOxcpPdkYHFs0vcxM
         VPbzzWhb02h8+Lnim1LCf8I38zliBKlTulmXJs9DPzOpFimsO1d9214md+/8ivSYwK
         O8Mxrqhj7oMAn/y87NxFRcVTI2WQPMGuHWhzvjvUFX/4ZgBj75XYBpb0yXu81ve80T
         8CGWTIwoPARpA==
Date:   Sun, 20 Feb 2022 21:06:33 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        kernelci@groups.io, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 2/2] selftests: sgx: Treat CC as one argument
Message-ID: <YhKfSUXC/U1twT9h@iki.fi>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210190642.1477814-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 12:06:41AM +0500, Muhammad Usama Anjum wrote:
> CC can have multiple sub-strings like "ccache gcc". For check_cc.sh,
> CC needs to be treated like one argument. Put double quotes around it to
> make CC one string and hence one argument.
> 
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/sgx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 2956584e1e37f..75af864e07b65 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -4,7 +4,7 @@ include ../lib.mk
>  
>  .PHONY: all clean
>  
> -CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
> +CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
>  			    ../x86/trivial_64bit_program.c)
>  
>  ifndef OBJCOPY
> -- 
> 2.30.2
> 


Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
