Return-Path: <linux-kselftest+bounces-20867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04C9B3E4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE771C21F5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1A1EE02D;
	Mon, 28 Oct 2024 23:12:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45382188CDC;
	Mon, 28 Oct 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157130; cv=none; b=DmaO6lqb9lzuA4Lgd+64eyM+aco3cFhApFMoQwwfAi11ugHB1xkSSwzCTiDwBFOQcvfYjq9IUHe0BWBHymOAv5Te23pX+rG4wQ4tlSRCqG8oZIuV8lENbvKekcpZhcKGXwCtHl4KsHERkrEgb1dYBXepmF0ZFboYXwau6W55dPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157130; c=relaxed/simple;
	bh=wcV09ZtY1F3z2hRq7z+lF1u5SCJeWxmgOeSAg0iKdEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lskoM1qpyW2uXib/3jMwh+QJKk/Ra71aSZYr3/p0V0TwpVwQnXWzMHWEE2Rws+Y2j4erCvSg2cLBvYdIQfFqTbFGiu0dFISQFruy9qqK0VwRdkEXtYsYCCmubglUvfhadzq04EvI27t+oEdzA/Tlwx8H/w4eXgJc0xhLAOyPwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D977C4CEC3;
	Mon, 28 Oct 2024 23:12:07 +0000 (UTC)
Date: Mon, 28 Oct 2024 19:12:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: dhowells@redhat.com, mhiramat@kernel.org, surenb@google.com,
 jyescas@google.com, kernel-team@android.com, android-mm@google.com, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing: Document tracefs gid mount option
Message-ID: <20241028191204.0e6a9040@rorschach.local.home>
In-Reply-To: <20241028214550.2099923-2-kaleshsingh@google.com>
References: <20241028214550.2099923-1-kaleshsingh@google.com>
	<20241028214550.2099923-2-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:43:57 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> [1] and [2] introduced a new gid mount options that could apply to a
> group to all entries in tracefs.
> 
> Document this in the tracing readme.
> 
> [1] https://lore.kernel.org/r/20211208075720.4855d180@gandalf.local.home/T/#u
> [2] https://lore.kernel.org/r/20211207171729.2a54e1b3@gandalf.local.home/T/#u

Your patch series is backwards. The first patch should be the fix, the
second be this patch and the last one is the test case.

You should reference commit IDs and not links.

   Commit ee7f3666995d ("tracefs: Have new files inherit the ownership of
   their parent") and commit 48b27b6b5191 ("tracefs: Set all files to the
   same group ownership as the mount option") introduced a new gid..."

-- Steve

> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  kernel/trace/trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a8f52b6527ca..2b64b3ec67d9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {
>  
>  static const char readme_msg[] =
>  	"tracing mini-HOWTO:\n\n"
> +	"By default tracefs removes all OTH file permission bits.\n"
> +	"When mounting tracefs an optional group id can be specified\n"
> +	"which adds the group to every directory and file in tracefs:\n\n"
> +	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
>  	"# echo 0 > tracing_on : quick way to disable tracing\n"
>  	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
>  	" Important files:\n"


