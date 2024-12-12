Return-Path: <linux-kselftest+bounces-23285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD19F0002
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 00:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5252870C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551E1DE88E;
	Thu, 12 Dec 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="cC0mYaWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxsvW09y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0F1D88C7;
	Thu, 12 Dec 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045805; cv=none; b=tQrfx0+kazMFFja2WMGhFHGNfS/dDsV7sIKV/6vymDyKMzL/qAyRMiTEB2HabZgR2W0umvTcRsbEMuZMtebyjF9CSLYm379jR+TPPlN/btMyY02HZuRBhDkwZqjED8iNb9FX5QFR9tNH6oRZvFonL8TjmHhP1HrJU4QsjaofUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045805; c=relaxed/simple;
	bh=/WdJlbdFKhBhBaI8pNkou1RvtXH2M6zc853zjdaiOt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=us+K+pO1zr4ZHlV8aPi5sa6KOoHHl8p1nQodmFRBZ4O+lXG0NVE4lO3MXxfjYaicwS8Hpb5CjUm2NGOhWrc7ODYNt+5vfEXK7ToOGNvET5Mg5KvUz90jL6YzjXy1rmxCzFt2s4QRx8Xh8B7ukw8fL9M+or/Gh9QPjfI+tx1lxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=cC0mYaWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxsvW09y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A4E36138370B;
	Thu, 12 Dec 2024 18:23:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 18:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734045801; x=1734132201; bh=u6hB1h+d6p4EJ8BejXkpl
	SVJZjGQRemDsGbKPqKBy50=; b=cC0mYaWPNkX/W9qzk9bEbNTc9jYgvgUUXLDTb
	D4vYUO2rCiX1bHh9QG8NbEuA1S2gSuqv09d8bULm/BOFVsM1AYlmnk2gtlxuUT+b
	Pmp7CKprRw8nUNn0n7Ua9caobdeTl8N8EXJfh4n56+AAzSNSzdmSNA0mG609WXKm
	SZ6empDjtqgIKHFQ9ZTMHCjnE2Ae0xZ10l48DafHFcffZkyRrs6P8UwofymOoybQ
	d/Vo3tOxzRGhMR8hK/wo4V5iJH8asTp/HBbMI0VUAEq7ixWGDHlyjh6MfOAGNUzu
	l4I17jmu7DWGowwQBT6XNoLoWdEuJd8OIv7UbjdUeQyHAYiDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734045801; x=1734132201; bh=u6hB1h+d6p4EJ8BejXkplSVJZjGQRemDsGb
	KPqKBy50=; b=UxsvW09ySFdttUyMHc7M7Qjtwdpr0KkfbGsuNO8QqXske8A7duG
	UoxlYTv2YCHbImL3LUlOCYFFHczU2uXbvhohtsv55mmpXzYrM6KQsvvRXy7GiU61
	/xjWBoFOBbF2XUl8L88omjhXRruTXfvSW2FYrvuZLu5FaxSiKBddmm8glYyugsM+
	74CZdTLU6gkzvENG0w/V0Ge9h79pz1rHDNiT4jfuZ4EYqOAKoIP/q78+NcvNvfNK
	Gu347qcVDLE1MTH0no1JIhuGLtZNy3zT4XKmQ13m/DynPmqIC7cZnJsSY/xnOan2
	FcqplC/RDMOgQuACz5JAu0//2DiNNlVgTPQ==
X-ME-Sender: <xms:aXBbZ5a5Io5bvcqF5c293mLqiAK2awPMk-UdQKHEir3RXZFekdtbJQ>
    <xme:aXBbZwblwylEjZWNQc3xBSD1t41ROoEnvtLoLtGft5NofQY547dw2agiFCzxcW3Z9
    fD5bBUkluTe2991sA>
X-ME-Received: <xmr:aXBbZ78_FBXmPqQ-T1sCv1sjMarsfbLUbInu8LDhWQfixHbaTHFRi5VxfRQCNMe4TEj3Qnlw43FUucutSmfSclQ3W98Sg6o8HqgKkP74lxWSa0G_lXWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgv
    lhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgf
    elvdffiedtleejvdetfeefiedvfeehieevveejudeiiefgteeiveeiffffnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuh
    drgiihiidpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsth
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgihorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepvggu
    ugihiiekjeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aXBbZ3oq3NX2Bm6kzA9ov_JgTysi5sijZsFsBasJ8rElVcaCzKRpfw>
    <xmx:aXBbZ0p2ow3VKV3CHgg0lyA6I7bZJYEbRL0-8IrZ3wFFkIxYxiB6yw>
    <xmx:aXBbZ9R1_mPgiPYy6BJk1EBZBisilRGjixiL7lMRFE62T6_3BGGS4w>
    <xmx:aXBbZ8o0QhsB1F5Tcf2FK5rTgUEVQWSbpzwmncUUtcjR5pbiGYBDtQ>
    <xmx:aXBbZweW3jzOKAn-kgX-1mAjTrt8NhLFuY7rJy54TXv1heuGctl21qPI>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:19 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v5 0/5] Support eliding map lookup nullness
Date: Thu, 12 Dec 2024 16:22:04 -0700
Message-ID: <cover.1734045451.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows progs to elide a null check on statically known map
lookup keys. In other words, if the verifier can statically prove that
the lookup will be in-bounds, allow the prog to drop the null check.

This is useful for two reasons:

1. Large numbers of nullness checks (especially when they cannot fail)
   unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
2. It forms a tighter contract between programmer and verifier.

For (1), bpftrace is starting to make heavier use of percpu scratch
maps. As a result, for user scripts with large number of unrolled loops,
we are starting to hit jump complexity verification errors.  These
percpu lookups cannot fail anyways, as we only use static key values.
Eliding nullness probably results in less work for verifier as well.

For (2), percpu scratch maps are often used as a larger stack, as the
currrent stack is limited to 512 bytes. In these situations, it is
desirable for the programmer to express: "this lookup should never fail,
and if it does, it means I messed up the code". By omitting the null
check, the programmer can "ask" the verifier to double check the logic.

Changes in v5:
* Dropped all acks
* Use s64 instead of long for const_map_key
* Ensure stack slot contains spilled reg before accessing spilled_ptr
* Ensure spilled reg is a scalar before accessing tnum const value
* Fix verifier selftest for 32-bit write to write at 8 byte alignment
  to ensure spill is tracked
* Introduce more precise tracking of helper stack accesses
* Do constant map key extraction as part of helper argument processing
  and then remove duplicated stack checks
* Use ret_flag instead of regs[BPF_REG_0].type
* Handle STACK_ZERO
* Fix bug in bpf_load_hdr_opt() arg annotation

Changes in v4:
* Only allow for CAP_BPF
* Add test for stack growing upwards
* Improve comment about stack growing upwards

Changes in v3:
* Check if stack is (erroneously) growing upwards
* Mention in commit message why existing tests needed change

Changes in v2:
* Added a check for when R2 is not a ptr to stack
* Added a check for when stack is uninitialized (no stack slot yet)
* Updated existing tests to account for null elision
* Added test case for when R2 can be both const and non-const

Daniel Xu (5):
  bpf: verifier: Add missing newline on verbose() call
  bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
  bpf: verifier: Refactor helper access type tracking
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         | 127 ++++++++---
 net/core/filter.c                             |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/test_global_func10.c  |   2 +-
 .../selftests/bpf/progs/uninit_stack.c        |  29 ---
 .../bpf/progs/verifier_array_access.c         | 214 ++++++++++++++++++
 .../bpf/progs/verifier_basic_stack.c          |   2 +-
 .../selftests/bpf/progs/verifier_const_or.c   |   4 +-
 .../progs/verifier_helper_access_var_len.c    |  12 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |   2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../selftests/bpf/progs/verifier_mtu.c        |   2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |   4 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |   8 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 19 files changed, 342 insertions(+), 96 deletions(-)

-- 
2.46.0


