Return-Path: <linux-kselftest+bounces-22802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C79E30B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 02:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790AEB21E4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144E523A;
	Wed,  4 Dec 2024 01:20:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB76FC3;
	Wed,  4 Dec 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275208; cv=none; b=lkC8JplPKlVxs7v+qhFSmU6WPFMBBRTwo+xX+Dc5lZBnPRDNkgfFK4suK5BqTnRaVtuPeMVDzA3rlZe1+cJhV3SnZ6kKq+wbbjNjzQ39oRjL4EJt/FKpbHtWPzsWqKI7Zz0XoJKZfeZcvQaPQxIrZiqMvNeVXdaTuXbbKd2WSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275208; c=relaxed/simple;
	bh=OFHHksg4BEg9aSBzLuTbIxjtWmZ3Pa2TRSNwyVKduTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULUP5PFSkjHc72aaJDwYEe1OSbGZDfec4yIdvHVi0txSKZKmjhja8gt6rJZ7JEtff4yCzOZuU/5IAir5OWJy6FiZJGjguXhuUOt7McOFSWt5iNnb2BSfLfpUYqJxjgyBZz50hRQLoyyNeP05oY2xepiDdBBIiMDlT5Zq0GJmBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0817C4CEDC;
	Wed,  4 Dec 2024 01:20:06 +0000 (UTC)
Date: Tue, 3 Dec 2024 20:20:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Naveen N. Rao" <naveen@kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
Message-ID: <20241203202008.1f30a266@gandalf.local.home>
In-Reply-To: <fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
	<20241202144111.75d1bb3b@gandalf.local.home>
	<fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 18:01:06 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/2/24 12:41, Steven Rostedt wrote:
> > On Sat, 30 Nov 2024 01:56:21 +0530
> > Hari Bathini <hbathini@linux.ibm.com> wrote:
> >   
> >> In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
> >> `vfs_read+X` except function entry offset (0) fits the criterion,
> >> even if that offset is not at instruction boundary, as the parser
> >> comes before probing. But with "ENDBR64" instruction on x86, offset
> >> 4 is treated as function entry. So, X can't be 4 as well. Thus, 8
> >> was used as offset for the test case. On 64-bit powerpc though, any
> >> offset <= 16 can be considered function entry depending on build
> >> configuration (see arch_kprobe_on_func_entry() for implementation
> >> details). So, use `vfs_read+20` to accommodate that scenario too.
> >>
> >> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>  
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Shuah,
> > 
> > Can you take this through your tree?  
> 
> Yes I can take it. I do have question about whether this is
> a fix - sounds like it is from the change log.
> 
> Clearly stating that it is a fix will help so it can be picked
> up for stables.

I would say it's a fix, as the test currently fails in certain scenarios
for powerpc.

You can add:

Fixes: 4231f30fcc34a ("selftests/ftrace: Add BTF arguments test cases")

-- Steve

