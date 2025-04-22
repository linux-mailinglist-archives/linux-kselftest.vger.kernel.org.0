Return-Path: <linux-kselftest+bounces-31341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E80A9743C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D1B440061
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A162980B6;
	Tue, 22 Apr 2025 18:06:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09F2973DC;
	Tue, 22 Apr 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345199; cv=none; b=KVVbdlj+XmizfeGNCMygko6IlVe7xmU6i3RAUU2BbVFt10pbMpGhoGA7YL9+pu1hpbgCJeU2+V9HYqe8YP4appy4jytD0QopvXAKqJ9sb9cHjUJ9LbXklb0Rr0aiN6J0PjZGTtRhtetRidzIa3kzG7FjC0SeY6+67NxsrH/vISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345199; c=relaxed/simple;
	bh=Ks6BvRNCvdIWlPmRHnoxO26WywxRVyCnrYdtD5PfjbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY5rDm7FfqiA6Bd8cBmmVG9mwW3XLbAHc+LHWnP74wUlg7rOTZXKv6fYNuSoZyZNqRQ9bt4m2lOdvYJ1Sj7sUPlVkbAsMvC0GiEoVBOtYg7j9W3ndTZxPyI9Z2lczOW3cFhzuz2Evokjbpj67UYM82VmV5LQp2kUqHuRGXSEC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF293C4CEE9;
	Tue, 22 Apr 2025 18:06:37 +0000 (UTC)
Date: Tue, 22 Apr 2025 14:08:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] tracing: selftests: Add testing a user string to
 filters
Message-ID: <20250422140828.4555f4d1@gandalf.local.home>
In-Reply-To: <de2a5e52-8061-4907-bd48-0d6d28b83b75@linuxfoundation.org>
References: <20250418101208.38dc81f5@gandalf.local.home>
	<de2a5e52-8061-4907-bd48-0d6d28b83b75@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 10:59:03 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > Link: https://lore.kernel.org/linux-trace-kernel/20250417183003.505835fb@gandalf.local.home/
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v1: https://lore.kernel.org/20250417223323.3edb4f6c@batman.local.home
> > 
> > - Use $TMPDIR instead of $TESTDIR as test file (Masami Hiramatsu)
> >   
> 
> Steve, Masami
> 
> Do you want me to take this for rc4?

Hi Shuah,

Sorry, I didn't copy the comment from v1 to v2, but it still applies:

    Shuah, I'm Cc'ing you on this for your information, but I'll take it
    through my tree as it will be attached with the fix, as it will fail
    without it.

It's already been accepted.

Thanks,

-- Steve

