Return-Path: <linux-kselftest+bounces-5415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD6862D6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Feb 2024 23:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62D31F215DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Feb 2024 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811C1BC27;
	Sun, 25 Feb 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3HkDmtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5018B1B;
	Sun, 25 Feb 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708900265; cv=none; b=isytdxBDwHEQqFt13EZaISPUzR+OAI+brEat4ztG9KrAhaac/mHUwyynpXN0VoGqZgQK3iWmUS63pbvwNyb5Z2sOBRKkXSTklnH2U1HDzlvLnBieE8eHF2t1IonQlTH4wNZH8Ag0DqtqsycQZRYaPpuZJPIRzXKda8v0svLMtvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708900265; c=relaxed/simple;
	bh=O4RTJudC8dhdXwVBJwoOhnqRe04W05XJHkcn8rJWNQ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mYzYaaOzuniag+1JjD5d8xnynj0lxrLgcBJ0O0jEO/d7FOhH4c3BN4JgafKDo0c2TQUMM1uJq7bltZiIBzKk4e3sSQ3DJFPqPzF3KV5Jic+6IRBz1KvUwe6NsHvttRY79ofbHSeGP7TfzUmJd3IGYkBxgNOEJl7SRRuFdEMgxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3HkDmtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E205C433C7;
	Sun, 25 Feb 2024 22:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708900264;
	bh=O4RTJudC8dhdXwVBJwoOhnqRe04W05XJHkcn8rJWNQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3HkDmtgDxqylZDyENqH3z+Xa6NVEcHQ50hLSBnTmV2fdif/el1XHPPbZobaKKizk
	 SkL7qII/cWlmo29ZsGFkluc9tu/m1/Hqu1nDqJ0Q1eBSPXEmJrK+/iB7XVBfobY4fG
	 ETHZDeV51hyx0tacQf+kVlDHpgr6ACBxN/2Ar8wvzjsCxIZ//2+p5MPvotjUMdRcK/
	 Zy4qjv6fpaUEg5bQsL5hhhYamF5iitZQZVWWf09sylMFSOmhGfd/CqKFPzNcmiWHDm
	 NDoMBGc/Jeg2aOXgQXaADgk6FIfsAlcNQwAJoY3dM/9nVdf0D86TPz6fUp42JeszR0
	 RgnA4vpyX7/Ww==
Date: Mon, 26 Feb 2024 07:30:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <skhan@linuxfoundation.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Limit length in subsystem-enable
 tests
Message-Id: <20240226073059.ad066900241022e704f72955@kernel.org>
In-Reply-To: <7420f9b5-2283-419f-8c6b-705f8b0c53f6@linux.alibaba.com>
References: <20240205131233.13686-1-xiangzao@linux.alibaba.com>
	<20240205082120.4144fb6f@rorschach.local.home>
	<7420f9b5-2283-419f-8c6b-705f8b0c53f6@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 20:14:56 +0800
Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> 
> 
> On 2024/2/5 21:21, Steven Rostedt wrote:
> > On Mon,  5 Feb 2024 21:12:33 +0800
> > Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
> > 
> >> While sched* events being traced and sched* events continuously happen,
> >> "[xx] event tracing - enable/disable with subsystem level files" would
> >> never stop as it cat an endless output.
> >> Select the first 100 lines of output would be enough to judge whether
> >> there are more than 3 types of sched events.
> > 
> > It's not that it never stops but on some slower systems it does seem to
> > take forever.
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@org>
> > 
> > Shuah,
> > 
> > Can you take this through your tree?
> > 
> > Thanks,
> > 
> > -- Steve
> > 
> 
> Thanks for your ack but I found that I missed the 2nd and 3rd 'trace' 
> after 'head -n 100' in code. Should I resend a new patch to fix this and 
> meanwhile modify commit messages according to Steve's words?

Yeah, please fix that and resend. This also should have Cc: stable with Fixed: tag.

Thank you,

> 
> > 
> >>
> >> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> >> ---
> >>   .../selftests/ftrace/test.d/event/subsystem-enable.tc       | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> >> index b1ede6249866..74c1114603a7 100644
> >> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> >> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> >> @@ -18,7 +18,7 @@ echo 'sched:*' > set_event
> >>   
> >>   yield
> >>   
> >> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >>   if [ $count -lt 3 ]; then
> >>       fail "at least fork, exec and exit events should be recorded"
> >>   fi
> >> @@ -29,7 +29,7 @@ echo 1 > events/sched/enable
> >>   
> >>   yield
> >>   
> >> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >>   if [ $count -lt 3 ]; then
> >>       fail "at least fork, exec and exit events should be recorded"
> >>   fi
> >> @@ -40,7 +40,7 @@ echo 0 > events/sched/enable
> >>   
> >>   yield
> >>   
> >> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> >>   if [ $count -ne 0 ]; then
> >>       fail "any of scheduler events should not be recorded"
> >>   fi


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

