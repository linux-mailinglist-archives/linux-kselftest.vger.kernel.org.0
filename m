Return-Path: <linux-kselftest+bounces-41958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C183B8A0D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D833C583BBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5531328D;
	Fri, 19 Sep 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtctAxtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696C2FC03B;
	Fri, 19 Sep 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293040; cv=none; b=Z4xWN9jZ9ckdQhNinYjAAs2l0IUqhT/AjpfBgg6XfSwXc/zx6wy/2o3Ot461hJhX16NtvwBsjZ0PiyBWuakVg6Ul3oZ82W9iR4AAppGCa0wJkyZ2LpW3L4PmTXLsB/cMaRVFoZlN/oWlYJ00wHTL2aMUdv0ffg0BG+5xpBGVspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293040; c=relaxed/simple;
	bh=tgkIwZkXy82iLvUj6D+P1CNw4VBnnKn2FdkseccjCec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGbwN3y33bsZEVlsjWVrtYQu4M1UrpBLdGs1cgwkcOhNWKuMZXVo6sUFzb0X/TLuiBvnnnkg3OxJdAiFkdGEiCbRi1DxLGw2CBM8XOFM86IgjnUjuCjzf2JuTswn8huqlHzdHQo6FAz55SLaWnf1rK/NNlBFlsggAEGeMU0fLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtctAxtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFECC4CEF0;
	Fri, 19 Sep 2025 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758293040;
	bh=tgkIwZkXy82iLvUj6D+P1CNw4VBnnKn2FdkseccjCec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtctAxttB0At3TcPH73mcchGwf4+wczzFO0nvukNwWi4g4gSEIf1w3kbNi+inY2yu
	 y/n4dZFmRxTdr77RTf/gs1RfrEnVNZXyNHWLdDBBJ13dZeU2oFgyRGaETNRm/cuSrR
	 7YGPqQHU+45rfI5rvD5VIkBdbSeDeN2z6lFyE+SGlVgXC4bKSNpd37cGqFmNDR8oRW
	 mPGePVGGHIjmt2pr1OVL1/42X3QF5YHmIg6zO3rIBZBGbWgZZC05V3hMi9XbyVtwWN
	 5jHd7Nyu+FyPZ0JF4anScbTzNPYFeosEX5sxi2w+WXdRIelu33/WnhGAJk0hniV7Ge
	 0Cv0Bsj/LL7TQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uzcL7-00000007oFw-3HTw;
	Fri, 19 Sep 2025 14:43:57 +0000
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/2] KVM: arm64: Expose FEAT_LSFE to guests
Date: Fri, 19 Sep 2025 15:43:54 +0100
Message-ID: <175829303126.1764550.939188785634158487.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918-arm64-lsfe-v4-1-0abc712101c7@kernel.org>
References: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org> <20250918-arm64-lsfe-v4-1-0abc712101c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, shuah@kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 18 Sep 2025 20:42:06 +0100, Mark Brown wrote:
> FEAT_LSFE (Large System Float Extension), providing atomic floating point
> memory operations, is optional from v9.5. This feature adds no new
> architectural state, expose the relevant ID register field to guests so
> they can discover it.
> 
> 

Applied to next, thanks!

[1/2] KVM: arm64: Expose FEAT_LSFE to guests
      commit: 5d20605c8e7930254f7bee41336e421be247181c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



