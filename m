Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127C4474BC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhLNTTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhLNTTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:19:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BA2C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60C40B81C68
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 19:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31013C34600;
        Tue, 14 Dec 2021 19:18:59 +0000 (UTC)
Date:   Tue, 14 Dec 2021 19:18:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Alan Hayward <alan.hayward@arm.com>
Subject: Re: (subset) [PATCH v7 00/37] arm64/sme: Initial support for the
 Scalable Matrix Extension
Message-ID: <YbjuIPRQkkIZ1cnY@arm.com>
References: <20211210184133.320748-1-broonie@kernel.org>
 <163950938829.2458221.13355977869770584914.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163950938829.2458221.13355977869770584914.b4-ty@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 07:17:09PM +0000, Catalin Marinas wrote:
> On Fri, 10 Dec 2021 18:40:56 +0000, Mark Brown wrote:
> > This series provides initial support for the ARMv9 Scalable Matrix
> > Extension (SME).  SME takes the approach used for vectors in SVE and
> > extends this to provide architectural support for matrix operations.  A
> > more detailed overview can be found in [1].
> > 
> > For the kernel SME can be thought of as a series of features which are
> > intended to be used together by applications but operate mostly
> > orthogonally:
> > 
> > [...]
> 
> Applied to arm64 (for-next/kselftest), thanks!
> 
> [04/37] kselftest/arm64: Parameterise ptrace vector length information
>         https://git.kernel.org/arm64/c/18edbb6b3259
> [05/37] kselftest/arm64: Allow signal tests to trigger from a function
>         https://git.kernel.org/arm64/c/9331a604858a
> [06/37] kselftest/arm64: Add a test program to exercise the syscall ABI
>         https://git.kernel.org/arm64/c/b77e995e3b96

I also applied patches 1-3 to for-next/sve but b4 doesn't remember more
than one instance of "b4 am" on the same series.

-- 
Catalin
