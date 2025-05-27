Return-Path: <linux-kselftest+bounces-33861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E7AC50D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445501BA15BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061E279355;
	Tue, 27 May 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIadMwCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42924278153
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355888; cv=none; b=gDAfqIvom/0wdWv7JTwv5F8A1vvHm7Hj4WjauiChBxJat64CG39RTyWeZmVaRuah6/0J9fnP70cENEwnrkjtQoWYNGPX0uwAdpDuMJxNUq2vCq2BG1bQ21BHlYeNqSo0CHsMVLewrlUDO58z5oo7cDPcn8yzkD5SIsABb9NWQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355888; c=relaxed/simple;
	bh=+SSxOMMFNEUYqXyhOMZxzDFcaBj3MIuICtYi5zenoUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOO5S9xof3+kj/lMqPv+gsU+F5Zr9HeT3IhqZjdS+aRp6GdfMWaKKN3f1DfPQF26tpsE6TXTTwpVhLb+0ulGLrTES3pLCOvYeLyIS09eOvP3Tec/UBShAbWSy+ndKQqOjr4Bu38jVYlI5D1pjGVbayx5n/8pycX7jv4xnQlLY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIadMwCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+M4G1HOIYzO3zH6634YUQensr31XqNL9E1Ubp3gcMeM=;
	b=PIadMwCroN4I5ZpYD/FMKQ3Qa383bHOvIOvwrWKzPHx8uVBY6Ndt8/yD5RWfyLGMaf8IB8
	oTotT9ve9BqgZWz9jNjGVekbZbqiWgD/Qjy6ofH6b+F4ZzxP9ClVNpDFmkgAzsjwNEsON5
	L6Z4qDPNCda/J+esoBn1AdWL62GI2Ns=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-0CfMEyklN3WS2ej9-sNU-g-1; Tue, 27 May 2025 10:24:43 -0400
X-MC-Unique: 0CfMEyklN3WS2ej9-sNU-g-1
X-Mimecast-MFC-AGG-ID: 0CfMEyklN3WS2ej9-sNU-g_1748355883
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442f4a3851fso25272655e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 07:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355883; x=1748960683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+M4G1HOIYzO3zH6634YUQensr31XqNL9E1Ubp3gcMeM=;
        b=lyVDJgCtg/e33Ot5sdBnCL0mLFzFfDOTbU+8ENTYExkqNFbD3ifLH+zP0FZ5DJ5F/q
         e35Qj1qW/avodAfre9fBgZLreBNKIrgq1MvaYJPh/3wG8VYtuLYFh2Usz9vPzX4k54r+
         BTYXSAVS+CFsVW2hvRGmkLeN8YM68TjrEVMQnz7SkFDRrkcXbhqGgyx4frg5hE9D3md/
         l5TBdlw5YdyN5O+gAF9wqxmZJDhl/EeFPHHXoeQFTSKz1e0DgQ7ffrgA+tkBYmrL/MS3
         l0xiZ89iK5wxFtYllTPjitmDB7P7l0RsPpbJI8qGL5xR4b/W2ecGqzOnfNc2T9Qcz7Pg
         A0bw==
X-Forwarded-Encrypted: i=1; AJvYcCWlB5IU0juWsRWt7TIoPeGjSY/v9RqqG+p33EvxnvNme1IEjrqCNvKcgjs+D8Y3kaYj3ocZpdFrgbPi9R+EW0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdsiRBX4mtzeO1ENwhElUxpmehCEDm3T+mt8PYXLDtbu8g728
	XvJXrUBXRNxyms0Vcy937+Xa+P14k1x6Bwsr7k5xtjKfExLESygKatrRRiKtGYn0vedvP4fg28H
	3e2IeVFSEa/PWfdG2X3lJr/8BWRQ5/mTlFYEXJo1nZxF1qd4IvQAx4WZ9RTrkjNnKHcg6hg==
X-Gm-Gg: ASbGncsF4N/xrBn8WumDP4BBrALQs3U1ZK3Fr5KKF+VPp/IXB92XI4KahtKbXwQ0fJY
	09KmnGIpZqXTCKP/Q/wMxBP43R9nd2pvQqEKXuKBposuK5c0Is7bUy878ct/TVmOHY9RyY2pIen
	J19lj2+KyLg8ZHuVI89L720hryvriHTIvm+fjqZAIcwW/s8bDCUYDqRfv+lvxKX7nIEyQqe/hrj
	d4OJo42vyfO17jmhlH3bSAgu/WRSB/is6CTGQa9HlSf8yT7ljfkpO2QJCBo2ULVSaEGeAD2vTjO
	ePYhvUB5wSmL7Y502PBb5+Dlonbi0+3NaIYQFtOfMgvo9NPGjiMVAPM6Wk8pyR5jVki2O652TA=
	=
X-Received: by 2002:a05:600c:3ca6:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-44c9465c97cmr126923765e9.17.1748355882708;
        Tue, 27 May 2025 07:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Y1uyM7+4XnYXdfaOr89AGuzVgzEd4y5M+LgOhzm3Rp5mg6OEofI/yliTAkfcRwsyfx9W9g==
X-Received: by 2002:a05:600c:3ca6:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-44c9465c97cmr126923535e9.17.1748355882319;
        Tue, 27 May 2025 07:24:42 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm278766415e9.20.2025.05.27.07.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:24:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] KVM: arm64: selftests: arch_timer_edge_cases fixes
Date: Tue, 27 May 2025 16:24:31 +0200
Message-ID: <20250527142434.25209-1-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some small fixes for arch_timer_edge_cases that I stumbled upon
while debugging failures for this selftest on ampere-one.

Changes since v1: modified patch 3 based on suggestions from Marc.

I've done some tests with this on various machines - seems to be all
good, however on ampere-one I now hit this in 10% of the runs:
==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:481: timer_get_cntct(timer) >= DEF_CNT + (timer_get_cntfrq() * (uint64_t)(delta_2_ms) / 1000)
  pid=166657 tid=166657 errno=4 - Interrupted system call
     1  0x0000000000404db3: test_run at arch_timer_edge_cases.c:933
     2  0x0000000000401f9f: main at arch_timer_edge_cases.c:1062
     3  0x0000ffffaedd625b: ?? ??:0
     4  0x0000ffffaedd633b: ?? ??:0
     5  0x00000000004020af: _start at ??:?
  timer_get_cntct(timer) >= DEF_CNT + msec_to_cycles(delta_2_ms)

This is not new, it was just hidden behind the other failure. I'll
try to figure out what this is about (seems to be independent of
the wait time)..


Sebastian Ott (3):
  KVM: arm64: selftests: fix help text for arch_timer_edge_cases
  KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
  KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width

 .../kvm/arm64/arch_timer_edge_cases.c         | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)


base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.49.0


