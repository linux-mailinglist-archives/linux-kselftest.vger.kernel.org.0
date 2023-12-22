Return-Path: <linux-kselftest+bounces-2338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B881C309
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A1B21CA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4DA50;
	Fri, 22 Dec 2023 02:15:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41894680;
	Fri, 22 Dec 2023 02:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6F2C433C7;
	Fri, 22 Dec 2023 02:15:00 +0000 (UTC)
Date: Thu, 21 Dec 2023 21:16:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux selftests
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3] tracing/selftests: Add ownership modification tests
 for eventfs
Message-ID: <20231221211604.5062f4e8@gandalf.local.home>
In-Reply-To: <20231221211229.13398ef3@gandalf.local.home>
References: <20231221211229.13398ef3@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Shuah,

This patch has no dependencies. You can take it through your tree for the
next merge window if you want. If not, I can take it.

Thanks,

-- Steve


On Thu, 21 Dec 2023 21:12:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As there were bugs found with the ownership of eventfs dynamic file
> creation. Add a test to test it.
> 
> It will remount tracefs with a different gid and check the ownership of
> the eventfs directory, as well as the system and event directories. It
> will also check the event file directories.
> 
> It then does a chgrp on each of these as well to see if they all get
> updated as expected.
> 
> Then it remounts the tracefs file system back to the original group and
> makes sure that all the updated files and directories were reset back to
> the original ownership.
> 
> It does the same for instances that change the ownership of he instance
> directory.
> 
> Note, because the uid is not reset by a remount, it is tested for every
> file by switching it to a new owner and then back again.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>

