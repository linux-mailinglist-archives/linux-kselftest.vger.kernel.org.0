Return-Path: <linux-kselftest+bounces-43547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B1BF13B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D26D734C7A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7231690E;
	Mon, 20 Oct 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONVT9Vem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69E3126A7
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963533; cv=none; b=alxt+TC4xx585Bv3NvBimgxk/zWJlEvL0c+aSc2mXnMZoexR9iyN5JdvNMGU3RBqycPTPdtKOktJhdFBpLlrMyujlRbRJ10zbbJCBptWDxvFvuIvF7slpTRQgPvvLcnfAGe6SExcFgOm78b5kD8gvNS+XiEUpnWyzlUpRxKZ8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963533; c=relaxed/simple;
	bh=yEU8OlJ4rnmeVIIFVpJYprNmuPl3V5iccAvk0qJgLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHBUfUNN8kOcoZ88HAR2nXNbkXYKX579R/q2IuWDWxYJQUI6hGGLr72rth9dpXifW2junWLnvihUUAB+/88BiPSRW8iLWIZ+1w5e1wTdWqiy6xcsTv6d9pA0PWWj949zuRyWeRshq8raOc4kgz0fqKLB9zlG/b5tzC3YdiGKTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONVT9Vem; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3c76f3703cso73994666b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760963529; x=1761568329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrHAmJjxM6ewOAgZH2FCw4tTUkBr/4mUYIaDeASxNLM=;
        b=ONVT9VemBlrEqqp4Xe3nEV5dhTX6ME9wfl4OBehvQuaMtUGhye1knQ1EoG3GVNntMW
         XjlLO3UTF4BTiNmuz0bhQUnn+PFKcjcAPL3BEjMewa0/K+7EyIO0VeljkaUOlCTYfHNE
         VM8RdVaKISDhcq5JjZkZMpThcVLen4BtZXJTrO1gVY0tWmm0/FtO+bzBHGk1O83Yvu/A
         hgyjG5sgoMtB9sc4PsKHeVBR7wfFCjloB7NTOs5z4dVO/lXYvR7/y7sw3aP7CwJ/Kfyr
         2KgqCocl0TeDBsiUu74qMOJbQQ0PkcY8qF4ptooz7eyzbhE2Pusr3XCiV8jtbYxZsetT
         3wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963529; x=1761568329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrHAmJjxM6ewOAgZH2FCw4tTUkBr/4mUYIaDeASxNLM=;
        b=aJGlQmWf1/cYR84oOrblnYMRMRnLzzBqmQ2M2KbOUnMQgMfPNlkqfBXrnm3rGWm7ZT
         I+y8nKri1JbyiUWg5fijBtI1FV2KuoSCvGUftkaNJvUvvbjVTy5ut7OVHfy6pEMT7Gr7
         hDgZsH/izDwlDiUF/eoEs1beZzkaK2QipTG0+MJOM0k5vSECX1AcHEdj3ueE+XvhS3LD
         cGmSeCZ2KgqjgwncSUm7pACDDhUznAB5LTuo3mGbkJbxKgkpJppf3GyjhzSUQO7Ld1Bq
         qaUf0ma8aN2loUhwXXZ9hzlClNkKQXD/kYoUl0/NkPnl+ICjd63fO2EtLQJyWEcoCMHA
         W3fg==
X-Forwarded-Encrypted: i=1; AJvYcCWyGo4naTM4bKwjBFUF7i6mAmUhnQXJb/c+X9e5lHWr5FVCSd2ou6HUPy5HDJ+MO8hLl+9QODr8AYWBvEFWxnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWAN0Yo1ZT8nV8wR4nIa7JgKSxYv5gAxjtz3t09YXFdrVSQ7s
	lLX5TO2ijXc+/LnGCMsBW4b6OrFaoWVRMj3HPoUdP+mqAP7HoGHAA57q
X-Gm-Gg: ASbGncsy4AmxwbRtt24umHrgZU6hUI2A3kRSK/0UV2Fd4JKeb0VmHGKKr6UGD30vQRI
	rZHwU7MjLqz6NqyqMu6cXdnoGccsFjdzr1AdA8aINoYuEkM98LH9zZDe+OCAYy+Bah+zQ4SwaDj
	hKhgrXwGJI0/q+7gNXJhmxy958Z5Q8ydnxCyNZiZ2k4bD5uaaMp7+iByfiyKi4ixYYL6/bC1Mzp
	l4CFMNuCJSEj40lX5NA3wnvW7xBqHRj9QUbC81CVOgdeZjZOZtv9C3jdzHbsMm66bSlLfPF+pkM
	VHi2cgv5V7SFw9JzipAP/us4wCqXWuSB5wsSs1HsmJ89S1EEYA/4fbat0Gegtyf7gl9W5w3LWG1
	9wbezOlUKsmLUs19WPpUmSDm+mJdL6mvKZm7yCK8iV2NYLEsBnU16oigHj0b8RAFyd1pyRpCOHC
	s+Ze8=
X-Google-Smtp-Source: AGHT+IHeviqrSd93w8iK4mCEl/S4LfRu1LVX2pbSgOi06QmgOak3XwTymoUDcoiO7hQie9VFAZ5kLw==
X-Received: by 2002:a17:906:641:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b65c8b81515mr400301266b.6.1760963528918;
        Mon, 20 Oct 2025 05:32:08 -0700 (PDT)
Received: from bhk ([165.50.81.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb499dasm787095166b.73.2025.10.20.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:32:08 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	ameryhung@gmail.com,
	toke@redhat.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v4] selftests/bpf: Change variable types for -Wsign-compare
Date: Mon, 20 Oct 2025 14:31:33 +0100
Message-ID: <20251020133156.215326-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow up patch for commit 495d2d8133fd("selftests/bpf: Attempt
to build BPF programs with -Wsign-compare") from Alexei Starovoitov[1]
to be able to enable -Wsign-compare C compilation flag for clang since
-Wall doesn't add it and BPF programs are built with clang.This has the
benefit to catch problematic comparisons in future tests as quoted from
the commit message:"
  int i = -1;
  unsigned int j = 1;
  if (i < j) // this is false.

  long i = -1;
  unsigned int j = 1;
  if (i < j) // this is true.

C standard for reference:

- If either operand is unsigned long the other shall be converted to 
unsigned long.

- Otherwise, if one operand is a long int and the other unsigned int,
then if a long int can represent all the values of an unsigned int,
the unsigned int shall be converted to a long int;
otherwise both operands shall be converted to unsigned long int.

- Otherwise, if either operand is long, the other shall be 
converted to long.

- Otherwise, if either operand is unsigned, the other shall be
converted to unsigned.

Unfortunately clang's -Wsign-compare is very noisy.
It complains about (s32)a == (u32)b which is safe and doen't
have surprising behavior."

This specific patch supresses the following warnings when
-Wsign-compare is enabled:

1 warning generated.

progs/bpf_iter_bpf_percpu_array_map.c:35:16: warning: comparison of 
integers of different signs: 'int' and 'const volatile __u32' 
(aka 'const volatile unsigned int') [-Wsign-compare]
   35 |         for (i = 0; i < num_cpus; i++) {
      |                     ~ ^ ~~~~~~~~

1 warning generated.

progs/bpf_qdisc_fifo.c:93:2: warning: comparison of integers of 
different signs: 'int' and '__u32' 
(aka 'unsigned int') [-Wsign-compare]
   93 |         bpf_for(i, 0, sch->q.qlen) {
      |         ^       ~     ~~~~~~~~~~~

Should be noted that many more similar changes are still needed in order
to be able to enable the -Wsign-compare flag since -Werror is enabled and
would cause compilation of bpf selftests to fail.

[1].
Link:https://github.com/torvalds/linux/commit/495d2d8133fd1407519170a5238f455abbd9ec9b

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes from v3:

-Downsized the patch as suggested by vivek yadav[2].

-Changed the commit message as suggested by Daniel Borkmann[3].

Link:https://lore.kernel.org/all/20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com/#r

Changes from v2:

-Split up the patch into a patch series as suggested by vivek

-Include only changes to variable types with no casting by my mentor
david

-Removed the -Wsign-compare in Makefile to avoid compilation errors
until adding casting for rest of comparisons.

Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Changes from v1:

- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.

Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u

[2]:https://lore.kernel.org/all/CABPSWR7_w3mxr74wCDEF=MYYuG2F_vMJeD-dqotc8MDmaS_FpQ@mail.gmail.com/
[3]:https://lore.kernel.org/all/5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@iogearbox.net/
 .../testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c | 2 +-
 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
index 9fdea8cd4c6f..0baf00463f35 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
@@ -24,7 +24,7 @@ int dump_bpf_percpu_array_map(struct bpf_iter__bpf_map_elem *ctx)
 	__u32 *key = ctx->key;
 	void *pptr = ctx->value;
 	__u32 step;
-	int i;
+	__u32 i;
 
 	if (key == (void *)0 || pptr == (void *)0)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 1de2be3e370b..7a639dcb23a9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -88,7 +88,7 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
 {
 	struct bpf_list_node *node;
 	struct skb_node *skbn;
-	int i;
+	__u32 i;
 
 	bpf_for(i, 0, sch->q.qlen) {
 		struct sk_buff *skb = NULL;
-- 
2.51.1.dirty


