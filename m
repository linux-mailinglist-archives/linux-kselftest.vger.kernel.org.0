Return-Path: <linux-kselftest+bounces-36475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0BEAF7EE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1F11C20B5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0D2E765E;
	Thu,  3 Jul 2025 17:30:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA82E6D2A;
	Thu,  3 Jul 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563827; cv=none; b=jB93Q3uhDTOiJKkn49oUS2FZ+NxQHBQqKJyEdJdvgutqqyX+faOR7WAb5/+2tZ6lgej2jpZ2Ttm8otBHdqzNkhOSauu5EgKqFbDy9GRUTQ8cArzjroQVtvzwhOVId2mYyGXXspbw8LXy2IpxBCOSrD0zPbiKQxQqd4Tl8RK/6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563827; c=relaxed/simple;
	bh=QAyBjaBSw5YglsjTxMPVD8vMVnxRC1o9TG/Ptvc7VfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drw68xqJLHOHQ925MvR1dDhijUHCk1UCgXfOmqxLYyhz1V9atmvuQoPfGDPNFoHnPlzi8Avv4Qljq++RmjVG3YD2lyFNrIQPQrdWK9T9TtjzLt7anIGTrjMZEz8I4EjjuBLG0tEph0uvB/5+00d+5sWwqwFZHqbWbZtbMDevgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123DDC4CEE3;
	Thu,  3 Jul 2025 17:30:24 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v2 0/3] kselftest/arm64: Update sve-ptrace for ABI changes
Date: Thu,  3 Jul 2025 18:30:23 +0100
Message-Id: <175156379920.3469134.14157042416856750044.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
References: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Jun 2025 16:25:30 +0100, Mark Brown wrote:
> Mark Rutland's recent SME fixes updated the SME ABI to reject any
> attempt to write FPSIMD register data via the streaming mode SVE
> register set but did not update the sve-ptrace test to take account of
> this, resulting in spurious failures.  Update the test for this, and
> also fix another preexisting issue I noticed while looking at this.
> 
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/3] kselftest/arm64: Fix check for setting new VLs in sve-ptrace
      https://git.kernel.org/arm64/c/867446f09058
[2/3] kselftest/arm64: Fix test for streaming FPSIMD write in sve-ptrace
      https://git.kernel.org/arm64/c/94ab150010f4
[3/3] kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace
      https://git.kernel.org/arm64/c/9e8ebfe677f9

-- 
Catalin


