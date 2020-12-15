Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1F2DA691
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgLODBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Dec 2020 22:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgLODBj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Dec 2020 22:01:39 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4BC0617A6
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Dec 2020 19:00:58 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2so13589101pfq.5
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Dec 2020 19:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=b9Yyd2SJUpD5M0JEcQPm/jMQVqbJpky9fEX60fZ5oLU=;
        b=kLw7ncveXiHBEXRnq/Rpd6ap9lA+qdSTsgLkFTS/JvrCkCMRcl5Hdug//D/YdTxLmI
         /VemLoljIXXAX1Q0ZZ2QRoNoZ2FZNrdJM0/ny6LBW2KFcrCipDHF6i5Kk1XJ/6gQdo9P
         qg8xZ1oSEuq1yblAWKoTuwLg6DdnUs9cfx3P12lSZg+ANqreHdnJcLvUPQQjFHWvJeD4
         ZOci35AXKZDqTeIlq3Vzz2AQ2lrFMdgF2qG69BY8WEYoB8f2IuDIwihht0LTM05NFhsr
         V0Qn4UHbznj8X/kqmP9KXBqWnn7AJGPO2o4hAMOWhrjgAqstMoRBceFSPHr8eIRBulmu
         ZoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=b9Yyd2SJUpD5M0JEcQPm/jMQVqbJpky9fEX60fZ5oLU=;
        b=SCUS5s4c8iU5w5MPGdA/wGDLPwvHcRMTkS4zxjdoMo0zBtVX3EdW5LzpmxCIruCIGc
         d68F1Awk05Fkd74fdyJuEr9WJ8Wno2xtSvmczIp1OKN1ASyjL8NymOFvMvc2WXbfYxH9
         sEZqn6LURMrKjsdDrIJ6mpMEgc6ITTYkRceV1rG4qQYhcIEkgJJkmEFZunbA2f+6W4dI
         SaP7aZCv154CI/sf/ANlnrKt/eJPyY3CgcRnR9/1jIIDXK3ne72TPfoKGvBDn2BkWXR+
         HctOP+f5troyvcmK/PJmRr4dDXUMZhX7Xj3gYo0PPVkz1lvMxVIE4PUdTemoaxnSCPI0
         agTw==
X-Gm-Message-State: AOAM530V0SGpQ7M2a0boRhNtCTQYUmQe4hF8/IcwjUi+b5wdF2DNNetE
        2ZlaGIQ5LY1oSBSk1OIXa3vwPw==
X-Google-Smtp-Source: ABdhPJyKCn7Z6PEeIJzplurcW2m8m7LJC9wdzi2X3lcSQ1bxIAbeSMiqO89ZdyZdyMq5hexNtN0JQw==
X-Received: by 2002:a05:6a00:80b:b029:198:124a:d58a with SMTP id m11-20020a056a00080bb0290198124ad58amr25719514pfk.56.1608001258225;
        Mon, 14 Dec 2020 19:00:58 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c199sm23127946pfb.108.2020.12.14.19.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 19:00:57 -0800 (PST)
Date:   Mon, 14 Dec 2020 19:00:57 -0800 (PST)
X-Google-Original-Date: Mon, 14 Dec 2020 19:00:53 PST (-0800)
Subject:     Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
In-Reply-To: <30d39293-80a4-9ef5-92bb-6b6dec464be3@toxicpanda.com>
CC:     bvanassche@acm.org, Christoph Hellwig <hch@infradead.org>,
        snitzer@redhat.com, corbet@lwn.net, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     josef@toxicpanda.com
Message-ID: <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Dec 2020 09:03:21 PST (-0800), josef@toxicpanda.com wrote:
> On 12/9/20 10:38 PM, Bart Van Assche wrote:
>> On 12/7/20 10:55 AM, Palmer Dabbelt wrote:
>>> All in all, I've found it a bit hard to figure out what sort of interest
>>> people
>>> have in dm-user: when I bring this up I seem to run into people who've done
>>> similar things before and are vaguely interested, but certainly nobody is
>>> chomping at the bit.  I'm sending it out in this early state to try and
>>> figure
>>> out if it's interesting enough to keep going.
>>
>> Cc-ing Josef and Mike since their nbd contributions make me wonder
>> whether this new driver could be useful to their use cases?
>>
>
> Sorry gmail+imap sucks and I can't get my email client to get at the original
> thread.  However here is my take.

and I guess I then have to apoligize for missing your email ;).  Hopefully that
was the problem, but who knows.

> 1) The advantages of using dm-user of NBD that you listed aren't actually
> problems for NBD.  We have NBD working in production where you can hand off the
> sockets for the server without ending in timeouts, it was actually the main
> reason we wrote our own server so we could use the FD transfer stuff to restart
> the server without impacting any clients that had the device in use.

OK.  So you just send the FD around using one of the standard mechanisms to
orchestrate the handoff?  I guess that might work for our use case, assuming
whatever the security side of things was doing was OK with the old FD.  TBH I'm
not sure how all that works and while we thought about doing that sort of
transfer scheme we decided to just open it again -- not sure how far we were
down the dm-user rabbit hole at that point, though, as this sort of arose out
of some other ideas.

> 2) The extra copy is a big deal, in fact we already have too many copies in our
> existing NBD setup and are actively looking for ways to avoid those.
>
> Don't take this as I don't think dm-user is a good idea, but I think at the very
> least it should start with the very best we have to offer, starting with as few
> copies as possible.

I was really experting someone to say that.  It does seem kind of silly to build
out the new interface, but not go all the way to a ring buffer.  We just didn't
really have any way to justify the extra complexity as our use cases aren't
that high performance.   I kind of like to have benchmarks for this sort of
thing, though, and I didn't have anyone who had bothered avoiding the last copy
to compare against.

> If you are using it currently in production then cool, there's clearly a usecase
> for it.  Personally as I get older and grouchier I want less things in the
> kernel, so if this enables us to eventually do everything NBD related in
> userspace with no performance drop then I'd be down.  I don't think you need to
> make that your primary goal, but at least polishing this up so it could
> potentially be abused in the future would make it more compelling for merging.
> Thanks,

Ya, it's in Android already and we'll be shipping it as part of the new OTA
flow for the next release.  The rules on deprecation are a bit different over
there, though, so it's not like we're wed to it.  The whole point of bringing
this up here was to try and get something usable by everyone, and while I'd
eventually like to get whatever's in Android into the kernel proper we'd really
planned on supporting an extra Android-only ABI for a cycle at least.  

I'm kind of inclined to take a crack at the extra copy, to at least see if
building something that eliminates it is viable.  I'm not really sure if it is
(or at least, if it'll net us a meaningful amount of performance), but it'd at
least be interesting to try.

It'd be nice to have some benchmark target, though, as otherwise this stuff
hangs on forever.  My workloads are in selftests later on in the patch set, but
I'm essentially using tmpfs as a baseline to compare against ext4+dm-user with
some FIO examples as workloads.  Our early benchmark numbers indicated this was
way faster than we needed, so I didn't even bother putting together a proper
system to run on so I don't really have any meaningful numbers there.  Is there
an NBD server that's fast that I should be comparing against?

I haven't gotten a whole lot of feedback, so I'm inclined to at least have some
reasonable performance numbers before bothering with a v2.
