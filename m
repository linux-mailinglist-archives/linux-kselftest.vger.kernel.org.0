Return-Path: <linux-kselftest+bounces-39846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01889B344E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15EC4820E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB03019D1;
	Mon, 25 Aug 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kPMfnH0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA9301488
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133899; cv=none; b=bZBrNfoeQO6IydZDqVTFlnLtTQP6Y+mU/6nnpNLdiWXVciJXtMwTsZi0h9ANpNKmRQNINyfFw5xCzNX58FrM3vWGhwaw/EbrnndbF7OLMUAmRK/8rgx1kkQ8X1SVn34vmP0sIlc6F2aEwnE5681H2rFYeIjcqURj2ZF6EpgLVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133899; c=relaxed/simple;
	bh=uF4znN0JKpWwZRxgNIEH8MqnRz9lQ5HTl5xrH59tsJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZsDbLKnKPtXOwvux8W8bSo2L4Ag40PYQ6DqVkRfDw4K6OcpX3okUj96b1d/uBDR/rxplnNilgA8FEL+14opB5wWTkbJTxP7wkwAbTEf27LpRYebgZRIqHIkiI7YpWS0NNE7Vx+EcfLT+qOB8djI4VL/2meQ8VJdgErzUwKOxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kPMfnH0k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so4259667b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133896; x=1756738696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+3wX2qQorY9HjJTcapV+Fc+oMOTnn7HyjyOkt8jkGk=;
        b=kPMfnH0kdMQMpMttu6FNZbXIIPRQaY6j9QDUVn0lMM2O7rVfM7U0ZygscFgnRKH6vJ
         mrcA3JKvSR/lRMpVEWIIbdwAtBv6iiBT2cXeJqzcS3SObSqOeAqj8Orgb7vWbwNpMIkq
         y2jRyS7bTKdx2UHeNXw+aIe8gRfNoRe59uN8ICol7N1qeOzvBK6jNyPEjtqihIOg76h1
         FJRy3zV7hBqej5gbtfzdKPHdkbJmHf2gixs4LzleJMcFOHguESxdHuc/+JyYS19OVC8e
         WuCWRepd3G6Uy84XrvepylChbOF6JwCiTcp33tpUnXJmeW2yOL1i3FsmbaAiIeeqcAeY
         UxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133896; x=1756738696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+3wX2qQorY9HjJTcapV+Fc+oMOTnn7HyjyOkt8jkGk=;
        b=rE+gFvttSQGegllOecgJllstIUsBlpUL8deMa3NTBAMKr8prq0kcUZlKS1GDjzPE8A
         yeE+Rqa/httoCmGJfZ19PNgQp5puL5QOEKkVcNxSpXwkdyfD3ulCEQ0NhsYt7/pJpY86
         xEMtYb4zkfeaSY0zWnNcXzni8YdntdS77lyyeA0QzxZUE+10Iip/liyDrJJk2HRjKChN
         yTFzhjb69fAjZLPwSbcJE+Iw5HvdUualkKX4iNqONDATHPaDD789PGx+EWQp9WXSrDN7
         fbxUCICQrlcJCr60p+dajM1LJrLOUJMFpGVyyxGTubj+FV4ISGqkqj35ygjsurBgauCp
         yACw==
X-Forwarded-Encrypted: i=1; AJvYcCVmDahKNBrRRQeIFlnOkLQAyJrK9/jmR+kI6XML9CDh4V0wmSqEjgUKXSrvyUeAHDHpFSLdyaDBSwhVvfGmLyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnsITmicplwGAGj6bELzHIT3yNH0AU6Ru56Bnv/rrxcLzjkWu
	FtRdgoQOZ6IbYiJAou0cHLQKN4E+/HrwwK0kzxnfpFapZFXId+tEtNAP3JgFA+Z1qvXwipOIAX6
	LLrpiwD4=
X-Gm-Gg: ASbGncuAjU6MIdGuyeC0HFwCSleYpp/PmQVjDj9ZZL4IDvU5+lGC7l5c0VeWiulsM0o
	I0yB7QXp6y08LiMcdpp1nG/LLDxhdZi3C7hmLp5ioyQ/6MfyFFqlCcwn9xq2Twrf4+JZ0Z6sDgx
	ejY0Bpe1J+OTSKGI2V2F6uBgY+LE0S6tjBn6ATBe6g2dlF6yOxY27SLYd7aMibyo6wOFz+l2vBQ
	ZOLYEss7Ut7KHCt+0hIkJYus9MqDNpXB44gIIAxxx1iTER3EdHmMtXw7a6Bqjzz77o+wMIIimG/
	7h/wK3jgoVd81yi/9xI0cVU8X86aANn4mBglbwxYqT9wXfFj0zjiN0cRkQdxhg3UX/Fgb2Z8mu7
	XeBSqg7fQcn6+fkDGAbd5j+NormgU3RtKSvpLeJKLNPg8bJa1Xuxoj5Cwz4yG
X-Google-Smtp-Source: AGHT+IGSZCY+q8MGo/Jnr4rtyaAqqyD29rBoj9ScLH5hoteOddGdtmlulcvDapltGRS/9Os/f0IGgw==
X-Received: by 2002:a05:6a00:4b04:b0:76e:885a:c333 with SMTP id d2e1a72fcca58-7702fae24c4mr16042177b3a.25.1756133895786;
        Mon, 25 Aug 2025 07:58:15 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:15 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:15 +0800
Message-Id: <20250825145719.29455-13-linyongting@bytedance.com>
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


