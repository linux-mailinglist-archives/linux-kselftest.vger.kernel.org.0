Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F904B76B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiBOTel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 14:34:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiBOTek (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 14:34:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B378EB91E9;
        Tue, 15 Feb 2022 11:34:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA20617A5;
        Tue, 15 Feb 2022 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C76C340EB;
        Tue, 15 Feb 2022 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953669;
        bh=F+cJp5xIaO0YVVFLhJNtK3an6SPGWlgzhsfPnZICwFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBS9ax5BUPFInXX6j5ShRoSpNCqNsHz6fo5Cqn9jM4kjfhTUh1sBryq0Z8PD7tITO
         RI7BBtdtwlv+5Vkp21wH+SUJfKAcQ4pti+BAA3/x/uRU9lOi2MffcxSB+G8cwL5ZZ6
         irxvRyqcA7fMGVEDP5KaKQloKTUIN2VRbd2V8bx7TFKVn3u465exd7TQc6yoE9gsHD
         2xRvoiorkvAwo8xLKC8HWnyqxRiL+FjipqZUZblU0cnNrAs9PruvSpPPAyuni21y+6
         HMx1ewrPWoBLAK/iCo3ZFEl0msahcbiP9Zcro6OTv7610p/SzJydXVw4I3Uh5SY5vn
         ujFyhHwoptKEg==
Date:   Tue, 15 Feb 2022 20:35:03 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests/sgx: Do not attempt enclave build without
 valid enclave
Message-ID: <YgwAZwk7hIVN/d30@iki.fi>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 10:23:57AM -0800, Reinette Chatre wrote:
> It is not possible to build an enclave if it was not possible to load
> the binary from which it should be constructed. Do not attempt
> to make further progress but instead return with failure.
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/sgx/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 370c4995f7c4..a7cd2c3e6f7e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  	if (!encl_load("test_encl.elf", encl, heap_size)) {
>  		encl_delete(encl);
>  		TH_LOG("Failed to load the test enclave.\n");
> +		return false;
>  	}
>  
>  	if (!encl_measure(encl))
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
