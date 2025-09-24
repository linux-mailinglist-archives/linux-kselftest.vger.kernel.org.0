Return-Path: <linux-kselftest+bounces-42233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D5B9B874
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D630F4C6F7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397C319865;
	Wed, 24 Sep 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS4gQZ2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BF313D72;
	Wed, 24 Sep 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739110; cv=none; b=eQc0A82NW1OMq3rD0qaFfzb42BO5DbnaeLbthpWxyG+ZPsDcdLWW8yg5MDELPG+eq6HZqpgaooEt3ayTMC4m/b0Ww5vyWSbAtJ6HAMjR6FJi1zjlOmSds5gJWjZChFKypPGWwRF3wPF1+CsaXm/FUftmgAVdDpsuZsPaDSoAdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739110; c=relaxed/simple;
	bh=JIUwIwvyK28kGXsFjmWwmTqUM0qtgo11UVD4GpXU9DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOeyzt4QCirEAiak7LMnNhdGr84sMgSZ+FUVCz+TYKSc7WmbldjS53a8SMF2iyv+VuEDKDsTw1qJ4Qn78t6Wkiob7wjfecX7TxuWe+syBtzPl8aL8to7xEwiJkUZdskfd/IbXWzlLZD2mEOlHmCsB9PNsOBT+OnqFDjPOSaOk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS4gQZ2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A1C4CEE7;
	Wed, 24 Sep 2025 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758739110;
	bh=JIUwIwvyK28kGXsFjmWwmTqUM0qtgo11UVD4GpXU9DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QS4gQZ2ut/p5CX+SDw9+RK/9FA9j4cDOup/uPL78PwlLRA+8Az8iC5ktHnQ6FenUz
	 n9UEmWIomcmPGbVdGsDQO33pNlFPpPll8WC51BqC6C7pjq2IY4NqJw1crh2kh5aaIO
	 DYr/7zLh7ZcCFb6xIkYIk/Pl9m1DBiUt2K7bz2x1h+Lr7rFiYEl0BCOHQAvzVyf8QS
	 D/+IshKU7j/9s7SU3sCmrYQuAlZwVuP/YgQMoJVOSd5m4hn6UcKxwACPBm7dhtxDMr
	 DdlavpKVCrxuFSllGp4YSkc0JTIhfaRkBLVUd1e6GgimrNbNOerkrcgJDg7raOlJbL
	 IsVVZwk5NrL9g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v1UNo-000000097OU-0ZEg;
	Wed, 24 Sep 2025 18:38:28 +0000
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
Subject: Re: [PATCH 0/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in set_id_regs
Date: Wed, 24 Sep 2025 19:38:24 +0100
Message-ID: <175873910389.2373233.15017711229799268342.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
References: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
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

On Sat, 20 Sep 2025 20:51:58 +0100, Mark Brown wrote:
> The set_id_regs selftest lacks coverag for ID_AA64ISR3_EL1 which has
> several features exposed to KVM guests in it.  Add coverage, and while
> we're here adjust the test to improve maintainability a bit.
> 
> The test will fail without the recently applied change adding FEAT_LSFE:
> 
>    https://lore.kernel.org/r/175829303126.1764550.939188785634158487.b4-ty@kernel.org
> 
> [...]

Applied to next, thanks!

[1/2] KVM: arm64: selftests: Remove a duplicate register listing in set_id_regs
      commit: 5a070fc376babc7efdc8288b97431e43e18f4646
[2/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in set_id_regs
      commit: b02a2c060b657296c080cff1b54ee4e9e650811c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



