Return-Path: <linux-kselftest+bounces-10045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB88C2A54
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899561F21508
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331E3FB31;
	Fri, 10 May 2024 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BA8SjD8I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627ED2EE
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368140; cv=none; b=gkXiJX/6dO8Pmsdt3H2NmgLztIgETFiUNsViGvmtoFoLsSw0kf7p3Jxo3CshwqH8Ja/2eI5E69JpqsrzoeQq9hlMlW7YyTkAZpAQbtnfEGKPrFqLETq4aleYQYnRR3/7pUqAQJB65ZPvSZQK/Jsmqd16w+JB2NpCcDxYy2AwvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368140; c=relaxed/simple;
	bh=046+K2rooJaiWehncD1DjTIcHY7f2phEuhcBFTeaDGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o9mw+HZVsGK3rZBqtdBDan1ql/FsfRlRj1P98V3BP+hAe0u2f0nFu5V5ad6wDgyqHPsyYvH+VBbxIYtjD42PmVEOg0JDShL+hvipd05ZJhy8ZkL52VmCyKePNMcNLyohus/rkQ5Sh6qhjuQCf+UyBSn+jskE94ewNsWijo91dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BA8SjD8I; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-6f07a69673fso2822694a34.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368138; x=1715972938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZP8DSrrJ7HH0ntIonPMO4nthwrGJnEqqpwjTbUOSDM=;
        b=BA8SjD8IrT8ffFuES+q99xBC1S1R2+rhp7A74e9UiUP9gzTSie252MgzcNDlQqEfRp
         EFsAImBQKTY1fZ2obKgLwy1Sks5Eq4x35APKD4qDBA9aDuu1Yv5fsTUhlzDwsG9zJsgk
         gpjPmpiAS37vMztGdxkZMiGJ+Kt0RfQozQfDzVB0G3sXasen5aNxCOaquL8koEAQaEEE
         6Rxby53Hi7g4Jd2+t6+Y8clfG/Hh0EJLkKUUsiOuUwIaJxitSz69A231w08lhKTE6qBF
         j9j8kcVyMO7AhmPgF7BaVc3tAXVTWERdhMisdrbz4LD567f3DcxR+1Pc8DyY2Mj5PX57
         d9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368138; x=1715972938;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZP8DSrrJ7HH0ntIonPMO4nthwrGJnEqqpwjTbUOSDM=;
        b=tmsl/xgeODs8a3kLWPg5DKtZoIpmxYXp7sJSfVu7iXBF5rudM+g9fXZM4uqTEQy9Ze
         xqp62bu8Sghqf7krUxRR+zbpT8uIoNMJg57lRbBhrTp85sE44fTMN62GDOeJgwqKM5rA
         iOCuX+dSQxGUDnDzkt3Aw73eXghrzz0xjOZsA4XjKM35doQM7fPs2LJrSbLDFE5ySDBy
         nzPXaZwKtsp6vU2CXVrK822Nb3YbbpVxr3TgySANLBYWjQElbzeyvDp++SbgepLYe9Xx
         l9+UWm93Hkps0TRDBsClORaFsUN72GUNKJ5b0aX98w6eFVLzBYzwlorZVsvTKqJIjOu0
         QN6w==
X-Forwarded-Encrypted: i=1; AJvYcCXOEX6Qu+rHbynLGHNQyw7ZwpTlNdyhW8nY8n33xKBkWzyEgPR5IRlomG14He2+aateuAAMX6C1zWjUJkb0J9RNDZOB0QayqJA6wbhbNV6B
X-Gm-Message-State: AOJu0YyVk/qXuWDzGWGvzKzQcYUfHD0OI9WcXhweh7+okKdifQukRXc1
	OCBJx1LLcDsR4XEbmWLqwl/dC4TIwNKi4RgcohTHThHh9Cg9V3oZ9ePDZwvBkjUNzUEn+sQFAA=
	=
X-Google-Smtp-Source: AGHT+IGGsXZTPzxHdEkJ5KE1P5Ipo87Hv5nbFQ8da3X3dwC+l4U11PMrYCVwh4lKpb4TjrVQnINN73hlnA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a92:dd01:0:b0:36c:2ed4:8d4c with SMTP id
 e9e14a558f8ab-36cc14fde56mr743125ab.4.1715367768757; Fri, 10 May 2024
 12:02:48 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:17 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-1-jrife@google.com>
Subject: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
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

This patch series migrates remaining tests from bpf/test_sock_addr.c to
prog_tests/sock_addr.c and progs/verifier_sock_addr.c in order to fully
retire the old-style test program and expands test coverage to test
previously untested scenarios related to sockaddr hooks.

This is a continuation of the work started recently during the expansion
of prog_tests/sock_addr.c.

Link: https://lore.kernel.org/bpf/20240429214529.2644801-1-jrife@google.com/T/#u

=======
Patches
=======
* Patch 1 moves tests that check valid return values for recvmsg hooks
  into progs/verifier_sock_addr.c, a new addition to the verifier test
  suite.
* Patches 2-5 lay the groundwork for test migration, enabling
  prog_tests/sock_addr.c to handle more test dimensions.
* Patches 6-11 move existing tests to prog_tests/sock_addr.c.
* Patch 12 removes some redundant test cases.
* Patches 14-17 expand on existing test coverage.

Jordan Rife (17):
  selftests/bpf: Migrate recvmsg* return code tests to
    verifier_sock_addr.c
  selftests/bpf: Use program name for skel load/destroy functions
  selftests/bpf: Handle LOAD_REJECT test cases
  selftests/bpf: Handle ATTACH_REJECT test cases
  selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
  selftests/bpf: Migrate WILDCARD_IP test
  selftests/bpf: Migrate sendmsg deny test cases
  selftests/bpf: Migrate sendmsg6 v4 mapped address tests
  selftests/bpf: Migrate wildcard destination rewrite test
  selftests/bpf: Migrate expected_attach_type tests
  selftests/bpf: Migrate ATTACH_REJECT test cases
  selftests/bpf: Remove redundant sendmsg test cases
  selftests/bpf: Retire test_sock_addr.(c|sh)
  selftests/bpf: Expand sockaddr program return value tests
  sefltests/bpf: Expand sockaddr hook deny tests
  selftests/bpf: Expand getsockname and getpeername tests
  selftests/bpf: Expand ATTACH_REJECT tests

 tools/testing/selftests/bpf/.gitignore        |    1 -
 tools/testing/selftests/bpf/Makefile          |    4 +-
 .../selftests/bpf/prog_tests/sock_addr.c      | 1821 +++++++++++++++--
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../testing/selftests/bpf/progs/bind4_prog.c  |    6 +
 .../testing/selftests/bpf/progs/bind6_prog.c  |    6 +
 .../selftests/bpf/progs/connect4_prog.c       |    6 +
 .../selftests/bpf/progs/connect6_prog.c       |    6 +
 .../selftests/bpf/progs/connect_unix_prog.c   |    6 +
 .../selftests/bpf/progs/getpeername4_prog.c   |   24 +
 .../selftests/bpf/progs/getpeername6_prog.c   |   31 +
 .../selftests/bpf/progs/getsockname4_prog.c   |   24 +
 .../selftests/bpf/progs/getsockname6_prog.c   |   31 +
 .../selftests/bpf/progs/sendmsg4_prog.c       |    6 +
 .../selftests/bpf/progs/sendmsg6_prog.c       |   57 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |    6 +
 .../selftests/bpf/progs/verifier_sock_addr.c  |  331 +++
 tools/testing/selftests/bpf/test_sock_addr.c  | 1140 -----------
 tools/testing/selftests/bpf/test_sock_addr.sh |   58 -
 19 files changed, 2142 insertions(+), 1424 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.c
 delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh

-- 
2.45.0.118.g7fe29c98d7-goog


