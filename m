Return-Path: <linux-kselftest+bounces-32751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF3AB1783
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C01895229
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34422578D;
	Fri,  9 May 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIHQV3Uq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E63224B0B
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801213; cv=none; b=bmErqxgrrnSbKzuxGTH2ZivvvsNioumLDT3Y1RWpKPwO2oVyFUlUAYoBWLcWo/Rwcw81TZ6t0iWrfSF0IEex3IQwPdMZMCXBEyyP6i/h/aqlxa9ey1ReUUjOLb2iiKQ+GHRJUzcvbQOzGOM3ukOIJNuEC83LNq3y8lOnM0LKrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801213; c=relaxed/simple;
	bh=VzQyPkruYWrDZAOkmL/UT3N0xShjKnGR9pQJo0jQ/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8S4E7Ie+Vzcwqpdf9IQ607uWCoZgOlF3zjoKFDMq6gh24JPBOJ8VICQaz41uMnTiW5TMbr3y+g6vudiw/SxX/38pMoAWbgP8w7J3HfaGU/GCtNXVMQ9BCOHcbNCShEzJ3QY616t7axJAOXAFUKHH45GXEkVfN9lCG4gMLBxN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIHQV3Uq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746801210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
	b=LIHQV3Uqf20LMnyYuk5o+h38tv1TTVN0eleR1flo8tjjdjlA5NQOPNkETc4k8ixjt1Dpbv
	dfDyYrS9ULIvAi/ymJmxt49amXSKTypEpif+JKpvuT1F2H2k6WiODC/vMQUnlCECXr3UAE
	zoc7gVjj1iPK77XL0v7FwIIoZ8EO1rA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-dWcQ-gSgOIalv9ZLkokIBQ-1; Fri, 09 May 2025 10:33:29 -0400
X-MC-Unique: dWcQ-gSgOIalv9ZLkokIBQ-1
X-Mimecast-MFC-AGG-ID: dWcQ-gSgOIalv9ZLkokIBQ_1746801208
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so15407945e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 07:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801208; x=1747406008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
        b=FEaG3mEE7H/bM2bluLnCuNcYPNd3d8M3gRvIygb0hWMvRFcL3E7qOgR5l9i/yPoCA9
         6omtAwbig0yuir7BBKh+qwKJeMaMohBO1TD1dJpl6jKuSdnUmr1mRFlKp5SSZdhXjqBP
         4FVLc8tDo39WGqPJJXDJWxXhNx4XtLZ6CGJaJMqmDqbMODb15qLmAhlldXMKSbm6hdq6
         WzEHBAOLkijeXuiqT6ALlgBD5jIWDid4slGF7GuxapRcDk3+vZJGeMksFzFlECeEWe/z
         t1QKU3jPWgauh/OE0f+V7nhLbUKWD1O2BP4HcX6/qqwtB44gwzY4L7uKLUg/GtWkQvun
         kaWA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Y7tQ4UhdS4E0I3HKxk9SNnD/eeaLGhXvhHSGxgHxHqc/vp27a+cfpjp3FhK94Y7q9EzIy9xFEruejOaGnDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWU39dMbHVTkIfNl/Ha+XLejKFpzh1LCb8WIlG0ZQrI0vVKf37
	+ceVKLWjoo13pVYF7FuDJZ442GkOzfQ493McN1iQ1AG+vObyZZngkQIthjv2lAjTBWeX+GFC8q/
	4qnUtHIJWhnfn04See9zmM6cVvU8BkA3XDBvYOkoFNIqXMbGNEpQ6sVMTeRypzdPBRw==
X-Gm-Gg: ASbGncu/3As/fskFkMMVoCgLruWI0vEfPQxx/23vYKBE/wQbVCEWMyhjASAtfFUGyWj
	dDIu40cK7wmSYBXnJsWKRj+G58B98tvAR/xLBsnh4P/KBsLvyIG9OojnGSbbn8WmREpakH3LWIp
	Qrz+XTjlW6xPDxeEa48P5dc3bfYGgQ2evGgPB2ROCMreYG25CghVnm0ASBtiq2hCWmxyIUwGraP
	EEMznhJ7sKAl3rKV3PPAh5xnARvGG7aHaWIsfAdtfHntUujALDBx59S5aq70M+x21BP6y72l4W3
	85UKjYVQoPPsn55Uo1yWejlpt6Zt8/JFsS+y4MCKcCzXdIAJdys9lJkAz5/kPifo8Lz3JsTm3jQ
	=
X-Received: by 2002:a05:600c:83ca:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-442d6d18b68mr35853795e9.3.1746801207827;
        Fri, 09 May 2025 07:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm9MkDy/quubUQsSnalTOipje79m4aFFrG3Bj/W0QEAlm0r1Z0dt5gqWlFblcQZwsloaT3Fw==
X-Received: by 2002:a05:600c:83ca:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-442d6d18b68mr35853555e9.3.1746801207515;
        Fri, 09 May 2025 07:33:27 -0700 (PDT)
Received: from rh.redhat.com (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm32150775e9.4.2025.05.09.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:33:27 -0700 (PDT)
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
Subject: [PATCH 1/3] KVM: arm64: selftests: fix help text for arch_timer_edge_cases
Date: Fri,  9 May 2025 16:33:10 +0200
Message-ID: <20250509143312.34224-2-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509143312.34224-1-sebott@redhat.com>
References: <20250509143312.34224-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the help text for arch_timer_edge_cases to show the correct
option for setting the wait time.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a36a7e2db434..c4716e0c1438 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -986,7 +986,7 @@ static void test_print_help(char *name)
 	pr_info("\t-b: Test both physical and virtual timers (default: true)\n");
 	pr_info("\t-l: Delta (in ms) used for long wait time test (default: %u)\n",
 	     LONG_WAIT_TEST_MS);
-	pr_info("\t-l: Delta (in ms) used for wait times (default: %u)\n",
+	pr_info("\t-w: Delta (in ms) used for wait times (default: %u)\n",
 		WAIT_TEST_MS);
 	pr_info("\t-p: Test physical timer (default: true)\n");
 	pr_info("\t-v: Test virtual timer (default: true)\n");
-- 
2.49.0


