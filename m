Return-Path: <linux-kselftest+bounces-2169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B35817C4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 21:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF06B20A01
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4173468;
	Mon, 18 Dec 2023 20:52:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D772057;
	Mon, 18 Dec 2023 20:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5879EC433C7;
	Mon, 18 Dec 2023 20:52:30 +0000 (UTC)
Date: Mon, 18 Dec 2023 15:53:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4] tracing/selftests: Add test to test the trace_marker
Message-ID: <20231218155326.009e3d74@gandalf.local.home>
In-Reply-To: <9978c0db-ec37-4d99-847b-86098bb0ba98@linuxfoundation.org>
References: <20231213111527.6a4c9b58@gandalf.local.home>
	<20231214075926.e3969c8746068953fe910ed0@kernel.org>
	<9978c0db-ec37-4d99-847b-86098bb0ba98@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 13:49:22 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/13/23 15:59, Masami Hiramatsu (Google) wrote:
> > On Wed, 13 Dec 2023 11:15:27 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> >> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >>
> >> Add a test that writes longs strings, some over the size of the sub buffer
> >> and make sure that the entire content is there.  
> > 
> > This looks good to me. and tested.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >   
> 
> Assuming this is going through tracing:

Yeah, I'll pull it through mine, as it's being used to make sure the code
I'm working on still works.

> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I'll add that.

-- Steve

