Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDED4BD0CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiBTTDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 14:03:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTDz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 14:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C94377F5;
        Sun, 20 Feb 2022 11:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F65E60EC5;
        Sun, 20 Feb 2022 19:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03804C340E8;
        Sun, 20 Feb 2022 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383812;
        bh=HWIcNwmiZQcWWxwoRyqMSCbiA3SfghFbHTqekIDyJXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHvlNncTTJBe+4auGsKcHtIM2z+2wsVbp5uz8uIxNjDElpiTm+47NvH35H4U1HQTo
         1VNoWCEQvTTZ7m6Mk2BkhFs1hJHKVlMgIaatiZ+dVQNoiPnYIDj6m5PjVq+ujsD5xP
         5tcYYNtrsl3ZNxDSG+YREsBX5UgdCEDvIxxSBduA3eSyj7tcC7u0IstnauGn7khe5n
         XE8jGrrNnpIhSnBu7Iw9m8u4j55XjBETqGby73pWJI3J4NCELUs1E30OSvrpVFTQZ6
         yNlVDZuecUH6R3NPt6nzTcNh3KAmtpjgmatr735RoP17XtVlMo1JOnyUlEsrUqM7M+
         NctsAoxJQCNKw==
Date:   Sun, 20 Feb 2022 20:04:11 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 2/4] selftests/sgx: Do not attempt enclave build
 without valid enclave
Message-ID: <YhKQq0DsT7SN+CQz@iki.fi>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 01, 2022 at 02:47:04PM -0800, Reinette Chatre wrote:
> It is not possible to build an enclave if it was not possible to load
> the binary from which it should be constructed. Do not attempt
> to make further progress but instead return with failure. A
> "return false" from setup_test_encl() is expected to trip an
> ASSERT_TRUE() and abort the rest of the test.
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Add Acked-by from Dave.
> - Detail in commit log what callers will see with this change (Dave).
> 
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

BR, Jarkko
