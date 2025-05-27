Return-Path: <linux-kselftest+bounces-33863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306CCAC50D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7743B9D44
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCFA279918;
	Tue, 27 May 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5Tze+Qs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E72797AB
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355893; cv=none; b=kLdl4tpm8pSUtEXQOwXbm1pcOv3ZmEfIXN8//llQ+gHteA4kDtAcFyaLryapfFvtT4teV48eemxEeZztg7mj6UA7XmHBXRUIKP/kQwmcKevXPFJHtUB+AXz95rrlnKINetsE2UAPcrY3X/hw3JZ+J2ZOY4h9O5vtbo8IkkDVV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355893; c=relaxed/simple;
	bh=cOsu4Qrb+3bx73g5aMRxtPG7+Gkx5amoz9G8WVXNU9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocw2q1vli17Pxzsoax0i6gsGR/r33KJLytsr0Orpfi6vdYVx4sbfK0p6oGFSMhTuBUKutHQi+gpvTjqo/Y6Sli5mEuYwYTy/z4OgTi5lOmBymQ6YL1uXljW1E93QGJjITJsoU2cLv0SddtaVN56Hr8/qcvgkIVZHfWzhqSVxmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5Tze+Qs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiFig5XrzaKxrne/VffAS5Dccms79XHv1+bktez4Dgg=;
	b=O5Tze+Qs1Eobne292XTe9kfq4cEs3VPUM8oCAR2iXn3RgzA2CdK/1WQQumCRc8wT86DtCm
	7jFVeiKOYjoH6wjmIOyF6zqmwP64kREFJMr+NCP7+pai6KyK9JWIOKngcVevHzD9uYFHNy
	wcvjNjRyvwv3NL4f3YIv0cvjEI/NBWo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-1jDjmJY4N2qZQ1hN1N11OA-1; Tue, 27 May 2025 10:24:47 -0400
X-MC-Unique: 1jDjmJY4N2qZQ1hN1N11OA-1
X-Mimecast-MFC-AGG-ID: 1jDjmJY4N2qZQ1hN1N11OA_1748355886
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-441c96c1977so20470725e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 07:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355886; x=1748960686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiFig5XrzaKxrne/VffAS5Dccms79XHv1+bktez4Dgg=;
        b=jXlRUINE7RdTnkcS9BrkYUSvB5SJBeuY2pQKLjrC13eQI39B0qPPsX40L6MXCsQtO9
         5/kjminZGdYre84JsuD7dO5N7khqcXmcNfWByjSdTUbXJvUO3DjdMrLdSp2+td7+MZPH
         Nmc7YfckqfERWxPtlkEp3tQRojjFkaC9IFWpLY3tk+53fDB8g07uj/vs6KYTg90Wtjx8
         Qhq8cADrQEEx/o5iYKLaNOwk5MLoPecW3j+MUSPc+4x+4EbIBn1rro5oEdD7t9Pknkyw
         sAMyDWvm73HIFotUhrOupBVezJ4Sf4Nn2kzlJ8B0B60Xq/aaH2umTkEhLbVcsMnaO8IT
         9pRA==
X-Forwarded-Encrypted: i=1; AJvYcCU30W5fUstoZzi5w7EzSotuZS1La76NNIY6rO6/+LbE/38QWf/2vG29uucrv5lRybT3FsHOkmQ8thUPdDV3Isk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LLXwuLcwQ5YJGkSBuo7d2TukSHhYkBpZ/dK1lJQ7RWySzZT5
	ZyQFF65yyXGPj8eTke5Cf80FAmJ6OjM2hN3FAGuTQX6EkPJEN5eNmggSvpV9pmsbRNp9QihtBq0
	dqhy1dvVzr8hEhVfcEZVC+CP3KAXwhzVKan5dsV9ykS4Na3vD3p3WKAPgwo+yL3H9sJhUaA==
X-Gm-Gg: ASbGncvP42jhxYWum82GQGpojWA5QE5FrKow0M1hAk2BRv9fG3mWaiM1Tdc1JI/Du6N
	H5FmVgdCoBh9+4goHXblo+VjJ1XYqle1xh0iOkHtO10ZmpPSPrHmM2nTPO/XjOgmNKaoOcKVb8m
	htEdubdD2tUHaqtk2wftFe9Y8nW+OiYsIoeaGfOCzO614lrw+rqPCpbGnOLt2p4JimYgneJqQQ1
	XJdfEIdmdEmJD7MJCCAUot2yRBxChrAsOdI7HVchxAdg9rzXHxW8xt1PJr8fGlQ5CdUKI+46Lqk
	rPnYQTZ+QkDmIUNHUoJDVGxoSWIwFuB5xkSkMfhDfHOoE5CdPO/Ncjk67igTro7fMRXjVD3pEg=
	=
X-Received: by 2002:a05:600c:5120:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-44c94374ed0mr124869935e9.14.1748355886241;
        Tue, 27 May 2025 07:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELzaCUvaTNc9Adiu9Az9zHtuATeQC88HKSvkrZ4YDOc4EmiLqQ4b0pQxQ8ybi5Fu++RvO9Hg==
X-Received: by 2002:a05:600c:5120:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-44c94374ed0mr124869595e9.14.1748355885791;
        Tue, 27 May 2025 07:24:45 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm278766415e9.20.2025.05.27.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:24:45 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v2 2/3] KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
Date: Tue, 27 May 2025 16:24:33 +0200
Message-ID: <20250527142434.25209-3-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527142434.25209-1-sebott@redhat.com>
References: <20250527142434.25209-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer_edge_cases tries to migrate itself across host cpus. Before
the first test it migrates to cpu 0 by setting up an affinity mask with
only bit 0 set. After that it looks for the next possible cpu in the
current affinity mask which still has only bit 0 set. So there is no
migration at all.

Fix this by reading the default mask at start and use this to find
the next cpu in each iteration.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index c4716e0c1438..a813b4c6c817 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -849,17 +849,17 @@ static void guest_code(enum arch_timer timer)
 	GUEST_DONE();
 }
 
+static cpu_set_t default_cpuset;
+
 static uint32_t next_pcpu(void)
 {
 	uint32_t max = get_nprocs();
 	uint32_t cur = sched_getcpu();
 	uint32_t next = cur;
-	cpu_set_t cpuset;
+	cpu_set_t cpuset = default_cpuset;
 
 	TEST_ASSERT(max > 1, "Need at least two physical cpus");
 
-	sched_getaffinity(0, sizeof(cpuset), &cpuset);
-
 	do {
 		next = (next + 1) % CPU_SETSIZE;
 	} while (!CPU_ISSET(next, &cpuset));
@@ -1046,6 +1046,8 @@ int main(int argc, char *argv[])
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
+	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+
 	if (test_args.test_virtual) {
 		test_vm_create(&vm, &vcpu, VIRTUAL);
 		test_run(vm, vcpu);
-- 
2.49.0


