Return-Path: <linux-kselftest+bounces-44435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D6C212B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033964EC2EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB53683AA;
	Thu, 30 Oct 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkobSByQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC043683A5;
	Thu, 30 Oct 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841412; cv=none; b=HtjM/XQ3i2jfvlTh55j4lzp6rKDJ1zXlDJjEP3m8yPTLdcfM4In1AhuJ+Cmw2FJ/Kbfw4vvQmhig+2TM5fzwxtbqxm/SiU6povfa2CIqezBXZjP/ZayYwPgKLPnNCKxjFybwwHMOr1Eb+07km2YGGVlhe1ClC2EAnjcOaNSLHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841412; c=relaxed/simple;
	bh=lNYaB9TRi0xA6KdXoCxuUICxtxUxEpnWksgszaMGxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqj0It/qj42qKzOmn1ZHphGaV3K0DtE4yyhZ2gM8B/6i00Ktn6my5otArGWNEoFA4yxss9XoNPRB5mjdqpiORa+KVqGnNfAXo9Yb7MuMXtYMk7YERc7ouNr/kKrQJUaOLCYYa40Ns5YXGi4EMCubdcezRtXy6DbjuwXJPNADHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkobSByQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657FBC4CEF8;
	Thu, 30 Oct 2025 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841412;
	bh=lNYaB9TRi0xA6KdXoCxuUICxtxUxEpnWksgszaMGxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkobSByQ/iNWh6Ap6EUP6UAu6lWYrlg57zvsDNoIlkT/q19oeG0Heu1irYWzv8TGU
	 CU+SyNzyvr+9rvIcFV4jw1vCqY6CPDJyI7qqIJCc2ZOETLdNG7+VBz6oAIatntra6w
	 VmdBZygS+J7TpbeK90Z5s7w0mHkM3VVIo94rnlWfY9UQC8CuhvEIQH/ifLDK3UwbM5
	 +hZP6mJnvmvDDpwZLwf93Y9AS3tYp3z8Pq76CukOB1lPZzsMoUirm4+Z776BQ/zV70
	 c4n2QYPTbrL3dSBCqf5TrSuoIcrORTNhEQOGr/R6UGBwP0oZxd+j4Lrxd+m3XQj6iy
	 pE8cynMQPQRrg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vEVQw-000000013AP-1hRB;
	Thu, 30 Oct 2025 16:23:30 +0000
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
Subject: Re: [PATCH] KVM: arm64: selftests: Filter ZCR_EL2 in get-reg-list
Date: Thu, 30 Oct 2025 16:23:26 +0000
Message-ID: <176184140653.2037728.16270464384501479116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-kvm-arm64-get-reg-list-zcr-el2-v1-1-0cd0ff75e22f@kernel.org>
References: <20251024-kvm-arm64-get-reg-list-zcr-el2-v1-1-0cd0ff75e22f@kernel.org>
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

On Fri, 24 Oct 2025 00:43:39 +0100, Mark Brown wrote:
> get-reg-list includes ZCR_EL2 in the list of EL2 registers that it looks
> for when NV is enabled but does not have any feature gate for this register,
> meaning that testing any combination of features that includes EL2 but does
> not include SVE will result in a test failure due to a missing register
> being reported:
> 
> | The following lines are missing registers:
> |
> |	ARM64_SYS_REG(3, 4, 1, 2, 0),
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: selftests: Filter ZCR_EL2 in get-reg-list
      commit: a186fbcfd845699d51809f7c7e54cf997fe32820

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



