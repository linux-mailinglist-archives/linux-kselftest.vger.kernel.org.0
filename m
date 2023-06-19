Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03A735D86
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjFSSkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFSSkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 14:40:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A63D18C;
        Mon, 19 Jun 2023 11:40:51 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 77862210DDA3;
        Mon, 19 Jun 2023 11:40:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77862210DDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687200050;
        bh=qo6WhpT1uRSqMbsupvdaieoE2v8tvR0YEzNpA1DiJWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyk+6dMT8YaqJtnwfjGNxxzVmIrLKjDtWYtPaPvZ2y+oLBYTW8jrJZ5SxplYeaK9S
         KjWtqX5EYMjTBiuBZnkRjhAylPCC0u6sfqFnFxUTKyfnfz8uc87UheW0h19oOfdGfX
         EY0W1j40j7qLmZoUB1pV6EnwAMaG/0zlNKaqhWpY=
Date:   Mon, 19 Jun 2023 11:40:44 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <kelulanainsley@gmail.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disabled
Message-ID: <20230619184044.GA88@W11-BEAU-MD.localdomain>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
 <20230609030302.1278716-2-sunliming@kylinos.cn>
 <20230616160845.GA88@W11-BEAU-MD.localdomain>
 <CAJncD7Sfasoe4-hKZP4c3bPZ892S2Kk5JaMo-aca6eBDwLjLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJncD7Sfasoe4-hKZP4c3bPZ892S2Kk5JaMo-aca6eBDwLjLNQ@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 19, 2023 at 04:51:56PM +0800, sunliming wrote:
> Beau Belgrave <beaub@linux.microsoft.com> 于2023年6月17日周六 00:08写道：
> >
> > On Fri, Jun 09, 2023 at 11:03:00AM +0800, sunliming wrote:
> > > The writing operation return the count of writes whether events are
> > > enabled or disabled. This is incorrect when events are disabled. Fix
> > > this by just return -ENOENT when events are disabled.
> > >
> >
> > When testing this patch locally I found that we would occasionally get
> > -ENOENT when events were enabled, but then become disabled, since writes
> > do not have any locking around the tracepoint checks for performance
> > reasons.
> >
> > I've asked a few peers of mine their thoughts on this, whether an error
> > should result when there are no enabled events. The consensus I've heard
> > back is that they would not consider this case an actual error, just as
> > writing to /dev/null does not actually return an error.
> >
> > However, if you feel strongly we need this and have a good use case, it
> > seems better to enable this logic behind a flag instead of having it
> > default based on my conversations with others.
> >
> > Thanks,
> > -Beau
> 
> 
> 
> There is indeed a problem. Once enabled, perform the write operation
> immediately.
> 

The immediate write does work, and gets put into a buffer. The ftrace
and perf self tests do the above case. So, no worries at this point.

> Now，when the event is disabled, the trace record appears to be lost.

I'm taking this to mean, if in between the time of the bit check and the
actual write() /writev() syscall the event becomes disabled, the event
won't write to the buffer. Yes, that is expected.

> In some situations
> where data timing is sensitive, it may cause confusion. In this case,
> not returning an
> error (as mentioned in your reply, it is not considered this case an
> actual error) and
> returning 0 ( meaning that the number of data to be written is 0) may
> be a good way
> to handle it?

This is where I get a little lost. What would a user process do with a
return of 0 bytes? It shouldn't retry, since it just hit that small
timing window. In reality, it just incurred a temporary excessive
syscall cost, but no real data loss (the operator/admin turned the event
off).

I'm missing why you feel it's important the user process know such a
window was hit?

Can you help me understand that?

I do think returning 0 bytes is better than an error here, but I'd
really like to know why the user process wants to know at all. Maybe
they have user-space only logging and want to be able to mark there if
it's in both spots (kernel and user buffers)?

Thanks,
-Beau

> Thanks,
> -Sunliming
> 
> >
> > > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > > ---
> > >  kernel/trace/trace_events_user.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > > index 1ac5ba5685ed..92204bbe79da 100644
> > > --- a/kernel/trace/trace_events_user.c
> > > +++ b/kernel/trace/trace_events_user.c
> > > @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> > >
> > >               if (unlikely(faulted))
> > >                       return -EFAULT;
> > > -     }
> > > +     } else
> > > +             return -ENOENT;
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.25.1
