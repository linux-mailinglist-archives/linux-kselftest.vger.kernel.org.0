Return-Path: <linux-kselftest+bounces-32490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B567AABDCA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986B57A9B52
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332922DA04;
	Tue,  6 May 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWnoo6Xe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228C216399;
	Tue,  6 May 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521521; cv=none; b=kA45cyeNp4WaDu15KKufu052+aMDqS8i/IInhH/6Y6jH+wljLO6mcsfB4/S4XLzK2PV7EGlqUCaUgRRQTLRd6KzPWfJpb3QbWQXAzSrTwbfpguFAMAt2XvqzrQk6ag8j2mC1vSiCeC7UoeZbq3p0rqu/vb2Lwlt8lCyEpSXmzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521521; c=relaxed/simple;
	bh=6NUiTuauuVTTWDJGRfLdUgLEoCQtYK+fPlsDsFdb7uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKxXKSggSaWl1c0n4U7Wpvzaz7BfiMsfSE5mc51zlQ8ONjN12Iu67aTvcJ0AzLEFiOLanyppChKhEIxgRIQVlHuGaZ9oCM6VVsAhcl2I/Ty3zWvU7M7PQUsxXQlbURJfmy4A3zg5DBEnfrdPj74KaPJ5tbcU7PiNxDG8ReW7lls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWnoo6Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5BAC4CEE4;
	Tue,  6 May 2025 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521520;
	bh=6NUiTuauuVTTWDJGRfLdUgLEoCQtYK+fPlsDsFdb7uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWnoo6XeiUf/E7X7aaYO2Wh16ejc7WkatxpgR04nnkXPUwev+4plNxTx6AYD5nZry
	 rKM5g+jeKlRdWscq5qD9QuHgGejaznVxNuVahZB8tbRLOSOtCcriS1DBKNtC8nPp7n
	 Yhr0itoXjoEC1WXwb6dV/fmLDkXGL5Qps4iB1cs8/vwE4U8zA1XMSSNw6/XAot22of
	 5eW9RpWWKKK2ccdoPRbYq6gA3RgyNjcGcEIvLvhTayFjr+xpCq21j7JUVq/7jT7jYG
	 4qWECc9C0iWGt3L/HFnyJx6/+c16osgt56vPofuA1hNnZXbSbTBiQ6L7WQRHgqOMEM
	 +gAyGHTaKAP6Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uCE1u-00C9X1-O6;
	Tue, 06 May 2025 09:51:58 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH] KVM: selftests: add test for SVE host corruption
Date: Tue,  6 May 2025 09:51:54 +0100
Message-Id: <174652150331.339671.16106130205951028954.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>
References: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, shuah@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, broonie@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 17 Apr 2025 00:32:49 +0100, Mark Brown wrote:
> This test program, originally written by Mark Rutland and lightly modified
> by me for upstream, verifies that we do not have the issues with host SVE
> state being discarded which were fixed in
> 
>    fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state")
> 
> by running a simple VM while checking the SVE register state for
> corruption.
> 
> [...]

Applied to kvm-arm64/misc-6.16, thanks!

[1/1] KVM: selftests: add test for SVE host corruption
      commit: e0ccc45b056d626d4b271820faeedf3837337ceb

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



