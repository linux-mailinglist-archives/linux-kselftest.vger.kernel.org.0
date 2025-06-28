Return-Path: <linux-kselftest+bounces-36054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42AAEC7E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158C87B0B8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC524A06F;
	Sat, 28 Jun 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="IlsEjLlX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876221FF36;
	Sat, 28 Jun 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122254; cv=none; b=QSyQGO2dGoKcKBT7cZY+TNQxkbArUgSiS9aNgTdesjM/wNVmVW2pZ57/mBg/+WgOARr4wThl8sPz5kx2otzUFOpD5op40TDL1uJzd43dAVilW8oP+wJ1knk19nXHc7d5PGDxdDf848/x5vulCe2VXpnwtdD9VWymQhI6URX2rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122254; c=relaxed/simple;
	bh=lwPuntJq70PRVEPQV8u+g+NimU9leJZxsQaQehZreJk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l88P0afo2Fcql8Pe33Nwd2rabL94T3H5qHCDGd55ZKnlNJD9O+FdVYcr8LFhooL6n1X7gCZOvEOV4b4LSLmgiyi3HMmkUXP8fE1kJuteuy/VvXvHIvaNzNOiV4s2XpqS9Dq7/vaIfqgqbxeIrvqc6XWxqCA6NiUyXWYknObBGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=IlsEjLlX; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751122249; bh=iMb2iIt/E2pk6yBJ3Cqte9rJPzi7soiEOAkpW8AKw9k=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=IlsEjLlXg0dQ2/cXedMThb9ECdiuVQR15w36EnMzXA/PM14TOjlHV3O/M42rywQi6
	 U7WEa/GuWEej15nDAFpVP/UuJiwQ1nUFRotgrcz01xwyAl7ZPT0fdM+pYb+yNv5KdX
	 oBQmZktaXd3MeJ8I1uSohSefMt9RQBRSaxEI4iFdZZgLAGlAIyDjOn3J0+W+Wdn+x2
	 jmi7LQwZkMuwjMTsr62NxVUeGD7lwomT710jJLNjUrH68CTt+vLeF/GHDsP7TBl2l1
	 wgWteowYk4nv+/jQ6kBIw8DwTQ0ivH/7dw1zvgDJSWhjQqcyCumoni9Fhv+LMnR4qy
	 zBRyCKRkheJQQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTwMs2zKVzPjgf;
	Sat, 28 Jun 2025 16:50:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18dbNxXayfq6bFY1zyTm4okoLcFve9YUcQ=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTwMp2LBMzPkVH;
	Sat, 28 Jun 2025 16:50:46 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Peilin Ye <yepeilin@google.com>,
	Jiayuan Chen <mrpre@163.com>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix and test aux usage after do_check_insn()
Date: Sat, 28 Jun 2025 16:50:13 +0200
Message-ID: <20250628145016.784256-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix cur_aux()->nospec_result test after do_check_insn() referring to the
to-be-analyzed (potentially unsafe) instruction, not the
already-analyzed (safe) instruction. This might allow a unsafe insn to
slip through on a speculative path. Create some tests from the
reproducer [1].

Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") should
not be in any stable kernel yet, therefore bpf-next should suffice.

[1] https://lore.kernel.org/bpf/685b3c1b.050a0220.2303ee.0010.GAE@google.com/

Changes since v1:
- Fix compiler error due to missed rename of prev_insn_idx in first
  patch
- v1: https://lore.kernel.org/bpf/20250628125927.763088-1-luis.gerhorst@fau.de/

Changes since RFC:
- Introduce prev_aux() as suggested by Alexei. For this, we must move
  the env->prev_insn_idx assignment to happen directly after
  do_check_insn(), for which I have created a separate commit. This
  patch could be simplified by using a local prev_aux variable as
  sugested by Eduard, but I figured one might find the new
  assignment-strategy easier to understand (before, prev_insn_idx and
  env->prev_insn_idx were out-of-sync for the latter part of the loop).
  Also, like this we do not have an additional prev_* variable that must
  be kept in-sync and the local variable's usage (old prev_insn_idx, new
  tmp) is much more local. If you think it would be better to not take
  the risk and keep the fix simple by just introducing the prev_aux
  variable, let me know.
- Change WARN_ON_ONCE() to verifier_bug_if() as suggested by Alexei
- Change assertion to check instruction is BPF_JMP[32] as suggested by
  Eduard
- RFC: https://lore.kernel.org/bpf/8734bmoemx.fsf@fau.de/

Luis Gerhorst (3):
  bpf: Update env->prev_insn_idx after do_check_insn()
  bpf: Fix aux usage after do_check_insn()
  selftests/bpf: Add Spectre v4 tests

 kernel/bpf/verifier.c                         |  30 ++--
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/verifier_unpriv.c     | 149 ++++++++++++++++++
 3 files changed, 174 insertions(+), 9 deletions(-)


base-commit: d69bafe6ee2b5eff6099fa26626ecc2963f0f363
-- 
2.49.0


