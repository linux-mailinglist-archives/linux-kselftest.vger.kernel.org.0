Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74343F2DB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhHTOJm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 10:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234189AbhHTOJm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 10:09:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC02610FF;
        Fri, 20 Aug 2021 14:09:03 +0000 (UTC)
Date:   Fri, 20 Aug 2021 10:08:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 4/5] selftests/ftrace: Add selftest for testing
 eprobe events
Message-ID: <20210820100856.0fb17ca9@oasis.local.home>
In-Reply-To: <20210820094639.77a9d0eec97bde10e28f5b47@kernel.org>
References: <20210819152604.704335282@goodmis.org>
        <20210819152825.526931866@goodmis.org>
        <20210820094639.77a9d0eec97bde10e28f5b47@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Aug 2021 09:46:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +
> > +echo "$SYNTH u64 filename; s64 ret;" > synthetic_events
> > +echo "hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
> > +echo "hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger  
> 
> Hmm, can you make this more simple one without synthetic events?
> Since synthetic event depends on CONFIG_SYNTH_EVENTS, you need to add
> "synth_events" to 'requires' tag.
> However, this means that this testcase doesn't run when CONFIG_SYNTH_EVENTS=n
> but CONFIG_*PROBE_EVENTS=y.

Sure. I just used this because it was one of the main purposes I was
using it for. I may keep this as a test, but will rename it as
something else, and make a more simple one for just testing the event
probe add and removal.

-- Steve
