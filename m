Return-Path: <linux-kselftest+bounces-16226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B984895E47D
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E6B21C6E
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52080155389;
	Sun, 25 Aug 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA1LnCsp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BB2E414;
	Sun, 25 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724605310; cv=none; b=ScsynZpWBqntCmZHK+e/cZH1tyZf/3lDbwjbnKNRdRcqV1Z2ZIA4O5SLXSnX8bozPFv9tjwDflS9AwaQKedn8bk8xvK0shtTo3JUiIn9O7ltcv3cMx65vhjkK7JefPBiWPyENQkWT/Gg5sPXl8dmWU9gm66YAGtZkML0j3RR678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724605310; c=relaxed/simple;
	bh=EPolHw/el52PuT0VWE6le7FPzSmuz7JciNHM2H6aH7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQjmBv5HVGg4A4Ab5NxqgQWt0abFHW8Ozs/ppbDuidMslQeUmAXfMG/aA3TFSEHXLSTA2+EimzPGOYCIv2VhvpL99kyV/2EdobpagkXHHLhq/VEJI1iurcnKkD7EvINVDyye2BumdmEm3LWnmHdtF7u9APgPxRixyBbAblzdhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA1LnCsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D431C4AF13;
	Sun, 25 Aug 2024 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724605309;
	bh=EPolHw/el52PuT0VWE6le7FPzSmuz7JciNHM2H6aH7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA1LnCspJhNUmNm0eCsLrlCIlOVh9M1wb2SYSad+IVoFDGkuaT1+cVc7l/jTZRN3i
	 Wvs8KebJYSJnzaAa6GMQUvjtBvofGfNR6wNXLLYBMpBeiFvpf0ny3TcQqq0ChPFzjK
	 SdjRe9NYBIG6mrRwVfJyCXWj/lTXuH7bJ5WobjKU6olKJRdJaDk4X9SUA7zO4+L9PQ
	 X4HKbklwQSr/pPIDqbjBfSdghx1+K45uSk0000uRydq5EiXbkkLmGtMjt+TsKC9paX
	 iv1f8xyN7ofq09/IvfrCawaXfla0Anx59yxEMCv+mDGgmqg5nk5DLpyOtD+wJMFRPP
	 qispObnZ9BCig==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1siGcd-006hIn-9U;
	Sun, 25 Aug 2024 18:01:47 +0100
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>,
	kvmarm@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v5 0/4] Allow userspace to change ID_AA64PFR1_EL1
Date: Sun, 25 Aug 2024 18:01:43 +0100
Message-Id: <172460529881.3851223.2305395558569783838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723072004.1470688-1-shahuang@redhat.com>
References: <20240723072004.1470688-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, kvmarm@lists.linux.dev, broonie@kernel.org, shahuang@redhat.com, eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, catalin.marinas@arm.com, james.morse@arm.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 23 Jul 2024 03:19:59 -0400, Shaoqin Huang wrote:
> This is another try to allow userspace to change ID_AA64PFR1_EL1, and we want to
> give userspace the ability to control the visible feature set for a VM, which
> could be used by userspace in such a way to transparently migrate VMs.
> 
> The patch series have four part:
> 
> The first patch disable those fields which KVM doesn't know how to handle, so
> KVM will only expose value 0 of those fields to the guest.
> 
> [...]

Applied to next, thanks!

[1/4] KVM: arm64: Disable fields that KVM doesn't know how to handle in ID_AA64PFR1_EL1
      commit: ffe68b2d19a5a84440fea99a732cfc3b157559eb
[2/4] KVM: arm64: Use kvm_has_feat() to check if FEAT_SSBS is advertised to the guest
      commit: e8d164974cfa46fe5ec87869c8a7113641f322d5
[3/4] KVM: arm64: Allow userspace to change ID_AA64PFR1_EL1
      commit: 78c4446b5f957fb14737582e503b1b25f66edc45
[4/4] KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1
      commit: dc9b5d7e0bd40e68a94013766b27be3dda10c006

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



