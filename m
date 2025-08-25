Return-Path: <linux-kselftest+bounces-39838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4BB344CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D3E7A90CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC342FDC28;
	Mon, 25 Aug 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="At8ZvItz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6B2FD7CF
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133868; cv=none; b=mZ1Lfq1otXk4bXo3YePbXC/9BFLpHNgWYyWXSNd0eOO39BTSsWIbM0Sz6vBszkn/iP9HogsnfMRDD6BYQ6TRONFqJiog038JVtYPaVo754XumPxmQCD9A798XhHHcJKyYPRsx5VZxyJbWyhvILpQ0I41bjfL/RhGJZAhiKecqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133868; c=relaxed/simple;
	bh=uF4znN0JKpWwZRxgNIEH8MqnRz9lQ5HTl5xrH59tsJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfQcktp4exmROXtU6MSgUo9uQRVFXnCxrMGS8PKxMbE6/lJBiaPctBCqcKrlH8palfNjNQuVgFqFmbj3N4YekhRu/g/g2b6BpMKz5+Fq91F+bJsm7MPsxlhx13+9xpYtUQ00ruEIAzenLocPB7rWabZR/gBICObiw3ClgwWNXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=At8ZvItz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771e15ce64eso794433b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133865; x=1756738665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+3wX2qQorY9HjJTcapV+Fc+oMOTnn7HyjyOkt8jkGk=;
        b=At8ZvItzpJRAohPmB+3fqhVmvHGAVCk1GmNlOzPADLtJ2I0WBq35w6D2/ngj94tdDq
         GIt9u7mQGqOXOkJC97iT+xa6kWv3SX+roBQ7nLJkefjpuMqe0FHukBdAtjxcQU8tKZpb
         uJd2P3oTLUbhnMi1I3UOiPRm0pH6aMx9rsEqUsNtc3f735b+SAdJPOXg7G1h54ECBLzp
         pRpmLHct86RaUH5AtB5lPDn/Tg+LelgjzcpqJR1hvxk0vti294EEZooBiR7uRGyvkPrl
         nNCBemppKzqTf1KTJgm63mKTi3xR1NjBfzN0KwsRiR+j/7iQD3RT8xsWpO8ZFMhZdPYS
         Frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133865; x=1756738665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+3wX2qQorY9HjJTcapV+Fc+oMOTnn7HyjyOkt8jkGk=;
        b=FX9Wxmw2Y9smwSqf0xHnmU+TWVlY7TG/SesD3qMVI31b8wuQsBpqKrxThJGDlQQDaF
         EaEb7XG5UORaDcpeOoocw7XwqtpuMCqtfUS98RHrBPAssUGQI/XZph1NKeqtTsF06ODm
         rnQnixnDEkfYJVGSyQ48In42ZPUFfe73wTTWLJFTVPJAuqRpbSVsNxkcElyqbGGDguDW
         fBhaBsTl5m3ogDeWvUmWx4unTvy2T9p44rvyd5ib2lv/IXn20DwhOOB2BXzptin37kfX
         Icf2e8Hq7lzcqHrQ1/JETmjDlf+8EUlsjL2uRoTaSyDL6CzEX4CwRTKjUDZuwwCjkNzP
         6dCw==
X-Forwarded-Encrypted: i=1; AJvYcCXpu/KZCVi9k2topNAulfY+svhghZDXC9bPsOviLsVuCWaEhb1yYQa0Liwcu3/1FH3r1pS9ArxN+fQPDds8A3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyemr1RTzjpR7c/4zzHX4aGkqa3nQ1UnZwj313v+gBAHsdE7vMT
	wobsmD1KXqTHNYhIQ4FbLOZxoDwxEFI6gibtYw7gmJadhzyS348lh1Fs6b7SgETW91I=
X-Gm-Gg: ASbGncvrlcsDtQWBFCiTaPYqQU5sFoDmFpctBlKE10vPVyParthH6XJmFHE/+aHE9wb
	VgUEtbZkQXZTAuDd4NED6Qzrv96NMFh0ndhprOgoiMLQ8EgGPbEuyVzi9N5Mb56oUUR9jQsupM/
	iM0zhKZY5/MUaaB1k5CE1dOoBwXGRSzwd+7jYi53OPxjhJMDr1a1C+kugwYf0gx7piC9ERn433n
	J3NdLyB0wp0YY0WYqFne83VQOl6EJiL1ozidjI+nYnU4uAIW92BetxSBEo84mz9ybPq6JJcfe3d
	THClPVCXYi4M9zE0mIX45WnWrmycjuEkZi907eZ4Ie5/78DfuwFLgeScwHiYDVPN1sVKnChUm8C
	LPtc0wUXB5ZzBF/aNKoULmF5JgeDQuqM/2Ji7IMUd7afuI0bYa0Yd5OmoYSHW
X-Google-Smtp-Source: AGHT+IG029ngLH0Z0VBrJyvV3C0TtjVJCx48xckH0n599Ds5K4PkyEQjVQ5nnkIfx/oH8gYOcLg5pw==
X-Received: by 2002:a05:6a21:3391:b0:243:78a:827f with SMTP id adf61e73a8af0-24340dbe653mr17737819637.55.1756133865176;
        Mon, 25 Aug 2025 07:57:45 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:44 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mshare: selftests: Add test case shared memory
Date: Mon, 25 Aug 2025 22:57:07 +0800
Message-Id: <20250825145719.29455-5-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify the basic functionalities of mshare.

Create a mshare file and use ioctl to create mapping for host mm
with supportive flags, then create two processes to map mshare file
to their memory spaces, and eventually verify the correctiness
of sharing memory.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 81 +++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 35739b1133f7..2347d30adfee 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -3,9 +3,86 @@
 #include "../kselftest_harness.h"
 #include "util.c"
 
-TEST(basic)
+#define STRING "I am Msharefs"
+
+FIXTURE(basic)
+{
+	char filename[128];
+	size_t align_size;
+	size_t allocate_size;
+};
+
+FIXTURE_VARIANT(basic) {
+	/* decide the time of real mapping size besed on align_size */
+	size_t map_size_time;
+	/* flags for ioctl */
+	int map_flags;
+};
+
+FIXTURE_VARIANT_ADD(basic, ANON_512G) {
+	.map_size_time = 1,
+	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, HUGETLB_512G) {
+	.map_size_time = 1,
+	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, ANON_1T) {
+	.map_size_time = 2,
+	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_VARIANT_ADD(basic, HUGETLB_1T) {
+	.map_size_time = 2,
+	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
+};
+
+FIXTURE_SETUP(basic)
 {
-	printf("Hello mshare\n");
+	int fd;
+
+	self->align_size = mshare_get_info();
+	self->allocate_size = self->align_size * variant->map_size_time;
+
+	fd = create_mshare_file(self->filename, sizeof(self->filename));
+	ftruncate(fd, self->allocate_size);
+
+	ASSERT_EQ(mshare_ioctl_mapping(fd, self->allocate_size, variant->map_flags), 0);
+	close(fd);
+}
+
+FIXTURE_TEARDOWN(basic)
+{
+	ASSERT_EQ(unlink(self->filename), 0);
+}
+
+TEST_F(basic, shared_mem)
+{
+	int fd;
+	void *addr;
+	pid_t pid = fork();
+
+	ASSERT_NE(pid, -1);
+
+	fd = open(self->filename, O_RDWR, 0600);
+	ASSERT_NE(fd, -1);
+
+	addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
+		       MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+
+	if (pid == 0) {
+		/* Child process write date the shared memory */
+		memcpy(addr, STRING, sizeof(STRING));
+		exit(0);
+	}
+
+	ASSERT_NE(waitpid(pid, NULL, 0), -1);
+
+	/* Parent process should retrieve the data from the shared memory */
+	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.20.1


