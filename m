Return-Path: <linux-kselftest+bounces-20402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9259AB20A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05121C21835
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45E1A3031;
	Tue, 22 Oct 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPBO+XiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48888139CE2
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610957; cv=none; b=oCok3t+I5wj40SV0ZWklAFDVuQcsEDrG830cL9SelyNMC0v2FyBqEMAgqFtKtIP1d1N89fmXukoYTj7bZjZeykmdoXy9udtBBlRHVU2LPoAMZorWabYFWfgWIv0C6nCxmnfeOicDvzbxZusFifMXEx5nTjnazI865ej7X8n7nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610957; c=relaxed/simple;
	bh=AVHQdyjmODZpdCOtuBHcLgFbP4dCsqQ3defZwhN46S8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QyXtYmBqeUbB7w228wmLUUPYVKJcUmAfBCthiUDIX/thgBKRReCxGnSWbmbm0mdjNOo5wbJMfwd5nqkbcN5lWKPO6TS/7o+XyFdkgBgN3PFkwTG28Pf2fnuVrcLAZ10NneelCe00I5378FxaVec/TNl52tEr9T/Z+uxCUNoDd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pPBO+XiN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2ca403f5dso5422315a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610955; x=1730215755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzVIdkphVy6VCB+khzDa62+1PBT7rr/AZQaCe6/5n3s=;
        b=pPBO+XiNqRh+ic46FC598D7Yo3K2psIeC+4m75QPo00xQ2ABnMRfRK20mDbRCP6C5g
         YFIuAOlZlQbQmdTXxzcuqI2m+xXFWryW6p/FAJiOrhAjdXCq9YHaK6+FeZVkUJ5geO5o
         3fp5Mot8M/6ALpLN98p7g+QgMPym5mBc/ZpP2ijk/q/FQYLSRvp8EcfSz16QE6DzbirK
         RF/cloCqnBxhTzKnOLCfbc6PDLA4S6MBpE6aOg+r8CMPGGr5BZAIFFBySE6y1dVCHO7q
         4zQx8nPh+0k/bfKAhduyFUIOAvSNGuPqfL3WvARRMt96WRu5HqoI1KfP9LThQZucVFR5
         rX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610955; x=1730215755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzVIdkphVy6VCB+khzDa62+1PBT7rr/AZQaCe6/5n3s=;
        b=UxyVatxC061O1F1PTpVaWLQTMIGm5WBf8a6wJo+3TWd5N2UthwM9WMx1Tbm26uN63U
         bZlun+30FIXDxj8BR4k6Y1yVZSVO1E9IqY2qagsBtEi27OYcswMvLCbu1t8t6NCZnnsJ
         IY9bxUcjnXMqx8FoB6WXrS4lc7wOKHs6ExyQD2nrzHwTxFj77i7MlsdBPiuFie9qpIwj
         TlWe3lcSBpT2d4LYAS9F7hyaE2fv9oLstP9D2SljTD1TEvOatdmeWaOnOAi4XGlIsTsj
         z6vJPFZyYIf5domv3fmaIl99Kfji9h0PizR9Ea9K8ETnaIELNdOlc/SBXxV5r15YXkUc
         jSUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Evoxa7RftfwMPJaYkG2KpRq0wJXeMVNjMc9GZJ0ZLKF4LPyQUkwwLFtQR89+Yg3VQ6Lb/mfX4IUAHs+rzLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByLEcyLs+58M/8GVjgrHg3TXfG156c39ShI0XajdIx7TN8nUk
	CxpVbFquQlFFt4IiVzXo75yW7FGSIPcPvGXf02/ZSmKl4DDMK/mW43AgZxfMtX87tmSs2+gocw=
	=
X-Google-Smtp-Source: AGHT+IGwcz/pUSBYuldFca3TxUcJHChZIavks6kQTWuGxmKjTJGzCxMUOarWkF1lSgYb4PLig7p/EQIuqg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:fb46:b0:2e2:af52:a7b4 with SMTP id
 98e67ed59e1d1-2e561a55cf1mr28674a91.8.1729610955483; Tue, 22 Oct 2024
 08:29:15 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-1-jrife@google.com>
Subject: [PATCH bpf-next v2 0/4] Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series migrates test cases out of test_sock.c to
prog_tests-style tests. It moves all BPF_CGROUP_INET4_POST_BIND and
BPF_CGROUP_INET6_POST_BIND test cases into a new prog_test,
sock_post_bind.c, while reimplementing all LOAD_REJECT test cases as
verifier tests in progs/verifier_sock.c. Finally, it moves remaining
BPF_CGROUP_INET_SOCK_CREATE test coverage into prog_tests/sock_create.c
before retiring test_sock.c completely.

Changes
=======
v1->v2:
- Remove superfluous verbose bool from the top of sock_post_bind.c.
- Use ASSERT_OK_FD instead of ASSERT_GE to test cgroup_fd validity.
- Run sock_post_bind tests in their own namespace, "sock_post_bind".

Jordan Rife (4):
  selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
  selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
  selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to
    prog_tests
  selftests/bpf: Retire test_sock.c

 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/sock_create.c    |  35 ++-
 .../sock_post_bind.c}                         | 256 +++++-------------
 .../selftests/bpf/progs/verifier_sock.c       |  60 ++++
 5 files changed, 150 insertions(+), 205 deletions(-)
 rename tools/testing/selftests/bpf/{test_sock.c => prog_tests/sock_post_bind.c} (64%)

-- 
2.47.0.105.g07ac214952-goog


