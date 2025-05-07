Return-Path: <linux-kselftest+bounces-32601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F1AAEC26
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F6E188C683
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14EE28E56F;
	Wed,  7 May 2025 19:26:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6D28D846;
	Wed,  7 May 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646004; cv=none; b=H2WQIOobvuPBBk5dtvPmam8DH+3J6aSGdnISJeEh/RZCT9ze6LfggcMAqTk9Q0Q0a84CzOyxD4eVcVVOIbCnVZAKUzvBDS7ff9TVVdcDPhF0dGkChIFLMSTkKDGDp+TBkK1Kfn64tnnhZgqDCybC89bgUeaTZl7k9k4r5ClVvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646004; c=relaxed/simple;
	bh=y6iGwsGU9RA/MktTdMq8U8TsMT9apZrCokqE7QsRSDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmykfgpaRBpxXiRiQMlrabsusy6LOedIjjTu+BNRLo5fF8cd0sD/CXz57EL0d58NNA9SLudFIRBkpUDbLNbKuDSoTM1oc9tmg7CC4REPXSxpENKSMxbo5A7c0rDeSQ8mnkTX1jyo7gqmP4M7JMN6dGVNqFuud4fkRHszCSE3teY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2360C4CEE2;
	Wed,  7 May 2025 19:26:42 +0000 (UTC)
Date: Wed, 7 May 2025 15:26:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ayush Jain <Ayush.jain3@amd.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <Naveen.Rao@amd.com>,
 <Kalpana.Shetty@amd.com>, <Narasimhan.V@amd.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Convert poll to a gen_file
Message-ID: <20250507152653.4af2549a@gandalf.local.home>
In-Reply-To: <20250409124855.4dc8fd58@gandalf.local.home>
References: <20250409044632.363285-1-Ayush.jain3@amd.com>
	<20250409124855.4dc8fd58@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Shuah,

Can you take this through your tree?

-- Steve


On Wed, 9 Apr 2025 12:48:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 9 Apr 2025 04:46:32 +0000
> Ayush Jain <Ayush.jain3@amd.com> wrote:
> 
> > Poll program is a helper to ftracetest, thus make it a
> > generic file and remove it from being run as a test.
> > 
> > Currently when executing tests using
> >     $ make run_tests
> >       CC       poll
> >     TAP version 13
> >     1..2
> >     # timeout set to 0
> >     # selftests: ftrace: poll
> >     # Error: Polling file is not specified
> >     not ok 1 selftests: ftrace: poll # exit=255
> > 
> > Fix this by using TEST_GEN_FILES to build the 'poll' binary as a helper
> > rather than as a test.
> > 
> > Fixes: 80c3e28528ff ("selftests/tracing: Add hist poll() support test")
> > 
> > Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>  
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> > ---
> >  tools/testing/selftests/ftrace/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> > index 49d96bb16355..7c12263f8260 100644
> > --- a/tools/testing/selftests/ftrace/Makefile
> > +++ b/tools/testing/selftests/ftrace/Makefile
> > @@ -6,6 +6,6 @@ TEST_PROGS := ftracetest-ktap
> >  TEST_FILES := test.d settings
> >  EXTRA_CLEAN := $(OUTPUT)/logs/*
> >  
> > -TEST_GEN_PROGS = poll
> > +TEST_GEN_FILES := poll
> >  
> >  include ../lib.mk  
> 


