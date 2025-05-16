Return-Path: <linux-kselftest+bounces-33172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E95AB9B99
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7661216626B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B0236430;
	Fri, 16 May 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD8PqnZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD71361;
	Fri, 16 May 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397056; cv=none; b=FmQnFs0vw1TInS5woiCjQvNCpjYJN8Qkid8zoMOJW2M3u4/2pRp/SuPnKSPfvXpV6YvZiHffJK1oVmT6uNwknQ5GT5wKZBpP0A6OZbzWtU+jOAOpkchBOOHNCiMF88Z9+C1xrvLlnED0mjJaGxeA4INcTybkF/qjSyrfOAgU67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397056; c=relaxed/simple;
	bh=KCwjgKTMuHSCGCH8zsLHrN2hAJYJKLa4Jq5iL6Vf2cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1x4zlPLMe7FMVHlxuXJPDTDYnsJ4EIH4UklWNowENJ3fFFGZgN3XE2J9TVoJ1O20h6K0f8ysgGus3RHA4zIy94cBN57yuLLkxNT6FLjsgtAeLXmq6I4EEGMW2JeHI2tm8Wvmim/Isrqc+jcTTuEY5WuJdXfP4mNOQIUOtNAfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD8PqnZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C165C4CEE4;
	Fri, 16 May 2025 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747397056;
	bh=KCwjgKTMuHSCGCH8zsLHrN2hAJYJKLa4Jq5iL6Vf2cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UD8PqnZALDd4Vfg+SoKbbdSuOiBznKSTYi986eO3GsWGWrlohNVWeVQYbZSu0zwas
	 7uIrS2h2nU/BQpyTP+12jXMyejDcEiuxp+Awn+wz5QxbUR8VvYuVg5zYKf964BxE8A
	 rx9SJ4iUTUBwoUBFumOmCf+7LNwkeubLDw2hEJW8586xxaUhR77JFLkMI7CUKSbTgH
	 ZD19WjtT9RdEQeAjUtCKMARt5BVhIubtmG/+ta7my/fig0CZQ4QhAX0sNw8HmwAiSE
	 yJeL4nOtG0H0rU1fSYpsYSb8fThjGZCWtHIyYRwN02sGVsReahHMKvB/9xncQK/NnA
	 7FNmF9nlKApxg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uFtnR-00FXoM-Rm;
	Fri, 16 May 2025 13:04:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ben Horgan <ben.horgan@arm.com>
Cc: james.morse@arm.com
Subject: Re: [RFC PATCH v2 0/3] KVM: arm64: Don't claim MTE_ASYNC if not supported
Date: Fri, 16 May 2025 13:04:10 +0100
Message-Id: <174739704125.2524774.18416359728104050072.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250512114112.359087-1-ben.horgan@arm.com>
References: <20250512114112.359087-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, ben.horgan@arm.com, james.morse@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 12 May 2025 12:41:09 +0100, Ben Horgan wrote:
> The ID_AA64PFR1_EL1.MTE_frac field is currently hidden from KVM.
> However, when ID_AA64PFR1_EL1.MTE==2, ID_AA64PFR1_EL1.MTE_frac==0
> indicates that MTE_ASYNC is supported. On a host with
> ID_AA64PFR1_EL1.MTE==2 but without MTE_ASYNC support a guest with the
> MTE capability enabled will incorrectly see MTE_ASYNC advertised as
> supported. This series fixes that.
> 
> [...]

Applied to next, thanks!

[1/3] arm64/sysreg: Expose MTE_frac so that it is visible to KVM
      commit: 5799a2983fea4f22f6aaa291aee3b704db81d29f
[2/3] KVM: arm64: Make MTE_frac masking conditional on MTE capability
      commit: fe21ff5d4b46c06c4e43a310fdb781d1e6b5173e
[3/3] KVM: selftests: Confirm exposing MTE_frac does not break migration
      commit: 69018866d2baa014413e340744bfb342ec0cdbcd

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



