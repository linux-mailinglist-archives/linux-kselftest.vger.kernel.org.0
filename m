Return-Path: <linux-kselftest+bounces-43138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F2BDB1E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 21:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CEA19252EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200BA30146C;
	Tue, 14 Oct 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgftkfUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B52FF144
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471429; cv=none; b=N3fVWwUcD0RwXMQDaks5g457jV03Qh5N/3KPItty8n3Q2WYEcoa5bUKpHfbnimEElC+PMhhsc4QjmyXs2EFQCOmi49YyXnlAtEDec0yQDdO+sYEjOFwt/nYnkTh1o/buOHmYGSengw7/QMPAdJ/ZsWMvVuVYk2OpM9/h1U3+/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471429; c=relaxed/simple;
	bh=Mnlqh6Cht/0getfLLNgLfhatm+njIti5tG7bquUeZAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EjPc6Tz2Xea+aXlAPLss5X86i0P2/+UHS1t3kE9Bn5DZicmyK9Ugh4noYf0/HZbqNfISJYqHtpsfkydSqfg933T5b2MPLNix6m3mrQFBqETgr7W+Vf8ll+P4sbvUEUi4yFncnTDt4Z6RIX1BMJ+lJAeVYYi8Tqzh3vH75BTZaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgftkfUr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so32878015e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760471425; x=1761076225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkhCJA/dXOXcwZ7S2jDqDvDpKsjxlEMR9YOOSuHW/cQ=;
        b=cgftkfUrpBNXzTTeo0/ikV9tskeeIguaI3V0sJZ79Cukn//qku+8pdYbrG425mKXMV
         h6xKmNN0ziNJqdxfFBQIcbjrgxkmrrZwINIBhN9B1+gqJiBkvuQqt9LC+j+leOfHoTCA
         Y8LaLip7EtHsmM1QGZ7OI7/OhU/8I2EGKN7wiTV8uef8YzG6vZUXA5zjiZKm3oJ6Vd+Y
         OJdLaCnu819G1HgdCAAdHy84xV36P64djs3s98R3PrAFaL4WHfIa1pZyctAROrDH17hN
         55BOkYJhmPxtPpHpzFUcs1GKhfB6KQleljvT7zSgTGdw+r3NMworGUz/Q7twEpUjTAPw
         qXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471425; x=1761076225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkhCJA/dXOXcwZ7S2jDqDvDpKsjxlEMR9YOOSuHW/cQ=;
        b=eHwd3LSSobd+OKVlVPcsKf7YEV6OBdXaQ5uDk51icuIcWBEv+QchblQ9IRIj/Izp6p
         A6wIqAIW2YasMJudpj+1B/I205wOIYT9a7jXIxPwR/B9CbhKRjvougGYRNUAGaUVmXZ0
         L6o/Q3c3TWMoy7ObLBbIlVarzYr0k03SlXZyVF/LMXp90DZT+eEHY3GDUjnKSHiGb1ZY
         cD5p4F60J/RwTjRiqHwqvyroPV0QANTV865zSo75f2oJH+3AEbBysp9FgeM8PURTY3bT
         UvXPjpYg+gO9LebSHDbZhbfYgqyj+CzVRGN6X0Vh+W/XG4pneqwch+ZyTglGckwRNy0c
         AsrA==
X-Gm-Message-State: AOJu0YzVv3GJUScnbqsQqXLifQ24tCSjL0yLsGZAnBZp0127ZpC4TFe7
	IvfsFQAkkD3Qq5sv6Fo1LtQVLJlkQ3g6Dvhc2XsH77mI8MH8hHUC7/OM
X-Gm-Gg: ASbGncs1e8qdIw/w3G4P3XnghCv1KQb3+DD5Zm3CRzW0iPqHHwNhQcjUb0LUJfoypMX
	Nnyv/uuY6CQYOxe/IH9o9WLPT8jrAKFn+v68XzZkiGL/jaUuVQ1gH73P8y5Us1lMoLNcWry8La+
	KYPxkfzQ5LVn6N/eIJFpiH3A+X/xTkrnapsM0+nTtOxPJay449uz/Mn90uhk4RBOaOjmNUmjZzB
	RjxkXPsmUKH7gK/3U5z4rHoszkdBH8QZHY59+4cs0upPHJBoOhzt+vlZqYDJ9Jn3G9Ju1lU2/rw
	pCyZMQNZxvJQ6Lsw5CXKs+yFHkdoXACY7S/Kme6Fxr32/FfXmPFBH29OVwSLTiZUKg04JnmqyBN
	rY/bunZbNdjbUcbGVv+XsFEQYg20eqggeddG1kgIUw4o9k0zEDm8gqgI7qpc6K5fN1EqH02zwrJ
	aAgQoDsqcz/RCHE/A4SOJq/tTTRRagiw==
X-Google-Smtp-Source: AGHT+IHvY3jSRZiPAPUTjqLzv3in2vImFrsh3WPQgcjJugI6dCptqZos5H5Y/+xsV4lVpQrYH25Z3g==
X-Received: by 2002:a05:600c:1e86:b0:46e:6a6a:5cf7 with SMTP id 5b1f17b1804b1-46fa9aa0f6dmr179572755e9.12.1760471425371;
        Tue, 14 Oct 2025 12:50:25 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-177-131-159.red.bezeqint.net. [79.177.131.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49d03e2sm257969595e9.19.2025.10.14.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:50:23 -0700 (PDT)
From: Itamar-Dalal <dalalitamar@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	Itamar-Dalal <dalalitamar@gmail.com>
Subject: [PATCH] =?UTF-8?q?Add=20a=20new=20test=20'migrate.cow=5Fafter=5Ff?= =?UTF-8?q?ork'=20that=20verifies=20correct=20RMAP=20handling=20of=20Copy-?= =?UTF-8?q?On-Write=20pages=20after=20fork().=20Before=20a=20write,=20pare?= =?UTF-8?q?nt=20and=20child=20share=20the=20same=20PFN;=20after=20a=20writ?= =?UTF-8?q?e,=20the=20child=E2=80=99s=20PFN=20differs,=20confirming=20prop?= =?UTF-8?q?er=20COW=20duplication.?=
Date: Tue, 14 Oct 2025 22:49:44 +0300
Message-Id: <20251014194944.20341-1-dalalitamar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com>
---
 tools/testing/selftests/mm/rmap.c | 45 ++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/selftests/mm/rmap.c
index 13f7bccfd0a9..2ba3361fecf0 100644
--- a/tools/testing/selftests/mm/rmap.c
+++ b/tools/testing/selftests/mm/rmap.c
@@ -430,4 +430,47 @@ TEST_F(migrate, ksm)
 	propagate_children(_metadata, data);
 }
 
-TEST_HARNESS_MAIN
+TEST_F(migrate, cow_after_fork)
+{
+	struct global_data *data = &self->data;
+	int status;
+	pid_t pid;
+	unsigned long parent_pfn, child_pfn;
+	int pagemap_fd;
+	char *region;
+
+	/* Map private anonymous memory and fault it in */
+	region = mmap(NULL, data->mapsize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(region, MAP_FAILED);
+	memset(region, 0xaa, data->mapsize);
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	ASSERT_NE(pagemap_fd, -1);
+	parent_pfn = pagemap_get_pfn(pagemap_fd, region);
+	close(pagemap_fd);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+
+	if (pid == 0) {
+		/* Child: write to trigger COW */
+		region[0] = 0xbb;
+
+		pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+		ASSERT_NE(pagemap_fd, -1);
+		child_pfn = pagemap_get_pfn(pagemap_fd, region);
+		close(pagemap_fd);
+
+		/* Expect PFN to differ after write (COW happened) */
+		if (child_pfn == parent_pfn)
+			_exit(FAIL_ON_CHECK);
+		_exit(0);
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+	munmap(region, data->mapsize);
+}
+
+TEST_HARNESS_MAIN
\ No newline at end of file
-- 
2.34.1


