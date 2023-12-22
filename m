Return-Path: <linux-kselftest+bounces-2336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316E81C2FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C099B1F24955
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF2A49;
	Fri, 22 Dec 2023 02:06:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE3ECE;
	Fri, 22 Dec 2023 02:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72D5C433C8;
	Fri, 22 Dec 2023 02:06:53 +0000 (UTC)
Date: Thu, 21 Dec 2023 21:07:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-ID: <20231221210757.112aa4e8@gandalf.local.home>
In-Reply-To: <20231222105200.e73d58640d8be7da89331deb@kernel.org>
References: <20231221194516.53e1ee43@gandalf.local.home>
	<20231222102148.2aa3863d7c11f3928549335a@kernel.org>
	<20231221202813.38ef5664@gandalf.local.home>
	<20231222104841.1d1b306c989070f82c672d89@kernel.org>
	<20231222105200.e73d58640d8be7da89331deb@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 10:52:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 22 Dec 2023 10:48:41 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> And I confirmed that this test passed on v6.5.13 with that change.
> 

I just ran it on 6.5.13 and it took *forever*!

But I do have a bit of debug, and before 6.6 creating the instance and
deleting it required creating and deleting thousands of inodes and dentries.

-- Steve

