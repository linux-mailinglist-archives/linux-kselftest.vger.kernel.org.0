Return-Path: <linux-kselftest+bounces-34371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A27ACF0C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 15:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA2C3AAE42
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46092356C4;
	Thu,  5 Jun 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXXzABH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD623507C;
	Thu,  5 Jun 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130419; cv=none; b=MEvvET8WUadPEsfpnbIoUGhs3OdDXESX7YmrSekhRXJVejdGL0uWqK3W5K+VI7I5bUnEAJvRQpR7oAtdgtdOKuQA6V7YPxV+kv3pP3hMe7mZ6UH8rtS7YgXfrE4jK8ehOWuyaS+lGKTVtbiVohhLcP/YZ6uoQjXZu1T3IORfqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130419; c=relaxed/simple;
	bh=yxqHU2sOZN27FulrAoAbvaO56DcbsQKhcY/tONUxapg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vmow+wxomqGdVtu4QlbHtQoP4+/tulVNabY1gVy2cT/egaekqyHzXp2/E1HAhlBH02KmgSvlP4WCShbkoVtsDmjeLszHe8+nmkLul2d5rHsDt7A/o/1iQiBUwVh7aBJVmC8Cw1LGcmKvTNXTrf8WoIodhQthdR/q1h8cUBHb1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXXzABH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121AFC4CEE7;
	Thu,  5 Jun 2025 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130419;
	bh=yxqHU2sOZN27FulrAoAbvaO56DcbsQKhcY/tONUxapg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXXzABH/J2X+vsgPNiyyVobzGpKHW4ZnkuN6qgNbdAWtraINx/hRirrLgERmAI2fg
	 O3r2rSRBLCJRdcVmRHNj5RhVOqxcCoqzSGyOdkYopDU6HUbp8TqXz3xDFiOOryliDs
	 wylMSmmKV252l0db+CVj7VxuSeX7JEVkrHn8ztKfHi0UGSmdRr3G2xSZeflt0exUJG
	 dbSUDq8Ao1qFERKPsnvMxBStOqO3KSvYDjMkrDGQGC67oO1WzOt2AqvPxnUCSNWyb6
	 K75JqBZDQg01SnJv1qIyupDf4uZ8pHjB8IPOWJRYCrqxdfF0bc1CUPRgJItS+dZLwN
	 Odn3i+cZ2P0TA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uNAiu-004J3E-Kj;
	Thu, 05 Jun 2025 14:33:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>,
	Sebastian Ott <sebott@redhat.com>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] KVM: arm64: selftests: arch_timer_edge_cases fixes
Date: Thu,  5 Jun 2025 14:33:30 +0100
Message-Id: <174913039935.1215874.15467510100629405540.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, sebott@redhat.com, coltonlewis@google.com, ricarkol@google.com, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 05 Jun 2025 12:36:09 +0200, Sebastian Ott wrote:
> Some small fixes for arch_timer_edge_cases that I stumbled upon
> while debugging failures for this selftest on ampere-one.
> 
> Changes since v1:
>  * determine effective counter width based on suggestions from Marc
> Changes since v2:
>  * new patch to fix xval initialization
> 
> [...]

Applied to fixes, thanks!

[1/4] KVM: arm64: selftests: fix help text for arch_timer_edge_cases
      commit: 9a9864fd09c7e52440c05e70609bf5ee8da425d0
[2/4] KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
      commit: 050632ae6571d0f148fa0d4b90b6409a12645461
[3/4] KVM: arm64: selftests: arch_timer_edge_cases - fix xval init
      commit: 05ce38d489dbc96eb1dd700b287f949cb8cc0610
[4/4] KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width
      commit: fad4cf944839da7f5c3376243aa353295c88f588

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



