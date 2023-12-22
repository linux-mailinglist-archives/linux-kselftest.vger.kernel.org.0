Return-Path: <linux-kselftest+bounces-2330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AC81C2DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C768287A2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA759A50;
	Fri, 22 Dec 2023 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldP2wCiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5751A31;
	Fri, 22 Dec 2023 01:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30DAC433C8;
	Fri, 22 Dec 2023 01:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703209727;
	bh=ln5eRPVANWPndCD+dlWI7Vb1/wfMbPs/UZdRFzTe57E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ldP2wCiRCyrOCpWKfdnwzcBxyooxA6L/KE3mMV84SqbO2gx+02XvzpfrhpjpDG98/
	 RKsfKPuPNUfI5aXp74r/nyimNH1csQSbaSFMH5K2V992d17X8TREWBQuq8phHXgG2e
	 flGBtCtftMEEFHvMFzKGdvaADSlPOaejw6abt1VWetB6RqFZxQgb7pA5RzRIvQAiLs
	 TDkxPfFUbR+pgpRiYhFWIFePj0KvsnlZADe2ndB1UDU+Mzgj3roZwRPAXXCLDba7kz
	 B2mFawayVrQ/StJi8tGWiUVQ+uv6OrHgPM5C1u3vOyjsi9lgDyrrJ+bPT+wadOozDs
	 iuNjGLJgWJLcA==
Date: Fri, 22 Dec 2023 10:48:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-Id: <20231222104841.1d1b306c989070f82c672d89@kernel.org>
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
> 
> I'll try it out to see what fails for 6.5.13. Perhaps there was another bug
> that the stable releases need fixing for?

I found that the failure was my environmental issue.
BTW, for busybox environment, 

+instance="foo-$(mktemp -u XXXXX)"

This doesn't work. it needs XXXXXX (6 times X). And this is
somewhat wrong usage of mktemp because it can not check there is
foo-<random>.
What about change it as

instance="$(mktemp -u foo-XXXXXX)"

?

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

