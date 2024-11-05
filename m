Return-Path: <linux-kselftest+bounces-21448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED50E9BC81B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F20BB21FCB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5119993D;
	Tue,  5 Nov 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDOSZjmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017513633F;
	Tue,  5 Nov 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795866; cv=none; b=SBciD8mHP9OJkSnoe5EW7sZd1wJ+DgB8x/V9HAciL9KGtyMFAeILJREL5kN7kniZ4Qiu3DtR4KgiyqY46dq6BUOiqCpAR8JrZS7MiXnJkd41kcmLjKCqvPKmzWRp6ME+JDVmk5UFgutiKb+ramvv/kgjft8oRBBztXZOPGmwZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795866; c=relaxed/simple;
	bh=1VWejZRpiUp2jc8Rw/SnJEMp+oAMfk5UApT35ACHDlY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fEtITTcR/ytdI8YJiq66dTHog9KyQMpPLnw47KQobC9e5I6FG9f361w3Y4WDgGVyPlMAbOT6PW2XXnka9Jw0Xei7D+DrBTyacTriQqBfQjR6glhgtkTriqk5J6p9nBnsDUvRxHYaiIuuM9b9P4r5c4zuGxzi09jOpoqZ20AjnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDOSZjmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CA8C4CECF;
	Tue,  5 Nov 2024 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730795866;
	bh=1VWejZRpiUp2jc8Rw/SnJEMp+oAMfk5UApT35ACHDlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDOSZjmWLsp8fibcytie6dbuQqmukvL7/6vlUPnMPiRGsdfIeO5pjg57MyQlsqJOv
	 Ujq2Rs5s21VqWJN3BDGTsCYAozy63rgkR4zTpqt8BbgFphB9cBdIqs2ibXw0SrxU73
	 0qIErEpKPqfcceoua6DpSo3R1d7zcknYkl2A5ca5bOpQW/0Cx90HRSoUylNVzJzfbY
	 mkUOw0UL5psPYluHoVa2BnNwLiF0uz4aqOi2FUxu81FZs7qJftl2+mzVQulzYa6za6
	 xfiitHB1tdQc+SYSEn838k8p+YNrKEZI0B+TQtwoIQc7RR7RSA4cJQBSDr/0yd4HU1
	 Tk4L0JoMP3LJg==
Date: Tue, 5 Nov 2024 17:37:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Naveen N. Rao"
 <naveen@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
Message-Id: <20241105173743.a5ae78484e850448f1d20526@kernel.org>
In-Reply-To: <d10f4a96-944f-42c4-9886-05dfe831e8fd@linux.ibm.com>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
	<20241103135758.5a5f8f0870a139ab1a5bc7b8@kernel.org>
	<d10f4a96-944f-42c4-9886-05dfe831e8fd@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 15:02:12 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> 
> 
> On 03/11/24 10:27 am, Masami Hiramatsu (Google) wrote:
> > On Sat,  2 Nov 2024 00:49:25 +0530
> > Hari Bathini <hbathini@linux.ibm.com> wrote:
> > 
> >> For ppc64le, depending on the kernel configuration used, offset 16
> >> from function start address can also be considered function entry.
> >> Update the test case to accommodate such configurations.
> >>
> > 
> > Hi Hari, so have you met any error on this test case?
> 
> Hi Masami,
> 
> vfs_read+8 is function entry on powerpc. So, the test case bails out at:
>    "check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS"
> 
> as it allows setting kprobe "vfs_read+8 $arg*"
> 
> > Can you share the error result too?
> 
> 
> End of the log file for reference:
> 
> "
> Test command: p vfs_read $arg* $arg*
> [2661828.483436] trace_kprobe: error: $arg* can be used only once in the 
> parameters
>    Command: p vfs_read $arg* $arg*
>                              ^
> Test command: p vfs_read+8 $arg*
> "

Ah, OK. so it should fail but passed. (and test failure)

Thank you,

> 
> Thanks
> Hari
> 
> > 
> > Thank you,
> > 
> >> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> >> ---
> >>   .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> >> index a16c6a6f6055..c03b94cc5784 100644
> >> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> >> @@ -111,7 +111,11 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
> >>   if !grep -q 'kernel return probes support:' README; then
> >>   check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
> >>   fi
> >> +if [ "$(uname -m)" = "ppc64le" ]; then
> >> +check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
> >> +else
> >>   check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
> >> +fi
> >>   check_error 'p vfs_read ^hoge'			# NO_BTFARG
> >>   check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
> >>   check_error 'r kfree ^$retval'			# NO_RETVAL
> >> -- 
> >> 2.47.0
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

