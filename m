Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94E43466D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCWRy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 13:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhCWRyF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 13:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D61E619AE;
        Tue, 23 Mar 2021 17:54:02 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 00/11] kselftest/arm64: mte: Fix feature detection and compilation
Date:   Tue, 23 Mar 2021 17:54:01 +0000
Message-Id: <161652203083.28887.4073099105213789837.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 19 Mar 2021 16:53:23 +0000, Andre Przywara wrote:
> When trying to run the arm64 MTE (Memory Tagging Extension) selftests
> on a model with the new FEAT_MTE3 capability, the MTE feature detection
> failed, because it was overzealously checking for one exact feature
> version only (0b0010). Trying to fix that (patch 06/11) led me into the
> rabbit hole of userland tool compilation, which triggered patches
> 01-05/11, to let me actually compile the selftests on an arm64
> machine running Ubuntu 20.04. Before I actually fixed that, I tried some
> other compiler and distro; patches 07 and 08 are my witnesses.
> Then I got brave and tried clang: entering patches 09/11 and 10/11.
> Eventually I tried to run the whole thing on that model again, and,
> you guessed it, patch 11/11 concludes this apparent "2 minute job".
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[01/11] kselftest/arm64: mte: Fix compilation with native compiler
        https://git.kernel.org/arm64/c/4a423645bc26
[02/11] kselftest/arm64: mte: Fix pthread linking
        https://git.kernel.org/arm64/c/e5decefd884d
[03/11] kselftest/arm64: mte: ksm_options: Fix fscanf warning
        https://git.kernel.org/arm64/c/31c88729a7ad
[04/11] kselftest/arm64: mte: user_mem: Fix write() warning
        https://git.kernel.org/arm64/c/40de85226fec
[05/11] kselftest/arm64: mte: common: Fix write() warnings
        https://git.kernel.org/arm64/c/4dfc9d30a8ab
[06/11] kselftest/arm64: mte: Fix MTE feature detection
        https://git.kernel.org/arm64/c/b17f265bb4cc
[07/11] kselftest/arm64: mte: Use cross-compiler if specified
        https://git.kernel.org/arm64/c/28cc9b3d8996
[08/11] kselftest/arm64: mte: Output warning about failing compiler
        https://git.kernel.org/arm64/c/6b9bbb7f934d
[09/11] kselftest/arm64: mte: Makefile: Fix clang compilation
        https://git.kernel.org/arm64/c/adb73140eec7
[10/11] kselftest/arm64: mte: Fix clang warning
        https://git.kernel.org/arm64/c/005a62f6d269
[11/11] kselftest/arm64: mte: Report filename on failing temp file creation
        https://git.kernel.org/arm64/c/b4985bb88afb

-- 
Catalin

