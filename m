Return-Path: <linux-kselftest+bounces-14969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FF94B148
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575AA2822D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26229145B0B;
	Wed,  7 Aug 2024 20:29:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C01145A07;
	Wed,  7 Aug 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062543; cv=none; b=YZo/thGFbDaoq/maM6rKd+Ip5uBKkohC8wtFkDs+qeo4jSXjZEbDVeVYyoR+3I0FH3z9DVkfhjtSHo+5Wpas4pT7UAv2FtZ3lj38Idlanl6F/C7xmey9q2FXYj0lTaADEUoKdECBl7ODigmnVIVecgPoPkA0jjiOkVWXBNMZMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062543; c=relaxed/simple;
	bh=xAiH54vP8Fo1po3b4KEyuvViFTqrVVqIAg0NTt2VA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0yhDhmkrbo1eKO0j4Wxyf1s381yhetidENfdRJEykcuTTxRwoNbQX0Yqr1TUvvmT08yxxrv+b9PAlBtTtKezby92/iNqrx2c9FTF2YwOdK5VcbdEcn9gMzOv57ik+vNRLg5S4L6rVebOvSAlcmfPSoFNwfQ/C6WFi4vdlMm3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936D0C32781;
	Wed,  7 Aug 2024 20:29:01 +0000 (UTC)
Date: Wed, 7 Aug 2024 16:29:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ali Zahraee <ahzahraee@gmail.com>, Shuah
 Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/selftests: Run the ownership test twice
Message-ID: <20240807162900.32c8e32f@gandalf.local.home>
In-Reply-To: <20240614124151.33ee0dc6@rorschach.local.home>
References: <20240523124541.7dd4cca9@gandalf.local.home>
	<20240614124151.33ee0dc6@rorschach.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 12:41:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> Can you take this through your tree?

Ping!

-- Steve

> 
> -- Steve
> 
> 
> On Thu, 23 May 2024 12:45:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A regression happened where running the ownership test passes on the first
> > iteration but fails running it a second time. This was caught and fixed,
> > but a later change brought it back. The regression was missed because the
> > automated tests only run the tests once per boot.
> > 
> > Change the ownership test to iterate through the tests twice, as this will
> > catch the regression with a single run.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  .../ftrace/test.d/00basic/test_ownership.tc   | 34 +++++++++++--------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > index c45094d1e1d2..71e43a92352a 100644
> > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > @@ -83,32 +83,38 @@ run_tests() {
> >  	done
> >  }
> >  
> > -mount -o remount,"$new_options" .
> > +# Run the tests twice as leftovers can cause issues
> > +for loop in 1 2 ; do
> >  
> > -run_tests
> > +	echo "Running iteration $loop"
> >  
> > -mount -o remount,"$mount_options" .
> > +	mount -o remount,"$new_options" .
> >  
> > -for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> > -	test "$d" $original_group
> > -done
> > +	run_tests
> > +
> > +	mount -o remount,"$mount_options" .
> > +
> > +	for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> > +		test "$d" $original_group
> > +	done
> >  
> >  # check instances as well
> >  
> > -chgrp $other_group instances
> > +	chgrp $other_group instances
> >  
> > -instance="$(mktemp -u test-XXXXXX)"
> > +	instance="$(mktemp -u test-XXXXXX)"
> >  
> > -mkdir instances/$instance
> > +	mkdir instances/$instance
> >  
> > -cd instances/$instance
> > +	cd instances/$instance
> >  
> > -run_tests
> > +	run_tests
> >  
> > -cd ../..
> > +	cd ../..
> >  
> > -rmdir instances/$instance
> > +	rmdir instances/$instance
> >  
> > -chgrp $original_group instances
> > +	chgrp $original_group instances
> > +done
> >  
> >  exit 0  
> 


