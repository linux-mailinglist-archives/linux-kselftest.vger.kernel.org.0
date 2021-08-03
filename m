Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786773DF1C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 17:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhHCPrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 11:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236991AbhHCPrw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 11:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 101FE60F93;
        Tue,  3 Aug 2021 15:47:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 0/4] kselftest/arm64: Vector length configuration tests
Date:   Tue,  3 Aug 2021 16:47:33 +0100
Message-Id: <162800564638.22044.15141225072637378536.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803140450.46624-1-broonie@kernel.org>
References: <20210803140450.46624-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 3 Aug 2021 15:04:46 +0100, Mark Brown wrote:
> Currently we don't have full automated tests for the vector length
> configuation ABIs offered for SVE, we have a helper binary for setting
> the vector length which can be used for manual tests and we use the
> prctl() interface to enumerate the vector lengths but don't actually
> verify that the vector lengths enumerated were set.
> 
> This patch series provides a small helper which allows us to get the
> currently configured vector length using the RDVL instruction via either
> a library call or stdout of a process and then uses this to both add
> verification of enumerated vector lengths to our existing tests and also
> add a new test program which exercises both the prctl() and sysfs
> interfaces.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
      https://git.kernel.org/arm64/c/7710861017ac
[2/4] kselftest/arm64: Validate vector lengths are set in sve-probe-vls
      https://git.kernel.org/arm64/c/b43ab36a6d86
[3/4] kselftest/arm64: Add tests for SVE vector configuration
      https://git.kernel.org/arm64/c/95cf3f23877b
[4/4] kselftest/arm64: Add a TODO list for floating point tests
      https://git.kernel.org/arm64/c/e96595c55d23

-- 
Catalin

