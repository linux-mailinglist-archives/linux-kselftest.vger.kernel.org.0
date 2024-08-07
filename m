Return-Path: <linux-kselftest+bounces-14970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69C94B178
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9952827EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED13145B0B;
	Wed,  7 Aug 2024 20:36:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E912A14C;
	Wed,  7 Aug 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063001; cv=none; b=mm5ioddkLt2rVviHjVRJ5VgYJFmg4fYG785q0Z7/kvqcmEmuKJUrmPWCFdbfT2EY20Per6/zgUyt0acMwZkyvOV5XD+Nd/ycu4AbwAOj4vb1zO9aG52z4IZFhLgAnnfMZY7tJZ5xqOdPZaySn3xXw5CbQSFqOkhKI+Eqpwv8EPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063001; c=relaxed/simple;
	bh=Bal76tT9P5W4aeoFmIAcNfeYIQtoWSnmB27v/LAfBik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NE0jl1cUThrDp3BUryhqeBfJSwgNBNgUdd+VhZnITYNKu/34GxLCEdAk+I7nUOcXhEu6ZF2XH8f5VSzveSzQRLcqHRt2kbNX+BpOviHJo6cdERPDWoAur6zO5lZUpTHvVVEMv1B0s+NK5Rmvb7sjq8MnK5kW8bjz7frjyWFR5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F5C32781;
	Wed,  7 Aug 2024 20:36:39 +0000 (UTC)
Date: Wed, 7 Aug 2024 16:36:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 oleg@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/uprobes: Add a basic uprobe testcase
Message-ID: <20240807163638.528b72a1@gandalf.local.home>
In-Reply-To: <171651179523.161068.3164659198838770307.stgit@devnote2>
References: <171651179523.161068.3164659198838770307.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 09:49:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a basic uprobe testcase which checks whether add/remove/trace
> operations works on /bin/sh.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah, can you take this too.

-- Steve

> ---
>  .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |   26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> new file mode 100644
> index 000000000000..a275decdc880
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove/test uprobe events
> +# requires: uprobe_events
> +
> +echo 0 > events/enable
> +echo > dynamic_events
> +
> +echo 'cat /proc/$$/maps' | /bin/sh | \
> +	grep "r-xp .*/bin/.*sh$" | \
> +	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events
> +
> +grep -q myevent uprobe_events
> +test -d events/uprobes/myevent
> +
> +echo 1 > events/uprobes/myevent/enable
> +echo 'ls' | /bin/sh > /dev/null
> +echo 0 > events/uprobes/myevent/enable
> +grep -q myevent trace
> +
> +echo "-:myevent" >> uprobe_events
> +! grep -q myevent uprobe_events
> +
> +echo > uprobe_events
> +
> +clear_trace


