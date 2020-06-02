Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343201EB277
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 02:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFBACE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 20:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgFBACE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 20:02:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B022072E;
        Tue,  2 Jun 2020 00:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591056123;
        bh=m/A9exI6hCT7HrMZiS79aYvM5xMnJxLqw67x4zmRnak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QlUK8Fpd9R3dGozfIUXBzSEEM3d2dUORNDsOcLFfBUf+gGIZu8OZrxER7Vs+9EGdB
         G6seZZahYdzO4NZK00Vf/UdSt+X2g+U6zoPfgJ2dfDo97WAlSm5jbctGSSVPrPyfns
         pDHC0kJtbuKW40KdKbaJkoNzLjpWhxivIr8ss1/k=
Date:   Tue, 2 Jun 2020 09:01:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 4/7] selftests/ftrace: Convert required interface checks
 into requires list
Message-Id: <20200602090157.45cf58947267cec561da67ea@kernel.org>
In-Reply-To: <e23a0d5c-5e7e-13db-e9c1-2a093d3327be@linux.intel.com>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
        <159102256204.31199.842249429317038334.stgit@devnote2>
        <e23a0d5c-5e7e-13db-e9c1-2a093d3327be@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 1 Jun 2020 14:54:12 -0500
"Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On 6/1/2020 9:42 AM, Masami Hiramatsu wrote:
> > Convert the required tracefs interface checking code with
> > requires: list.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org
> [ SNIP ]
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> > index c80007aa9f86..59f876c80d45 100644
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> > @@ -1,17 +1,13 @@
> >   #!/bin/sh
> >   # SPDX-License-Identifier: GPL-2.0
> >   # description: event trigger - test inter-event histogram trigger onchange action
> > +# requires: synthetic_events
> 
> I think this should be 'set_event'
> 

Thank you for point it out. I found another missed requirement.
I'll fix it.

Thank you,

> Thanks,
> 
> Tom


-- 
Masami Hiramatsu <mhiramat@kernel.org>
