Return-Path: <linux-kselftest+bounces-6476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F108863EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF24C282F1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD9D310;
	Thu, 21 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFrIl3KT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1CDDB6
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063231; cv=none; b=KgyM9zITgD3mwzN0feRHHl4RGGK2NGAcXF7q/FQD4P7SZIrtrtWLKKHgomt7icUOouMKmuGHuB3KLXM5adfZTpa7DDcLWHnZPt0ZtMJpaA/YBVX42cZXBRBPqZMnBCrKFlx9Yev4WsWZUusfATVUOueihpODU7mpwjNQVnWd4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063231; c=relaxed/simple;
	bh=dxz7GqyPcYMZ17vA34k+wHNNyKUjhZBgCEw2mQEZ818=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I7B9yhfTSCICkooxnGGBnwq4244k8XuuPvti28Luxfm2RdJeIKYsMXbd0v7Fw2DHdoywNA95Z2noFwhRWfAy+CgRr5znMOEnKdVo29ClOAJaDvyCZqCl4YbdKp9Ar6zKMywsBLo3BM8omWK2MdM9uK6qmi8JemPZEMD1xLND9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFrIl3KT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so1034039a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711063229; x=1711668029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJkna889vaoG1pUyPc+t29CTNaYEYMQM72LV9bOJhDM=;
        b=BFrIl3KTZXpSZxrOaWEm2rOiR7mqdraxMTbib9qZsc9FyJj0LBfnRfJ43/n25nL9Yv
         Ch0X/BUV+DvL5lfTLAWAbk75P5YCHKX6fxv+A3s2pQ2DnhyWIQcPSjCLiPk8NhnueAr1
         a4VfVx4fGbuHB3uXmiomuat/eK9muRF/cL1f8ri2iEA/+bf843w3vK/MGua0BDyHCEIu
         KKM/PLwQZJA5/AOP8ntPcX8vWTPUjETseYMHTFguzesXAot4+XETF86/7/mVPzXRDXMo
         WG4+NURwhAdAPrzTdg/VxngY8O+aN8y+UyPgihbENGw4q7npNYrsr/XkIhRB6u73tu+N
         GuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711063229; x=1711668029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJkna889vaoG1pUyPc+t29CTNaYEYMQM72LV9bOJhDM=;
        b=xUrRE/4K+p7sBUAaxUuLNZiksf6i78PPmUVuMMow6pyO+6PYfaCjH8CN4g2jMLsYjM
         c61qFGTpwRVTrS4IGRfWz4caZTlvIxNpl1gICoWG+lClWuerbKX2BRKB43X54pNgL2T9
         YgcCZh4P74TaWfBx7jBqolLLSePlC4rOc3douCOeuZFVYYVp91fbOZqijFE4VbqDzsyS
         yEB58nFueCKIqX7BiD6oGOI1a1cGhpckzhLlIWIGgZXdbSjA5PWYFv9P0BVT03DyOmXm
         ZcPhaYW74SrvZ6Ut4KUuuCRN+ojKqoppK59Wo/fUC+atTH4CfqSle/KuznAX3MPCp02s
         P5kw==
X-Gm-Message-State: AOJu0YwhfWYAv0PGagWPZs7h21oeD3XkzYaVZ7NP3FP6fk8hEWtpBfDv
	cvFyIjxMcdqGTy7RCtyW6L4ATy/WhHmKOYU/ZwiBDci4xWf9XbeNs5yWH6KVxtA6ootYxXIf9Nr
	aqQ==
X-Google-Smtp-Source: AGHT+IHy7n9urU4OinfJFgbLw+GEQU4fI6k6GosyucewtA/EmPr7Kyb5FxEC4vw7lvW9PN/ezx1bGic7M9g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:e304:0:b0:5dc:1cc9:36ab with SMTP id
 f4-20020a63e304000000b005dc1cc936abmr1620pgh.12.1711063229245; Thu, 21 Mar
 2024 16:20:29 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:20:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321232023.2064975-1-edliaw@google.com>
Subject: [PATCH v1] selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The sigbus-wp test requires the UFFD_FEATURE_WP_HUGETLBFS_SHMEM flag for
shmem and hugetlb targets.  Otherwise it is not backwards compatible
with kernels <5.19 and fails with EINVAL.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 4a48dc617c6b..21ec23206ab4 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1437,7 +1437,8 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_fn = uffd_sigbus_wp_test,
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
-		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
 	},
 	{
 		.name = "events",
-- 
2.44.0.396.g6e790dbe36-goog


