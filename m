Return-Path: <linux-kselftest+bounces-46526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D6C8AD77
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1643AC045
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97C33C538;
	Wed, 26 Nov 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnG2lGal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287533D6D1
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173339; cv=none; b=aiUOnN6ersYNniEvoMAFaNK+FAz2PgRRhRehIMLZQCk4VXrYiLDnbsdy1QSBOxLKCOVwhzP6/wkhsUGOjox0HMi1GA2W9VxQbveRL/+uQ3spZieHunlJbiuYHrPdKt3aaEZGC80XIKfVvNEEekj2E25YuF2BKMqWYrOMJx55Rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173339; c=relaxed/simple;
	bh=7I2EQS/O47z6XkwcLP1Gg8ZRDwtXdZe/P9q5/pdULpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDFE0Os2z6dGciWZOXkg0dpa4dKBDEK8bsviZGws3Ds2iZg1daMve8IkSxddxg+ef5iAex58K77OFoz5iU+w5kvYdDQP880gSajLOeGXRSplnt/wZyAOUka3tDuJrn3CSJhI7yO2donTg+81DYTOyhBIb2X4fH/cnnRJsFOkisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnG2lGal; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo8195921b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764173330; x=1764778130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0w85V/n6/PltUzl9FbkvTGvY3LknN/8DxQ32r6IxQUM=;
        b=XnG2lGalo2r7m0ceuuS65+FVFrGEoCyIU6X45bSGmuk1dEFFiPErtkNv5+j0LBIeaJ
         XJqjcmGPVpokdxPmtam8sj1jqaXxy38XXgTlUYyR15nA8FObMVYFZ1HxTPofhnlT+FG3
         rAxSNTv9CunasAh4rn0rClsSevupK7PFBI7x135rY1boZjkSSxUxPiXow6PtdLfJyIe1
         qSA3ZaqB3nQS5LwLIceEyaE24weKRxgqF1FOzvemZYQftiA6Yzl7UT3lROzLRSjmpFIV
         cHgdjkrc0qdaV0MEaovZO+PMotJIM9noUPuzXDm9IDdSpSKYRHW+ihVhE14W4jYi2Xg9
         Hy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764173330; x=1764778130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w85V/n6/PltUzl9FbkvTGvY3LknN/8DxQ32r6IxQUM=;
        b=h3mW0xA6YzI3W+Vg9q/Dac664hUu1PvkayWTB7PjQMltpvbabVag0l7i8pkikv4wj8
         raReIADGrRcEWihik8Vns+YgTzNVV2z1Qt5FifU2rzhEtQDMZm6L5Xmp9t1ux/flxLQV
         V41B268Z/0lLOl0sbvs5oeDEPP2HVt/QCjMj/JHw1y/jc0aENpM4JNusr4MmrQLuevge
         nmbi/CES1t34WazEdb9ltmUf6amc85lA+B1eoqUjF2L4N/+AmCSm5k9XXJcRF9xprk86
         G+AohMlgVIxGQ1eMkmrJWnfcHViNqvNrhNQbY5feJ2HthWVNVSovVGU7tx6TD7s76P9f
         553Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyiRYjhyUKA3W/nD3DiXptpoRPzc5A3Muhw2sued7T4FNbB9UWY3QZzXIRauZy4YG6RcGFv7IXdwliRkTqbxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJ15YAPlGjyQ/0oApqbqrjCJFR4KoHRIUeuCTYv4SZSShgq1U
	7fYTi3ud4GxKaBwTqRDgIv45Qr87ygn+c9XvKcadS54ZDmy5W2GAmLQ0
X-Gm-Gg: ASbGncsuZzdzUKWaCR8ayfpQIvuc52aKFzFKfsZs17NEzo4gy67UmGbq0GakCqVb52n
	4CwATZ3TdIMqKZwQwQH27mpvV0scFQb5mVkkpzdQZ2TIWU4rfZAh3kYf0rwdke1PQWWTvTLVbtF
	S63yLtFNehBzzSWt+eRqTHxaeaCs8nTLyLgu3A/vw30yB8psyfqsU0qfibi9DbrOA8mOnnup4zb
	tZ4ygZVVHqBDcAp4iiE9aJMGiGjWPjHjydA51RZ3THEcbAOXS4Hz2Cbgf1cjnOkngygETV5r4rY
	dxjlftpDpO6i+8Ca7GqCZtslB1v+2OxDMLbzW1c50XAyMA8/Ajw+Ds7RFQYkLZjz2LRlGwPg0Ye
	HvZb5z128aBS0/HgNi9oqHgp9brGgGNsiqPa5l4k00Bbi7aagSgaInCxSLMqFFEgSaKlCH8lX6s
	EEKzTkxm2HMBNe83mjy6rOY6WwBMA+cw==
X-Google-Smtp-Source: AGHT+IEebVkUKBP+U1i9Oqi7Ort6BI2gg0wHmeA+Y9t88Utsg2k3h8rxgk1fLNRybEyKRORRW5br6g==
X-Received: by 2002:a05:6a00:2d88:b0:7b9:ef46:ec70 with SMTP id d2e1a72fcca58-7c58e50c16emr18224646b3a.23.1764173330206;
        Wed, 26 Nov 2025 08:08:50 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0243b3csm21831681b3a.36.2025.11.26.08.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:08:49 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/mm/uffd: initialize char variable to Null
Date: Wed, 26 Nov 2025 21:38:30 +0530
Message-ID: <20251126160830.52124-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "uffd-stress.c" & "uffd-unit-tests.c". address of char variable having
garbage value (uninitialized) is passed to 'write' syscall triggers
warning.

	uffd-stress.c:246:39: warning: variable 'c' is uninitialized when
	passed  as a const pointer argument here
	[-Wuninitialized-const-pointer]

	uffd-unit-tests.c:581:31: warning: variable 'c' is uninitialized
	when passed as a const pointer argument here
	[-Wuninitialized-const-pointer]

so the fix is to assign char variable to '\0' to prevent writing of
garbage value.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
this warning is raised with clang version 21.1.5 (Fedora 21.1.5-1.fc43).
---
 tools/testing/selftests/mm/uffd-stress.c     | 2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index b51c89e1cd1a..700fbaa18d44 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -241,7 +241,7 @@ static int stress(struct uffd_args *args)
 			return 1;

 	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
-		char c;
+		char c = '\0';
 		if (bounces & BOUNCE_POLL) {
 			if (write(gopts->pipefd[cpu*2+1], &c, 1) != 1)
 				err("pipefd write error");
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index f917b4c4c943..f4807242c5b2 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -543,7 +543,7 @@ static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool test_col
 {
 	unsigned long p;
 	pthread_t uffd_mon;
-	char c;
+	char c = '\0';
 	struct uffd_args args = { 0 };
 	args.gopts = gopts;

@@ -759,7 +759,7 @@ static void uffd_sigbus_test_common(uffd_global_test_opts_t *gopts, bool wp)
 	pthread_t uffd_mon;
 	pid_t pid;
 	int err;
-	char c;
+	char c = '\0';
 	struct uffd_args args = { 0 };
 	args.gopts = gopts;

@@ -819,7 +819,7 @@ static void uffd_events_test_common(uffd_global_test_opts_t *gopts, bool wp)
 	pthread_t uffd_mon;
 	pid_t pid;
 	int err;
-	char c;
+	char c = '\0';
 	struct uffd_args args = { 0 };
 	args.gopts = gopts;

@@ -1125,7 +1125,7 @@ uffd_move_test_common(uffd_global_test_opts_t *gopts,
 {
 	unsigned long nr;
 	pthread_t uffd_mon;
-	char c;
+	char c = '\0';
 	unsigned long long count;
 	struct uffd_args args = { 0 };
 	char *orig_area_src = NULL, *orig_area_dst = NULL;
--
2.52.0


