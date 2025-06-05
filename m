Return-Path: <linux-kselftest+bounces-34365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964BACEDC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 12:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EB1701E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85119217734;
	Thu,  5 Jun 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfYLkCY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE584215175
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119825; cv=none; b=XxvomefMbudTBIEySy0n8FnOUWYYsG52F6wYPDu5ar7C9tuMcDokI9f7R5Y0cuoYELJzGCKd7FQWlRZwZvPIv5+TPhtVskPrwTmR8sHJEThTP7blXpugJcmKXgSYalpDrW9iGmIMN0vWStz0K0t8oyIf85jrRtCXZCSTEK5uNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119825; c=relaxed/simple;
	bh=cOsu4Qrb+3bx73g5aMRxtPG7+Gkx5amoz9G8WVXNU9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvvVxqGwbwW6bJ8wgOBmWgW4YoorEP9qbXFLS4cyoWoxXWkw8LIZVYJZl1ls5pY34C3uuvhn1FoUutN1xP2WEWD3ebBpt3k/ry5QNgHxPtp3uE8PWIPzaLzQnHnNLKX+yD+LumNQSITDMmLBnKE6BUjHGGX8N7aemajiJxiKu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfYLkCY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiFig5XrzaKxrne/VffAS5Dccms79XHv1+bktez4Dgg=;
	b=KfYLkCY5Ibfns3yY5fwO0kFdujfCOVRQ+CtLu8D2PM/PFTK0SWpN/1TIGv+Gobpzh8humL
	j+SIfyVP4YtskmjMO8eoz+Z8LyAR98nmOOMGw/OGb/hqFgmatXm7e5aCMt8IBnkJZQ2nka
	+z1LU7rjg+CN4fN89F5e6oqRdk/jLIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-FAw9IqG-OMuS56taOHyqaQ-1; Thu, 05 Jun 2025 06:37:01 -0400
X-MC-Unique: FAw9IqG-OMuS56taOHyqaQ-1
X-Mimecast-MFC-AGG-ID: FAw9IqG-OMuS56taOHyqaQ_1749119821
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d57a0641so5613945e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 03:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119821; x=1749724621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiFig5XrzaKxrne/VffAS5Dccms79XHv1+bktez4Dgg=;
        b=AMtFP44YsCx2+W7wGjZAOJu8FAK6kcDiqR+TUbz1hWyfgqEQZmoL6q9vfIGtVhOJ10
         mo8GiSnhHYjic9ra82qxPYuvM7FjSlL7kxt3O5yvWnaqaNILE00k1arfbznpaXKMvJoZ
         sFguZF34x556Y7ccnAD2m6prmL8nDYagJ4VOHl4f8OUjTFwcastkHJaAQcLWpkMS0NBR
         IhdTqySIy2Q0jhUGOcX80mhUuFe1X5NFXn9z9cty2DmS/FgJypITBgSX4bKYExG/YAwG
         lVlT9KmtEDEW0qgE5VbqZtx8RHcPmgE5i6ORWp4hLfJlOuGjOJr3Mt/l8HmWzddsgFV5
         NGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3uL+qOTKae3eaLi70RLNRDeyxen7Cpx7ky2B7254tkGEyuBLqC3K0c2qKzKQisKy79M3UwgdgXVnfRaf5Feg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8w3+2o73ZZVVX88il6sbyCNg+K4Qar1lDn1GuO7/3YE9UsVvf
	j5R9+oBuS4GLRcg/Zi775abPg8Oy2hTU/aMxZS88f19LB0GS12AU1qJT3SZA98N8Iy98nEuGPD/
	eqtCmW75B72qta8eEeU6F1ywUdiEM5TLgzr+zGsYuXWonTvCmpQnGRF1ERhwmTsTMQ7zqmA==
X-Gm-Gg: ASbGncvbAVN9TYZWBnZcLAZUAZpBCxuHJOgasx+ytOVArrxXS9+k6/XYvtRn6YVXYXJ
	Y8WMmw4hztSypUltR8/wSxBW6GNpwpXqCSPbxJAVMn/P2O1cAtojstyJreOXTBGmH4SbVOw6N/z
	vw3uYtpmWmE9iJX07Ta/p41rvdvTBEqKgbMFVbjsWERRspIpDFypgtiNB/rhgM0JyWBBoi7Vbrm
	oOXdgGWlY5B0Cr6sdEMsPszAVa/grPvhstQZXgQXInH8xcjdQ3eCSZx9hEr2NCvZj1Xhay92Obr
	kvpkyvS+WZuJrQHg9M9ovJECQaLPeZmZNu4KSVq4/Iv7bXhUuuQF0x2iUJ052jSpPx80SJXjbg=
	=
X-Received: by 2002:a05:600c:828f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-451f0b26621mr50050475e9.21.1749119820630;
        Thu, 05 Jun 2025 03:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs6aFjV1ri9gglwDDly0k/rNzs1/j6SDKTIoXHxHHy0T2KK5H3bwQ524CbBRzv8yzrX28AyQ==
X-Received: by 2002:a05:600c:828f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-451f0b26621mr50050275e9.21.1749119820235;
        Thu, 05 Jun 2025 03:37:00 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:36:59 -0700 (PDT)
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
Subject: [PATCH v3 2/4] KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
Date: Thu,  5 Jun 2025 12:36:11 +0200
Message-ID: <20250605103613.14544-3-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
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


