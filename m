Return-Path: <linux-kselftest+bounces-20079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D89A3102
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D13E1F231D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A21D6DBE;
	Thu, 17 Oct 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ug8twrOo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0C1D7E54
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205455; cv=none; b=p2mI517W7NC0H/w0UApe8RKzVRBd/71G1zUTbjJjDw6guM76FmSu4S4ZtbVqf5RpGgcqmueV2twIFbClXHy+hW3yIMjbEteL8BhKVVDPkQ8Lg6pRM9LfwEM/16sJQ4cDq5zd+D6wA9gBfOiHDBkc3M9orz9mttMmVohzShV8nLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205455; c=relaxed/simple;
	bh=OAfb9anE8210FYwBEiWKF9dWOFe/8c3Rp5+zThDaAEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKd+0PomSKUMB7lZPAuZBdnZ7xMuQrEs2fG3deIpGn183jn7HzyiVgpnq0fpryEAm4LbJ7y655hQ2jjlu07AYzDnh4CRX2V33elmsIEyc/JmBfH//U86Y1RmLB9BAAW0aPNQ3AqMZn9b+OayTNnq+xayg26vdAc+4+R+zUFD58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ug8twrOo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so1686471a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205453; x=1729810253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpV9vj1wEc7ES1irbyMGy3x7XyZP4rCXDLt1nZkWgOw=;
        b=Ug8twrOo8hUUeFQrBpiNnO/myUTKr+e3Ge7f3CatAuGCUKbpk3WxyAdYXktKL3UXeb
         mJ29n7a0/uE6umptdyXOPE1Ub2WKhDArAdqb0xTLIAhmtU16qlarAUbmJ/EMCJGavg7W
         PSaiDwDjmsmwElz74/IJHbbCDjqoKnVOXWY4Rbveqdfm5GtPSqJ3n32boMxUjf0EoP1/
         u0dmOrOD8BwQ89SrK3gO2Z5JbJ4Le+RtSDyBRy3LIs1XvCv8Q93WpS2Zxez05fA4WDtw
         NuCgbYjFIunalD72GAHi7u27m8FZOoIVB0E6w01cIUI2J1+FwI7X9yAGbCAoWIOKokjE
         utww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205453; x=1729810253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpV9vj1wEc7ES1irbyMGy3x7XyZP4rCXDLt1nZkWgOw=;
        b=SXW9oPkX9ZSgs7qeijC48AM8Bt/7R2sCD3dyxXb15IhREQ+9FmQrV1IR4OCEKGZF5e
         6HVvbtyWWUJHmvRsnwPWdLwhkfQpMzImxzIvTSZT5Ii0kpXIrQ4BJNHSf4mYPHKiiLrp
         k0Gh9SCm7hdGi3S8LTG78SfkOhWYbSe+sWlgfDqbW0vVXLgrgOu/NIQhgg6PFDnuUcsU
         QU2MfUnOW/VXR6MJLut+e2Jcq1EG9k+kay9ExVNGkb5F5pUDabmSheMPp7hCS6xPXHgn
         ygH7T5hb2AlwniJ40RLlsfEQr5FThnmBVtoopvUczkDM9ZdcUiq7CuMx1YM7RIE6wY1r
         D3nA==
X-Forwarded-Encrypted: i=1; AJvYcCXsMi2gJJQN2ck8p/OxmVM7N44Oz/GjFPSAv90eFqFHvbspW0bsTYa1B+EV4RaCbjP4DIK5yKb/iQdpAe0Rxes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINLPKBg0H1vuzoF4AqgOOhCNqNudrvRjFVASkBURm4rayXlhy
	g3I9LQ4bpGFeoKvB3710lqsrfZH8XFKCtx1tdoWCtM9fhp2fI9kYdg+FUgnKdmtfTkUyfBNndQ=
	=
X-Google-Smtp-Source: AGHT+IE7XDoWkOp0WIbTWUuiS5u5byNPF8by+mu47+ha2YVZCO/96GGrlgTXq8SY3tz9F74VDfHYmJYvnw==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:230b:0:b0:7ea:694b:db02 with SMTP id
 41be03b00d2f7-7eacc6f0a4emr231a12.4.1729205452871; Thu, 17 Oct 2024 15:50:52
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:21 +0000
In-Reply-To: <20241017225031.2448426-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-4-jrife@google.com>
Subject: [PATCH bpf-next v1 3/4] selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE
 test cases to prog_tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the "load w/o expected_attach_type" test case to
prog_tests/sock_create.c and drop the remaining test case, as it is made
redundant with the existing coverage inside prog_tests/sock_create.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_create.c    | 35 +++++++++++++------
 tools/testing/selftests/bpf/test_sock.c       | 28 ---------------
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_create.c b/tools/testing/selftests/bpf/prog_tests/sock_create.c
index 17a3713621dd..187ffc5e60c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_create.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_create.c
@@ -237,6 +237,19 @@ static struct sock_create_test {
 
 		.error = DENY_CREATE,
 	},
+	{
+		.descr = "load w/o expected_attach_type (compat mode)",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = 0,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+	},
 };
 
 static int load_prog(const struct bpf_insn *insns,
@@ -291,16 +304,18 @@ static int run_test(int cgroup_fd, struct sock_create_test *test)
 		goto detach_prog;
 	}
 
-	err = getsockopt(sock_fd, SOL_SOCKET, test->optname, &optval, &optlen);
-	if (err) {
-		log_err("Failed to call getsockopt");
-		goto cleanup;
-	}
-
-	if (optval != test->optval) {
-		errno = 0;
-		log_err("getsockopt returned unexpected optval");
-		goto cleanup;
+	if (test->optname) {
+		err = getsockopt(sock_fd, SOL_SOCKET, test->optname, &optval, &optlen);
+		if (err) {
+			log_err("Failed to call getsockopt");
+			goto cleanup;
+		}
+
+		if (optval != test->optval) {
+			errno = 0;
+			log_err("getsockopt returned unexpected optval");
+			goto cleanup;
+		}
 	}
 
 	ret = test->error != OK;
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 26dff88abbaa..f97850f1d84a 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -47,34 +47,6 @@ struct sock_test {
 };
 
 static struct sock_test tests[] = {
-	{
-		.descr = "sock_create load w/o expected_attach_type (compat mode)",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = 0,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 8097,
-		.result = SUCCESS,
-	},
-	{
-		.descr = "sock_create load w/ expected_attach_type",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 8097,
-		.result = SUCCESS,
-	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.47.0.rc1.288.g06298d1525-goog


