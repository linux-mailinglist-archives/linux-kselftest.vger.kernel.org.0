Return-Path: <linux-kselftest+bounces-5805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E4986F8F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FC71C20944
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D538D33CF;
	Mon,  4 Mar 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh9wgkeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC22F35;
	Mon,  4 Mar 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523601; cv=none; b=uuIC5ZAvpG5we8OqiAlWq9usZvlCD5Cdb7HZCLWziXmqB5G4hADjJaLOhCf9iNgyaV7FQVf3IZWla8+9gs0Xq8RVLnhEk5S1KjNugeHmu2sWVV/stw3s5CVzkZcVlq4UDKeZuyZVnCt1qZSSTq4Pm0BUbcRaQfxIy+gFhYfodAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523601; c=relaxed/simple;
	bh=PSql8T+SB1nHve+XLIxaaalYKdBXrVJvU38xsLLMMdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W5L1KsMUV5p8LEW4fBWykLdN1Ff6W3OzohBPXRXnPUpmXShMi1Wm/Cv9KHFMinpSeuAY9FUWMTC0NGiA5Qh3CaZCdVTvKynjOtF/0hoOYlgzEdYiVgTN5iIifnqI17Ra3qqLqwijEYP1SU3RY/UoUe+CeAPu/iIwFpVqo69dPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh9wgkeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70044C433C7;
	Mon,  4 Mar 2024 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523601;
	bh=PSql8T+SB1nHve+XLIxaaalYKdBXrVJvU38xsLLMMdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Oh9wgkeqk/wDfQFQkSH8NnelRNo+gVDZoebrTJzmoK+9xli/KBi2D3cLwLdVWl0Cy
	 +61oWLw5X1s5FgAVT0Y9jtvPu6bEljxwDCEDBVEvxM2wpEhaZ/UgQkoDJ7gxZKAnrB
	 DEMP2I8FwCX/iFAajaMFQHEshpbjXboPsGprOJj8sU+MITr9yqjStN+UjGP+KM/09a
	 YYWZYzZ5LgMAuQlHUo10UAc/+lpr4OUu8S3HUm8RWwYmysDD5Zje/kSI67MsU1rYLu
	 g9pORQ9xEeedtgTn6pMwremyJO2Ua0a2rsZTkhshhiOpIetZScpHpCe7REFcgFOdx/
	 MeRquWoyiuNQQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/8] tracing/probes: Support function parameter access from return probe
Date: Mon,  4 Mar 2024 12:39:56 +0900
Message-Id: <170952359657.229804.14867636035660590574.stgit@devnote2>
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

Here is version 3 series of patches to support accessing function entry data
from function *return* probes (including kretprobe and fprobe-exit event).
The previous version is here;

https://lore.kernel.org/all/170891987362.609861.6767830614537418260.stgit@devnote2/

In this version, [1/8] is a bugfix patch (but note that this is already pushed to
probes-fixes-v6.8-rc5, just for reference), updated [4/8] changelog and build error,
fixes selftests error [6/8], update document[8/8] and added Steve's reviewed-by.


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

Masami Hiramatsu (Google) (8):
      fprobe: Fix to allocate entry_data_size buffer with rethook instances
      tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
      tracing/probes: Cleanup probe argument parser
      tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
      tracing: Remove redundant #else block for BTF args from README
      tracing/probes: Support $argN in return probe (kprobe and fprobe)
      selftests/ftrace: Add test cases for entry args at function exit
      Documentation: tracing: Add entry argument access at function exit


 Documentation/trace/fprobetrace.rst                |   31 +
 Documentation/trace/kprobetrace.rst                |    9 
 kernel/trace/fprobe.c                              |   14 -
 kernel/trace/trace.c                               |    5 
 kernel/trace/trace_eprobe.c                        |    8 
 kernel/trace/trace_fprobe.c                        |   59 ++-
 kernel/trace/trace_kprobe.c                        |   58 ++-
 kernel/trace/trace_probe.c                         |  417 ++++++++++++++------
 kernel/trace/trace_probe.h                         |   30 +
 kernel/trace/trace_probe_tmpl.h                    |   10 
 kernel/trace/trace_uprobe.c                        |   14 -
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |   18 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |   18 +
 15 files changed, 521 insertions(+), 176 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

