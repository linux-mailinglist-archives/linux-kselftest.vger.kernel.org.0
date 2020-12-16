Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA12DC7D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 21:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgLPUgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 15:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgLPUgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 15:36:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90935C061282
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Dec 2020 12:35:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so6445524plt.12
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Dec 2020 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p8XQW4cjugdKIwxwILtgQ7d/G6qN5cGSPlZP2CvVqWE=;
        b=Ae5GMZR0GgdREbYr5rQL+Y6zzEpSs9tfB6yohEkPmZ5E1lcGrwEUU+HoYpy8Fa8RgS
         VAC13qOduFHPKeiR1uI3szWbNbAMgObaU2YT4T5QDUIVeeNt/aWuFqWwmNoFQU+dbuKc
         Z4kviXMMEEyOlqoT1cOyXnBeLIM94mPlS7K4BqE88Z1EPMuSbXOerl74LIqQcUk3lq1x
         IuZLG+a2gM8sI3Kubb4gc8EsYnlFD7BfAuCcDovqJRqZIt64oGZvU2nE05Gw8ENVYU+7
         2iJ9ZB22yeKFfkxjzay9AvrLAPhog7Axgffdf7X2RUP/HL3sTl2xBH7DvYyONUShZ1Bv
         Lbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p8XQW4cjugdKIwxwILtgQ7d/G6qN5cGSPlZP2CvVqWE=;
        b=ltbp1xjuK5KwS5K4vQ2jnCKBE2MysFHtj8FYzDaTPT/m7IIQUjtiT0XsMSisUytbMy
         kP4o3todlhn3PQKxRlcXnN4VUVsPOjJlG3lpAc9uxiHFCS5WXd5SAwZ8COYS3QeMxD+U
         l5G/6pZzd+rqyRKJ8KfNDr3ySLztFOE5+EOFq/Heq9SeD/AfyAo4ZJ36dnR5jVwW6OAF
         JFGty4hbFuZ7+3ITw2tJl1fZ5J/ESs+MXT3R/QOnFzlDq+z7UkO85qM5VNMjj9gGIH4H
         ojvNIUNj/yfWlWIccO5fd+XhmVb0w/Hq1kF9a0S1ogJHaCZ+jWy6ih82pXdarF/ekL7k
         h2QA==
X-Gm-Message-State: AOAM5312+sBmIG++xKDp3H8pQQJ1y6cwxGmYIxdHW230sKbyx8GmIiXQ
        xNMUFLcD1zDVEH0J36qeWa5Zgg==
X-Google-Smtp-Source: ABdhPJzSD8U4wMSXgHoibwCGxFPKpPyA9oDYq8beROKHNnGC6MmYee5AX3iL50+jC56MZu8jjmPTdw==
X-Received: by 2002:a17:90a:df13:: with SMTP id gp19mr4545800pjb.235.1608150930853;
        Wed, 16 Dec 2020 12:35:30 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u25sm3329042pfn.170.2020.12.16.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:35:29 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:35:29 -0800 (PST)
X-Google-Original-Date: Wed, 16 Dec 2020 10:42:26 PST (-0800)
Subject:     Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
In-Reply-To: <CABmKtjfdDS-iO+jLkwt7x-oDHt9V1p-cpYHjL5EV2NKwHxqN1Q@mail.gmail.com>
CC:     josef@toxicpanda.com, linux-raid@vger.kernel.org,
        bvanassche@acm.org, snitzer@redhat.com, linux-doc@vger.kernel.org,
        shuah@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, song@kernel.org,
        dm-devel@redhat.com, michael.christie@oracle.com,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        agk@redhat.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ruby.wktk@gmail.com
Message-ID: <mhng-cc7f1629-3ff7-4efe-8dc6-806b4d8e28c5@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Dec 2020 22:17:06 PST (-0800), ruby.wktk@gmail.com wrote:
> Hi my name is Akira Hayakawa. I am maintaining an out-of-tree DM target
> named dm-writeboost.
>
> Sorry to step in. But this is a very interesting topic at least to me.
>
> I have been looking for something like dm-user because I believe we should
> be able to implement virtual block devices in Rust language.
>
> I know proxying IO requests to userland always causes some overhead but for
> some type of device that performance doesn't matter or some research
> prototyping or pseudo device for testing, this way should be developed. Of
> course, implementation in Rust will give us opportunities to develop more
> complicated software in high quality.
>
> I noticed this thread few days ago then I started to prototype this library
> https://github.com/akiradeveloper/userland-io
>
> It is what I want but the transport is still NBD which I don't like so
> much. If dm-user is available, I will implement a transport using dm-user.

Great, I'm glad to hear that.  Obviously this is still in the early days and
we're talking about high-level ABI design here, so things are almost certainly
going to change, but it's always good to have people pushing on stuff.

Just be warned: we've only had two people write userspaces for this (one of
which was me, and all that is test code) so I'd be shocked if you manage to
avoid running into bugs.

>
> - Akira
>
> On Tue, Dec 15, 2020 at 7:00 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> On Thu, 10 Dec 2020 09:03:21 PST (-0800), josef@toxicpanda.com wrote:
>> > On 12/9/20 10:38 PM, Bart Van Assche wrote:
>> >> On 12/7/20 10:55 AM, Palmer Dabbelt wrote:
>> >>> All in all, I've found it a bit hard to figure out what sort of
>> interest
>> >>> people
>> >>> have in dm-user: when I bring this up I seem to run into people who've
>> done
>> >>> similar things before and are vaguely interested, but certainly nobody
>> is
>> >>> chomping at the bit.  I'm sending it out in this early state to try and
>> >>> figure
>> >>> out if it's interesting enough to keep going.
>> >>
>> >> Cc-ing Josef and Mike since their nbd contributions make me wonder
>> >> whether this new driver could be useful to their use cases?
>> >>
>> >
>> > Sorry gmail+imap sucks and I can't get my email client to get at the
>> original
>> > thread.  However here is my take.
>>
>> and I guess I then have to apoligize for missing your email ;).  Hopefully
>> that
>> was the problem, but who knows.
>>
>> > 1) The advantages of using dm-user of NBD that you listed aren't actually
>> > problems for NBD.  We have NBD working in production where you can hand
>> off the
>> > sockets for the server without ending in timeouts, it was actually the
>> main
>> > reason we wrote our own server so we could use the FD transfer stuff to
>> restart
>> > the server without impacting any clients that had the device in use.
>>
>> OK.  So you just send the FD around using one of the standard mechanisms to
>> orchestrate the handoff?  I guess that might work for our use case,
>> assuming
>> whatever the security side of things was doing was OK with the old FD.
>> TBH I'm
>> not sure how all that works and while we thought about doing that sort of
>> transfer scheme we decided to just open it again -- not sure how far we
>> were
>> down the dm-user rabbit hole at that point, though, as this sort of arose
>> out
>> of some other ideas.
>>
>> > 2) The extra copy is a big deal, in fact we already have too many copies
>> in our
>> > existing NBD setup and are actively looking for ways to avoid those.
>> >
>> > Don't take this as I don't think dm-user is a good idea, but I think at
>> the very
>> > least it should start with the very best we have to offer, starting with
>> as few
>> > copies as possible.
>>
>> I was really experting someone to say that.  It does seem kind of silly to
>> build
>> out the new interface, but not go all the way to a ring buffer.  We just
>> didn't
>> really have any way to justify the extra complexity as our use cases aren't
>> that high performance.   I kind of like to have benchmarks for this sort of
>> thing, though, and I didn't have anyone who had bothered avoiding the last
>> copy
>> to compare against.
>>
>> > If you are using it currently in production then cool, there's clearly a
>> usecase
>> > for it.  Personally as I get older and grouchier I want less things in
>> the
>> > kernel, so if this enables us to eventually do everything NBD related in
>> > userspace with no performance drop then I'd be down.  I don't think you
>> need to
>> > make that your primary goal, but at least polishing this up so it could
>> > potentially be abused in the future would make it more compelling for
>> merging.
>> > Thanks,
>>
>> Ya, it's in Android already and we'll be shipping it as part of the new OTA
>> flow for the next release.  The rules on deprecation are a bit different
>> over
>> there, though, so it's not like we're wed to it.  The whole point of
>> bringing
>> this up here was to try and get something usable by everyone, and while I'd
>> eventually like to get whatever's in Android into the kernel proper we'd
>> really
>> planned on supporting an extra Android-only ABI for a cycle at least.
>>
>> I'm kind of inclined to take a crack at the extra copy, to at least see if
>> building something that eliminates it is viable.  I'm not really sure if
>> it is
>> (or at least, if it'll net us a meaningful amount of performance), but
>> it'd at
>> least be interesting to try.
>>
>> It'd be nice to have some benchmark target, though, as otherwise this stuff
>> hangs on forever.  My workloads are in selftests later on in the patch
>> set, but
>> I'm essentially using tmpfs as a baseline to compare against ext4+dm-user
>> with
>> some FIO examples as workloads.  Our early benchmark numbers indicated
>> this was
>> way faster than we needed, so I didn't even bother putting together a
>> proper
>> system to run on so I don't really have any meaningful numbers there.  Is
>> there
>> an NBD server that's fast that I should be comparing against?
>>
>> I haven't gotten a whole lot of feedback, so I'm inclined to at least have
>> some
>> reasonable performance numbers before bothering with a v2.
>>
>> --
>> dm-devel mailing list
>> dm-devel@redhat.com
>> https://www.redhat.com/mailman/listinfo/dm-devel
