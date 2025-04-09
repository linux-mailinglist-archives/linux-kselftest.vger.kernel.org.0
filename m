Return-Path: <linux-kselftest+bounces-30438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A822AA82A6A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2741885947
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65E2673A3;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40A267392;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212360; cv=none; b=XnLh1sZ1y+sYh418TgIgBKalbNg35D/o8fVc5q3sfjFiYUiWxANMM0hmnvelOJaP9w4KXi3y/H9NHL2nTqlWb3tiUFPN3S2nuOC9u1LLgeP2GswLT/tgs/ComgAWSGXr7feDDoAtg8VP8IfzIy5/TwNe/rNnFK9nJXkPL352NsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212360; c=relaxed/simple;
	bh=HuGjzSJBxJfnhAXNbzT7vAN2Hq3vYmNgvnmqaup+qJU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=m6bjAbkQC0ItB/nTCunVCXpxAhZv7oOmGguKfrlZf/UUwU3CuGNclO1vfjjUxI3/hdIa7RXEfCZlOdcQPwV7wWzU+OV0n9mMLm8GV0odrl90wisZyIZwtToM0AC5dLhHtM/aMZh7ktdW5dPc0UtdpYFcT/0T2+vvyXxuS8cGXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31924C4CEE7;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u2XKi-00000008kQa-0mBg;
	Wed, 09 Apr 2025 11:27:20 -0400
Message-ID: <20250409151549.788068911@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Apr 2025 11:15:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org,
 Andy Chiu <andybnac@gmail.com>
Subject: [PATCH 0/2] ftrace: Fix subops accounting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

A fix [1] came in that fixed the notrace_filter side of the subops processing
of the function graph tracer. When I started testing that fix, I discovered
that the many more functions were being enabled than were being traced.

The function graph infrastructure uses ftrace to hook to functions. It has
a single ftrace_ops to manage all the users of function graph. Each
individual user (tracing, bpf, fprobes, etc) has its own ftrace_ops to
track the functions it will have its callback called from. These
ftrace_ops are "subops" to the main ftrace_ops of the function graph
infrastructure.

Each ftrace_ops has a filter_hash and a notrace_hash that is defined as:

  Only trace functions that are in the filter_hash but not in the
  notrace_hash.

If the filter_hash is empty, it means to trace all functions.
If the notrace_hash is empty, it means do not disable any function.

The function graph main ftrace_ops needs to be a superset containing all
the functions to be traced by all the subops it has. The algorithm to
perform this merge was incorrect. It was merging the filter_hashes
of all the subops and taking the intersect of all the notrace_hashes
of the subops. But by taking the intersect of all the notrace_hashes
it ignored how those notrace_hashes are dependent on the associated
filter_hashes of each individual subops.

Instead, modify the algorithm to be a bit simpler and correct.

First, when adding a new subops, do not add the notrace_hash if the
filter_hash is not empty. Instead, just add the functions that are in the
filter_hash of the subops but not in the notrace_hash of the subops into the
main ops filter_hash. There's no reason to add anything to the main ops
notrace_hash for this case.

The notrace_hash of the main ops should only be non empty iff all subops
filter_hashes are empty (meaning to trace all functions) and all subops
notrace_hashes have the same functions.

That is, the main ops notrace_hash is empty if any subops filter_hash is
non empty.

The main ops notrace_hash only has content in it if all subops
filter_hashes are empty, and the content are only functions that intersect
all the subops notrace_hashes. If any subops notrace_hash is empty, then
so is the main ops notrace_hash.

[1] https://lore.kernel.org/all/20250408160258.48563-1-andybnac@gmail.com/

Steven Rostedt (2):
      ftrace: Fix accounting of subop hashes
      tracing/selftest: Add test to better test subops filtering of function graph

----
 kernel/trace/ftrace.c                              | 314 ++++++++++++---------
 .../ftrace/test.d/ftrace/fgraph-multi-filter.tc    | 177 ++++++++++++
 2 files changed, 354 insertions(+), 137 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi-filter.tc

