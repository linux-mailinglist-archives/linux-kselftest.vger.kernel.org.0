Return-Path: <linux-kselftest+bounces-10043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DABE8C2A4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9487AB25EC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30E48CE0;
	Fri, 10 May 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3FTIWyO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904445023
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367797; cv=none; b=TylHoofXvEEwqNCDwqcBtx5eQr2ya85/JMMeN24SQNq4NVUmZbkHQOSw22Z2XnjONqPbuqf2Smv1Lc9R63tlJBxxxrwBeEzN8V1pfnHN3Ep497Vj9yDN3RT2ilCQyyIwPZ8jHPexTc6kFzcDQgLMH9aow+jR1PF56+rIl1oXRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367797; c=relaxed/simple;
	bh=T0zjrJP+NJhtEGA7To/nE1u/4nq/7/uZUvODiMREuBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eF9Uelf5CGEGEyjMktdrzETvNwBmiPBxgnTAgf0rXDw8MKMf8B9lE8dMN91Kax9tMDKIfEDgBfz7c25nht23xeiab04hmyhLJ4+nNdyjM6Nq+3oSmAoSG51jIrGznumnhKf7R1oXp98G8+yeI2bOok9NZrEJcACdly7t15YOrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3FTIWyO; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-36c96503424so25408655ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367795; x=1715972595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LG6b+p0f7R0KZLw/Ip8/hPBsUvl5qeWsV9/q9Vz57w=;
        b=W3FTIWyOJuvS1qB8QlH5+gtPX/upTdQUhX38P2t33FX0+HKyMPd3Kkgc8BZCApY37i
         r/N6X3v4ZKP4YG8NUaRhwNQ8J9vPAL1BuMBzyE0ooxMsOFqJguNSrelCMHbyK4uPDLgZ
         ZlF1txSBi1qb0/pC2BdmdTbsouCt3MJdzVvjBRLtu08iK7BXJRe6hTgHBOhYBQR+Spyj
         Z7uj2Kc94QRnXllthxH6pPhg+XH+eGKQQPYHRps0CYN4XlbcN6RyAVAvVFEulUCP0Alx
         QTEp/EfEV1SNfrCTu98QFEOE40k6ZyFJPsQCS8TYO7ztyMhWsTXRPC9hxZf0L4hrDvo8
         SU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367795; x=1715972595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LG6b+p0f7R0KZLw/Ip8/hPBsUvl5qeWsV9/q9Vz57w=;
        b=ceBhzgKYsGqphOGVuLk3n4Vktg3uDtGHIvF/otsOfXHL6tqzDkGe9DukZ/42E6nMaJ
         t4ZhcelKVi3LkzWtanQi9E69NVWEpE/xoiRmm2AlJb54YK8CmAI7SE1xSewi4WWNvQ/t
         vYVLN4i8+SaQv0LFNGUCKnY0eKEDtIqJV5FbQ7JOLZoORzfGblECH3gkMYorJE7yfboC
         1e9HBjWp0wovflvjFGPRdupERNK1hIl6OeO6rGdXzhPTFhz1JkOyy1TuTXJ/sFSAPWvV
         yiIr142FrtL2HURrNcE8IthvAoO2EIAR2WeVi34VJHvyS+ZZ0ct2Ml90Tr+2092MO3UA
         5KPw==
X-Forwarded-Encrypted: i=1; AJvYcCU2b7oxQzB3wPx8mZpT033i6nxvDSDdu6VTForde2bL5JB/14XcGMUTopVm8v5h8bR2s+otK98zF4cPIBfA+UNLOuOHEgkthC+RSLF7Dvlc
X-Gm-Message-State: AOJu0YyHU1qDYEoyuYBLob4HjHGamDoInbHIrXYH3MdTLIOqq2MgSn+I
	RDvLmIsld8F6yonUeW8UPBylcf3PUP5ofjJmqZtLJOJ7+WFzJW6LO4lLaTuXhRzVld00o5iBpQ=
	=
X-Google-Smtp-Source: AGHT+IHVC4ksDd3n7KP2LAYtsFvQfCVmcXKbRCGGlpyadJiSUQMW0cVNS8pn76DZJX3NrUtP3u1dSUpg7Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a92:2902:0:b0:36c:11a0:7878 with SMTP id
 e9e14a558f8ab-36cc145874amr704145ab.2.1715367795052; Fri, 10 May 2024
 12:03:15 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:33 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-17-jrife@google.com>
Subject: [PATCH v1 bpf-next 16/17] selftests/bpf: Expand getsockname and
 getpeername tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This expands coverage for getsockname and getpeername hooks to include
getsockname4, getsockname6, getpeername4, and getpeername6.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 304 +++++++++++++++++-
 .../selftests/bpf/progs/getpeername4_prog.c   |  24 ++
 .../selftests/bpf/progs/getpeername6_prog.c   |  31 ++
 .../selftests/bpf/progs/getsockname4_prog.c   |  24 ++
 .../selftests/bpf/progs/getsockname6_prog.c   |  31 ++
 5 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 0477b4080b2e8..a0a40bdcfe45c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -15,7 +15,11 @@
 #include "recvmsg6_prog.skel.h"
 #include "sendmsg_unix_prog.skel.h"
 #include "recvmsg_unix_prog.skel.h"
+#include "getsockname4_prog.skel.h"
+#include "getsockname6_prog.skel.h"
 #include "getsockname_unix_prog.skel.h"
+#include "getpeername4_prog.skel.h"
+#include "getpeername6_prog.skel.h"
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
@@ -466,7 +470,11 @@ BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
 BPF_SKEL_FUNCS(recvmsg_unix_prog, recvmsg_unix_prog);
 BPF_SKEL_FUNCS(getsockname_unix_prog, getsockname_unix_prog);
+BPF_SKEL_FUNCS(getsockname4_prog, getsockname_v4_prog);
+BPF_SKEL_FUNCS(getsockname6_prog, getsockname_v6_prog);
 BPF_SKEL_FUNCS(getpeername_unix_prog, getpeername_unix_prog);
+BPF_SKEL_FUNCS(getpeername4_prog, getpeername_v4_prog);
+BPF_SKEL_FUNCS(getpeername6_prog, getpeername_v6_prog);
 
 static struct sock_addr_test tests[] = {
 	/* bind - system calls */
@@ -1688,7 +1696,71 @@ static struct sock_addr_test tests[] = {
 	/* getsockname - system calls */
 	{
 		SOCK_ADDR_TEST_GETSOCKNAME,
-		"getsockname_unix",
+		"getsockname4: getsockname (stream)",
+		getsockname_v4_prog_load,
+		getsockname_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname4: getsockname (dgram)",
+		getsockname_v4_prog_load,
+		getsockname_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname6: getsockname (stream)",
+		getsockname_v6_prog_load,
+		getsockname_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname6: getsockname (dgram)",
+		getsockname_v6_prog_load,
+		getsockname_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname_unix: getsockname",
 		getsockname_unix_prog_load,
 		getsockname_unix_prog_destroy,
 		BPF_CGROUP_UNIX_GETSOCKNAME,
@@ -1703,10 +1775,156 @@ static struct sock_addr_test tests[] = {
 		SUCCESS,
 	},
 
+	/* getsockname - kernel calls */
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname4: kernel_getsockname (stream)",
+		getsockname_v4_prog_load,
+		getsockname_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname4: kernel_getsockname (dgram)",
+		getsockname_v4_prog_load,
+		getsockname_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname6: kernel_getsockname (stream)",
+		getsockname_v6_prog_load,
+		getsockname_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname6: kernel_getsockname (dgram)",
+		getsockname_v6_prog_load,
+		getsockname_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname_unix: kernel_getsockname",
+		getsockname_unix_prog_load,
+		getsockname_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETSOCKNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
+
 	/* getpeername - system calls */
 	{
 		SOCK_ADDR_TEST_GETPEERNAME,
-		"getpeername_unix",
+		"getpeername4: getpeername (stream)",
+		getpeername_v4_prog_load,
+		getpeername_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETPEERNAME,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername4: getpeername (dgram)",
+		getpeername_v4_prog_load,
+		getpeername_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETPEERNAME,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername6: getpeername (stream)",
+		getpeername_v6_prog_load,
+		getpeername_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETPEERNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername6: getpeername (dgram)",
+		getpeername_v6_prog_load,
+		getpeername_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETPEERNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername_unix: getpeername",
 		getpeername_unix_prog_load,
 		getpeername_unix_prog_destroy,
 		BPF_CGROUP_UNIX_GETPEERNAME,
@@ -1720,6 +1938,88 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+
+	/* getpeername - kernel calls */
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername4: kernel_getpeername (stream)",
+		getpeername_v4_prog_load,
+		getpeername_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETPEERNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername4: kernel_getpeername (dgram)",
+		getpeername_v4_prog_load,
+		getpeername_v4_prog_destroy,
+		BPF_CGROUP_INET4_GETPEERNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername6: kernel_getpeername (stream)",
+		getpeername_v6_prog_load,
+		getpeername_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETPEERNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername6: kernel_getpeername (dgram)",
+		getpeername_v6_prog_load,
+		getpeername_v6_prog_destroy,
+		BPF_CGROUP_INET6_GETPEERNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		SUCCESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername_unix: kernel_getpeername",
+		getpeername_unix_prog_load,
+		getpeername_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETPEERNAME,
+		&kern_ops_kernel_sendmsg,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
 };
 
 typedef int (*info_fn)(int, struct sockaddr *, socklen_t *);
diff --git a/tools/testing/selftests/bpf/progs/getpeername4_prog.c b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
new file mode 100644
index 0000000000000..4c97208cd25dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#define REWRITE_ADDRESS_IP4   0xc0a801fe // 192.168.1.254
+#define REWRITE_ADDRESS_PORT4 4040
+
+SEC("cgroup/getpeername4")
+int getpeername_v4_prog(struct bpf_sock_addr *ctx)
+{
+	ctx->user_ip4 = bpf_htonl(REWRITE_ADDRESS_IP4);
+	ctx->user_port = bpf_htons(REWRITE_ADDRESS_PORT4);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/getpeername6_prog.c b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
new file mode 100644
index 0000000000000..070e4d7f636c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#define REWRITE_ADDRESS_IP6_0 0xfaceb00c
+#define REWRITE_ADDRESS_IP6_1 0x12345678
+#define REWRITE_ADDRESS_IP6_2 0x00000000
+#define REWRITE_ADDRESS_IP6_3 0x0000abcd
+
+#define REWRITE_ADDRESS_PORT6 6060
+
+SEC("cgroup/getpeername6")
+int getpeername_v6_prog(struct bpf_sock_addr *ctx)
+{
+	ctx->user_ip6[0] = bpf_htonl(REWRITE_ADDRESS_IP6_0);
+	ctx->user_ip6[1] = bpf_htonl(REWRITE_ADDRESS_IP6_1);
+	ctx->user_ip6[2] = bpf_htonl(REWRITE_ADDRESS_IP6_2);
+	ctx->user_ip6[3] = bpf_htonl(REWRITE_ADDRESS_IP6_3);
+	ctx->user_port = bpf_htons(REWRITE_ADDRESS_PORT6);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/getsockname4_prog.c b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
new file mode 100644
index 0000000000000..e298487c63474
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#define REWRITE_ADDRESS_IP4   0xc0a801fe // 192.168.1.254
+#define REWRITE_ADDRESS_PORT4 4040
+
+SEC("cgroup/getsockname4")
+int getsockname_v4_prog(struct bpf_sock_addr *ctx)
+{
+	ctx->user_ip4 = bpf_htonl(REWRITE_ADDRESS_IP4);
+	ctx->user_port = bpf_htons(REWRITE_ADDRESS_PORT4);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/getsockname6_prog.c b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
new file mode 100644
index 0000000000000..811d10cd55258
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#define REWRITE_ADDRESS_IP6_0 0xfaceb00c
+#define REWRITE_ADDRESS_IP6_1 0x12345678
+#define REWRITE_ADDRESS_IP6_2 0x00000000
+#define REWRITE_ADDRESS_IP6_3 0x0000abcd
+
+#define REWRITE_ADDRESS_PORT6 6060
+
+SEC("cgroup/getsockname6")
+int getsockname_v6_prog(struct bpf_sock_addr *ctx)
+{
+	ctx->user_ip6[0] = bpf_htonl(REWRITE_ADDRESS_IP6_0);
+	ctx->user_ip6[1] = bpf_htonl(REWRITE_ADDRESS_IP6_1);
+	ctx->user_ip6[2] = bpf_htonl(REWRITE_ADDRESS_IP6_2);
+	ctx->user_ip6[3] = bpf_htonl(REWRITE_ADDRESS_IP6_3);
+	ctx->user_port = bpf_htons(REWRITE_ADDRESS_PORT6);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.0.118.g7fe29c98d7-goog


