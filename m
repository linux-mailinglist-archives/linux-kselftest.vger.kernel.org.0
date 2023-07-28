Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74F766208
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjG1CoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 22:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1CoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 22:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570C35B0;
        Thu, 27 Jul 2023 19:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598D561FB2;
        Fri, 28 Jul 2023 02:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AECC433C9;
        Fri, 28 Jul 2023 02:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690512192;
        bh=pm8EEJ3QVFbZRsnnFWhbHs7DxRk67vj7nVk7xzm5K6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JY3PNodbQLvsX/IukNSn5Vy8hxvOWmgmZbr57BdemunG/lL+U0h/YWYpcQqnNiRqs
         mxnwR/BO7w1OkCYLZx2dQtDyjf5FdlCcRWeHJLR3PL56T00W16VIjBaQiDOjdkh9/m
         aRtXi96h3XHUh1AXrzpgggQa2nBFAsKoUCLjV8crWrW8ThqmXF2PUbJb0vv40fCCkL
         BjGH0CVYHb7/4fpBAM3VQyp3+5BAQlznyNuwDqjJHO1CSxxiezQygfHrsqRDYgipl5
         Q+q38AFIpg3yybJUMpQaNW9jr5Jf2KT5UKwvNtjrIv1+Atw0zGmyxs3vDU3tsyopi6
         TE658BcOcHnzA==
Date:   Thu, 27 Jul 2023 19:43:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Message-ID: <20230727194311.6a51f285@kernel.org>
In-Reply-To: <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
        <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
        <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
        <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
        <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Jul 2023 01:38:40 +0000 Anjali Kulkarni wrote:
> Jakub,
> Do I need to revert the -f runtime filter option back to compile time
> and commit with that disabled so the selftest compiles on a kernel on
> which the new options are not defined?

I'm not 100% sure myself on what's the expectations for building
selftests against uAPI headers is..

I _think_ that you're supposed to add an -I$something to
the CFLAGS in your Makefile. KHDR_INCLUDES maybe? So that the uAPI
headers from the build get used (rendered by make headers).

Take a look at Documentation/dev-tools/kselftest.rst, I hope
the answer is somewhere there.
