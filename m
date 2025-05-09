Return-Path: <linux-kselftest+bounces-32753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4786AB1785
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB891C45B31
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD135227BA1;
	Fri,  9 May 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvRc7B2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8A225A59
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801216; cv=none; b=UG+h9Yuxqj+IidAGR0KeTtd50SUVwoKYsauarwaP5rRX/3fbiUICjEY0zP2F2S35pCSU0baKZf4Z+5jbvP2971j9NtWhEENBNZWN+bwTU/nZHLnTHOcwz/dnFH7tiAw3kmiCiYKFHW8t/T68GTGgVpm2iZq60zi7pvRAlCsj5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801216; c=relaxed/simple;
	bh=naf0ZTgkhlpI+qKa6xvqWgk8ol/hCC97goS1SGCaatU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2IVO8Z3Gfmep3SLqhUI+rGrg13YJ5XAilpnaGKP6HBUVTfHVI6SSOCHC2JYK28zwAO+uiPLtFO5nfy2BLAijI2GZZ/6YVQebdRXbAQzVrcGOAWEEYkw4epbKxV1xYNCjV5uTM9R1lnY2kcZ2+h7DErhfOOUaSWxSP7nrl7QZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvRc7B2o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746801213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L+bu3C5bNo3IB9ZkU52/sTrMkPyP3mUjU6YriIz+Oo=;
	b=DvRc7B2owQI3WTmdMtGX/wYtUiAJk+8lzM0ymOeFWqJZG/w6DymINaDyRR71D08A66vbnA
	RtDZs6SpmbZQvZhq7UEuSI4mxocPOfe1Kx1RXALJbterFX2NN7ymCiKxTTOa18zg8c/Wft
	TodrK4RJmCjS48s0dCmbJClkTFEh0+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-5R-m7RqLNc2KpIMxQCU5cw-1; Fri, 09 May 2025 10:33:31 -0400
X-MC-Unique: 5R-m7RqLNc2KpIMxQCU5cw-1
X-Mimecast-MFC-AGG-ID: 5R-m7RqLNc2KpIMxQCU5cw_1746801211
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so10277255e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 07:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801210; x=1747406010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L+bu3C5bNo3IB9ZkU52/sTrMkPyP3mUjU6YriIz+Oo=;
        b=d7MElKWz74XUtoxi9TGiu+WhEvBUgUjYOVMOw1nFlsnE/ZU2oy+BEE05WCazR+Houb
         lGVkfakV/OmRwZXGIbvSvFD2Kxu5HIdbFpPbigbSidL1WJxG24VBQZvdzdwWAqIO/rO4
         Q7gPLaeL9TLiBV8BsPD10WyAQFwY6waMSIg/pi6RfqMl67gFQ/7wiAAoHWFaIKXZ0heY
         TJ8U8cWRbPrJdamBt9aQ3shym4rK1eLx3tjYlma2btkfwcAkjy8/VD/OivHfIDAPXDdW
         fXy0L56plvV8w5c+ZsUo1xHKf13MESBJ3Ghee/lvKZLkhcs1P/CtP+OhLMOzpWncTwCv
         bv5w==
X-Forwarded-Encrypted: i=1; AJvYcCX60m/un/ds7XlKPprAPOja2KKZYIo5m1pa+BefRTfZCwadWK4oFUUGnZDsZbL0VaUFNaO+DeFoqZA0hwNvGus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9i2WFvtqCq7VKKC3cVFKt97nj8qzDIvgwYbee/5vXfoW5hoC
	NiWokTK3bzUTfmUgW7tqBpcP7tiL+BcOtBdBjPpf2GJ6V7kbCzv7b+BNFJzZ5Sa9s2yLxtLSkTm
	re3z7X9mvcfxlGxEHBeqBziK9x6BRupjz4fN1vEBgYrKpN5/R5L/xPEdaKtsOOHzQ3A==
X-Gm-Gg: ASbGnctE6V+im05Cx0jxUKuHzQd9k+X7qcHAwkMAEqATnjNiYfbc3ShX91QjQDEoMEe
	Zi8D2eFcBj8aYsH8ohxQTPDpKg55PGK8pmG0XLO04CyFsO7XR+kiH/u2yNOG1yhCXermkQSeUIE
	t9eyslTPEY84N/PZkqUO5HfDzz65GzSCFsAd6sVMf6Kg5Q8Ljg2ATJA2fsbfp+lb9DCym3y90S7
	AJPSaHs95HxZN8M9SoqEAFJPuJcLOfXRMnT0JKiw8rBPpLS881iKU7Zh4YGhpfPJivGbAdidrS/
	nnh7DYVQi1aK2XgZBy9ge4lBCi8fxQ4VucE4W4pVht5iLFXf6jOpv6DRw5+SmDDiYpAGADv4O5M
	=
X-Received: by 2002:a05:600c:a42:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-442d6ddcff4mr23932655e9.28.1746801210567;
        Fri, 09 May 2025 07:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkHBgasEQcr/4ZVQSpWJmPLcvd6o7zSPvgSmEK9zaLE7PuQpFCA6hRhF0NO2Opfzb52f6PlA==
X-Received: by 2002:a05:600c:a42:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-442d6ddcff4mr23932325e9.28.1746801210127;
        Fri, 09 May 2025 07:33:30 -0700 (PDT)
Received: from rh.redhat.com (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm32150775e9.4.2025.05.09.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:33:29 -0700 (PDT)
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
Subject: [PATCH 3/3] KVM: arm64: selftests: arch_timer_edge_cases - workaround for AC03_CPU_14
Date: Fri,  9 May 2025 16:33:12 +0200
Message-ID: <20250509143312.34224-4-sebott@redhat.com>
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

arch_timer_edge_cases currently fails on ampere-one machines with
the following assertion failure:

==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:169: timer_condition == istatus
  pid=11236 tid=11236 errno=4 - Interrupted system call
     1  0x0000000000404ce7: test_run at arch_timer_edge_cases.c:938
     2  0x0000000000401ebb: main at arch_timer_edge_cases.c:1053
     3  0x0000ffff9fa8625b: ?? ??:0
     4  0x0000ffff9fa8633b: ?? ??:0
     5  0x0000000000401fef: _start at ??:?
  0x1 != 0x0 (timer_condition != istatus)

Meaning that the timer condition was met and an interrupt
was presented but the timer status bit in the control register
was not set.

This happens due to AC03_CPU_14 "Timer CVAL programming of a delta
greater than 2^63 will result in incorrect behavior."

Work around this issue by reducing the value that is used to reset
the counter and thus reduce the delta.

Link: https://lore.kernel.org/kvmarm/ac1de1d2-ef2b-d439-dc48-8615e121b07b@redhat.com
Link: https://amperecomputing.com/assets/AmpereOne_Developer_ER_v0_80_20240823_28945022f4.pdf
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a813b4c6c817..2f0397df0aa6 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -31,7 +31,7 @@ static const int32_t TVAL_MIN = INT32_MIN;
 static const uint32_t TIMEOUT_NO_IRQ_US = 50000;
 
 /* A nice counter value to use as the starting one for most tests. */
-static const uint64_t DEF_CNT = (CVAL_MAX / 2);
+static const uint64_t DEF_CNT = (CVAL_MAX / 4);
 
 /* Number of runs. */
 static const uint32_t NR_TEST_ITERS_DEF = 5;
-- 
2.49.0


