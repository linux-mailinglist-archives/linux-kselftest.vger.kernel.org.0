Return-Path: <linux-kselftest+bounces-27557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E76A4556B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741523A8BD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFE267721;
	Wed, 26 Feb 2025 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbzL73He"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371D16DEB1;
	Wed, 26 Feb 2025 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550721; cv=none; b=SPWb+7Q/2MQP8I6kM9ciqbC81l2X0qRYfxB0E1nfV0B+gueqvZom6iwo13LIPXR6CknVKryqLSWpACRhIEZWvS/NnUaCVsDdlvEynpKCyAm7VNt7AYzcgNH1x926MAI/Rq+RorvXtB1FhLRoqF2/3/53TLfUJy0EVc0hm6djiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550721; c=relaxed/simple;
	bh=ih0Il9VNpXYbKf9bvdfY0gWj93ycLMrwGzMmW0dJ+fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OsyAyeH7VEpxud0Ba3sLEAEwAQ7LoSeVXIM6pz0Jnxv+JlbWZQ5v0HoheeLWVoPCs06Q8LNskBbo+RSCZ2DLXrSgKS6C2e0igdgo8VPSA9g81/n0Gi3ybNoHuF7Haac5IaWpGiyw+rXQsTGJjtVE+nH9A/sjZ+sZKGmA6KFTN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbzL73He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE67C4CED6;
	Wed, 26 Feb 2025 06:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550721;
	bh=ih0Il9VNpXYbKf9bvdfY0gWj93ycLMrwGzMmW0dJ+fY=;
	h=From:To:Cc:Subject:Date:From;
	b=AbzL73HehKGV2Yfi4pr6Iw/PzCjphe0OupUVlfAS4QQ/cPn9isb2Ug2ROIbI2vOvh
	 SUX3bF4ZVNpa+G4XA/qe4Xc08Z4kSIduDftSW/UYkMX6cmedEgxGOWi2AzdXVnCQim
	 4BN0kxFn1unZ4bOIK9jPLAcDXdQiWZIRYhgVLfojcFpXfHM9yswHhmO7wZKoGjP7DJ
	 u1BIgWDELd6srw2SxcbWaBuPbd+BbV34vVMj2p5BCozjnnOlP0g61QMo3Ar03QmYsX
	 whYENUeUe//eqRafVWKsHD4YT4ltzUk28isLlgdJEUdCd4pfO0o+eOuj8viJWS9api
	 gK9difvOiXatw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/8] tracing: probes: Fixes and enhancing error logs
Date: Wed, 26 Feb 2025 15:18:37 +0900
Message-ID:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The following series fixes some bugs and adding some error messages
which are not handled.
This also add some selftests which tests the new error messages.

Thank you,

---

Masami Hiramatsu (Google) (8):
      tracing: tprobe-events: Fix a memory leak when tprobe with $retval
      tracing: tprobe-events: Reject invalid tracepoint name
      tracing: fprobe-events: Log error for exceeding the number of entry args
      tracing: probe-events: Log errro for exceeding the number of arguments
      tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro
      selftests/ftrace: Expand the tprobe event test to check wrong format
      selftests/ftrace: Add new syntax error test
      selftests/ftrace: Add dynamic events argument limitation test case


 kernel/trace/trace_eprobe.c                        |    2 +
 kernel/trace/trace_fprobe.c                        |   25 +++++++++++-
 kernel/trace/trace_kprobe.c                        |    5 ++
 kernel/trace/trace_probe.h                         |    6 ++-
 kernel/trace/trace_uprobe.c                        |    9 +++-
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   14 +++++++
 .../ftrace/test.d/dynevent/dynevent_limitations.tc |   42 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    1 
 8 files changed, 98 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

