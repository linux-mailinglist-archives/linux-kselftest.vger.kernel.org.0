Return-Path: <linux-kselftest+bounces-48612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB944D0AFF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B1C312BE3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3AB328B6C;
	Fri,  9 Jan 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2KYLebv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9E2EAB6E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973032; cv=none; b=o3MoYhE2IgRXF6cQVutYA2CL2GqxQYGs8PyIxxfHPxKD98rOM2sonQRirIg4q4BAsPBvwYdKZASVyyMm7iwlOfELoSn0so+9iqqYaZ/PU7K85Z9cD4mLrfN0Nl6zvlE7t/n0CdAAGCuKHnlGy0YbRR+D45msRaBK8P6dJPVDUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973032; c=relaxed/simple;
	bh=UiHnQOX8n8z/sEk6RLsE9km58+/qOu0e4tMQxCdsk0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lck3WGZVsPDpsHT5JTxObBDc1Bxu9LfMRi4iuXiQSc2ZF/6U7/PC0dQxflC0uMnh//xr3fyxnqR+0HjbNGDYI4yX7lbIdmG97h7nhfT3HrSVXJWPe5HrGPWG0iIRNJYadkBv4DZfzjW97yYu2nqSZ037vqlD7myi4ETLLkpegUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2KYLebv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767973017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btTxvIehuKA9Wli51TouY54utCzePLidNshQnisty/w=;
	b=d2KYLebv5utowYBuU4UqGGjExr3k+VQQAPDSDqlkAB7UCGlwTIrKVpqy7qFQjN4h26lif3
	fXSC8aR0TAx0SKsSHha3wwPKEkuvvhG2M6M5DYjYowe1rkvm6MAcHqmV00KzHjkOg/qPqh
	/iDBW7Semt8/oACj8RYRGJtfiB+8HHs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for bpf_get_branch_snapshot helper
Date: Fri,  9 Jan 2026 23:34:17 +0800
Message-ID: <20260109153420.32181-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the PMU LBR is running in branch-sensitive mode,
'perf_snapshot_branch_stack()' may capture branch entries from the
trampoline entry up to the call site inside a BPF program. These branch
entries are not useful for analyzing the control flow of the tracee.

To eliminate such noise for tracing programs, the branch snapshot should
be taken as early as possible:

* Call 'perf_snapshot_branch_stack()' at the very beginning of the
  trampoline for fentry programs.
* Call 'perf_snapshot_branch_stack()' immediately after invoking the
  tracee for fexit programs.

With this change, LBR snapshots remain meaningful even when multiple BPF
programs execute before the one requesting LBR data.

In addition, more relevant branch entries can be captured on AMD CPUs,
which provide a 16-entry-deep LBR stack.

Testing

The series was tested in a VM configured with LBR enabled:

vmtest --kvm-cpu-args 'host,pmu=on,lbr-fmt=0x5' -k $(make -s image_name) -

Branch records were verified using bpfsnoop [1]:

/path/to/bpfsnoop -k '(l)icmp_rcv' -E 1 -v \
  --kernel-vmlinux /path/to/kernel/vmlinux

For comparison, the following command was used without
BPF_BRANCH_SNAPSHOT_F_COPY:

/path/to/bpfsnoop -k '(l)icmp_rcv' -E 1 -v \
  --force-get-branch-snapshot --kernel-vmlinux /path/to/kernel/vmlinux

Without BPF_BRANCH_SNAPSHOT_F_COPY, no branch records related to the
tracee are captured. With it enabled, 17 branch records from the tracee
are observed.

Detailed verification results are available in the gist [2].

With this series applied, retsnoop [3] can benefit from improved LBR
support when using the '--lbr --fentries' options.

Links:
[1] https://github.com/bpfsnoop/bpfsnoop
[2] https://gist.github.com/Asphaltt/cffdeb4b2f2db4c3c42f91a59109f9e7
[3] https://github.com/anakryiko/retsnoop

Leon Hwang (3):
  bpf, x64: Call perf_snapshot_branch_stack in trampoline
  bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for
    bpf_get_branch_snapshot helper
  selftests/bpf: Add BPF_BRANCH_SNAPSHOT_F_COPY test

 arch/x86/net/bpf_jit_comp.c                   | 66 +++++++++++++++++++
 include/linux/bpf.h                           | 18 ++++-
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 30 +++++++++
 kernel/trace/bpf_trace.c                      | 17 ++++-
 .../bpf/prog_tests/get_branch_snapshot.c      | 26 +++++++-
 .../selftests/bpf/progs/get_branch_snapshot.c |  3 +-
 7 files changed, 153 insertions(+), 8 deletions(-)

--
2.52.0

