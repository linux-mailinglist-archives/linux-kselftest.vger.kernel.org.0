Return-Path: <linux-kselftest+bounces-47720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C369CCDF15
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 00:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6FBC302FB60
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F752330B2E;
	Thu, 18 Dec 2025 23:29:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D032E6A2;
	Thu, 18 Dec 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100550; cv=none; b=ctudIXwbVBTZrddArUL4egbvAk3a0y/NqsHcWXFlKSSwWWRotQrzBFvd6gDEM639lakz7QiGow1B/18R0LGvclzzsafPQBz12HXS6y3CYgdgl2wLr3KUdtPMsZirjknbiy9VLu/UzV6h8JkhQyLirsLKQZHoxC85Sm3Cwimf5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100550; c=relaxed/simple;
	bh=LH8HiBrmyPTzuxuvVpDq75RMEKUZn9JwAPNaO30rIQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIRPLxEEUzqID/rWWFZSYMDzssJ62ayXjg3uxE/ex6MC3qKZJY0jvKMK2myEFfj20SpCt4+L9ieInpENpJ280rcOH9L5jfIK5M/ftzPTDSoGXwH1tzGSIsLopCUYE7Gr6TFOpKA7IVYAUcbukcTcjxp2mxZFhEyUmteUU7gPb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id EF8A914035C;
	Thu, 18 Dec 2025 23:29:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1FC0D2002E;
	Thu, 18 Dec 2025 23:29:01 +0000 (UTC)
Date: Thu, 18 Dec 2025 18:30:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <mhiramat@kernel.org>, <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Test toplevel-enable for instance
Message-ID: <20251218183040.0f652a64@gandalf.local.home>
In-Reply-To: <20230907214020.34981ffd@gandalf.local.home>
References: <20230509203659.1173917-1-zhengyejian1@huawei.com>
	<20230609174626.66659892@gandalf.local.home>
	<20230710175415.2ec0061f@gandalf.local.home>
	<20230907214020.34981ffd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: esjkffxbodnnu35g586wgerjyxu6a9h1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1FC0D2002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197ECzlJbzg0OYx3eoNOwQbv2tJTAEJ/PY=
X-HE-Tag: 1766100541-279658
X-HE-Meta: U2FsdGVkX18452fXfM/hySVl1Ct+6OcUwsovMrbgaVEdfGXe42hiGSao+WvmfM9OQQgkkEe6JcRONzvsi3armIsOcLRJU9NcNzW84jJEhdQVnpRyQUL7QVrrEnx/Q4JidDh2O1vlJbtMm2i1sQFgVCLZWimS8I6Bu0D2QY/cMHf00NJa5732GGMOxX0cCcNk363b/I+s5ugO5TdKJTv2N1Vvut2ykzNFjxKtfQHmM0bW6YHbCIxJLmIs2cxiHR8kI3ED3sNWA5BDOTD0mlXrz5AdxhRTC5IOvyFQMpYg5XTXBa0I0sXdz+3euukDFTcHx55MvIasFgp7nBEMmmzbHS8eDd7HulZpoMy0QVLQMTqcNzlOo1QN2N7Q8Zh1vG4Bfb4byfxm/rQgu8Sz/xitsg==

On Thu, 7 Sep 2023 21:40:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 10 Jul 2023 17:54:36 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Shuah,
> > 
> > I think this dropped through the cracks. Can you take this through your
> > tree?  
> 
> ping?

Found another one that never got applied.

-- Steve

> 
> 
> > 
> > -- Steve
> > 
> > On Fri, 9 Jun 2023 17:46:26 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Wed, 10 May 2023 04:36:59 +0800
> > > Zheng Yejian <zhengyejian1@huawei.com> wrote:
> > >     
> > > > 'available_events' is actually not required by
> > > > 'test.d/event/toplevel-enable.tc' and its Existence has been tested in
> > > > 'test.d/00basic/basic4.tc'.
> > > > 
> > > > So the require of 'available_events' can be dropped and then we can add
> > > > 'instance' flag to test 'test.d/event/toplevel-enable.tc' for instance.
> > > > 
> > > > Test result show as below:
> > > >  # ./ftracetest test.d/event/toplevel-enable.tc
> > > >  === Ftrace unit tests ===
> > > >  [1] event tracing - enable/disable with top level files [PASS]
> > > >  [2] (instance)  event tracing - enable/disable with top level files [PASS]
> > > > 
> > > >  # of passed:  2
> > > >  # of failed:  0
> > > >  # of unresolved:  0
> > > >  # of untested:  0
> > > >  # of unsupported:  0
> > > >  # of xfailed:  0
> > > >  # of undefined(test bug):  0
> > > > 
> > > > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>      
> > > 
> > > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > 
> > > -- Steve
> > >     
> > > > ---
> > > >  tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > > > index 93c10ea42a68..8b8e1aea985b 100644
> > > > --- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > > > +++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > > > @@ -1,7 +1,8 @@
> > > >  #!/bin/sh
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  # description: event tracing - enable/disable with top level files
> > > > -# requires: available_events set_event events/enable
> > > > +# requires: set_event events/enable
> > > > +# flags: instance
> > > >  
> > > >  do_reset() {
> > > >      echo > set_event      


