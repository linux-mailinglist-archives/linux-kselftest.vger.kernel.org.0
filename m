Return-Path: <linux-kselftest+bounces-6342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAB87CAA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 10:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41BB1C21526
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5617BD5;
	Fri, 15 Mar 2024 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPWe5/fg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218E17BB9;
	Fri, 15 Mar 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494818; cv=none; b=YiK83fMoqpC04q9q/+NwYKQk3/SdLvnrOMoOpd1ElaO7Gva8+zVxog3xZk9pJJoWCbc9QcAkYbtQS9CfQ6DQGQOGnaMZnuNvJiOeOHXxQM1nnhfVvi8YFRV+bNbk1VV3GuPCx1hRyTlmDQOYACX5i4sSwf27QxsUxBcMAu0SUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494818; c=relaxed/simple;
	bh=B189A+GOAXY/PxUfUcn9D1ygMGSqq+flupHGVm7EOrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iH+W858tcMKDCkZ6Gcpr3vUS2OGN5GHYhMKB6ANDv/zRjLJBMkSJI8njtI8pIHD/TbYl9LXFKaNcAxvGgrpwDKxTOwe9WJjZkeIluRB+lRDYJy1tdNztwsQ5l7+Az+3XMA7iHtCE7RIpFlZAc4ZHuDTvZeSWLlhoaY5LvpwPCJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPWe5/fg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413ef770363so14481525e9.2;
        Fri, 15 Mar 2024 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494815; x=1711099615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uoc1FhiOzy9zo6HbOlCBGlUHBMGiad+RyI7SAZIQAY=;
        b=RPWe5/fgY7De3x4daPRcsDXP/12QcJnZc8+Nvuogbk8oifxvvqrHBA5zxd12C5eI3b
         m3TK3sK1IUmR9viKP4/MJOfnucD8XvnbnTYLWtpaLycTf7ox+9lp9nJ/Kq6BEFEe3plB
         NAihP1YZTN+LCEGDtm+VTg+cUHIPvYnrjQm7vjD8I8A0aX44kzt8NdzmpgC9Cd3x2kgo
         UINcTPWzHx3VaspiEx+IHI1YnYpBoHAjc7yBi4TCeypHWnRnaO14YctRorbtQoyn9zAR
         c1JS0sxRkOSx+raJksmYVkqHoBpQtqksGjx75BMPW0wLFkGS0ItBMmA8/Bmm4x+jk33/
         FGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494815; x=1711099615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uoc1FhiOzy9zo6HbOlCBGlUHBMGiad+RyI7SAZIQAY=;
        b=CSFZrNJMHoddpU2+8LuHNAvbRWRB2PDIts6xFa1JpOskLvGEim7EzWTTYNwVZjCeiK
         pjYvB/mCTcxKxjNbokn3SaN2OCgY/nunnm58OotuFwkSs2r36dZn8qAxjl3mzvJeTYPm
         I9dBBVVkJBXk7xvbvOAuUL9kwOS/LZL2JKzcmKM8IeAZxfoiagRoi0A02XdVdWCvfTst
         DR6X/okI4uROE0bCsytnzHlsyxw4rSgDv/nuiqcNeBkgaVSdMa53Y918/+XJobFlpkJs
         x+6INWnY9z7eiKoB2DNHlKlEr/rz/3FGGaf7WgN1R6w9y8rH2j14Hrb/bVIsdVqcaqUF
         RUNA==
X-Forwarded-Encrypted: i=1; AJvYcCUoIUD8NPEwrpBfbWq4KpnZe36FRNoemJ1xrnQhrstcO4GSTU1yzYKN8FDsesF0k+cjt9ayVYTXlnQmkNkUpbo2R1/eK9gOCmgrUevzQnGlvZxjNdEN8kFquhsTPJFDeXQEI1FdExRgz0Gr1RYO2CvUwIdYdDjcsjIXpBZpBRFXGlP2
X-Gm-Message-State: AOJu0Yw9mN6VFZQkFAfo8Y77ij5QSInoU+jOXbkT5DiJhkHaUGMwautt
	plqTAlge3SITlBD5VDOeu4JSM4g0Iugff1adeMzoDsA9kNY9SxJn
X-Google-Smtp-Source: AGHT+IFMeMBdmo97BMuwK0Izj+6Rxcz5sZu0QUBhehR7e6sd457BVotjbx7ooGfVpA6f6hjDlf4IYA==
X-Received: by 2002:a05:600c:45c4:b0:414:24d:7f9 with SMTP id s4-20020a05600c45c400b00414024d07f9mr651665wmo.1.1710494815202;
        Fri, 15 Mar 2024 02:26:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id jg5-20020a05600ca00500b00414024d078dsm944989wmb.17.2024.03.15.02.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:26:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: Remove second semicolon
Date: Fri, 15 Mar 2024 09:26:54 +0000
Message-Id: <20240315092654.2431062-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are statements with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index b36de42ee4d9..e2ff8ea1cb79 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -186,7 +186,7 @@ static void *task_producer(void *input)
 
 		for (i = 0; i < batch_sz; i++) {
 			if (!pthd_results[i])
-				pthread_join(pthds[i], NULL);;
+				pthread_join(pthds[i], NULL);
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 3db416606f2f..fe65e0952a1e 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -673,7 +673,7 @@ static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, int mul)
 
 static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
 {
-	int *t, i, sum = 0;;
+	int *t, i, sum = 0;
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-- 
2.39.2


