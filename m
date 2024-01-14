Return-Path: <linux-kselftest+bounces-2952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE682D169
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67FF281CF3
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E03D63;
	Sun, 14 Jan 2024 16:20:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523003C36;
	Sun, 14 Jan 2024 16:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE04C433C7;
	Sun, 14 Jan 2024 16:20:25 +0000 (UTC)
Date: Sun, 14 Jan 2024 11:20:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
Message-ID: <20240114112014.7503163f@rorschach.local.home>
In-Reply-To: <20240114231711.0959180366d8823dd8543241@kernel.org>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-6-vdonnefort@google.com>
	<20240113223946.9c463c5a4787dc0261789e65@kernel.org>
	<20240114231711.0959180366d8823dd8543241@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jan 2024 23:17:11 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > Looks good to me and tested.
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 
> Sorry, I should cancel these. I found this test did not pass if I set
> the function tracer on.
> 
> / # cd /sys/kernel/tracing/
> /sys/kernel/tracing # echo function > current_tracer 
> /sys/kernel/tracing # /mnt/map_test 
> TAP version 13
> 1..2
> # Starting 2 tests from 2 test cases.
> #  RUN           map.subbuf_size_4k.meta_page_check ...
> # map_test.c:174:meta_page_check:Expected self->meta->entries (15293) == 16 (16)
> # meta_page_check: Test terminated by assertion
> #          FAIL  map.subbuf_size_4k.meta_page_check
> not ok 1 map.subbuf_size_4k.meta_page_check
> #  RUN           map.subbuf_size_8k.meta_page_check ...
> # map_test.c:174:meta_page_check:Expected self->meta->entries (15270) == 16 (16)
> # meta_page_check: Test terminated by assertion
> #          FAIL  map.subbuf_size_8k.meta_page_check
> not ok 2 map.subbuf_size_8k.meta_page_check
> # FAILED: 0 / 2 tests passed.
> # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> Does this depend on "nop" tracer?

Yes.

> > > +
> > > +static int tracefs_reset(void)
> > > +{
> > > +	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
> > > +		return -1;
> > > +	if (__tracefs_write_int(TRACEFS_ROOT"/trace", 0))
> > > +		return -1;
> > > +	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
> > > +		return -1;

Looks like the below is needed:

	if (__traces_write(TRACEFS_ROOT"/current_tracer", "nop"))
		return -1;

> > > +
> > > +	return 0;
> > > +}
> > > +

-- Steve

