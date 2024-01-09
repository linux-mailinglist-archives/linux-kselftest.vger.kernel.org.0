Return-Path: <linux-kselftest+bounces-2749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD58828389
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 10:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37001F289E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E8358A4;
	Tue,  9 Jan 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn0jv3ig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DF358A0;
	Tue,  9 Jan 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccbded5aa4so31398621fa.1;
        Tue, 09 Jan 2024 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704794220; x=1705399020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNT3knrwtx3ZC85CWhs6pgGlgSacEXpphCQbs6n70C0=;
        b=Tn0jv3igbLr4mDkkRt7ZquqKM/lpEze0j/LRzoKkc5lZRyundLhVvYLbT1MkJaMzm/
         dbwhv6wE6ZqkY8nkiNn3hcAEgzawsIWiblibXasW0Npo9m9yWAtUYIQwFrgL61KZob97
         RT4BP72sJthDsWGRaR/WQJWnObksXh29xj6GMU5/+Z+ttE77HquXSMegKz+7LYfwL+DB
         dYJNZTnUPBLs7d1wIF+nbpfg8dinVYGnwFc95uc8BriiUGZK/Hs0k7IZkQxAMGw92BLQ
         50oIFHGb6Ly8B0RR9zUqF2FDsvmcphbVFqMAtN3+CiV9sW1thKMsBVCCul8lmPwsZhGs
         vVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704794220; x=1705399020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNT3knrwtx3ZC85CWhs6pgGlgSacEXpphCQbs6n70C0=;
        b=AdJfct5WErIo9TrQbhEC9Bl8dOIhtOa/weTj2hKADuuhLzR8cI6gDlfvrCa58gcKsI
         LXhk8HPX9+FbQUFXGrgzupQo2ckUy6qCfxg045W6tk7fIlL7lbHN6k9T9BDWUWpH8cgr
         OXLr616YnWNyzwvlYvnPUvZ6ZoMYSnVskzUUz/oxSCYF/Vda//mTU5cfDTRohzW3L83y
         cdesRxDO/85W1StkqMzsL5bb5JDwK3zoYFZUei+PzY9vY4QqzGjtvromrziMWml0pNRo
         3OmQBjhdJrHJK3M3NDCl3Rqtj4k4xyPqodVzGHr4OUG/IfErBVBCRvbENQyYdoVuZ/VC
         9tjw==
X-Gm-Message-State: AOJu0Yw9zc3ZIU7cROEoVhmxvh4PuuWASsDmivstBkNllPC1mwNUWLwe
	Ful62oAiZiNyK10IetFlGpg=
X-Google-Smtp-Source: AGHT+IGkMB2ZfO0i6cIwd5Kg8TbkhohMQGYVm9XLNv8yuUlqP+sGYQmxfMcZd4FSKhvAQ2tlr0BySg==
X-Received: by 2002:a05:651c:603:b0:2cc:e48d:d0f3 with SMTP id k3-20020a05651c060300b002cce48dd0f3mr2208277lje.79.1704794219704;
        Tue, 09 Jan 2024 01:56:59 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id a3-20020a17090680c300b00a2a4a6e1bc5sm832017ejx.204.2024.01.09.01.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:56:59 -0800 (PST)
From: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] find_vma BPF test: increase length CPU computation
Date: Tue,  9 Jan 2024 09:56:37 +0000
Message-Id: <20240109095637.35934-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Some aarch64 systems running a PREEMPT_RT patched kernel, needs
more time to complete the test.
This change mirrors:
commit ba83af059153 ("Improve stability of find_vma BPF test")
addressing similar requirements and allowing the QTI SA8775P based
systems, and others, to complete the test when running RT kernel.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/find_vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
index 5165b38f0e59..43d62db8d57b 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -51,7 +51,7 @@ static void test_find_vma_pe(struct find_vma *skel)
 	struct bpf_link *link = NULL;
 	volatile int j = 0;
 	int pfd, i;
-	const int one_bn = 1000000000;
+	const int dummy_wait = 2500000000;
 
 	pfd = open_pe();
 	if (pfd < 0) {
@@ -68,10 +68,10 @@ static void test_find_vma_pe(struct find_vma *skel)
 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
 		goto cleanup;
 
-	for (i = 0; i < one_bn && find_vma_pe_condition(skel); ++i)
+	for (i = 0; i < dummy_wait && find_vma_pe_condition(skel); ++i)
 		++j;
 
-	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */, i == one_bn);
+	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */, i == dummy_wait);
 cleanup:
 	bpf_link__destroy(link);
 	close(pfd);
-- 
2.34.1


