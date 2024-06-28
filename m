Return-Path: <linux-kselftest+bounces-12911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC991B6AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 08:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2173D1C20D18
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D6481A4;
	Fri, 28 Jun 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtdGV2u+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9547796
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554711; cv=none; b=XhDzUttljfmXa9vmQ0ENLybjfdjKplXkAq9UtEGRU9VBmY7sUinekYMGKhcB7ZeZtFSBXzeayZnN9ybMpGNVMU8+OQOwNgjsZsdo8gSQDXWgNJtI7wg7NlWaU7zybkjMks4CcOlUbsp/49bmpL0m19/1H8r98UuHpa1661xkm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554711; c=relaxed/simple;
	bh=lU1XvXjiFFxsti9Je9vlciruaCZtXmC+z+HqWsgjafU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDqubKYdBkehFRX5o4aOnU/IdcTRgkk4UK8rk+CxboTikWzYtByeCElSmeLR5ymQmxu6EY2puFDl2kDfe8SSFbcCWII6XSCXOW3TwwuPn7krOq863IHr54FRRS9JEdXYSL2TeeC4woGGpls9OJQtNfcXMOxnZ/1EEoUzBT8OTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtdGV2u+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719554709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ajvn4ITctkTMolN6abYxpt2/qWjVElb6xUSFcHxU6sg=;
	b=JtdGV2u+8g8Kc1ujLZhReX8T3pOeq5bzZd2uvPD2u5hgxvkPA5Wmtg5s7UdKujzrMqral4
	BGE2OIz0LD/vdaCwQ2QYAuvY0jPxy0sJe0XblPYPyTa8ypJgqZigz8qVdulMBNjFt5fxX8
	wuRLfcDD4adMQ2NoASldHu99357Vbns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Uu0m_sE3NF6Jx4ije6529w-1; Fri,
 28 Jun 2024 02:05:05 -0400
X-MC-Unique: Uu0m_sE3NF6Jx4ije6529w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C1E91955DA6;
	Fri, 28 Jun 2024 06:05:03 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0819419560A3;
	Fri, 28 Jun 2024 06:04:59 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
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
Subject: [PATCH v3 0/2] Allow userspace to change ID_AA64PFR1_EL1
Date: Fri, 28 Jun 2024 02:04:50 -0400
Message-Id: <20240628060454.1936886-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow userspace to change the guest-visible value of the register with
some severe limitation:

  - No changes to features not virtualized by KVM (MPAM_frac, RAS_frac,
    SME, RNDP_trap).

  - No changes to features (CSV2_frac, NMI, MTE_frac, GCS, THE, MTEX,
    DF2, PFAR) which haven't been added into the ftr_id_aa64pfr1[].
    Because the struct arm64_ftr_bits definition for each feature in the
    ftr_id_aa64pfr1[] is used by arm64_check_features. If they're not
    existing in the ftr_id_aa64pfr1[], the for loop won't check the if
    the new_val is safe for those features.

For the question why can't those fields be hidden depending on the VM
configuration? I don't find there is the related VM configuration, maybe we
should add the new VM configuration?

I'm not sure I'm right, so if there're any problems please help to point out and
I will fix them.

Also add the selftest for it.

Changelog:
----------
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

Shaoqin Huang (2):
  KVM: arm64: Allow userspace to change ID_AA64PFR1_EL1
  KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1

 arch/arm64/kvm/sys_regs.c                         | 4 +++-
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.40.1


