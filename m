Return-Path: <linux-kselftest+bounces-4146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298E849BA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF948281782
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6D1CD03;
	Mon,  5 Feb 2024 13:21:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5031C695;
	Mon,  5 Feb 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139286; cv=none; b=udU6sNQwj6KZuSxbBjbLpvvCsSYhkoWoUmU3+y18MGeefrDfRu2dp6+Hb/4bElHsZ+2Qkm6q1/Uhbll130bCZg60FtT0/BM1EccdZ9FjzJdwYkf/AmaO19iPv+hZjGZ2LHT2vvN+0MTqbOLlf7Da2Zl972y3lX1TY8/ngK/Czyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139286; c=relaxed/simple;
	bh=4gaDTV9hKjBY9iK+/Q1Ex4/ry+6hZY5x8sNAFELZeB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn7E5e2UzTAc8tpix1dHsjXkPG6k5y0t07S6lDNcJHoKLx+DIrN7B32S8KwthXZdtEJRz0QGfhfww/G9CBCheS/bm/EjmnAth9A0kllDDqGWbvfno2QXEp0gJDWRl5PuSiX2PqfxNmggL+Buo+QiDZUp93z+0pFlsKEn+/2IcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E670C433F1;
	Mon,  5 Feb 2024 13:21:24 +0000 (UTC)
Date: Mon, 5 Feb 2024 08:21:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Limit length in subsystem-enable
 tests
Message-ID: <20240205082120.4144fb6f@rorschach.local.home>
In-Reply-To: <20240205131233.13686-1-xiangzao@linux.alibaba.com>
References: <20240205131233.13686-1-xiangzao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 21:12:33 +0800
Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> While sched* events being traced and sched* events continuously happen,
> "[xx] event tracing - enable/disable with subsystem level files" would
> never stop as it cat an endless output.
> Select the first 100 lines of output would be enough to judge whether
> there are more than 3 types of sched events.

It's not that it never stops but on some slower systems it does seem to
take forever.

Acked-by: Steven Rostedt (Google) <rostedt@org>

Shuah,

Can you take this through your tree?

Thanks,

-- Steve


> 
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
>  .../selftests/ftrace/test.d/event/subsystem-enable.tc       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> index b1ede6249866..74c1114603a7 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> @@ -18,7 +18,7 @@ echo 'sched:*' > set_event
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -29,7 +29,7 @@ echo 1 > events/sched/enable
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -40,7 +40,7 @@ echo 0 > events/sched/enable
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -ne 0 ]; then
>      fail "any of scheduler events should not be recorded"
>  fi


