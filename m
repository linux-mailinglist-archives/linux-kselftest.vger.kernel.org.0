Return-Path: <linux-kselftest+bounces-2329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2481C2BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A0A286D3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63530A41;
	Fri, 22 Dec 2023 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA7mTsZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42410A23;
	Fri, 22 Dec 2023 01:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3EC433C8;
	Fri, 22 Dec 2023 01:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703208713;
	bh=x+IVEprNBc950G24JG4TYU2l9WUQyvsN8NnHhGl5PPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MA7mTsZJa670OodOhYprwJLJrGjOOaDin69eftgzxDuhvXSUPfasag7SN/AoT4aJ3
	 5eMITg4XqUiH+Db5fWARL6XyxC1huQ96AP+HK4/zOw2V1wX1usMG27mzxs1w2T4fNE
	 rf4xuiOyP2TcZd2XRvQTDYlDTRBzynpv2hLRMaPk2QUiHJYwVExaMfwyzKjYvEHG04
	 yn6NRVtNIbU6YPgesMhBjZY5jBVMIjXxjBUQP0uWzmK5he8HJso34j8tMvX/pmRwFj
	 pan+LW0W74wLYYb17TJH77Vknf6NOXhpHd7upk3yvaId/s+dwAmskLUcTy0zpi5RYB
	 +MKUv6dIiFyEg==
Date: Fri, 22 Dec 2023 10:31:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-Id: <20231222103148.2f31d91f24134543c0aba382@kernel.org>
In-Reply-To: <20231221202813.38ef5664@gandalf.local.home>
References: <20231221194516.53e1ee43@gandalf.local.home>
	<20231222102148.2aa3863d7c11f3928549335a@kernel.org>
	<20231221202813.38ef5664@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 20:28:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 Dec 2023 10:21:48 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > The testcase itself is OK but is there any way to identify the system
> > supports eventfs or not? I ran this test on v6.5.13 for checking then
> > it failed. We may need to skip (unsupported) this test for such case.
> 
> Hmm, honestly, it should technically work on all past versions.

Ah, sorry. It was my mistake. I need to make /etc/group,passwd files in my test environment.
Let me try it again.

> 
> I'll try it out to see what fails for 6.5.13. Perhaps there was another bug
> that the stable releases need fixing for?
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

