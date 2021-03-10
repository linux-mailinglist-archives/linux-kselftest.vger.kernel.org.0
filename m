Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7E333B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCJLkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 06:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCJLj2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 06:39:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C7D864FD7;
        Wed, 10 Mar 2021 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615376367;
        bh=jiQqkSADI/qQWvZMlQ7MnGuqdjp8S7DVmxmJFrsr0d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5NGADlkfld3T/Fohgfswof7/goFezi2GjLReI+yC0QPWPsQWQZo73p3ExwT+Rpfn
         YY0qw6m+gWuzqB7QEq27aDSn65aqA9M3P+SwTW2NGvxwFndRifo21EFh8OCnA7v/eM
         Vbcw9E/rtJC9bUWMYXoeJ0DLkA1zEfSCUiZyZzopg8GiOOqC80YmORy35pG3X61+kc
         uLLN53M8SSVIkbiWoVOOXyEYID0orPVZusgrUUo77cA/KeNeViifIrXZttzpZUxydb
         AY4lHziJeu5FPQ+gHG/s+45uvLGWy/ulJ3Uc0xagDZi4pwzEHSjEsHdpuqpkmgESnr
         Xv2vllPph7ejg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest: arm64: Fix exit code of sve-ptrace
Date:   Wed, 10 Mar 2021 11:39:17 +0000
Message-Id: <161537389185.1673798.15786183151440302678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210309190304.39169-1-broonie@kernel.org>
References: <20210309190304.39169-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 9 Mar 2021 19:03:04 +0000, Mark Brown wrote:
> We track if sve-ptrace encountered a failure in a variable but don't
> actually use that value when we exit the program, do so.

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest: arm64: Fix exit code of sve-ptrace
      https://git.kernel.org/arm64/c/07e644885bf6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
