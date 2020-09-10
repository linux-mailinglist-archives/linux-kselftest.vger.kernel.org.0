Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96841265526
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgIJWlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 18:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgIJWlO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 18:41:14 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A2A208CA;
        Thu, 10 Sep 2020 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599777674;
        bh=7vOGvZR/YLfARcXz6Z2coM5EtpzEOD+Vp38+MDRRuBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQUtgJbLFZrTuC75zsxYj43MXXasjfhvyn9qe4Tvg1x5vwcAWXtPUN6rRno+UzqNx
         U4oZN3vK5OWypDVPYK8xLvcs0SwXc5Zevx7FxMNOn0ChyfZ+QDeNIhY03nyJklzo4S
         aycpHm8sEong+di3IKQ1oL/FWEE73jftri0VB9wg=
Date:   Fri, 11 Sep 2020 07:41:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 3/8] Documentation: tracing: Add tracing_on option to
 boot-time tracer
Message-Id: <20200911074110.fa9d19c152f3c35947199360@kernel.org>
In-Reply-To: <CY4PR13MB1175F981AB2931C228EBF42FFD270@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
        <159972812521.428528.4047280962991773996.stgit@devnote2>
        <CY4PR13MB1175F981AB2931C228EBF42FFD270@CY4PR13MB1175.namprd13.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tim,

On Thu, 10 Sep 2020 13:26:05 +0000
"Bird, Tim" <Tim.Bird@sony.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Masami Hiramatsu
>  > 
> > Add tracing_on option description to the boot-time tracer.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Documentation/trace/boottime-trace.rst |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
> > index dcb390075ca1..1341b449acaa 100644
> > --- a/Documentation/trace/boottime-trace.rst
> > +++ b/Documentation/trace/boottime-trace.rst
> > @@ -61,6 +61,10 @@ These options can be used for each instance including global ftrace node.
> >  ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
> >     Enable given ftrace options.
> > 
> > +ftrace.[instance.INSTANCE.]tracing_on = 0|1
> > +   Enable/Disable tracing on this instance when boot.
> 
> when boot. -> when booting.
> (or when boot. -> on boot.)

Thanks! "when booting" or maybe "when starting boot-time tracing"
will be more accurate, since if user sets the "ftrace=function"
in the kernel command line, it will start tracing function calls
until the boot-time tracing stops it by this option.

Thank you,


>  -- Tim
> 
> > +   (you can enable it by the "traceon" event trigger action)
> > +
> >  ftrace.[instance.INSTANCE.]trace_clock = CLOCK
> >     Set given CLOCK to ftrace's trace_clock.
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
