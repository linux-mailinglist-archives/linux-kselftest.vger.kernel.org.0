Return-Path: <linux-kselftest+bounces-36641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0CDAFA150
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CE2189CD18
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B1212B31;
	Sat,  5 Jul 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="dabMzoAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CE1C84CB;
	Sat,  5 Jul 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751742587; cv=none; b=HWk3pSQW+RZR2FKkXTO4w8Qvz6Axd/8QaetFBfn8jvwa+EsW2MAUDMFoNDBBLwbIH12VHj+kWlZhEA7Q61OOFOm2d23Isdmz8n7pRDjNsjnerBSFlPSIWKE0OXr8xUy5zWrxi8/5KIxkpel5rJiE7FKU+QG3PsPMBwFIwgtAbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751742587; c=relaxed/simple;
	bh=qp6t18ocRY52K85B+FiCV7mr3R4S0Clf6jSk6R9gHtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cuhMsOqEhgWc4NIQUOKRu24sr/8yNgyEaD43Yi38ySbe1xAASzku4DXSroDQL8k/v1TsB8ddAe9DrPSWUp0y69z81akUIsZHLSZ7KTC1E8SU4VdWqi64K6qKZWG9ZBFrkdz3xkbmJvGqsDAuiaUEqtcv/CdJYr1JFH+RekL56SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=dabMzoAs; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751742575; bh=U4JRcb2ISLhy6GHoPDCy2o9SAqKHaBiyifazmsE7ZfU=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=dabMzoAsMcA5VXmWoWqC9uDhMbVXY2m4NC+tHhMRkF41V9PW0CEimFmuPsu2SdKSO
	 HILTD0E0v1XKmZuw4nAr3h2/PoOqMuvjgEe9p3CzebxBMeO3AhS9s/21aAO2Fz1lcw
	 OsPd2tvSIKUj2RrUtSxMLwFuGoXmEHLr4sASjtjZGzX1fMwSt5RomJBXOG/nW7cVeR
	 As/N0msV9l7Hb55OrEl6yo9W53KTAUv+PC4/PvEuNEUi2b7sIOngsgHTHbmLIzBD4T
	 NzU1s7QvFYwq/pqVsn02/h4usfRObReaLhuEBZWW4a6CInU+KWuMJ/E6FlbQoNQ3Jo
	 NBfy/+O/YQ2fA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bZKnC61Mmz1xwW;
	Sat,  5 Jul 2025 21:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362a:3200:5d43:2d8a:dc0e:5715
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362a:3200:5d43:2d8a:dc0e:5715])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19p3JUrEsOfWRyomGLjfk3UMHlSJN+uMLU=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bZKn85Bmnz1xsD;
	Sat,  5 Jul 2025 21:09:32 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Viktor Malik <vmalik@redhat.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Fix and test aux usage after do_check_insn()
Date: Sat,  5 Jul 2025 21:09:06 +0200
Message-ID: <20250705190908.1756862-1-luis.gerhorst@fau.de>
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

Changes since v2:
- Use insn_aux variable instead of introducing prev_aux() as suggested
  by Eduard (and therefore also drop patch 1)
- v2: https://lore.kernel.org/bpf/20250628145016.784256-1-luis.gerhorst@fau.de/

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

Luis Gerhorst (2):
  bpf: Fix aux usage after do_check_insn()
  selftests/bpf: Add Spectre v4 tests

 kernel/bpf/verifier.c                         |  19 ++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/verifier_unpriv.c     | 149 ++++++++++++++++++
 3 files changed, 167 insertions(+), 5 deletions(-)


base-commit: 03fe01ddd1d8be7799419ea5e5f228a0186ae8c2
-- 
2.49.0


