Return-Path: <linux-kselftest+bounces-11021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7B8D6515
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74381F26F8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238626AC2;
	Fri, 31 May 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR9aDfRi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E77483;
	Fri, 31 May 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167651; cv=none; b=iBhNafHjxx24KfS8X0RmHSRSkj67FwBcTRBZSzlEDYUIv2mzKb3WAm8PYvnxO+bpPBQ2MVMB+zBVYHZIEioL0TJWU+j03BVqA6BMGEFj4zBO25M6rK658DHD6MlxFAYOSIXoxR6Axi2Tog7MlAocIMdR4N9EaU5+62PfRT3N05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167651; c=relaxed/simple;
	bh=lNSkXp6089IHQNq0gU4AKnSQIdYErLjMuM20ebZC21Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SQsZWpo74JMZdau94/CjqZKEXTCarkLO9JJ/AlR19peMyNwMC6kBuYIHHB8y7lNNf0IGwahHu+Xb2WQ4s/gO+tlMm6Ob67PBnfMDxZfH50KLf8kbsNOL21hU7OiMHjFs1M2UKnEbniVr95jo8TG+VzABQd2rxIj1vW4r5Mn1Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR9aDfRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D0EC32781;
	Fri, 31 May 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167650;
	bh=lNSkXp6089IHQNq0gU4AKnSQIdYErLjMuM20ebZC21Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YR9aDfRiFZ7mZP7hyvPmd8CBM7RmQmzgmehyStOv1WxCy2PvlCFcL+XsJcHvYN3tq
	 MDIRzMqvHcPN6kKGF9QzNI1WjpMWtV2mvsYUeEnwZeeeMi88rmDgK83gUNjz8QZ3VE
	 CzjXMkieUp7fEpxajZC5ZHBHsGiNyL42Jwg8q1tRyjneNdQC68OmNe1uHkK2MwSYq4
	 3BFNWHfzQN7JY6ZLACX/hPY6wFryQEI/ovOUn9AeqdsRdSPl1N4070bmxC4r7dL+0p
	 jt7Ql1EUX/Tv3mYxIWXn/Vkac9l3dVHWsFRmkvWD7GYGuwqCc8zMVdnFSUWgArg8I+
	 uyCu9NuNEBxTg==
Date: Sat, 1 Jun 2024 00:00:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/tracing: Fix to check the required
 syscall event
Message-Id: <20240601000047.9e2b406a1307d843314bec02@kernel.org>
In-Reply-To: <85472ab9-aa2e-4f5e-869d-5ab42e47c8a0@linuxfoundation.org>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
	<171714862700.198407.14000969067636098427.stgit@devnote2>
	<85472ab9-aa2e-4f5e-869d-5ab42e47c8a0@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 08:41:00 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/31/24 03:43, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since test_duplicates.tc depends on syscalls/sys_enter_openat event,
> > it must add the event file to `requires`.
> > Without this fix, the test fails if CONFIG_FTRACE_SYSCALLS=n.
> > 
> > Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> > index d3a79da215c8..5f72abe6fa79 100644
> > --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> > @@ -1,7 +1,7 @@
> >   #!/bin/sh
> >   # SPDX-License-Identifier: GPL-2.0
> >   # description: Generic dynamic event - check if duplicate events are caught
> > -# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> > +# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
> >   
> >   echo 0 > events/enable
> >   
> > 
> > 
> 
> This change is already in mainline. I sent the fix up in my 6.10-rc1 pr?

Oops, sorry, I forgot to pick it to my working branch...

Thanks!

> The short log is a slightly different:
> 
> commit f6c3c83db1d939ebdb8c8922748ae647d8126d91
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Date:   Tue May 21 09:00:22 2024 +0900
> 
>      selftests/ftrace: Fix to check required event file
>      
>      The dynevent/test_duplicates.tc test case uses `syscalls/sys_enter_openat`
>      event for defining eprobe on it. Since this `syscalls` events depend on
>      CONFIG_FTRACE_SYSCALLS=y, if it is not set, the test will fail.
>      
>      Add the event file to `required` line so that the test will return
>      `unsupported` result.
>      
>      Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
>      Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>      Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

