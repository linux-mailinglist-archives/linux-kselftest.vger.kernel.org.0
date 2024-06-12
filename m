Return-Path: <linux-kselftest+bounces-11728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B472790490D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 04:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605D81F24414
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 02:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500DF9EF;
	Wed, 12 Jun 2024 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfbOMOqm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53CB667
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159775; cv=none; b=f53aQZAtWby7UZm815C2ALa7ApTXwLqZLCN0dn4AUINucpItDphatzTOWIoC7fdebID6yLX8VctsJQySB/D7GCk0tXWwFV+GbiL2xgSKJSUeETjmFzeqiNptjH5W6zTjJKDxjzWfzvVStaRfD4r7nuGm8nnxV3ET+98YI0xfqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159775; c=relaxed/simple;
	bh=+zTXVVp9zEYSS8FpmkYG3jt7vMygW3q5VbDW7BOSSik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c5t+7BzVNDFf/5htrC4IgwvGUUnR9GwwZTgHZcp2A+9K/ELUTMVRMIYL/+xHb4oOo8CHcG7mGUfKVDvFm3G3c9dPRElC5+irPKrvncx/Fdf2IsWWw8q2zbFTxi9LhkbBaiZkOOzpcEGRW5ZdAH0f/N66n+DMbdmaQLX61nwRQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfbOMOqm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718159772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rm5KrzlMz16jgYDKm0W+81rd6UxTby42kLMaocYRJT4=;
	b=JfbOMOqmnoX0TLvZ8wCA94qgw3V2gZ7ALSL1H6Uti7ncN1majBr03iGYq5yr0dfT+Y90MK
	+Tcbp4vX6AaIs+PXU4N2RVwR9ML7vBi5+bFXKHT3NDbOecdX8cYM4IemwdxXgp6lz8LEoa
	Ib7aPhaNQtKVh9mMJHE/LrLCZhQJDe4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-I3EBlmaWOheMu2EXI5MiEQ-1; Tue,
 11 Jun 2024 22:36:06 -0400
X-MC-Unique: I3EBlmaWOheMu2EXI5MiEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E358019560BD;
	Wed, 12 Jun 2024 02:36:02 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E53B19560AD;
	Wed, 12 Jun 2024 02:35:58 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
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
Subject: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1 writable
Date: Tue, 11 Jun 2024 22:35:50 -0400
Message-Id: <20240612023553.127813-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi guys,

I'm trying to enable migration from MtCollins(Ampere Altra, ARMv8.2+) to
AmpereOne(AmpereOne, ARMv8.6+), the migration always fails when migration from
MtCollins to AmpereOne due to some register fields differing between the
two machines.

In this patch series, we try to make more register fields writable like
ID_AA64PFR1_EL1.BT. This is first step towards making the migration possible.
Some other hurdles need to be overcome. This is not sufficient to make the
migration successful from MtCollins to AmpereOne.

Shaoqin Huang (2):
  KVM: arm64: Allow BT field in ID_AA64PFR1_EL1 writable
  KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1

 arch/arm64/kvm/sys_regs.c                         | 2 +-
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.40.1


