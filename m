Return-Path: <linux-kselftest+bounces-5417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4728668F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E17F1C233BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DB19BBA;
	Mon, 26 Feb 2024 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynq5945f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC11B7E3;
	Mon, 26 Feb 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919878; cv=none; b=hwPaNzACZTnd663q+jIbZepmjRA6osRIcMKBzv9EoTisp4iNqaxOS7WX9uF/kwXj+9BLpJSVpmnpJ3wPnmAnN4ZMVqDvNwyxdwwLvW532xhlTz/IRLu02CGWCDt/mwpQeZcdPnljPF1vi1WSVk9OCqR94He3+2W5KZyTbvAK6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919878; c=relaxed/simple;
	bh=6eV/0foyMhUCesPp4RUIfzVdUPTf/g2H7EDQ8aK/UiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WHD+RRuwZzg3rZMfFmW32rFkeio2pZE1Bw0Q2oKNoRedek0NLP0vl1/wCjQJSqfaIszNaf2GfeFzrPC3h9CI036ZvLSjlZaLEEcLHlYBa04FXhRzb6TZ5K/r9U69fXv9nXsKWqRngOFIZ5+LbUZDJihBU8THUd4g6MgYZBjEh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynq5945f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD4FC433C7;
	Mon, 26 Feb 2024 03:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919878;
	bh=6eV/0foyMhUCesPp4RUIfzVdUPTf/g2H7EDQ8aK/UiE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ynq5945f9Uj1pO+1l/G/qFbWR1EvKH6IbKRxedbgP32P/t1GzHI7ghH1y7slQ3xri
	 6u+7NYV8bF9RqPNxErTFQoXS6IjcJO4iMBFfRUolghRQoxcC19OE1RZsMni1JzlhDP
	 K7B4smpOv8wJSbsiorRH60apN3rck2o+KFH9CsckA8lg9S9oAh25q1n886AqSztetP
	 IP+yssUSnoS/E2mC+NBGgirFBBaATSxCsOa+qoK/gqBfBFZ+lHP9u8MLSB5hMmaxlX
	 kY0ByORlK6EY3tV4anD8fDiXE/w2SJyEXmxvcE1XOMpAIJzjAA6R4wmZexuLfduvtu
	 /j4kysTdW2NNg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/7] tracing/probes: Support function parameter access from return probe
Date: Mon, 26 Feb 2024 12:57:53 +0900
Message-Id: <170891987362.609861.6767830614537418260.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is version 2 series of patches to support accessing function entry data
from function *return* probes (including kretprobe and fprobe-exit event).

In this version, I added another cleanup [4/7], updated README[5/7], added
testcases[6/7] and updated document[7/7].

This allows us to access the results of some functions, which returns the
error code and its results are passed via function parameter, such as an
structure-initialization function.

For example, vfs_open() will link the file structure to the inode and update
mode. Thus we can trace that changes.

 # echo 'f vfs_open mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
 # echo 'f vfs_open%return mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events 
 # echo 1 > events/fprobes/enable 
 # cat trace
              sh-131     [006] ...1.  1945.714346: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x2 inode=0x0
              sh-131     [006] ...1.  1945.714358: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4d801e inode=0xffff888008470168
             cat-143     [007] ...1.  1945.717949: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
             cat-143     [007] ...1.  1945.717956: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4a801d inode=0xffff888005f78d28
             cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
             cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8

So as you can see those fields are initialized at exit.

This series is based on v6.8-rc5 kernel or you can checkout from

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/entry-data

Thank you,

---

Masami Hiramatsu (Google) (7):
      tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
      tracing/probes: Cleanup probe argument parser
      tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
      tracing: Remove redundant #else block for BTF args from README
      tracing/probes: Support $argN in return probe (kprobe and fprobe)
      selftests/ftrace: Add test cases for entry args at function exit
      Documentation: tracing: Add entry argument access at function exit


 Documentation/trace/fprobetrace.rst                |    7 
 Documentation/trace/kprobetrace.rst                |    7 
 kernel/trace/trace.c                               |    5 
 kernel/trace/trace_eprobe.c                        |    8 
 kernel/trace/trace_fprobe.c                        |   59 ++-
 kernel/trace/trace_kprobe.c                        |   58 ++-
 kernel/trace/trace_probe.c                         |  417 ++++++++++++++------
 kernel/trace/trace_probe.h                         |   30 +
 kernel/trace/trace_probe_tmpl.h                    |   10 
 kernel/trace/trace_uprobe.c                        |   14 -
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |   18 +
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |   18 +
 12 files changed, 483 insertions(+), 168 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

