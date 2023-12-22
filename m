Return-Path: <linux-kselftest+bounces-2347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E281C3C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 05:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144EB1C24D13
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F61C06;
	Fri, 22 Dec 2023 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyecIRAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8998F40;
	Fri, 22 Dec 2023 04:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE59C433C8;
	Fri, 22 Dec 2023 04:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703218303;
	bh=cOh3HqqN/2o8/n2h2oZTCxQJgNUcu+nvKLVUPxkxR9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fyecIRAHClOG27LegLH1Ex/LySYEE4G/pZSZt0zXQ5TAJKrFh4K5rRCdGqQTHDHH2
	 qOs3zAyZIbZnLRwS7Ib8BUURWdnbGay4eijigoL4dGFYxqQ9DFoWRIXGSUvUFWFbml
	 KskgJftD3Bs5gbU69H8lsP2qHQqgbfqqRziGc2VcSlsDslo/2jA5U7fvjLwz9YpfRE
	 lUxqJ8A6KSoRyBtupp8XDRhlttKeWAlppLhH+TXjuCsE84u+8hUUx2bVeuH4Q0vTks
	 RUAiuXW+xVPvr3670Ie8WAlrKjRLdF0Ro0B6txKcYr9oDSQiQt1rdMXDCvVDxcrRnY
	 wwXGnLw2Xr4jA==
Date: Fri, 22 Dec 2023 13:11:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-Id: <20231222131139.26fe6dea8524016d4f3251a4@kernel.org>
In-Reply-To: <20231221210757.112aa4e8@gandalf.local.home>
References: <20231221194516.53e1ee43@gandalf.local.home>
	<20231222102148.2aa3863d7c11f3928549335a@kernel.org>
	<20231221202813.38ef5664@gandalf.local.home>
	<20231222104841.1d1b306c989070f82c672d89@kernel.org>
	<20231222105200.e73d58640d8be7da89331deb@kernel.org>
	<20231221210757.112aa4e8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 21:07:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 Dec 2023 10:52:00 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 22 Dec 2023 10:48:41 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > And I confirmed that this test passed on v6.5.13 with that change.
> > 
> 
> I just ran it on 6.5.13 and it took *forever*!
> 
> But I do have a bit of debug, and before 6.6 creating the instance and
> deleting it required creating and deleting thousands of inodes and dentries.

Hmm, it may depends on the machine. I could ran it (on 64 vcpu VM)

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

