Return-Path: <linux-kselftest+bounces-5813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941986F909
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAA41C2099B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D39475;
	Mon,  4 Mar 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzCISer0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED379C4;
	Mon,  4 Mar 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523680; cv=none; b=MXc7S87lSbWRSUAI1AcVlB50UbDgJE0gu+JRB1kdMTahrgn3Fk1AnaOhCTmrHbgWvyOmi7Yx2h5xq97lEdigHMYkaPsn3oVime0zCkUhT8XvFF0dE2Gn8+1+ry8LWlGLhjiLpSAmorX7pLaZstxwlh1npZPZBu2HQ/m5HLQfMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523680; c=relaxed/simple;
	bh=8NW/FHEoLd4ENSKfrOd68QHgWBaHFO7j15Gs6Cdq4nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd1mL7jEb/JX3OZDTLyKqzPwUD9WZw1RGoQ20gzWwR4uv6TblPtcGOqS6T8FYvg3u9fCJPmIZqRrA0BX2RPO1zSfDwaQft0MiLyG3PyWBnJ6Ld5oOlA0QCARNxuoJawrbjLVdhUAgIG3vCiwJBiEFskMx5fq6jUuoqOtiSJOZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzCISer0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F012DC433C7;
	Mon,  4 Mar 2024 03:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523679;
	bh=8NW/FHEoLd4ENSKfrOd68QHgWBaHFO7j15Gs6Cdq4nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzCISer0GtepWuozvz7cEKxavhp98EbeA8d4akEnw3vepELLur4Z1hMN9Z39CoUnK
	 496ntpP5p6k1gpIOLrdnuP8C2WMpwYWKekw6xl7bTcy16UWDu1LBfNIx1t7b7r1s73
	 BwHFbbggHa4Y9R5Hbw0Ad2glqztI+5YRT4PSLE8/lg76ztAJrzdL810fq8ApbDD44b
	 wl1RJbQrs+QZo0/oQn9GYtOFk8djcN0ucTJZihfBCgZ1f8PZqW/ktUSdghp0L2p+zP
	 ONnFkvJFXZopjUYq06DyNGywAdhoGoM4iOcEyG0yeonZ0dqNkWZUyRLPzEgkbBm5F1
	 UJtylTioxrpsg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 8/8] Documentation: tracing: Add entry argument access at function exit
Date: Mon,  4 Mar 2024 12:41:15 +0900
Message-Id: <170952367549.229804.8843506960483577062.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170952359657.229804.14867636035660590574.stgit@devnote2>
References: <170952359657.229804.14867636035660590574.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a notes about the entry argument access at function exit probes for
kprobes and fprobe trace event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add usage example in fprobetrace.rst.
---
 Documentation/trace/fprobetrace.rst |   31 +++++++++++++++++++++++++++++++
 Documentation/trace/kprobetrace.rst |    9 +++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index e35e6b18df40..0f187e3796e4 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -70,6 +70,14 @@ Synopsis of fprobe-events
 
 For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
 
+Function arguments at exit
+--------------------------
+Function arguments can be accessed at exit probe using $arg<N> fetcharg. This
+is useful to record the function parameter and return value at once, and
+trace the difference of structure fields (for debuging a function whether it
+correctly updates the given data structure or not)
+See the :ref:`sample<fprobetrace_exit_args_sample>` below for how it works.
+
 BTF arguments
 -------------
 BTF (BPF Type Format) argument allows user to trace function and tracepoint
@@ -218,3 +226,26 @@ traceprobe event, you can trace that field as below.
            <idle>-0       [000] d..3.  5606.690317: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
       kworker/0:1-14      [000] d..3.  5606.690339: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
            <idle>-0       [000] d..3.  5606.692368: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
+
+.. _fprobetrace_exit_args_sample:
+
+The return probe allows us to access the results of some functions, which returns
+the error code and its results are passed via function parameter, such as an
+structure-initialization function.
+
+For example, vfs_open() will link the file structure to the inode and update
+mode. You can trace that changes with return probe.
+::
+
+ # echo 'f vfs_open mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
+ # echo 'f vfs_open%%return mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
+ # echo 1 > events/fprobes/enable
+ # cat trace
+              sh-131     [006] ...1.  1945.714346: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x2 inode=0x0
+              sh-131     [006] ...1.  1945.714358: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4d801e inode=0xffff888008470168
+             cat-143     [007] ...1.  1945.717949: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
+             cat-143     [007] ...1.  1945.717956: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4a801d inode=0xffff888005f78d28
+             cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
+             cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8
+
+You can see the `file::f_mode` and `file::f_inode` are upated in `vfs_open()`.
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index bf9cecb69fc9..a49662ccd53c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -70,6 +70,15 @@ Synopsis of kprobe_events
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 
+Function arguments at kretprobe
+-------------------------------
+Function arguments can be accessed at kretprobe using $arg<N> fetcharg. This
+is useful to record the function parameter and return value at once, and
+trace the difference of structure fields (for debuging a function whether it
+correctly updates the given data structure or not).
+See the :ref:`sample<fprobetrace_exit_args_sample>` in fprobe event for how
+it works.
+
 .. _kprobetrace_types:
 
 Types


