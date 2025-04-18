Return-Path: <linux-kselftest+bounces-31125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F0A936F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332241B65C58
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907C26FA7D;
	Fri, 18 Apr 2025 12:23:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD71A3168;
	Fri, 18 Apr 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979024; cv=none; b=KOUDU7HkEFlV0jxbA27B08+gy1UaRwKCou5roMGbfy9/KybynDSv7O+Xp13Q3HihcbZAIJ/ShtjhcRg9qcdARp5BEEiAHGb4mzBgUKuj2QjH1Saj5JiyQ70LOqo11slzvasp4m5M2ie8c0W1CyEflCHzUHCN+m5d1ddvyAZP+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979024; c=relaxed/simple;
	bh=Bcyh1fZ7aFYee5ogIECPyOVrc3MmpGyXQeP5/o6lJ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJWUPWqkDu9Ox0Ph/wULsuDaGPqvpXLlWKr/iGB8nSwIY6+8H/AWsXbM8SPWwohIJgfO+D1Uyh1uL6X3gucDxKOkt4BaexwEuhAEMDnD2YnlVGxdI42S1hNfuCAHOrQK3uQ0c0v19KYRPp24RObTMBlTNPaz5TFlU3Z2srxfn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3665AC4CEE2;
	Fri, 18 Apr 2025 12:23:43 +0000 (UTC)
Date: Fri, 18 Apr 2025 08:25:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing: selftests: Add testing a user string to
 filters
Message-ID: <20250418082523.5040e03c@gandalf.local.home>
In-Reply-To: <20250418161404.04771abaeafec2dce3413247@kernel.org>
References: <20250417223323.3edb4f6c@batman.local.home>
	<20250418161404.04771abaeafec2dce3413247@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 16:14:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +if [ -f events/syscalls/sys_enter_openat/filter ]; then
> > +	echo "filename.ustring ~ \"*test.d*\"" > events/syscalls/sys_enter_openat/filter  
> 
> I think it is better to use a $TMPDIR for the test script,
> instead of reusing the $TEST_DIR. Since $TMPDIR has been
> introduced to be used for this purpose.
> 
> DIRNAME=`basename $TMPDIR`
> 
> echo "filename.ustring ~ \"\*$DIRNAME\*\"" > events/syscalls/sys_enter_openat/filter
> 
> > +	echo 1 > events/syscalls/sys_enter_openat/enable
> > +	echo 1 > tracing_on
> > +	ls /bin/sh
> > +	nocnt=`grep openat trace | wc -l`
> > +	ls $TEST_DIR  
> 
> and `ls $TMPDIR` ?
> 
> Does that work?
> 

Yeah I can do that instead.

My actual fear is that 'ls' may one day not call openat and the test fails.
But if that happens we can always update the test.

Thanks,

-- Steve


