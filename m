Return-Path: <linux-kselftest+bounces-46036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D88C71ADF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B54BB289C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B62367CF;
	Thu, 20 Nov 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUvDn1KI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3F41C69;
	Thu, 20 Nov 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601929; cv=none; b=R6te1bwdZw0QpJc4IRdsdqHflfW20b5ofelHlaNjPSNL6xxv4nqQ56xe6ixDS6hzBkU+ZYa46AHRsQlB6Zo2PJNc1raYt0SKmZWCAvj2GMMl0dRsEazwVrLAxuS6drZtedc/ALCTUkQRxBxojEI8js8aqz1BUhYUVOAuRbjw4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601929; c=relaxed/simple;
	bh=hYUO0uaO6Gz6S28NBPbmgO3vosV56mqXCFJrPXnvcks=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gNYtEX+/t7Fje+qr1M/qVh/eZJ5rlrsYH5jE0KO3J2BV/2vLSPIjPLPxgO+CdUsigsUQ3+MqJrNEX6wVmCdupSQOa8JbzHth8Zf4eJBK5SlkNAEM/P1ZqoYyrWjHvoI0qrOjF4YUtWDnLmBuzPKtiPUCWWHJ6TCBjWB+R3fvn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUvDn1KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA354C4CEF5;
	Thu, 20 Nov 2025 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763601929;
	bh=hYUO0uaO6Gz6S28NBPbmgO3vosV56mqXCFJrPXnvcks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUvDn1KIuVcI0sn2ydbW7Mj4p1/27yx44LBO9SO/JI9WEKWJPNXwHhvlOuJqXtAH+
	 4vUQeEt6kKM7oBZmGXo7xnhTmJ7iOJ9j9UKACbE1FY0Eqdv1ysXPIG9wdh4V5RNBq9
	 8V620gCWvP5ejUoh8Kyu1f39rr2/7NNSaIY/CTZQYL4ga0bsYn8OyffjEI81/QIJMR
	 //wt6ffYpHJhX24A55REcgaB9A9YUGWQvxYW7hVoo05/ACO4mNpBCqK/hehha9VDYT
	 Cm90alNUGGYvVREo7tFCuad+lmNePUIRBei/uIlPA3tuPYJofe9hbA1YuADIqlbmaC
	 YqfBSKDupxlNw==
Date: Thu, 20 Nov 2025 10:25:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
Message-Id: <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
In-Reply-To: <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
	<f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
	<20251119170611.6eff8df7@gandalf.local.home>
	<b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 15:56:57 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 11/19/25 15:06, Steven Rostedt wrote:
> > On Wed, 19 Nov 2025 14:44:22 -0700
> > Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> >> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
> >>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>>
> >>> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
> >>> enable tprobe event") caused regression bug and tprobe did not work.
> >>> To prevent similar problems, add a testcase which enables/disables a
> >>> tprobe and check the results.
> >>>
> >>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>
> >> Steve, do you want me to take this through my tree?
> > 
> > Yes please. Masami's an official maintainer and mostly handles all things
> > "probe" related. This is his domain ;-)
> > 
> > Thanks,
> > 
> > -- Steve
> Applied to linux-kselftest next for Linux 6.19-rc1.

Thanks Shuah! This and other regression fixes is better to go
through selftests tree because those are checking existing
features. Maybe better to add [PATCH -selftests] or something
like that?

Thank you,

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

