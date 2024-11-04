Return-Path: <linux-kselftest+bounces-21389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B706E9BBB36
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AADB20F1A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4A1C2339;
	Mon,  4 Nov 2024 17:12:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320A1C07DA
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740369; cv=none; b=lD2pEiSMAxKFo6zfazhknOq61PM+n3S4iJqrJOJw5eoA4Wksi19kuWhg3eRM5hl4uctuyQ1wAfVboiiUWwvuAWx5cSCcIaODhvjmaTfXZPMadf2wiphsZii64PQTV9jJkujEPWhI9qAdc/vi6/ReC+2umq9twtO5hZoVPQB/U+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740369; c=relaxed/simple;
	bh=Yb2YG3yTlVnHSIbMd/7qj9a+jw9JOfssSYZoWVNt7to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XViQ1wNV+NVD4sset1V6cwWX7+5qTEqbFJphPEsLD4qNBwF4t5AgW5lR0AOmLROkku3Kh5iXs//hKwrld1KalcnZmUSIoWkSlEiMeIMcYQCD54VakqranZdAAUeQi+wsF7eSPeMoBUFcUjFxsW+tCqFnuakCLeQ4tbCh2YM2Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DB4C4CECE;
	Mon,  4 Nov 2024 17:12:45 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Will Deacon <will@kernel.org>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	Dave.Martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	tglx@linutronix.de,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: (subset) [PATCH v3 0/5] Improve arm64 pkeys handling in signal delivery
Date: Mon,  4 Nov 2024 17:12:42 +0000
Message-Id: <173074023809.2453606.393538963004702686.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029144539.111155-1-kevin.brodsky@arm.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 14:45:34 +0000, Kevin Brodsky wrote:
> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> series [1] that recently landed on mainline. The goal is to improve the
> way we handle the register that governs which pkeys/POIndex are
> accessible (POR_EL0) during signal delivery. As things stand, we may
> unexpectedly fail to write the signal frame on the stack because POR_EL0
> is not reset before the uaccess operations. See patch 1 for more details
> and the main changes this series brings.
> 
> [...]

Applied to arm64 (for-next/pkey-signal), thanks!

I took the kselftest patches through the arm64 tree as well (patch 4
acked by Dave Hansen from an x86 angle). Patch 1 has already been merged
as a fix (this branch is based on top of the arm64 for-next/fixes one
which contains patch 1).

[2/5] arm64: signal: Remove unnecessary check when saving POE state
      https://git.kernel.org/arm64/c/466ece4c6e19
[3/5] arm64: signal: Remove unused macro
      https://git.kernel.org/arm64/c/8edbbfcc1ed3
[4/5] selftests/mm: Use generic pkey register manipulation
      https://git.kernel.org/arm64/c/6e182dc9f268
[5/5] selftests/mm: Enable pkey_sighandler_tests on arm64
      https://git.kernel.org/arm64/c/49f59573e9e0

-- 
Catalin


