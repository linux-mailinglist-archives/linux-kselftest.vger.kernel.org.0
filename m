Return-Path: <linux-kselftest+bounces-4194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC184B789
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8632285F90
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF71131E25;
	Tue,  6 Feb 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHmmrBUN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C513172D
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228763; cv=none; b=LSshQxyytZTlm/uzTEw2kKKTOJHA/NadcqC9wzDqVf4usV9POl6WVk4Zzq2nVxy9E4q4kggNSA8k37y64JX3scUqbs9RR7StUk957mmizQYWPw01MAv7MuKeqXfELGwX1oDh/DE1t1A6JWr04HjkIalUKYTF/zqTV0f4fMrv9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228763; c=relaxed/simple;
	bh=Wt1T7etqlQIEFK5ye8kbDen9dDtuHaTDaBefpNZivFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goFsLBZ5nZBqWtjLkbJCmZWOh1gOqWLgexG5DpJQZoThGFM6GMsfSiWQMsHQMnkS9NvTkGmeQdgEMA5Ko1nt+kXMZG6lNp73VBFf9DxMVZCDslTT7WLm2aC37qszjD20WP2/VfNWdy5ZW1AfbW1oFMdJbzfyg5CiyuRK0rLVtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AHmmrBUN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso3750006b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707228761; x=1707833561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SA4faVVJYDMfy/r36fEUOihZ2CAD3tpPWMLG1ykrqg=;
        b=AHmmrBUNQbpQBUNTNGMp4onxodtEw1ZYMd8Z89tho4tDr3F3rA1D2BHCQojlgbCZTv
         voJb+ixLHF2RBEdcTuFIwEAB6SXfv4PnUSbYSXRhw+OSeooEo4p3JGFgY06PgHbIgUGG
         6uECBK4Kt9YjqsL9rICiwTJLANX0H7ZLd8SYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707228761; x=1707833561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SA4faVVJYDMfy/r36fEUOihZ2CAD3tpPWMLG1ykrqg=;
        b=I64Opse/087sv012Ukh4+9P4sD5s9reccuIldcvX+84t14obP4pqH9okYpenCygwad
         +MaLOs3J/4NnakrvMLRUF+kwbZPv4KSDh/LyNOxNEZjUWz9DoXNsX9NvTGrNTBOo9WmW
         6avLY0fL6VB5tGsQzdFp6DDL4w09XInHAGd80BiVn3EbB/921olkSV/W3VCNnYcisrqu
         u4zUu+/AOV6uy0rpRGt8pq8hCyjynLpkTVlxZFR7rF0Dk3+veCs1ThkJhAOjsFXWgny4
         ExBePh2mLO+knzislgWlX7QXAqTAyDQeHy8SKekyc1OsDAyK/lpIj/UdV/PtWLBnwINN
         a97g==
X-Gm-Message-State: AOJu0Yz+FR7Y0IduZnUPFZtaPJ9L6mX8qwYHcrJXZetC4M7L/i9JmLUv
	bulxO3mJyncDIlhjRm1N5N6BGep7W/MMCFmWMA48Q9gSVFaUEYsHef+G+ECCJQ==
X-Google-Smtp-Source: AGHT+IFjIm7YicmBYMed0INjWHvRfa4gZyjy/0xpwHIjp3Smy4PnQ4TfpOO5epSssOkF+8jtNXBFAg==
X-Received: by 2002:a05:6a00:938d:b0:6df:f634:4f83 with SMTP id ka13-20020a056a00938d00b006dff6344f83mr3185288pfb.2.1707228760934;
        Tue, 06 Feb 2024 06:12:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIazxDHvc79fqGX/yKrNSWou2+R1ZUiqoDY3X9PldKpTEv1Buai/LBFC1rxMdTEClTGBPyS9UXo1TbQPDov/pY4NIG97DF8PsVhgxuupuIRcwqKOihklIN97P2bPpvksyOfhcpc2OnmIpdWoXcSFem/2d/Jv3PiU2y5PltgyI0uLDhIJCQpQAVvsayTdZH3DmlzBRXXuwDiv3Wnnxh2jT8A4WzcrVuj2kY3tZD1mLLyhBGvsPJK7aeLf4T/uJ1tJXZo4eCWnug8/gsFuOgoKbM5BzOgdVqS6zg2IYUZ3c=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b006ddcf5d5b0bsm1939165pfk.153.2024.02.06.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:12:40 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] selftests/seccomp: Pin benchmark to single CPU
Date: Tue,  6 Feb 2024 06:12:38 -0800
Message-Id: <20240206141234.it.656-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3071; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Wt1T7etqlQIEFK5ye8kbDen9dDtuHaTDaBefpNZivFc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwj5WFrkcgZ8hALvXjbxNjhFAKG7jNJ00NXZx4
 ZMCIEaIQp2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcI+VgAKCRCJcvTf3G3A
 Jj8PD/0RojU69usxAsxYgxt3MI1BZ+ud7tXZFqO7D6VqR1yC1k33YfPK8CB0aIfflDa9URbWbKt
 UPHooy6DVrSjD4M+JTp7ulrAm+M6i5r/ZLjowZz3dd09rUoe2v776gu8lUxlkugnR33mNwz63Du
 okWgEALg9W7IhpRRrTG2p9d54Chwc6Ztr9DXueR+XyeSiN1JmTGO7NP2Um1NcaXQZKj07ea135h
 i65RDTEz9fjIAgbjjzmXPr/agb6H29o36M/CMc9UFfm2+uBV3OTSEG8c1mM/7ZNHuS6Wv5PN9bW
 aKzCnwyDequy3FkbCVmi81f9SKoME+VUTcKD4PTlcrJuSSxnJ1Ef9v2VdZk2A3Y8LBsH/Vd0yPL
 SFlcUB/fA2p0f6s2M0XYKyT1z1+1mBPC680zuWdNoMZHb0A9RZ/0QpOzAehag3j88cLjyorG6CD
 ejXuSDPLXaTzd6SE8ly0UMU4W89GfmE+zHS4P69nK6ECGe8yIjwvctektdgRADC1zglg9yCamKC
 W0e1rjaLHQQwkIkThNmkh9PE0LewY94M2yia91t0/EX9hLcL2qW3xzRDMcRDOGEXMOx9AmOKQqD
 rWLNo55g+I70dTA8MqlSwR/RlaYOoDcaPrHj5pKz238be1bNDPcbI45Oh8N0xOiq9IaToYXnls6
 nQC2Vfm cMCiWoxw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The seccomp benchmark test (for validating the benefit of bitmaps) can
be sensitive to scheduling speed, so pin the process to a single CPU,
which appears to significantly improve reliability, and loosen the
"close enough" checking to allow up to 10% variance instead of 1%.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402061002.3a8722fd-oliver.sang@intel.com
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - improve comment about selecting CPU (broonie)
 - loosen variance check from 1% to 10%
v1: https://lore.kernel.org/all/20240206095642.work.502-kees@kernel.org/
---
 .../selftests/seccomp/seccomp_benchmark.c     | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 5b5c9d558dee..9d7aa5a730e0 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -4,7 +4,9 @@
  */
 #define _GNU_SOURCE
 #include <assert.h>
+#include <err.h>
 #include <limits.h>
+#include <sched.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -76,8 +78,12 @@ unsigned long long calibrate(void)
 
 bool approx(int i_one, int i_two)
 {
-	double one = i_one, one_bump = one * 0.01;
-	double two = i_two, two_bump = two * 0.01;
+	/*
+	 * This continues to be a noisy test. Instead of a 1% comparison
+	 * go with 10%.
+	 */
+	double one = i_one, one_bump = one * 0.1;
+	double two = i_two, two_bump = two * 0.1;
 
 	one_bump = one + MAX(one_bump, 2.0);
 	two_bump = two + MAX(two_bump, 2.0);
@@ -119,6 +125,32 @@ long compare(const char *name_one, const char *name_eval, const char *name_two,
 	return good ? 0 : 1;
 }
 
+/* Pin to a single CPU so the benchmark won't bounce around the system. */
+void affinity(void)
+{
+	long cpu;
+	ulong ncores = sysconf(_SC_NPROCESSORS_CONF);
+	cpu_set_t *setp = CPU_ALLOC(ncores);
+	ulong setsz = CPU_ALLOC_SIZE(ncores);
+
+	/*
+	 * Totally unscientific way to avoid CPUs that might be busier:
+	 * choose the highest CPU instead of the lowest.
+	 */
+	for (cpu = ncores - 1; cpu >= 0; cpu--) {
+		CPU_ZERO_S(setsz, setp);
+		CPU_SET_S(cpu, setsz, setp);
+		if (sched_setaffinity(getpid(), setsz, setp) == -1)
+			continue;
+		printf("Pinned to CPU %lu of %lu\n", cpu + 1, ncores);
+		goto out;
+	}
+	fprintf(stderr, "Could not set CPU affinity -- calibration may not work well");
+
+out:
+	CPU_FREE(setp);
+}
+
 int main(int argc, char *argv[])
 {
 	struct sock_filter bitmap_filter[] = {
@@ -153,6 +185,8 @@ int main(int argc, char *argv[])
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
+	affinity();
+
 	if (argc > 1)
 		samples = strtoull(argv[1], NULL, 0);
 	else
-- 
2.34.1


