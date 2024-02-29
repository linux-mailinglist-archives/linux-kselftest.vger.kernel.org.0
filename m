Return-Path: <linux-kselftest+bounces-5609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32786C437
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3789A28A0C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57456451;
	Thu, 29 Feb 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNexrZMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63454FA9;
	Thu, 29 Feb 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196742; cv=none; b=owYsw1+F8bm6j8izg+D/Z/Q+BBESBQqwbGqxvyuQuSvBTKdmJwCH3zuNiXuEq0mYPUR+bCt2r/CTZqKi9p/X1fXq1kZUudTDiLhpADk5WZW7hp8UNxwL1O6PTlkYhsKpSt44kg7G3dznyKkJPgbFPe2a5KBd5YqmohQdTdlS0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196742; c=relaxed/simple;
	bh=h+PuR60VQc/pChn5sYT/Cgrh7xTZzneJkEBH+LhG32A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GAmtraSvhxoHkBrhSjAYxnwntz32AqE5EaydNcKkoo6G2cQM22S3CTEwX5I9/Sg3EWBjD3xR+WOunWktUrkG4ukOjIrUBya2Ms5+DwypwUjajYUOl+Lqi/JD/LxT6SfsDJd4R51ST9XdcWH/xl7C9v5TzlVnQZmR5NbwIwvYS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNexrZMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD97AC43394;
	Thu, 29 Feb 2024 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709196741;
	bh=h+PuR60VQc/pChn5sYT/Cgrh7xTZzneJkEBH+LhG32A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNexrZMoKDoA+1DL96h/s746iYZhicncl4TcZHi5yY/4ffvbifGSPwHxX9FfBhebE
	 mbNHdhPCjXkAyKyemDbgdBGGlDMkah6Zdkah5W17aWF1UMAbje+8vWgFVQ0KArY0nk
	 Oxfb9RyLZTkEPZ0ck80RicUdHVvVxgPZOxKMWwstb/CA7VNVbmuA3+yLRxUDMAnUS4
	 w5gpw3dWvpfzet0SzyPlBLkQ415JXPCARdytJ8aAdJiAnZr8kUjv/qtlQPoUS/rTxR
	 tU3prhQJQ0CmLrPm3emcsK9rHRm6AFJtgMlLqh9/qsoF03SiO94geK78G+9d/WptWI
	 cFaVzYODZ3dJQ==
Date: Thu, 29 Feb 2024 17:52:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-Id: <20240229175216.96bb2e16b510f81e3802ef23@kernel.org>
In-Reply-To: <20240229161320.978190f42dcc1a521c192e7d@kernel.org>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
	<20240229145139.a215085c44add62302463312@kernel.org>
	<20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
	<20240229161320.978190f42dcc1a521c192e7d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 16:13:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 29 Feb 2024 15:38:55 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, this seems arch_rethook_trampoline caused the issue.
> > 
> > And curiously, it depends on the number of stored data.
> > 
> > OK:
> > /sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3' >> dynamic_events 
> > /sys/kernel/tracing # echo 1 > events/fprobes/enable 
> > 
> > NG:
> > /sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3 $arg4' >> dynamic_events 
> > /sys/kernel/tracing # echo 1 > events/fprobes/enable 
> > 
> > I also confirmed that on 'vfs_write' caused the same result. 3 arguments(24 bytes) is OK,
> > but 4 arguments (32bytes) is NG.
> 
> And this may be the fprobe bug. kretprobe events doesn't show this issue.
> 
> OK:
> /sys/kernel/tracing # echo 'r vfs_read $arg*' >> kprobe_events 
> /sys/kernel/tracing # echo 1 > events/kprobes/enable 
> 
> But this is strange because both uses same rethook...

Lol, I haven't allocate the entry data size when initialize rethook.
That's a bug.
Please try below.

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6cd2a4e3afb8..9ff018245840 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int size;
 
-	if (num <= 0)
-		return -EINVAL;
-
 	if (!fp->exit_handler) {
 		fp->rethook = NULL;
 		return 0;
@@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 
 	/* Initialize rethook if needed */
 	if (fp->nr_maxactive)
-		size = fp->nr_maxactive;
+		num = fp->nr_maxactive;
 	else
-		size = num * num_possible_cpus() * 2;
-	if (size <= 0)
+		num *= num_possible_cpus() * 2;
+	if (num <= 0)
 		return -EINVAL;
 
+	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
+
 	/* Initialize rethook */
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
-				sizeof(struct fprobe_rethook_node), size);
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
 	if (IS_ERR(fp->rethook))
 		return PTR_ERR(fp->rethook);
 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

