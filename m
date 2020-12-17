Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901582DCCC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 07:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLQG4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 01:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgLQG4A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 01:56:00 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DBC061282
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Dec 2020 22:55:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so11645546pgl.10
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Dec 2020 22:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BjnZ5s+jnI9mFnTZF3RJgIJMeukCqH/N1kppehfap7Y=;
        b=MBNR7NLIdCYQa+qPbJyC+kEool/SY9YLMyPfGemmPyFOFNBylFATMYY0dvR/oo61E8
         9f4eyvP+inKs/hugnGWwfwE2QtXdDrna2juwkKf1zZwI4ibcD9gU2BYyhkoPZFBL8Sxb
         ShVzr0UPDrFT4vMttijcd+lYmuLDZVOmxMMrz8huf+mNHWh71wfNP0ZWJ1ZrdHZu3SqF
         YjOWXNdI4hufbL5e6JVHlsvsg9qeOVlfA1zBc2blHIa/8dM6FI2YC0ZWkN0GEjWCwv7P
         12OZZS+iGTuSm1EzDR4rrh/l2KsC1J9enE/z5SzJWscdldap/xklGjipk/IIbGLbFTk0
         xG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BjnZ5s+jnI9mFnTZF3RJgIJMeukCqH/N1kppehfap7Y=;
        b=sA6/ubQnC+05sRc/T/cRjUpUwqNkkQUn5vX31uPYsxDd2uuZANhwK89sRouSyDvUvy
         EYnmPMeEOZbyl7G9q2P/5T2S3e0ncIYcltUcNyAR4kAfJKn4ZwU60mzB6XEvOQjzkVeM
         hcpB4tNdAZP04+ivlC/2x9m1KA15PpNK+B6bZn5D9rajyllS3r4R9vdI8ZLJJ4Ai683R
         TLxK6jlZK+aMMWpxRQh1AJ8dEjuV9AMfB+iXPvtcZ0sifxJjc1E/H2OGvuBErtd1Nb+X
         IRX+441D8oho4v6xU9PK3rzY8jnwCbCW/0ZcdWidyWJrNBFWNbwjruCkWEeMIKsBSdd0
         XbjQ==
X-Gm-Message-State: AOAM532CTYaDeK5zApHG+yxyWKu5h/z+e/Vfqc4YIQzD3AqsvdnDA4cV
        fRDvyny27+BBBMIRKSNXgIz9vg==
X-Google-Smtp-Source: ABdhPJwOkX04PZM/hDkMwFByq3zRzuq27yaN/Sp6sDe9qMIhnlWHKH2jlrq5wuwjc8F2fNQ6gRsdzQ==
X-Received: by 2002:aa7:8506:0:b029:19e:95:f75f with SMTP id v6-20020aa785060000b029019e0095f75fmr35416013pfn.7.1608188119792;
        Wed, 16 Dec 2020 22:55:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l7sm3921765pjy.29.2020.12.16.22.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 22:55:19 -0800 (PST)
Date:   Wed, 16 Dec 2020 22:55:19 -0800 (PST)
X-Google-Original-Date: Wed, 16 Dec 2020 22:55:17 PST (-0800)
Subject:     Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
In-Reply-To: <CAGF4SLgDvS7VOih4XZ+sqx6jVK3wBQZan+uZMVsdYdVEPZdrpw@mail.gmail.com>
CC:     josef@toxicpanda.com, bvanassche@acm.org,
        Christoph Hellwig <hch@infradead.org>, snitzer@redhat.com,
        corbet@lwn.net, kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     v.mayatskih@gmail.com
Message-ID: <mhng-7da80016-a7d7-4232-999d-6fea3196118d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Dec 2020 10:24:59 PST (-0800), v.mayatskih@gmail.com wrote:
> On Mon, Dec 14, 2020 at 10:03 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> I was really experting someone to say that.  It does seem kind of silly to build
>> out the new interface, but not go all the way to a ring buffer.  We just didn't
>> really have any way to justify the extra complexity as our use cases aren't
>> that high performance.   I kind of like to have benchmarks for this sort of
>> thing, though, and I didn't have anyone who had bothered avoiding the last copy
>> to compare against.
>
> I worked on something very similar, though performance was one of the
> goals. The implementation was floating around lockless ring buffers,
> shared memory for zerocopy, multiqueue and error handling. It could be
> that every disk storage vendor has to implement something like that in
> order to bridge Linux kernel to their own proprietary datapath running
> in userspace.

OK, good to know.  That's kind of the feeling I'd gotten from having chatted to
a handful of people about this, but I don't remember people having actually
gotten all the way to zero-copy.  That's how we managed to end up at this
middle-ground ABI style: when I thought people were, in practice, punting on
zero copy because the complexity just wasn't worth the performance benefit.
Maybe I'd just been colored by how my projects ended up going, but I've ended
up designing complicated interfaces in the past that allow for zero-copy only
to never get around to actually making that work.  I don't know if that's just
because I've had the good fortune to avoid working on anything that ended up
with users, though :).

For our use case I think we actually get better performance out of the
copy-based (and probably more importantly kalloc-based, but that's an
implementation thing not an ABI thing) approach: essentially we're very
sensitive to memory pressure and expect this first dm-user daemon to mostly be
idle, so we're really worried about avoiding excess memory usage while idle and
less worried about throughput when active.  This stream-based interface means
that userspace doesn't need much memory allocated to service a request, which
helps with sleep/wake latencies and/or idle memory usage.  That's also why we
have the simple locking scheme: no sense splitting locks if there's no
contention, and we only need a single thread to saturate the storage bandwidth
on these phones.

That said, it does sound like people really do care about the sort of
performance levels where zero copy is relevant in this space.  I'll take a shot
at something along those lines, and while it will add a degree of userspace
complexity I'm not sure it'll add much in the way of kernel complexity -- at
least compared to a fast version of this, where we'd need most of that stuff
anyway (obviously the malloc+single lock design is simple, but probably
wouldn't stick around for long).  At a bare minimum it'll be interesting to
play around with, but if people are doing it in practice then I'm more
confident that I can put something together that at least serves as a starting
point for further discussion.

I haven't gotten around to writing any code yet, but I had spent a bit of time
thinking about how to put this zero-copy version together and am leaning
towards it being a standalone block device (as opposed to a DM target).  I'd
avoided that before as I didn't want to mess around with my own device control
scheme so I'll still try to do the DM thing, but I'm not sure it'll be viable.
That's all speculation now, but it does bring up one interesting question:

IIUC, this version of dm-user handles BIOs before they reach the block
scheduler while a standalone driver would likely handle them after blk-mq.  I
don't have direct experience with this, but the last time I ran into people who
had these sorts of performance requirements for userspace drivers they weren't
actually trying to write userspace drivers but were instead trying to write a
userspace scheduler, with the userspace drivers just being the mechanism to
implement that scheduler.  This was a decade ago and I'm not sure that's what
people are trying to do in the new blk-mq world, but if it is then it's going
to be a major design consideration.  I'm also not entirely sure that we're
really solving the same problem at that point.
