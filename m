Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9C344582
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhCVNVg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 09:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232167AbhCVNUJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 09:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B78C161606;
        Mon, 22 Mar 2021 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419209;
        bh=paoioZHt7SggcDIVeK8nqBctwIc6qD7MD6NrpBx+xnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOfdzn6/i5usxMfDTxX/pV0wBCU+J0cbq+hgrqVoiq9yDLNZKApJyu7KIhfCgY30D
         mo+0Hnawl+Z+vGyXewgutdV4ohCJRSrx10FsL+bK+UlpEVZva4W1ft5xNW0DPgwVZh
         qDkC6kDe9K7Ex57FLuVLWVUW3Z+JcXOiWrHxEn6pedbBmazfvCfNEjfAXeM0C9nAuw
         M0X8q4BKUtQ75Ra19IJ24EPaBQgEUVH0skOEs78b5p+J8V/Tnah/+GWeJMBiv+M43J
         iworjIZFejBa9ca/S/Rmkxwbl/DFtUJIQfHEBxgTKUtt9nhibhOoPX2zkOZGsSj7Nx
         XdMrT+o5tKq8g==
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH] kselftest/arm64: sve: Do not use non-canonical FFR register value
Date:   Mon, 22 Mar 2021 13:19:55 +0000
Message-Id: <161641739736.3901488.4203092835901236915.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319120128.29452-1-andre.przywara@arm.com>
References: <20210319120128.29452-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 19 Mar 2021 12:01:28 +0000, Andre Przywara wrote:
> The "First Fault Register" (FFR) is an SVE register that mimics a
> predicate register, but clears bits when a load or store fails to handle
> an element of a vector. The supposed usage scenario is to initialise
> this register (using SETFFR), then *read* it later on to learn about
> elements that failed to load or store. Explicit writes to this register
> using the WRFFR instruction are only supposed to *restore* values
> previously read from the register (for context-switching only).
> As the manual describes, this register holds only certain values, it:
> "... contains a monotonic predicate value, in which starting from bit 0
> there are zero or more 1 bits, followed only by 0 bits in any remaining
> bit positions."
> Any other value is UNPREDICTABLE and is not supposed to be "restored"
> into the register.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: sve: Do not use non-canonical FFR register value
      https://git.kernel.org/arm64/c/7011d72588d1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
