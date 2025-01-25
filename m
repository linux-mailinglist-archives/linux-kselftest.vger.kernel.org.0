Return-Path: <linux-kselftest+bounces-25164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053AA1C233
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AE21888968
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E16207A3A;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="useGx/Wg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F42EB10;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=r2AzcQa5wO/uqDGCiYto9U3cJ3M99HIebxv4RvJdSigUdxgAbf8sHYpBT7FpdCh7OdtVcZyAagOHMDmHosxHceoyg/Z6JmoGhFgS+yhjHP3fSGaH5O37iZWUrgGL6EWJBLWcwNdkGdyDqZx6OAsLiQmB0FPrHyk9IvLyLTEBWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=P5XuJJND0nKhLbsM46EPq1luRqpUiyBNf0HrYROsyE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=keRhTSosjAiwE4d+n2wMpiFJpde8AsLKh5DrYqNBCNGxg0SuVnB1Hcm1SvdK1CAJz3ES3TgCCN5653q0rfLlY6zr3dWz4dPH8PUM/nwv71+w7eED2uVTwbkLgbpaHVrL7lhYOSB00ZUVeiWfKMAalGWLwVh7Jnm/tNa7D2ep5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=useGx/Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C890BC4CED6;
	Sat, 25 Jan 2025 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793827;
	bh=P5XuJJND0nKhLbsM46EPq1luRqpUiyBNf0HrYROsyE0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=useGx/WgDLm9SjiJn/oBJl95SvVEwfQjYspjb6ZwCbaVe7vOr+nWfHx2ev6c0vv0T
	 hEjB0W42O4AT9uS/d5EQbEC84zdMEeLhmVTz+fJJ9S+YfPRftVENQqTqfWuzHLceyN
	 LGVVpuDGvnuAUr4wh1uAKQmXaN5mc6BrJj2g6QxPbdAps8DNgVScOCVyGC1G6KMIdF
	 73I2+VA7ZsQBwApqy4Np6CNy4NN9iGWDOk9M24jsKxOHCr+2oDC2K2uOuCuJpW0nbq
	 TQMlcCFjDpSSPCWezTcj7uEFuD7kBPU1pXRc/ouCYU0Z4sZt6UoeeYK8LQ92rRkyXJ
	 di00bEhhQYfhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFBAC0218C;
	Sat, 25 Jan 2025 08:30:27 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Subject: [PATCH bpf-next v2 0/7] bpf: Add probe_read_{kernel,user}_dynptr
 and copy_from_user_dynptr
Date: Sat, 25 Jan 2025 16:29:47 +0800
Message-Id: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPuglGcC/2WNQQ7CIBREr9L8tZh+CkZdeQ/TNIWCJSqfADZtm
 t5d0rhzOXkzb1ZIJjqT4FqtEM3kkiNfAj9UoMfePwxzQ8nAay5r5IKpYLth8SHHLkRShvVKnBs
 tpbDYQ5mFaKybd+UdSpt5M2doCxldyhSX/WvCnf+08l87IauZbrRCjvZ0kXijT34RPY+a3tBu2
 /YF9/MfKbwAAAA=
X-Change-ID: 20250124-bpf_dynptr_probe-ab483c554f1a
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=P5XuJJND0nKhLbsM46EPq1luRqpUiyBNf0HrYROsyE0=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEV+2sHhhlq/K1lAjunTXgA/d6rjPlDg3JGN
 cK3kw69poiJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShFQAKCRBvO5jUL8bJ
 2HMwEADXmP+76DbBZ1IBtrqom4sXAe3aKiLOE3MIMuPQWiQqfaBzvDlhcm+cP3A05rzQ0sxvd+S
 MweuoGiHO51Xsegd0Mck/++847sj46LXAJXboCymenzgCqIYA/GCGLLpBe1OBFNJQCEnwVDcKjL
 t9/sPk6m724f1fNkZepcBuqLQBoJ6+/no7GPo2+lGN4lsU9PYnX7PAmSU0N14iJORNCvjotTK1R
 P7oSHqYpNDiq2iEx7u403QwHsUkO3lyXJA8feoOSFROi9xgCu7wR7OysANs9xZ1tvYY0789vteG
 6XmxZay2c2iRUhxa2qt6PCxaVgZZxIAOCVgLxJr0nYXOKVAZ7V6k1/bUTZ73ZyAoH1ONu582X9O
 DNVgjqLBwZvgOTapoM+ifeWqzB5s2GBYfIRIZQZiz34RayCUP6SCTh5zfzx48X33MIZ7ZtA9Kcy
 1hkKXNwTgyt9NgJFUQ6++BJ38/3RnREvZACz5TgoZ94+u8KQSuubmfK8CIkIoCabslRiDoc86ts
 O8WR3uE7ov+nBf1JXr7xnfjdl6hDnGXiGCBB0YhbAHvd9cvHb1GpaBWu2o/2kA4GgAUlBXwvCla
 htZkOf35wa8+pHPDK9Ybrx9tcmLjbZ7aFzIWdKRlpRv4+8nf/i8IijlBK9FUkBmgkQWgbQ+ycVj
 n3iArCud3OgaGdQ==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

This series introduce the dynptr counterpart of the
bpf_probe_read_{kernel,user} helpers and bpf_copy_from_user helper.

These helpers are helpful for reading variable-length data from kernel
memory into dynptr without going through an intermediate buffer.

Link: https://lore.kernel.org/bpf/MEYP282MB2312CFCE5F7712FDE313215AC64D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
Changes in v2:
- Add missing bpf-next prefix. I forgot it in the initial series. Sorry
  about that.
- Link to v1: https://lore.kernel.org/r/20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com

---
Levi Zim (7):
      bpf: Implement bpf_probe_read_kernel_dynptr helper
      bpf: Implement bpf_probe_read_user_dynptr helper
      bpf: Implement bpf_copy_from_user_dynptr helper
      tools headers UAPI: Update tools's copy of bpf.h header
      selftests/bpf: probe_read_kernel_dynptr test
      selftests/bpf: probe_read_user_dynptr test
      selftests/bpf: copy_from_user_dynptr test

 include/linux/bpf.h                                |   3 +
 include/uapi/linux/bpf.h                           |  49 ++++++++++
 kernel/bpf/helpers.c                               |  53 ++++++++++-
 kernel/trace/bpf_trace.c                           |  72 ++++++++++++++
 tools/include/uapi/linux/bpf.h                     |  49 ++++++++++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |  45 ++++++++-
 tools/testing/selftests/bpf/progs/dynptr_success.c | 106 +++++++++++++++++++++
 7 files changed, 374 insertions(+), 3 deletions(-)
---
base-commit: d0d106a2bd21499901299160744e5fe9f4c83ddb
change-id: 20250124-bpf_dynptr_probe-ab483c554f1a

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



