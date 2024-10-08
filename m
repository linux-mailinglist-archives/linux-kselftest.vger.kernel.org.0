Return-Path: <linux-kselftest+bounces-19303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D39995B6D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF3B21BE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BCF217320;
	Tue,  8 Oct 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwyO2kQd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEA173336;
	Tue,  8 Oct 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429166; cv=none; b=ktBVp8cDtfZp4zd+/XpIY/ErQ7HzG39xaonuTbRiksF8QQ8YCRnSwAyIizGhdKePJiDG88pMGrJDXqWdy0vOj35eef8NcCsnorGLxO+DXMFAu2+Yd7VY+gIIPYlFi2H+/f8efFAGadclToUzTI6EnDGwwgwSZA4Py6T1NEin1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429166; c=relaxed/simple;
	bh=V3BdJKy7CxOhfroJGxI5BGYjNRO00SqO6rdsy+vpmMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UrrtqkDeGBXmi5Rxzn+G7vTnI8JOg8MOw66r49d1RGsew6Lptjd1SiXghLL/hr1VUlwm+PG7E892Mmlcho51s2W4RM/FpB0jm8Lpz6or30KWqc0NrZUqCSqC3ux9/O8LI+hZpdcUHhxagDDhPaeDjFH0i/pp4fKMJ5N5VErwuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwyO2kQd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3061169a12.3;
        Tue, 08 Oct 2024 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728429165; x=1729033965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsjmZAaiL+r0qx+ZNZLEANsPckK9zwVJsn7S22NQzkQ=;
        b=AwyO2kQdzqC/2gITfL1+muD1nCLNSMQCbRu68992nRVzMWlPOftbx9pNlBV28ZDZdx
         nXJ97LDyqxwGJcSTR5Cgs77Le4PLVGj4xW2AlwneOdFV3K6wu1SlqibjUzEGBL5/bAFi
         m+vMQYMpH+IZ+wdYgRjYtVRrNGp83TK/ozKUA0tUiaSCTOuC/7U0oU2xswDV88CnbbA6
         Qp6pvlZBlEKHb6qB12A3YN4gjkBcKXm7pdx8jtC4/XBqmUUMu+otg2NwrD4ARUYBdXPb
         R1hTLcsrOTDgehWR2VHq0p8qA+DcIgBCRrbOQ7nFLWefxMbozGUf9WZY9SZrOWtD0nm9
         nToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429165; x=1729033965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsjmZAaiL+r0qx+ZNZLEANsPckK9zwVJsn7S22NQzkQ=;
        b=Q9VeEG7mcaV/tKyOEJ7lsk2TuDxqPmAuONdhmpG7Bkj47iiLAMy+xf18ufzllViClt
         sV2hqXUnLX0kTQiJ27gHse48DYjvJWiDEEohu/qjDwpauLnDHTyCdAI7skKDO4RY5340
         HXm4rqwV2/VNQRnUcsxtLk+kQZ4+HbYs/4ai2ZMVurAMFUAMD5BnYD6fISA0ikGH+3eW
         kO5zr1z0JGgQfwRvKi5pJqKHUvpO+h0I/LV2IY16shjgBSHQbwDLlVlkehOLfj/hlCVg
         e/PbzdAPbUxeskQNaCNghucf8jZn9r3r94WB0reLk/PGzPdSAewl9RmSwttwl+t0B5v8
         lWEA==
X-Forwarded-Encrypted: i=1; AJvYcCULpdJusenhwx/IHhBmjtZ0coHXqubO5ISwI6Dy356v6OZxLoGX0sa8Ku7QmXcdQ/mszn3hb7DveCMoh8wz8EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEG0mNSoAJb5MExXhbmPoVNNp4T7jP7GwyACyE57MRcB0df+uj
	R1d6K8UIGwHxPI/OyiB7WtxY7q81/XZue0ssYabbLFKe6zOlzxMBLZZAnQ==
X-Google-Smtp-Source: AGHT+IGKpGMqSDziCrUl7esZ93wa2cuNi5PZ2M5lQymHsIKGXZhZywAmLFnnwlXZSU5SvL0zctj2Og==
X-Received: by 2002:a05:6a21:4d8c:b0:1cf:6baf:61c0 with SMTP id adf61e73a8af0-1d8a3c490e1mr756328637.44.1728429164669;
        Tue, 08 Oct 2024 16:12:44 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f682decbsm7381929a12.45.2024.10.08.16.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:12:44 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf v1] selftests/bpf: Fix error compiling cgroup_ancestor.c with musl libc
Date: Tue,  8 Oct 2024 16:12:32 -0700
Message-Id: <20241008231232.634047-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Existing code calls connect() with a 'struct sockaddr_in6 *' argument
where a 'struct sockaddr *' argument is declared, yielding compile errors
when building for mips64el/musl-libc:

In file included from cgroup_ancestor.c:3:
cgroup_ancestor.c: In function 'send_datagram':
cgroup_ancestor.c:38:38: error: passing argument 2 of 'connect' from incompatible pointer type [-Werror=incompatible-pointer-types]
   38 |         if (!ASSERT_OK(connect(sock, &addr, sizeof(addr)), "connect")) {
      |                                      ^~~~~
      |                                      |
      |                                      struct sockaddr_in6 *
./test_progs.h:343:29: note: in definition of macro 'ASSERT_OK'
  343 |         long long ___res = (res);                                       \
      |                             ^~~
In file included from .../netinet/in.h:10,
                 from .../arpa/inet.h:9,
                 from ./test_progs.h:17:
.../sys/socket.h:386:19: note: expected 'const struct sockaddr *' but argument is of type 'struct sockaddr_in6 *'
  386 | int connect (int, const struct sockaddr *, socklen_t);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

This only compiles because of a glibc extension allowing declaration of the
argument as a "transparent union" which includes both types above.

Explicitly cast the argument to allow compiling for both musl and glibc.

Cc: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Fixes: f957c230e173 ("selftests/bpf: convert test_skb_cgroup_id_user to test_progs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
index 9250a1e9f9af..3f9ffdf71343 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
@@ -35,7 +35,7 @@ static int send_datagram(void)
 	if (!ASSERT_OK_FD(sock, "create socket"))
 		return sock;
 
-	if (!ASSERT_OK(connect(sock, &addr, sizeof(addr)), "connect")) {
+	if (!ASSERT_OK(connect(sock, (struct sockaddr *)&addr, sizeof(addr)), "connect")) {
 		close(sock);
 		return -1;
 	}
-- 
2.34.1


