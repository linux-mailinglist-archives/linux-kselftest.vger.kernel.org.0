Return-Path: <linux-kselftest+bounces-5603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE986C1A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 08:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0D91F24586
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498FE44C63;
	Thu, 29 Feb 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUGlU738"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14855446B8;
	Thu, 29 Feb 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190805; cv=none; b=p6lmd6WfsVkv8V8EhFuiCZd4qyXAR9UR4exEcOJIS9OrB55CBMVN0Zd1KbczT3HszLEhG+os1jT604Q/naEdnncUtK6DZVVPkad5jsTjHyLFe+4ll5abluIfQXC/hfHYiTZza8l/OkKQAe0pVhqcEWuXE6phoR7pSPgtWxahpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190805; c=relaxed/simple;
	bh=sTFRZabajf/krYk3PM4o4UwGsA4jCPH/kYX/YIBaFFQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rrou+qyt/mZB5i6rY5HjB2GFYmu6UMU3/LcpUhAgwEd4c9Zu4+zUl8aykqOr0l00V2QjOaY1o5AISgPbM5x+zONjMpQMkG6puRABdnaUn6RCS1g77m8sWIoVMsmshvVR9GH24SpsNrEPe0V7V3VsvjdV2CwDpeazsjhwQbiiw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUGlU738; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98225C433F1;
	Thu, 29 Feb 2024 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709190804;
	bh=sTFRZabajf/krYk3PM4o4UwGsA4jCPH/kYX/YIBaFFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUGlU738hUpRVx01d84rqAhOzR10pyvcWXzBPl3tO/bB0Ve/kdCrehO4Nvx7CNknc
	 zrpXNjLeKSA8R10DDUlU9Euuer0LPnly3RInbJbxAd3H7CTMDjQUXxjB6PzSbM64UQ
	 94U86xoToN7HwCt8P917HtYwhQdXb1ENvc6Dj5pdtv/I0KC2QZfhVqYj8HyVtbBHtI
	 L40MwM5UeB/+WMvCHr3E7OZ7koK23UXGBLX/alScaAmG5kFCKjKboruwtYlov6xQOa
	 diSK0jIl+0u04MeA5uel3UHKZA8Cz6573rDBfoiZcAj0nZlS/+zZKnm1jFzoJffcKA
	 tw+pk4LjuB1yg==
Date: Thu, 29 Feb 2024 16:13:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-Id: <20240229161320.978190f42dcc1a521c192e7d@kernel.org>
In-Reply-To: <20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
	<20240229145139.a215085c44add62302463312@kernel.org>
	<20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 15:38:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, this seems arch_rethook_trampoline caused the issue.
> 
> And curiously, it depends on the number of stored data.
> 
> OK:
> /sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3' >> dynamic_events 
> /sys/kernel/tracing # echo 1 > events/fprobes/enable 
> 
> NG:
> /sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3 $arg4' >> dynamic_events 
> /sys/kernel/tracing # echo 1 > events/fprobes/enable 
> 
> I also confirmed that on 'vfs_write' caused the same result. 3 arguments(24 bytes) is OK,
> but 4 arguments (32bytes) is NG.

And this may be the fprobe bug. kretprobe events doesn't show this issue.

OK:
/sys/kernel/tracing # echo 'r vfs_read $arg*' >> kprobe_events 
/sys/kernel/tracing # echo 1 > events/kprobes/enable 

But this is strange because both uses same rethook...

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

