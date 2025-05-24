Return-Path: <linux-kselftest+bounces-33734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB21AC2E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B533E3AE7ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653572617;
	Sat, 24 May 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS1mPh6Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3833C0C;
	Sat, 24 May 2025 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748075807; cv=none; b=W/qm8J3lxJvTwQ1XnkGqYYsugv5ikt4X+CYCpj3Jok486qV85qKICEZoJVENDCCPcB6sHvPbf+8SAKljY1GtZxlxv3SvklBtGtpMqdvMpeLmrzW3xy8BapbF7/rL0hcyLfNnwrmhiczhSvCWLKjregHRrUx7kqfoa78dN+i/Lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748075807; c=relaxed/simple;
	bh=9tfWWYvVm4l4xoayMLpAWFnjPSklM+ZvT7faG1Oxzaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+bD2LtZ1TmxHzgPSKXsfXo5Yw6a8WOaILIWpkApnUxYr3WS92eooBhA3BPjEgW8Y8aLXfnNzIQCvE/uKjpcw7VcRhsl2luUW4ogh+i0R5URWTF6KPgPdbx9F4P7ym8wl2/52KfLbwNG6RM/VDqsCBbG7P47JphHdfRy4nDMAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS1mPh6Y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30ea7770bd2so769647a91.0;
        Sat, 24 May 2025 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748075806; x=1748680606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0Lk85kbhsElZYJtc7AVIiBQoIYwHbLNrMdyS03HhQE=;
        b=ZS1mPh6Y+Ec290nKAlkl3PQCcUrByWnjgofEPBrmEBmpYAH/2NwTTNHB3KkNkN5cSp
         rJGA9tQkMVU7m6AANh7nECZoHYMJl2zM7Jjb10rWPpPcalhSYrdL5BGtJ3reKjjamKYN
         pzg3oNn6QEJNWlLO2PUT0MZrx80TV3EuNW//twgfY0QwMAq0fyCvEJGntXDc9+zt/tO/
         Q+9rN8VL5OEMit1HtBaUe5QD21XpedZIOyd+HzMO01d2i4Va9W2odMB1qhfM2/FFP28u
         tK4j3s+A8AXZH1g5MXR0krLSPeDFtAPBZOWCOtMMMxx8jww9wclNBT7/tNU1Xn/GeA7p
         i+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748075806; x=1748680606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0Lk85kbhsElZYJtc7AVIiBQoIYwHbLNrMdyS03HhQE=;
        b=MiJNVohKfCSmL7WLxDPVPoCdecamPNrmaE2soZYvKecnXO+ei6B5mxr7Zd5nuPs9wk
         Xehpe2+BIYnNjpylZltJnyGo2n4hoRUyMIaLWaADx9K2UxCZjpwXtU0XVwDMA34uOp8N
         wUIuvqHPd1wnTWzY4N0OakJu3ju2KCgOsienXdEIRoiYbiMxTuyWcNB9a+UkGNzuOUjs
         ShpaRhjuZYeKnaU2Zz/n2nvxqorKz6MuTCSaEwvWfK5ETr3pULT88S7DOamlMi6ZFpHF
         mSqXgn6pMh1RQuq1VAoS8vGJa6WUY/fibeNi5ssDKonstL/mZGSvjAs4gXHv1awct6mF
         RAKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZ31+XzaKPxZIIW13M6XRq7ZZl+8FLv+P7X7BuuWM0YcLWgDKyyWtkQRnRFtL3oYOfYhjHILxS1zyWbo=@vger.kernel.org, AJvYcCXIn6y3tUYqsehclJeC5IJ0LTqWX5ypPSoLPu7vFnOqLXvcysO4a1uY9Ru8+Y8LpBbLl7BW7FQSGNloc/Rf0nqC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Q9ZxpkIPv3RabvppIxMw8OSsd7C2xz6Fbmrskm9KrLcZEYi4
	HwPnsGWdJJfYeWuGxj9rdwgR2JSHSMCrjRIgw4Scku9Rkm9ZfBYDjvulD/TcoBBA
X-Gm-Gg: ASbGncv/Hj3r0y8zZNwn+dRCXna2B7c4E0xd89vXnHHW2uiquGYBDujoS3iiNnIhC41
	Cl2XWjMJv7V3AstXzaB5xsJ8WShbETM/NTRBXRTFwwWKdXbSJ1iCZD8MGlY+gA/92kRfejk77OY
	5tUTX4VcfSGusa05cFluUg7u0IEr58BFarLLTB2CXASZbEr0rwk6El5vU7mxy19cLEgqWdQ2GWa
	pwfhsKC+GK7t8K0f/dMJ8406z6tBxOodNyx0oZ5Xn5eZvb2ljFM92oJqCBnScCf2jV2pimR9qAw
	Fcf+y7jCOEoFvOUFx7qj7/g8DKsJUxjfJczx+G79BkCoTyfbJEAS
X-Google-Smtp-Source: AGHT+IFM32ImrgqZh4uQ2khJGbITCWZn9AIrjpGoD5wryt9f6rYAjA+v2pzFW0SWlQy+zAEvv+NfzA==
X-Received: by 2002:a17:90b:3f8d:b0:310:fcf1:36b with SMTP id 98e67ed59e1d1-3110f321c86mr2723418a91.21.1748075805563;
        Sat, 24 May 2025 01:36:45 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5d31sm8617539a91.38.2025.05.24.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 01:36:45 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH] selftests: cachestat: add tests for mmap and /proc/cpuinfo
Date: Sat, 24 May 2025 14:06:18 +0530
Message-ID: <20250524083618.29615-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Add a test case to verify cachestat behavior with memory-mapped files
using mmap(). This ensures that pages accessed via mmap are correctly
accounted for in the page cache.

Also add a test for /proc/cpuinfo to validate cachestat's handling of
virtual files in pseudo-filesystems. This improves test coverage for
edge cases involving non-regular files.

Tested on x86_64 with default kernel config.

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 69 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..81e7f6dd2279 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -22,7 +22,7 @@
 
 static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
-	"/proc/version", "/proc"
+	"/proc/version","/proc/cpuinfo","/proc"
 };
 
 void print_cachestat(struct cachestat *cs)
@@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 	return ret;
 }
 
+bool test_cachestat_mmap(void){
+
+	size_t PS = sysconf(_SC_PAGESIZE);
+	size_t filesize = PS * 512 * 2;;
+	int syscall_ret;
+	size_t compute_len = PS * 512;
+	struct cachestat_range cs_range = { PS, compute_len };
+	char *filename = "tmpshmcstat";
+	unsigned long num_pages = compute_len / PS;
+	struct cachestat cs;
+	bool ret = true;
+	int fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0) {
+		ksft_print_msg("Unable to create mmap file.\n");
+		ret = false;
+		goto out;
+	}
+	if (ftruncate(fd, filesize)) {
+		ksft_print_msg("Unable to truncate mmap file.\n");
+		ret = false;
+		goto close_fd;
+	}
+	if (!write_exactly(fd, filesize)) {
+		ksft_print_msg("Unable to write to mmap file.\n");
+		ret = false;
+		goto close_fd;
+	}
+	char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED) {
+		ksft_print_msg("mmap failed.\n");
+		ret = false;
+		goto close_fd;
+	}
+
+	for (int i = 0; i < filesize; i++) {
+		map[i] = 'A';
+	}
+	map[filesize - 1] = 'X';
+	
+	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
+	
+	if (syscall_ret) {
+		ksft_print_msg("Cachestat returned non-zero.\n");
+		ret = false;
+	} else {
+		print_cachestat(&cs);
+		if (cs.nr_cache + cs.nr_evicted != num_pages) {
+			ksft_print_msg("Total number of cached and evicted pages is off.\n");
+			ret = false;
+		}
+	}
+
+close_fd:
+	close(fd);
+	unlink(filename);
+out:
+	return ret;
+}
+
 bool test_cachestat_shmem(void)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
@@ -274,7 +333,7 @@ int main(void)
 		ret = 1;
 	}
 
-	for (int i = 0; i < 5; i++) {
+	for (int i = 0; i < 6; i++) {
 		const char *dev_filename = dev_files[i];
 
 		if (test_cachestat(dev_filename, false, false, false,
@@ -315,5 +374,11 @@ int main(void)
 		ret = 1;
 	}
 
+	if (test_cachestat_mmap())
+		ksft_test_result_pass("cachestat works with a mmap file\n");
+	else {
+		ksft_test_result_fail("cachestat fails with a mmap file\n");
+		ret = 1;
+	}
 	return ret;
 }
-- 
2.43.0


