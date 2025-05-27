Return-Path: <linux-kselftest+bounces-33864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C42AC50D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E7817D626
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B327A440;
	Tue, 27 May 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpXrheAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C527A10A
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355895; cv=none; b=ZyFnkq7yoZPLbuZrtQgkgPHU0e5OM6ftalbYZ6Bi0OfIZlJZZcIKa3E5semIdX/ue4UxPxxquqptYv3CMJ9S07Z94S3GGgoZ/YjK8C0XKZ9/CvT2kyEDtWUMYcYGPjF0xDZWOZ1qyhXwM15K4/51UhBG7Eg4GbMb9aX0Ko6SS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355895; c=relaxed/simple;
	bh=ocRxSy5EJXKWPp1wtDInyrXbEN2m5DHwoDq0BP3WbmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5b50dgYPDimyMvbA3R1Hs4ZMSnX1Z66Dz5mWBc+4PGuak+NfNBZJ35VNJJCjSWmsj+0ZQYxMWgl40Pss5//OPzCggQaO3sAWBm5z0Rmz4IABs8CAswk2SsFF1ayWirzkn2jhWXOIDILGuCND0I1e10MsnzNYSLtH1XH0gBHe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpXrheAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unMc8iAgdhI+llHDkqJsAFL7ZbF0O8Lqzu9ojtHqeJA=;
	b=NpXrheAsOxLieE9FhktSgDrgFcN9mOMi0fH0PVqEUTKkdNK4+rPTmku/VxvEVRI2UpP9YI
	12HOwEPW2QSAh7UPKGXeOKjxMwPQlwVSX3sLpMaTPC0x/WxvSfAAEh56yZuADmMipl5iRJ
	W/9JlYcBg8gHEb4qAN3fkRUzdasfsac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-25CAut0gOcmWHKT5kpqTzw-1; Tue, 27 May 2025 10:24:49 -0400
X-MC-Unique: 25CAut0gOcmWHKT5kpqTzw-1
X-Mimecast-MFC-AGG-ID: 25CAut0gOcmWHKT5kpqTzw_1748355888
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a34f19c977so1649979f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 07:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355888; x=1748960688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unMc8iAgdhI+llHDkqJsAFL7ZbF0O8Lqzu9ojtHqeJA=;
        b=mIzOV7d4KmdE927kLd7Gp9Jz3mIsOlDlnwZ6qqA4Yr/3Uxsmg/WH17yOSDraXAPoNL
         8XibIgoKTJikXiuraNgjhF8hMsORqN66iqd5sVqCyDrmaM4fVtt3GytzWF4BWx7MVJnP
         gePYpbgpiE3uU0s8jiNJwojai453wV2hpc18ApVNGWUTHDQvQkIrOCwIBU7nD2yuB0tz
         4AVm0SH+JReq4qeJZ9qNiIxIOHs+LlOYOsCHtZ+5xxaskClOj1OUJk64eAnMRueYX2QD
         Q8AM1D0/ELWbiSQUDQ7Q1v4ozBgZU+m2sbjwucynqQk+eSFDaYyfas7tpOsFBfe6lB/P
         1RVw==
X-Forwarded-Encrypted: i=1; AJvYcCVXa8MTVHBOEyBxFaN1GCLCT8vP6pcZubYiC0jJz+n2SF5CxP6BizyHnDCnD/+F1k5M4OT+g/8k4cKLk3rW23E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPvjdc6g8tuzlAUO0P0uwkeHZkdys9RVY7hVJClBnc11mL3dfU
	CyBUNRcg0H8WVzML9nCzU3TlX6eV75xO0/8II33XihmhZhbF2VLtSB7r41cRIv3l5IQ0ANUE2+S
	HHvjkzx3mLNGmMx6G9va5ldKfC6xraZhFU+rshEQq5GYlsHZlSAQ2A/Kv1fixYV2tc0sN3g==
X-Gm-Gg: ASbGncvYGWpiERMAVitLancaguSxUWW2xT2DLiBQHFFYxShh9gt1X2+HGQFnyr99Zyu
	Y5F90SWRTz8FpADb79j4g89hZAfin7Gr6nVo0/Dz/dr8WX1ohvCKo1OMmhkWFC9rcXUJZ9icPFD
	pTPaUye+SRddHK2QPR7AVJHn1E5qlZsknm5OCN2DyU9d0t+ObTfAKuhBN+8pzCrZuYMIDtvKbfA
	zpcDlAX/iI3vt8MJbGYN2zN8jYJrHGHsMQT1uTvO4QFd2begs2OS0NMdqvS5I0EG96w8rHNre/e
	hOzyU07cBuCQrgWx4x1X0H9XDeEyYr2lbWkm3mJboRkxIT1lag48EDOajw/eF1mjj+0jsOg+tg=
	=
X-Received: by 2002:a5d:5f55:0:b0:3a4:e1ea:3b38 with SMTP id ffacd0b85a97d-3a4e5e5d241mr1030440f8f.7.1748355887872;
        Tue, 27 May 2025 07:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED6cDk0pjU6x3lxG7ezTVdoW3wzIGaXlNoiosT7cd0gwNQ04WLe8XIloW7vpZA7k37aWMp8g==
X-Received: by 2002:a5d:5f55:0:b0:3a4:e1ea:3b38 with SMTP id ffacd0b85a97d-3a4e5e5d241mr1030399f8f.7.1748355887452;
        Tue, 27 May 2025 07:24:47 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm278766415e9.20.2025.05.27.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:24:47 -0700 (PDT)
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
Subject: [PATCH v2 3/3] KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width
Date: Tue, 27 May 2025 16:24:34 +0200
Message-ID: <20250527142434.25209-4-sebott@redhat.com>
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

arch_timer_edge_cases uses ~0 as the maximum counter value, however there's
no architectural guarantee that this is valid.

Figure out the effective counter width based on the effective frequency
like it's done by the kernel.

Note that the following subtest only worked since the counter initialized
with CVAL_MAX would instantly overflow (which is no longer the case):

	test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);

To fix this we could swap CVAL_MAX for 0 here but since that is already
done by test_move_counters_behind_timers() let's remove that subtest.

This also serves as a workaround for AC03_CPU_14 that led to the
following assertion failure on ampere-one machines:

==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:169: timer_condition == istatus
  pid=11236 tid=11236 errno=4 - Interrupted system call
     1  0x0000000000404ce7: test_run at arch_timer_edge_cases.c:938
     2  0x0000000000401ebb: main at arch_timer_edge_cases.c:1053
     3  0x0000ffff9fa8625b: ?? ??:0
     4  0x0000ffff9fa8633b: ?? ??:0
     5  0x0000000000401fef: _start at ??:?
  0x1 != 0x0 (timer_condition != istatus)

Link: https://lore.kernel.org/kvmarm/ac1de1d2-ef2b-d439-dc48-8615e121b07b@redhat.com
Link: https://amperecomputing.com/assets/AmpereOne_Developer_ER_v0_80_20240823_28945022f4.pdf
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 .../kvm/arm64/arch_timer_edge_cases.c         | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a813b4c6c817..1e3e36d869d4 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -22,7 +22,8 @@
 #include "gic.h"
 #include "vgic.h"
 
-static const uint64_t CVAL_MAX = ~0ULL;
+/* Depends on counter width. */
+static uint64_t CVAL_MAX;
 /* tval is a signed 32-bit int. */
 static const int32_t TVAL_MAX = INT32_MAX;
 static const int32_t TVAL_MIN = INT32_MIN;
@@ -30,8 +31,8 @@ static const int32_t TVAL_MIN = INT32_MIN;
 /* After how much time we say there is no IRQ. */
 static const uint32_t TIMEOUT_NO_IRQ_US = 50000;
 
-/* A nice counter value to use as the starting one for most tests. */
-static const uint64_t DEF_CNT = (CVAL_MAX / 2);
+/* Counter value to use as the starting one for most tests. Set to CVAL_MAX/2 */
+static uint64_t DEF_CNT;
 
 /* Number of runs. */
 static const uint32_t NR_TEST_ITERS_DEF = 5;
@@ -732,12 +733,6 @@ static void test_move_counters_ahead_of_timers(enum arch_timer timer)
 		test_set_cnt_after_tval(timer, 0, tval, (uint64_t) tval + 1,
 					wm);
 	}
-
-	for (i = 0; i < ARRAY_SIZE(sleep_method); i++) {
-		sleep_method_t sm = sleep_method[i];
-
-		test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);
-	}
 }
 
 /*
@@ -975,6 +970,8 @@ static void test_vm_create(struct kvm_vm **vm, struct kvm_vcpu **vcpu,
 	test_init_timer_irq(*vm, *vcpu);
 	vgic_v3_setup(*vm, 1, 64);
 	sync_global_to_guest(*vm, test_args);
+	sync_global_to_guest(*vm, CVAL_MAX);
+	sync_global_to_guest(*vm, DEF_CNT);
 }
 
 static void test_print_help(char *name)
@@ -1035,6 +1032,17 @@ static bool parse_args(int argc, char *argv[])
 	return false;
 }
 
+static void set_counter_defaults(void)
+{
+	const uint64_t MIN_ROLLOVER_SECS = 40ULL * 365 * 24 * 3600;
+	uint64_t freq = read_sysreg(CNTFRQ_EL0);
+	uint64_t width = ilog2(MIN_ROLLOVER_SECS * freq);
+
+	width = clamp(width, 56, 64);
+	CVAL_MAX = GENMASK_ULL(width - 1, 0);
+	DEF_CNT = CVAL_MAX / 2;
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
@@ -1047,6 +1055,7 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 
 	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+	set_counter_defaults();
 
 	if (test_args.test_virtual) {
 		test_vm_create(&vm, &vcpu, VIRTUAL);
-- 
2.49.0


