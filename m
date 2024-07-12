Return-Path: <linux-kselftest+bounces-13674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD37092FC6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D030281F4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FF171E49;
	Fri, 12 Jul 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfV49uhF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C45171678;
	Fri, 12 Jul 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794269; cv=none; b=LmeYldvKTCS4Mb98h//1ZaWQGP0r/Y5806ZrFqzTz7NAHDyM9ps+99fJ0979Nt9u1LPrXtP1KAQhF/mNcpt7TVWQ6S7ysSq1EWuNPjdMWX1trGAHzRERt9WjFCLfo8CRrfQSXfVVuaovlxliZalpVmIeA8LV1y6UxWTa6OvYgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794269; c=relaxed/simple;
	bh=4Zn7qwGp8k++4FBRO3AlA95RUwiXFiogeEVSMaSAxDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3yp6P/gBmtGrmwBwveIXWc7C5Np8BZ60zOCikpH5eABuvuJet8fgcZgWfx21mfzSSwewLw64cm/IfrgKzf0t26+aHXnZXQsSWxg+qtRmaPXUXMM6c/OlZuLmyQm6R9X/M3EGrS9ZoldrVOYEr1pDQ0sZkqByrDwfYZj3oAIueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfV49uhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE03CC32782;
	Fri, 12 Jul 2024 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794269;
	bh=4Zn7qwGp8k++4FBRO3AlA95RUwiXFiogeEVSMaSAxDc=;
	h=From:To:Cc:Subject:Date:From;
	b=YfV49uhFfT1psA3qgf8cvhlWtB5IwwDfx8h1eBRWkRP9+VQeHvJ1s3UTrRXeDoB6o
	 2Iv0dlqBKrBJ5BBTtR3GDYjOv8lq63gEOfvDeV55Ycw4xADsEn9wY3H4FyKAzM4zIR
	 kik32ogQYnNbh7gB5x14dovEsU0dL2dyeCjjbtob96eJJfSC2vvcdRpgbGhnnIECg+
	 z2FGIZ8DMpUC5Qj2WdiaG4oXLZ8lm/ctVKqNFaJN0mmvtrgdmJGL8bNAJPRNsp6u0O
	 s1HPmdhfj2r8JVgqtP6xDyRGQj6P45oNa3IQMwmdeqyJt5FIO3RvtpVN8EClmA/BDZ
	 PVQ9CDuOJJX3w==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] handle errno ENOTSUPP
Date: Fri, 12 Jul 2024 22:24:15 +0800
Message-ID: <cover.1720791488.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - patch 1, only commit log updated
 - update patch 2
   - add an unsigned variable
   - use "switch-case"
   - only "Operation not supported", no (-524) in string
 - patch 3, a now one

This patchset contains three fixes for handling errno ENOTSUPP.

Patch 1 fixes the return value of fixup_call_args() to make sure
ENOTSUPP is returned to user space correctly.
Patch 2 handles ENOTSUPP in libbpf_strerror_r() in libbpf.
Patch 3 includes str_error.h in BPF selftests, and drop duplicate
ENOTSUPP definitions.

Geliang Tang (3):
  bpf: verifier: Fix return value of fixup_call_args
  libbpf: handle ENOTSUPP in libbpf_strerror_r
  selftests/bpf: Drop duplicate ENOTSUPP definitions

 kernel/bpf/verifier.c                          |  6 +++---
 tools/lib/bpf/str_error.c                      | 18 +++++++++++++-----
 tools/lib/bpf/str_error.h                      |  4 ++++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c      |  4 ----
 .../selftests/bpf/prog_tests/lsm_cgroup.c      |  4 ----
 .../selftests/bpf/prog_tests/sock_addr.c       |  4 ----
 tools/testing/selftests/bpf/test_maps.c        |  4 ----
 tools/testing/selftests/bpf/test_verifier.c    |  4 ----
 tools/testing/selftests/bpf/testing_helpers.h  |  1 +
 9 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.43.0


