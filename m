Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0C435E9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJUKIU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 06:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhJUKIO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 06:08:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 673F36135A;
        Thu, 21 Oct 2021 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634810758;
        bh=sibpp7IiPQMnwySQZkL6cf2G65vTRtonKG5ecN5UMj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZ6ZiWR5h/Gyqtv8Su31N21O3QKRp0B2p7COW3WjBi9haC50XiMTQCGGX8zHw37E4
         a1IV62Dbmh11Oe3OKTadumD9kY429qdhYFxk2zIDhYPJLKETmSac87TOkkzDmMSz8T
         4MN+wRc99Sl8NEh8SAAlHvwayKBroPW/hWHEcnwgmEK/dXDkgqAKec5J3u4pTnN3Mo
         ZcEqrN9uxGNBOHsPaOJ6jMX+ubwrHZdhwOkDE4D7B2we5MNLzBmDnGq3H3Jf/F6Ql9
         M/YchDpiwnx2BrinUbDiCMbGPzOQZk61YxFNHcNLnbeQcjNgOkfUwJJQCLrcKO3Qnl
         jS4/KKzWS/MxA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-kselftest@vger.kernel.org,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Alan Hayward <alan.hayward@arm.com>
Subject: Re: [PATCH v3 00/42] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Thu, 21 Oct 2021 11:05:47 +0100
Message-Id: <163480789950.1807118.14185267593559020528.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 18:22:05 +0100, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].
> 
> For the kernel SME can be thought of as a series of features which are
> intended to be used together by applications but operate mostly
> orthogonally:
> 
> [...]

Applied first 9 cleanup patches to arm64 (for-next/sve), thanks!

[01/42] arm64/fp: Reindent fpsimd_save()
        https://git.kernel.org/arm64/c/2d481bd3b636
[02/42] arm64/sve: Remove sve_load_from_fpsimd_state()
        https://git.kernel.org/arm64/c/b53223e0a4d9
[03/42] arm64/sve: Make sve_state_size() static
        https://git.kernel.org/arm64/c/12cc2352bfb3
[04/42] arm64/sve: Make access to FFR optional
        https://git.kernel.org/arm64/c/9f5848665788
[05/42] arm64/sve: Rename find_supported_vector_length()
        https://git.kernel.org/arm64/c/059613f546b6
[06/42] arm64/sve: Use accessor functions for vector lengths in thread_struct
        https://git.kernel.org/arm64/c/0423eedcf4e1
[07/42] arm64/sve: Put system wide vector length information into structs
        https://git.kernel.org/arm64/c/b5bc00ffddc0
[08/42] arm64/sve: Explicitly load vector length when restoring SVE state
        https://git.kernel.org/arm64/c/ddc806b5c475
[09/42] arm64/sve: Track vector lengths for tasks in an array
        https://git.kernel.org/arm64/c/5838a1557984

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
