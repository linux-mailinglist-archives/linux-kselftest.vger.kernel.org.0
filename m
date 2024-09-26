Return-Path: <linux-kselftest+bounces-18382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8F986B43
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 05:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98A228344B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 03:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A09188595;
	Thu, 26 Sep 2024 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdEnEsW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD518756D
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321002; cv=none; b=NlflpMFRr9SJ09Ej4RG+QBB6KxlMvRWPcpwIwVTXqoLqj6C36LQ5nI/IyTOp1BPduxMh+f8iAruhAE7omfujURoO26e4ayiOZki5P2a7N8G4RN/5ZHUzsM7DZOEWJuCMrLQckT+xhs5XPCi+scUVkwEXposwu+OexMlAe8oIuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321002; c=relaxed/simple;
	bh=624SmO8XUNU38mpOIvZAumZSxp/fQT8P4sS1GJiW+pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFOvKF9Zz6ydwpJq+ufiN+CT02Htl+FogXGAyz6l0oQbP5ZPUo1zUVTwLUOb+D17LenH+ODd4gy/rMiHls6iVRNrXFG+Eq8kZNKehKID/6vEPGJJU5zBTo1uHKlIYqDaimCLgik4eLt9t6EKRl9JuLFajgQ3tCEpiMKRYgoD28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdEnEsW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727320999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utrx0K/+VugFVIukkmcrJK6P1DSpckYEB9F1vob9W3U=;
	b=JdEnEsW1plWAC6HZP0NR+Qfwt/Lj5m3ryUIsyIrpFw10gZWPWm7ocJnUsV5FTIx95crh7B
	LoHm8riShPrZyXs67cR+MAXdpn+KHbTWUjaBwfX28+KR34y/jnVDgN06KzyjKNJD8ruN/s
	tWjRT97BINKhb+P9hrvxf4U9NJab+ZM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-7yAz8LruPE6dXZbcRoFGBw-1; Wed,
 25 Sep 2024 23:23:16 -0400
X-MC-Unique: 7yAz8LruPE6dXZbcRoFGBw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8B8E19373E5;
	Thu, 26 Sep 2024 03:23:14 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (unknown [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1217A19560A3;
	Thu, 26 Sep 2024 03:23:11 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 2/2] KVM: arm64: Allow the RAS feature bit in ID_AA64PFR0_EL1 writable from userspace
Date: Wed, 25 Sep 2024 23:22:40 -0400
Message-Id: <20240926032244.3666579-3-shahuang@redhat.com>
In-Reply-To: <20240926032244.3666579-1-shahuang@redhat.com>
References: <20240926032244.3666579-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently FEAT_RAS is not writable, this makes migration fail between
systems where this feature differ. Allow the FEAT_RAS writable in
ID_AA64PFR0_EL1 to let the migration possible when the RAS is differ
between two machines.

Also update the kselftest to test the RAS field.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 arch/arm64/kvm/sys_regs.c                         | 1 -
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b09f8ba3525b..51ff66a11793 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2364,7 +2364,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .val = ~(ID_AA64PFR0_EL1_AMU |
 		   ID_AA64PFR0_EL1_MPAM |
 		   ID_AA64PFR0_EL1_SVE |
-		   ID_AA64PFR0_EL1_RAS |
 		   ID_AA64PFR0_EL1_GIC |
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
index d20981663831..d2dd78ce0e02 100644
--- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
@@ -126,6 +126,7 @@ static const struct reg_ftr_bits ftr_id_aa64pfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, CSV2, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, DIT, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, SEL2, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, RAS, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, EL3, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, EL2, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, EL1, 0),
-- 
2.40.1


