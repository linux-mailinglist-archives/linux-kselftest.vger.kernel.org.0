Return-Path: <linux-kselftest+bounces-36044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4EAEC745
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0466E2D4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100D19ABB6;
	Sat, 28 Jun 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="B0DG5Dwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6724A063;
	Sat, 28 Jun 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751115612; cv=none; b=ff/chGf8btSQ+Cq3cE3SdaOvu3X724l/3WpVk+VeGigBqfPVnt1FC984d3j2Zk/7BHLZSmE1V602o9r7vtf3gaQ/DH+5qOCyOTJtlGmi/6C/mekmREOTU4uKTjtxCjoaKyIcyr46cLUrEQDIH1F+/6xSXJJ+t1ajCIhjKZkDGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751115612; c=relaxed/simple;
	bh=cQqh4d0YAJXtJthh04L/xkoB8b8oBejLppRDkrOGXJI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rzyytlKXLX4WGZMikA+PkLSTntK+hHmRMXjuYcoYMWPHKdeKVGoNhGfOhpPdmPQiLO2VqH4oOtxvVIdW2UENLZ9o4meOmtv1DFvzD0IcPE5Hi0q5laobPn4nVmYyPEXFimJ+2qd63QQyglcsn1nww5nY3cPpY3odRi7Lws0yVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=B0DG5Dwi; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751115600; bh=oB81lEB+hjj+fyMybBi5rWn/3uMgT2vikvW1lNSLCfM=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=B0DG5DwiWW6IzKjXOU/VLqjnDOR75cUPQPo2YZbVbW2SlnUjRAwRxgSFu9/5VL9V/
	 GGW9bpqigjTW4bM4hAwW/ulhmeE4XmsVS+h+kaHBdAEHKHNbUFxjKA6IVRo99sYFQN
	 KtRKJxP68UqfUA1OykPppjLDOltxie6RdhTXaQnEDsUrCt/Y6jdbNlMbarDhsHtjKs
	 KWD+bAlFjecYzfyuTVzlfnAt6E+pDMik0pxY1sTXphmIlRNhC1vct2vzg4Cgnb7TyV
	 qDARnGg6TK9Don4lfDR5H6iWYxVqHhNZ4TnUirYbjWekOrysTGgrdUyudGyJH47mqL
	 MgipuZ21+3DKw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTsw05857z8sjY;
	Sat, 28 Jun 2025 15:00:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+c2pGUPmdXo6K7E8lEWtTa9cm2lpFP5B4=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTsvx3TV4z8v9h;
	Sat, 28 Jun 2025 14:59:57 +0200 (CEST)
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
Subject: [PATCH bpf-next 0/3] bpf: Fix and test aux usage after do_check_insn()
Date: Sat, 28 Jun 2025 14:59:24 +0200
Message-ID: <20250628125927.763088-1-luis.gerhorst@fau.de>
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


