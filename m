Return-Path: <linux-kselftest+bounces-45878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF09C6AE2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762C34F4417
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722383A79DF;
	Tue, 18 Nov 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgiMk+K7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AE3A79D8
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485826; cv=none; b=BtuzELrptD8srDw8bYvvslNyvV97FChRD7lfP6I6eAG/0JjVnHuQfuw7C/8fnIwA4n2eXt95Uphrkn1cZ9Gh/kq01pM5f9a7sIzfx2Ss5xgdfBRdy40vswwoc8Zxd6kzwRYe9nxHzgR1qLh86kvC0Sg2CU3Pop+f9NO7q1kuifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485826; c=relaxed/simple;
	bh=LDZGL4a3vvv8O1BiYRfiPuGsVbYdd3TRXhA8IpuHpl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sKIhAGcVnmXd1RJtlBblNfucxsX0IvyOh765slerT1GZiTzremTdaceGIdiKQPQGYs5VWxZJg23gTtkkHAvUP5/GKBc1+5R2/2owYoKahGXN5gasUK5rhSQFR3g91ZJ7QgUyJlLyV9J89eJJcOdh0/9ALmjR57ChDGoiQHfn8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgiMk+K7; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-299d40b0845so46093305ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485823; x=1764090623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opKHW4snE6AbRbbuPkU9JelehU8sZTSa7jldV99EN8Y=;
        b=OgiMk+K7HrwvraM9WNKcUdSGGEjH8O9zvy6yOQ3pIk/8Qf0nvO9z7CTrA/QTrirRS4
         fC6uQt8dzxSk+BruPCH2ShwshRiW/vZjgczbsgQwtrgPZ0zVSSDIQT+mKySYyb3wa3b1
         SFIjjZ/ywbLvsdyz0xzzFkP3M7mJNsw3R12L7GZ5oj6QdFC7439SJ2F8K/BsYzV1twnc
         4S6rP3S0RmJHu2biCrjedTf+W7q/WmSXjqrB97fPqTdrz0yuELqORrnhntoefQV/q3RR
         N3qlcU2YYL55LrJp28w3xo4NbaxC7pcE1JOFdSVMeYyTbLaAY7dXrwem7fdbOKjyYzIm
         C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485823; x=1764090623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opKHW4snE6AbRbbuPkU9JelehU8sZTSa7jldV99EN8Y=;
        b=tHShDl0yrWmhH+XubBwOKNykTF2XEIBlbQCPE2LGmJAes+vl0rgLZf+FNBY4Cbllqy
         UCXyGVKLui6N/fMbIqNq9pBbFfNUuWsb/6qUJ64yB63vBa5qPY5Rv2aG2wsITPTol8AL
         OqWQujEhODYuTJ+NxThh719J23hZbieViCr+t4CGgVIdlBax+S9ds5gyE+LD+0eekvDk
         h5bkKAjumUbPLot0kovYYLfkEQaLewqKbVJV/X7RFQoCx475rxrF+QhYw04/MnX0hVCB
         nGv/CJ9Dfo8E+kK+cL+Shkw1WlRwx5xPamNQ7NtLzEa2M0wZDepRWlkxagLv+XLeizxT
         FA3w==
X-Forwarded-Encrypted: i=1; AJvYcCVLiXbsW3FsSatzJqVq6SB4l8N4i1wsedWdC2RldoKrEGlnowp5yWrgPNUE+WBbtaSbRfzAoeaH414bhTZnFjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+0wacBxZo0e9McYQXQfA9SVB8mNKxcVCkOQAGa0uYr4/q5vK
	ArJkGynefMtLYdYUtPQQTXV23tjKKq76OGdWZCSnjFAhpsbptZA0n0ZR
X-Gm-Gg: ASbGncs61WlBmX7xyk2UqYcylVr4pj8AzFNQVybnQTw25655eAh8fDTEveuFlrgMeJ2
	FCpYJnySVlN4GP7de5BV1PkRg3bOQsMNsUz0N58rI5TjMAuaWRhGFI6RDb06GQcKdjMmgwMNNUf
	vVWwyFMGDJ7mmIxh0YXkugSFowyXNpRsa3hC7mPPYw3qcRe71pdySDY0FQ04B3Nv5VHjOlcsIAy
	fxxSzspskXr9YRbidhnh9rDZOi2T82b3UUsbsXfDtB77P+0eilYnoXcWeY3rKYOsMpeDSb09UcG
	R0hbJNNEih51l9cscXGW2bNjNKOoqVH66E/sI55u+sS/Svd49ofHOE6ccgxM0GdSBHDOkAm6t1i
	tQE8hpfePqvXK8lNCZLVGLk4CxlovdYM+NCg3THXfKSkTnkZvnQjiCAffSTzaVWu0+GcRD2jn6y
	DLNV6rJVQVTuCXNRjfB2LkotFtkKJZ21RFz3bwh+/+pr/1/5j9mEc=
X-Google-Smtp-Source: AGHT+IF/KaWmF75r7fV6/1/dLuD/8Mw6nF7YF5EqK1ZwOJVDh9j7Np/kDiIrJ8NQOoRAy343jV5yJw==
X-Received: by 2002:a17:902:d506:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2986a6b876dmr166505575ad.8.1763485822999;
        Tue, 18 Nov 2025 09:10:22 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d332asm17165019b3a.25.2025.11.18.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:10:22 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	andrealmeid@igalia.com,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftests/futex: Fix storing address of local variable
Date: Tue, 18 Nov 2025 22:38:50 +0530
Message-ID: <20251118170907.108832-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=8
Content-Transfer-Encoding: 8bit

In "child_circular_list()" address of local variable ‘lock_struct a’
is assigned to "" raising the following warning.

robust_list.c: In function ‘child_circular_list’:
robust_list.c:522:24: warning: storing the address of local variable ‘a’
in ‘head.list.next’ [-Wdangling-pointer=]

  522 |         head.list.next = &a.list;
      |         ~~~~~~~~~~~~~~~^~~~~~~~~
robust_list.c:513:28: note: ‘a’ declared here
  513 |         struct lock_struct a, b, c;
      |                            ^
robust_list.c:512:40: note: ‘head’ declared here
  512 |         static struct robust_list_head head;
      |                                        ^~~~

removing the static keyword of "head" to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:

v2:
Added changes suggested by André.

v1: https://lore.kernel.org/all/20251118162619.50586-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/futex/functional/robust_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index e7d1254e18ca..ef21a7ec9def 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -509,7 +509,7 @@ TEST(test_robust_list_multiple_elements)

 static int child_circular_list(void *arg)
 {
-	static struct robust_list_head head;
+	struct robust_list_head head;
 	struct lock_struct a, b, c;
 	int ret;

--
2.51.1


