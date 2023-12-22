Return-Path: <linux-kselftest+bounces-2331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51381C2E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780EA287BEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7CBA41;
	Fri, 22 Dec 2023 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJhjDv77"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A517C3;
	Fri, 22 Dec 2023 01:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2B0C433C7;
	Fri, 22 Dec 2023 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703209925;
	bh=kecEF49PU/2T4AgVwODE9w485i2hBXT2DPwqPKsasVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qJhjDv77xisDgkhIdoE3eP1gEF7H3en2W/IapHMyN5tYVdtgyf1lO1r8jjowKsTJQ
	 lPfcqS3LYzRDbS/JBCgbPQpsEnAkHrjhSHFzyhLZB8MyOrgRWPe/ezGj9CPCLUwqpJ
	 QJmO7tUdR2OhWm3+PBvY1sUNr37p5kugLwu4hN9B4OG3OcJVpuakGAIXUn+WnTwdxi
	 pOXqlrzNAKi4TqQwhlJoKpeITYikK4XJZBnHVE2kGbedlDGeDySm4v3TLRy9rMWfJs
	 cE7O7pQpmrGRErvroKk/6PocYFGWdca8Im/orUpIJSQMnEcs4dWCiogSFgbbGyc24B
	 7GlqczGI7YnBA==
Date: Fri, 22 Dec 2023 10:52:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-Id: <20231222105200.e73d58640d8be7da89331deb@kernel.org>
In-Reply-To: <20231222104841.1d1b306c989070f82c672d89@kernel.org>
References: <20231221194516.53e1ee43@gandalf.local.home>
	<20231222102148.2aa3863d7c11f3928549335a@kernel.org>
	<20231221202813.38ef5664@gandalf.local.home>
	<20231222104841.1d1b306c989070f82c672d89@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 10:48:41 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 21 Dec 2023 20:28:13 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 22 Dec 2023 10:21:48 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > The testcase itself is OK but is there any way to identify the system
> > > supports eventfs or not? I ran this test on v6.5.13 for checking then
> > > it failed. We may need to skip (unsupported) this test for such case.
> > 
> > Hmm, honestly, it should technically work on all past versions.
> > 
> > I'll try it out to see what fails for 6.5.13. Perhaps there was another bug
> > that the stable releases need fixing for?
> 
> I found that the failure was my environmental issue.
> BTW, for busybox environment, 
> 
> +instance="foo-$(mktemp -u XXXXX)"
> 
> This doesn't work. it needs XXXXXX (6 times X). And this is
> somewhat wrong usage of mktemp because it can not check there is
> foo-<random>.
> What about change it as
> 
> instance="$(mktemp -u foo-XXXXXX)"
> 
> ?

And I confirmed that this test passed on v6.5.13 with that change.

Thank you,

> 
> Thanks,
> 
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

