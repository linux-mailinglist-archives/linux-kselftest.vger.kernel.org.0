Return-Path: <linux-kselftest+bounces-20898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30259B436D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730411F23562
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7020125B;
	Tue, 29 Oct 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTl6tpZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DD1DF960;
	Tue, 29 Oct 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187996; cv=none; b=bFn/zGiw4e8hqcn7U3QP8xhKtUhtYSTsy3TJK6K/ANRKrOy76nZqNrWOVlOeTqVfJCos/lFltevwBZtKXT1l8UP3s8mKLZKqKxNMrnZne3eQH87wUR8kSjWJjWTBcy2m6MzJjj/qFTWwkbrxIdeGE2H2ATPz7uAXIMj6yInF8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187996; c=relaxed/simple;
	bh=x72eEdRMBENEWl47cq+IpbmlOAYV89oKCDZYIGYOfqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rEENUUgLiQ0jHz1uVLpm/VCAJF0bxEpj6pq0aZTKy5D27JFedyVjf7NpDkTzK70+sGyNbg1oWQ/MGihh6SIeIe3UcNlEANRE411UviPfVHHJXXOX4Xn6NR7V4z87iYipEfr8C4UWAzS+YLyJAh7hCY8Zkx1puxjRvf6N1pTy9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTl6tpZq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c767a9c50so45436015ad.1;
        Tue, 29 Oct 2024 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730187994; x=1730792794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/OOrlEt/IOTWUpwdkJAm5YSGuzkX0jOjM195037Pu4=;
        b=WTl6tpZqaCMmM0XK3CiFC0xqacAOaBqB3UxwA5txBx4h7UDlwhAWzlpbxL0zuivJX5
         /49P4l8ECqIUd5cs4taHO7lbwYMr+xA/yZ4JhAM6i9xTJqfuDEcDWg49UpaQPdo5yQmS
         pVBUrXh0XRcc1/zcBygBkOTaZjOMn2b88vtPEYIxcZPy4S/fy+XMM+96NSh73F5XaIRg
         kb7mK+3DSSm4oWFeDMNWA8X8OuVgSTZ1RzXsdsS5Lq3qaKRwF9O7ZP2FekQ4gS0hdUrD
         /SnFbb9FQd/wlFkDQVFnvb5gVx1wFYPQIn5mUVIhm52Md1obQi+prbxYcLvPA6cmzHV1
         Io+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187994; x=1730792794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/OOrlEt/IOTWUpwdkJAm5YSGuzkX0jOjM195037Pu4=;
        b=E9QXQXPjOx5nzp+ybMSUKvI8750cQw4QUju9+xtker+vZWu7fX1wrAhisFnAS+fgh8
         V0xEgoi3yT+g9g3oevY/Bf0XEhg3Lm9dKYKqG/2re4ka4NC5UVgTaeZ/zCsn3if/YyzS
         387UI+RCzEI5+VwNnpu2lzrbfZxB5yGEmNw/asFIDY473/qKyi1BoCZBQsS9zC4TtZf1
         7Jb0dsb+//9pY0sC6/gyEQkrEoz7ReyZtBjMEXOElENgFRUHNK357eIsLqGNu0z/rSql
         7ZThXSsP4flZXaquNYmVdpFZvQUKWt0k9DFr3EsbPNCmrZFl1rI4GydoRCyDQ6nLrkSj
         TZvg==
X-Forwarded-Encrypted: i=1; AJvYcCWLgg7VswDDAwQNj4qpEQv1yif820r3jTpi7hPxTsLpvqj7m+1U8kuJXqoG2mUkqrAHicn5id6ugf5bGUtG5sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5i5S9vMR2jNVW0GHe+dgtwhfzQz1CPDcV9fKnVqXC6/r+2r1
	ZBdzLuszNRMSQjuJ09CfsxNcY3Gwqt45lguoZhqBLoCGdMiJuChqxsDDBw==
X-Google-Smtp-Source: AGHT+IGoOfyrHVPz60y17mGyXfWaeDPYQgBw/XTSeKu5LDEJzF0T7iVC7Ips5z34K+aCQCJARl69zg==
X-Received: by 2002:a17:903:124b:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-210c68d4a96mr119684945ad.15.1730187993708;
        Tue, 29 Oct 2024 00:46:33 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210f0bee05asm3740345ad.250.2024.10.29.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:46:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2] bpf: handle implicit declaration of function gettid in bpf_iter.c
Date: Tue, 29 Oct 2024 15:46:27 +0800
Message-Id: <20241029074627.80289-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As we can see from the title, when I compiled the selftests/bpf, I
saw the error:
implicit declaration of function ‘gettid’ ; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
  skel->bss->tid = gettid();
                   ^~~~~~
                   getgid

Directly call the syscall solves this issue.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20241028034143.14675-1-kerneljasonxing@gmail.com/
1. directly call the syscall (Andrii)
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index f0a3a9c18e9e..9006549a1294 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");
 
-	skel->bss->tid = gettid();
+	skel->bss->tid = syscall(SYS_gettid);
 
 	do_dummy_read_opts(skel->progs.dump_task, opts);
 
@@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;
 
-	ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");
+	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
 
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid = gettid();
+	linfo.task.tid = syscall(SYS_gettid);
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	test_task_common(&opts, 0, 1);
-- 
2.37.3


