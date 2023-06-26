Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3073E252
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFZOmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFZOmH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 10:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BEAE7E;
        Mon, 26 Jun 2023 07:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9670060EA5;
        Mon, 26 Jun 2023 14:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5BFC433C0;
        Mon, 26 Jun 2023 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687790525;
        bh=L52cfU8cNq6uou6/bZ8tK6hh1Kl1s94l1tWbXWw/lAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaBsPVWCxzitqlENhTyVt6B8OAjiMC63ES5TIBAf5vcRfKr6lyDTte7X/FyHa5pRv
         VxxxEHlepMRn+2kghdO9gvALQUPGC5HMx9jumJ6sJ7JCeBvjYoUtLhVDz4cP8UBwjA
         eFiUdCFrHqmb9wBnGpVf8R1IYsSx8RgBa1B6UDQSmKFZQdOEeXWNsemzlQF7TS3glk
         eWNaxmvrVbN0buJEbOogNS0MVoKxVjYHl1mBI4cUK66tvNVkHiDTUw2IqLCRm91RCl
         l5M1TiaU2ie3wIMPOuTlL5Gr5PYSj5me4V6tTgHy+DJE6/IIny9RDvpMg2CCmUR27p
         DHMJblcXS48DA==
Date:   Mon, 26 Jun 2023 15:41:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <20230626144157.GA20162@willie-the-truck>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <b4bfd69f-2092-4d15-b7ce-b814f5f10ff2@sirena.org.uk>
 <CA+G9fYv=uyQaJs0JLMmZWLeLH0G5FF7WGcTa7y0bi0nCDfoi+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv=uyQaJs0JLMmZWLeLH0G5FF7WGcTa7y0bi0nCDfoi+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 25, 2023 at 07:21:24PM +0530, Naresh Kamboju wrote:
> On Tue, 23 May 2023 at 03:42, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > > Test log links:
> > > ========
> > >
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/test/check-kernel-kfence/log
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/tests/
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.28-240-gb82733c0ff99/testrun/17007268/suite/kselftest-arm64/tests/
> > >
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/test/check-kernel-bug/log
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/tests/
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/kselftest-arm64/tests/
> >
> > None of these seem to provide me with information like what kernel
> > config was used but I did manage to find
> >
> >   https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/config
> >
> > which might be it?  Or one of them?  However even trying to use that I'm
> > unable to reproduce issues with either the FVP or qemu.
> 
> You got the right config file which we are using for testing
> FVP selftests.

Sadly, the config link above no longer works (404 file not found).

However, I notice that the failure still seems to occur with 6.4:

https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4/testrun/17767612/suite/log-parser-test/tests/

Please can you point me at the config file for that run? I can't figure
out which one I need from the web interface.

Will
