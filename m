Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0CE70C3A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjEVQl0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEVQlZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 12:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71D8F;
        Mon, 22 May 2023 09:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4F2619EB;
        Mon, 22 May 2023 16:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980EEC433EF;
        Mon, 22 May 2023 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684773683;
        bh=wOWjsw7FGhZJlOxCLfZT/zgyM2RvGweBByAEWOjqL98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVTAUwC8osMQC/P0zy2Vo+d0HMoNKdC1vjUp6tZZJvzDJcMzuHbUVrnGXlCYVl4ZC
         JZf1J+Moj4+FBb1J/sUOPMGdpgSp1gCaJatSHPviWQ3vXE/kMp7aRUUBrCh25+fM+h
         i/xHNftuyNO0C/0vm7OWfbe2dbcEPinNGMKmavxADKsqWIUE1XIJ5kfUnWflqdm1I1
         Uzg9Ox50+Z2mIrr+Or7DvMZjKguhj2o0jovHtzFstNHFX5OdVrxgJmMXXJ0S3vzOCi
         Ku4ZQFC7l62PqXqbDa0TnSsaIhPN53Mvv5OkxuDoDNByHHUZuaHZeUoyMr76BIG4FQ
         4MWCMbMlUrXAQ==
Date:   Mon, 22 May 2023 17:41:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, broonie@kernel.org
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
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
Message-ID: <20230522164117.GA6342@willie-the-truck>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516134447.GB30894@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Naresh,

On Tue, May 16, 2023 at 02:44:49PM +0100, Will Deacon wrote:
> On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > Following kernel BUG noticed while running selftests arm64 fp-stress
> > running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.
> 
> Is there a known-good build so that we could attempt a bisection?

FWIW, I've been trying (and failing) all day to reproduce this in QEMU.
I matched the same VL configuration as you have in the fastmodel and
tried enabling additional memory debugging options too, but I'm yet to
see a kfence splat (or any other splat fwiw).

How often do you see this?

Will
