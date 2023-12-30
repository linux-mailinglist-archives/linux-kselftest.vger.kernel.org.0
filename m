Return-Path: <linux-kselftest+bounces-2524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69763820368
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2657A281FAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B77EA8;
	Sat, 30 Dec 2023 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uN10LrAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8322567
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Dec 2023 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe47a05516so2409658276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Dec 2023 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703905001; x=1704509801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uWd3JqiAE2BBpQa8flrDjVspwGJTFaM7DQZsv7IndQE=;
        b=uN10LrAVWk/f6UnLmZdJyiNxfWgTP2OUTj3v1ZbfS18VvpKR2kZlER08qeI+D1hmhG
         yJgWJOswHp/bDCDGqEmYWhF9w3jGl0yIIlirnNea2I64ImIBRF7BbMDatD+RlUoG+IeZ
         mes1HFUaWYAjgznC9ayoFY/zQO50ZJLMH/Yx0qBP1/lKz91IICTEMi3G/c/Qj5qqn/dA
         d3nhfBnh0Aw+4B9EjuF+AJi2B74O7k2l8k8lZqotzztTontejQPk2IdcxTOo6ggvgz06
         w3eeL+ET2vsRds4zKWs8H02B/2VGmJC1O0DA9V4KbHS5RssUwoqVsomvCdzkPdFRLnyd
         bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703905001; x=1704509801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWd3JqiAE2BBpQa8flrDjVspwGJTFaM7DQZsv7IndQE=;
        b=OP/yzMIIts4hdEEQFPCiz3eoTewQRxiJKsxgHJpXOgcwiMhcj2qz6M/rXjhJPrVJu5
         1pPJGIc5oTYMwEAuMXkLx+IOOtdXUfkdKAkngRhrqseXQYJt6L6LMorD8UFZ/twcQEDy
         75In61AYlIkT8TBYOwKIXa97Ik5kS954FQtKNUgx2bl9jJ6zcrUgWpfgq7nAZpPmJFT7
         Ii7EGDmZHZgsWEbkvGNekAloSmHHetK9HzIqz9eFxAoUtd1dW2jfH8/rtYruT3Sm5Xsd
         JVV+/659t3xkUONEcFWOlgRUkhGkVSktElKVR7OY1l6Kgb0oECdoc4aIuItyPWpDGYk+
         ohug==
X-Gm-Message-State: AOJu0Yym2TRY2zIz+xfyXgAn7/g2BsQCQqZBvE7eEVqMVZVihvh/OxU6
	34DxsN3ZnRBH0teAiJZZziDlizWHRgG7v6hcRw==
X-Google-Smtp-Source: AGHT+IHRb6MDmtyBRGquDuap6l4J0StnX2Ra/8WXL9DSsV83HHhUqhEmdZo6j2U3K5QEkTzvL3vHZ9ujVYM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:aa12:a8e:81ce:b04d])
 (user=surenb job=sendgmr) by 2002:a05:6902:561:b0:dbd:b59f:217c with SMTP id
 a1-20020a056902056100b00dbdb59f217cmr4894826ybt.6.1703905001158; Fri, 29 Dec
 2023 18:56:41 -0800 (PST)
Date: Fri, 29 Dec 2023 18:56:36 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231230025636.2477429-1-surenb@google.com>
Subject: [PATCH 1/2] selftests/mm: add separate UFFDIO_MOVE test for PMD splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a test for UFFDIO_MOVE ioctl operating on a hugepage which has to
be split because destination is marked with MADV_NOHUGEPAGE. With this
we cover all 3 cases: normal page move, hugepage move, hugepage splitting
before move.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Patch applies over mm-unstable.

 tools/testing/selftests/mm/uffd-unit-tests.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index d8091523c2df..cce90a10515a 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1199,6 +1199,16 @@ static void uffd_move_test(uffd_test_args_t *targs)
 
 static void uffd_move_pmd_test(uffd_test_args_t *targs)
 {
+	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
+		err("madvise(MADV_HUGEPAGE) failure");
+	uffd_move_test_common(targs, read_pmd_pagesize(),
+			      uffd_move_pmd_handle_fault);
+}
+
+static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
+{
+	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
+		err("madvise(MADV_NOHUGEPAGE) failure");
 	uffd_move_test_common(targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
@@ -1330,6 +1340,13 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_feature_required = UFFD_FEATURE_MOVE,
 		.test_case_ops = &uffd_move_test_pmd_case_ops,
 	},
+	{
+		.name = "move-pmd-split",
+		.uffd_fn = uffd_move_pmd_split_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_pmd_case_ops,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.34.1


