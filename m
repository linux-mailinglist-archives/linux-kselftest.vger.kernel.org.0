Return-Path: <linux-kselftest+bounces-14059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAE939BA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EF51F22BCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D914AD3B;
	Tue, 23 Jul 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmE5h9ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346813C68A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719223; cv=none; b=Hf3qOOKgR9r/aAMGa4txbYX81bI957JqwqwbhnwDKaLGgFgoTd//CiSdFiNDuxbSacw89FfWdcqNyth/ZMp3oE69uxJU5yH3Fn1FOQhNmoWd7voDm7y8r09z+C6TDH72iOK5o5eCm++z2d5SwQcgVEEMp5tWGsq0RWiFBqrnV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719223; c=relaxed/simple;
	bh=ZXzGO5dmDeidd3BRiSnDakFqMveADiJcUiUiaXY7wX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2UjdVlQWt7M0Ew+mxVV+tytVXUWsiiB9xkqGVkw7hXSUONm0Ucr+5sr5DhXnENYHvMY0uT0NrT4juOLgLQiqfJYYMpAQxJon8aNaxyemAjqmFC1LLWT9dLWgmu6f7V/VCF1KEvqspoNiSIRXQbjQVwUlb65I2kPfEY1ktzgOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmE5h9ck; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721719220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxeEIWgw+QlKqllfZg7rnP4x9/FSOChR4+aHAj39Qi8=;
	b=NmE5h9ckgQ71wGjXYeyrD5ppHll0PwuzSI/cJZS1NXulD58aBomiIS0jSr/slPzOZ/fkfw
	5PQVSLmQrnLAAaz84qzz1o9nKbvVQ3Pnnir7E50WdDUY7oilFzZ33et5x386DdxNo+hX1b
	WQR99URmFRegklC6dkpgAl9MRhCxM5A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-4Nz8a46_NGWSK468nJ3Teg-1; Tue,
 23 Jul 2024 03:20:16 -0400
X-MC-Unique: 4Nz8a46_NGWSK468nJ3Teg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD7C519560A2;
	Tue, 23 Jul 2024 07:20:13 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C54881955F40;
	Tue, 23 Jul 2024 07:20:09 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Cc: Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
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
Subject: [PATCH v5 0/4] Allow userspace to change ID_AA64PFR1_EL1
Date: Tue, 23 Jul 2024 03:19:59 -0400
Message-Id: <20240723072004.1470688-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi guys,

This is another try to allow userspace to change ID_AA64PFR1_EL1, and we want to
give userspace the ability to control the visible feature set for a VM, which
could be used by userspace in such a way to transparently migrate VMs.

The patch series have four part:

The first patch disable those fields which KVM doesn't know how to handle, so
KVM will only expose value 0 of those fields to the guest.

The second patch check the FEAT_SSBS in guest IDREG instead of the cpu
capability.

The third patch allow userspace to change ID_AA64PFR1_EL1, it only advertise the
fields known to KVM and leave others unadvertise.

The fourth patch adds the kselftest to test if userspace can change the
ID_AA64PFR1_EL1.

Besides, I also noticed there is another patch [1] which try to make the
ID_AA64PFR1_EL1 writable. This patch [1] is try to enable GCS on baremental, and
add GCS support for the guest. What I understand is if we have GCS support on
baremental, it will be clear to how to handle them in KVM. And same for other
fields like NMI, THE, DF2, MTEX.. At that time, they can be writable.

[1] [PATCH v9 13/39] KVM: arm64: Manage GCS registers for guests
    https://lore.kernel.org/all/20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org/

Changelog:
----------
v4 -> v5:
  * Only advertise fields which KVM know how to handle to userspace, leave
    others unadvertised.
  * Add a new patch to check FEAT_SSBS in IDREG instead of cpu capability.
  * Tweak the kselftest writable fields.
  * Improve the commit message.

v3 -> v4:
  * Add a new patch to disable some feature which KVM doesn't know how to
    handle in the register accessor.
  * Handle all the fields in the register.
  * Fixes a small cnt issue in kselftest.

v2 -> v3:
  * Give more description about why only part of the fields can be writable.
  * Updated the writable mask by referring the latest ARM spec.

v1 -> v2:
  * Tackling the full register instead of single field.
  * Changing the patch title and commit message.

RFCv1 -> v1:
  * Fix the compilation error.
  * Delete the machine specific information and make the description more
    generable.

RFCv1: https://lore.kernel.org/all/20240612023553.127813-1-shahuang@redhat.com/
v1: https://lore.kernel.org/all/20240617075131.1006173-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20240618063808.1040085-1-shahuang@redhat.com/
v3: https://lore.kernel.org/all/20240628060454.1936886-2-shahuang@redhat.com/
v4: https://lore.kernel.org/all/20240718035017.434996-1-shahuang@redhat.com/

Shaoqin Huang (4):
  KVM: arm64: Disable fields that KVM doesn't know how to handle in
    ID_AA64PFR1_EL1
  KVM: arm64: Use kvm_has_feat() to check if FEAT_SSBS is advertised to
    the guest
  KVM: arm64: Allow userspace to change ID_AA64PFR1_EL1
  KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1

 arch/arm64/kvm/hypercalls.c                   | 12 +++++-----
 arch/arm64/kvm/sys_regs.c                     | 22 ++++++++++++++++++-
 .../selftests/kvm/aarch64/set_id_regs.c       | 14 +++++++++---
 3 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.40.1


