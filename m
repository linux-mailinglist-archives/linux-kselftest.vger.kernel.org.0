Return-Path: <linux-kselftest+bounces-44434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A3C2129E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEAC9350127
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC5368384;
	Thu, 30 Oct 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdCOFcwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DC3678DC;
	Thu, 30 Oct 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841406; cv=none; b=FjfsDZLwThLvcU+7lmyBppFKgODP6oC15/5cmcnzKwj/3umBnqy4TFIJF4e6PjBgPwIkrVVVbAo0b4dQjKxIdbYXXfQZPsAwIHLn5Wa0umKQIrDjNmyn3N8Y9IsvY6V34NUzs5AmF8+CSvFnzTrR2h7dKaBiIlxvpJ6QifIdLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841406; c=relaxed/simple;
	bh=3oHW4EGzpi0IVzeps7hkcRmILdKRMCZknLPtO6MrMlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5XWPYRL0f5W8sWNMZ1IOmP27F7b1avFnlS8vkSzd3gCN1YWahmUs41ZSNqGKQTBDT46xpuGQT8thfhDCADDn8AXcxFvjW8hVb1Lv0zNTu/NK2GcMJnoYe+BU+TQtXg2aUvEjYxTWC5nK4mXuNEHbwYqXh7B77vuGCu7ZPRHdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdCOFcwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836C0C4CEFB;
	Thu, 30 Oct 2025 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841406;
	bh=3oHW4EGzpi0IVzeps7hkcRmILdKRMCZknLPtO6MrMlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdCOFcwRQsPn8kKg0D46Mw2N6hltPH94r5uymscS6Qpm8ocEtO21Adt+KsxoqB4gt
	 P9OYnBJdxOGVO3H53IQYI87EXHSCWnqdEtxtrp4BALjUEwkxLoHkOIaQBiYXwasfrz
	 JAFCm1JZWW0v0Zp7lAM0BaOpCqer9WZsepK7GXAoKTVEu0qROQj/g2ZLpreinMySCW
	 Kkc+hRTsu+J6cGZabzI3AWDolw4NPMJC0+fCDdTJMdWQYOAGVctz+vUvkQvWTOkVHo
	 uxgN7F02v5VMNezCiNS1zieHCGeIfmt4HCs4NjL3Gbkx4sO/fjVasbS+vitPTecQiZ
	 l7LRQrFvkIv8A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vEVQq-000000013A5-2eZL;
	Thu, 30 Oct 2025 16:23:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: selftests: Add SCTLR2_EL2 to get-reg-list
Date: Thu, 30 Oct 2025 16:23:21 +0000
Message-ID: <176184140111.2037675.2110055805883530232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-v1-1-088f88ff992a@kernel.org>
References: <20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-v1-1-088f88ff992a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com, shuah@kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 23 Oct 2025 22:19:29 +0100, Mark Brown wrote:
> We recently added support for SCTLR2_EL2 to the kernel but did not add it
> to get-reg-list, resulting in it reporting the missing register when it
> is available. Add it.
> 
> 

Applied to fixes, thanks!

[1/1] KVM: arm64: selftests: Add SCTLR2_EL2 to get-reg-list
      commit: 92e781c93ebe75e39ecdf78fb8ef1fdf1b63a9f8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



