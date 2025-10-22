Return-Path: <linux-kselftest+bounces-43754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690ACBFBA6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F4D480B54
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247230CDB6;
	Wed, 22 Oct 2025 11:34:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B442CA6B;
	Wed, 22 Oct 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132864; cv=none; b=HSbvaE+3BesbaY/gG/colQS7zHd+DW8XooDSwlG/JKJ2nKERr6WPKl2mkmFbVg9u+hIwFBeERbK40pnPP0qaGyFutGqnLegph44jJO9q8ib4LnQz7qnhUsRFdAKghHHs15K62TNlV+3FeT5oS2EEAVuqzRh3XTNiwNKyGVM4U4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132864; c=relaxed/simple;
	bh=4aezrQuW2GOC3SjfI1st8kg1jCV+C+GHUwHlziof+9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7V6I0OShCNwomWo6tg3Jw7zmIln0bXVTh+EQunrpE/nmOXxcSVga3arHbgzpolGQWPQ3oBlRsHeF6oVzvZibYZV0gpacnYsMsfwRd7AC67WmcNN+euKBuOI5HHcvOHHwpFPSqn6vu/rXaHxz9eqjN/NeMsp+wu1rGnI9r3JnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id D5D5B8B2A0B; Wed, 22 Oct 2025 19:34:19 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] bpf: Add kfuncs and selftests for detecting execution context and selftests
Date: Wed, 22 Oct 2025 19:33:31 +0800
Message-ID: <20251022113412.352307-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This path introduces several kfuncs to help BPF programs determine their
current execution context. When hooking functions for statistics, we often
need to use current->comm to get the process name.

However, these hooked functions can be called from either process context
or interrupt context. When called from interrupt context, the current we
obtain may refer to the process that was interrupted, which may not be
what we need.

These new kfuncs expose APIs that allow users to determine the actual
execution context.

Jiayuan Chen (2):
  bpf: Add kfuncs for detecting execution context
  selftests/bpf: Add selftests for context detection kfuncs

 kernel/bpf/helpers.c                          | 45 +++++++++++++++++++
 .../selftests/bpf/prog_tests/context.c        | 32 +++++++++++++
 .../selftests/bpf/progs/context_prog.c        | 33 ++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/context.c
 create mode 100644 tools/testing/selftests/bpf/progs/context_prog.c

-- 
2.43.0


