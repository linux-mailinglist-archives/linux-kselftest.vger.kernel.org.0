Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA652D18D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 19:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLGS4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 13:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLGS4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 13:56:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DAC061794
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Dec 2020 10:55:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e23so9668029pgk.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Dec 2020 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KtGdp/lwKq2VYARUSn9Vex8GHiah3So/M600I4rdU+k=;
        b=y8VTp9ob9fYKSzfHkWUymZptoMnZAg/NWhWoUrlxY8pjbTg36T7Fdn2pVvvh9zWVaa
         B87zFRzbc5t2R3rkosrvupXzz338IyKlSY3h6nO3hw2GSlHpQdfeFCFxtUhS5Em8PxAK
         GskuFtlBmCwDw1vgOearEpEMLctI3/GBGMMkxS4uTHgTlQmXpFEiGHn6AAwbt+EO5Xpo
         3asZytuj39HVI8357jpgKbjNw0RDymoX3VrjPjBcw6mvh9J8s4Dahu+rG1Q6cmQ+8YsP
         4+x7YjvAxBKlP5PrmfwWH835KSJEkeNn4fEjBTBtYWVE8cRi+N6+9AUXb+oBqFMdGTEM
         BcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KtGdp/lwKq2VYARUSn9Vex8GHiah3So/M600I4rdU+k=;
        b=SsO28MvgX2wdhXQW5var4b+Skkpjf2mm5NPZb2SRbYoHCgL0XgfsyyFjWEVXS7jYut
         +FllCqyjxNIXDLP1P9ek46Vh+53bidFKvz3jKXrhuk5EoG5UFG3qRsaYODKo5py9WFcf
         f4b9CKgeu3VQ4h/kycpmFBmqDXJy+34fVG4kWnPNUpCCR+mPiOjcLTbw62uLU9s4DHjo
         wAzXKhmrhdt7U6MQs+k/Aor2ajrIPTYPD+DQZZPLwsoCEm/hI7exyg+4QaGD7c2r0BmU
         l6IOv8PF+E9u5gVXVqQ9f6g2e0LF98x07Ixqx9VW514fvHjv9R20KiOV/Xi5RlYj2HOE
         D0Fg==
X-Gm-Message-State: AOAM531uv+yjOyU2KLB3utHGTH9DmEpilaTuQfCFt+t2NfI5aHrBGAl8
        KUEs8c/x+KyWigPDLgnHVBt1gA==
X-Google-Smtp-Source: ABdhPJzLmOMynfb1JI8F+/oNdCFJom0GbATVogv9ZDfkhxeT99YUXudSQ0OdVQFteOgVntZyE3iBvQ==
X-Received: by 2002:a62:4dc2:0:b029:19d:b6f2:e7bb with SMTP id a185-20020a624dc20000b029019db6f2e7bbmr17129167pfb.74.1607367358874;
        Mon, 07 Dec 2020 10:55:58 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t36sm14214255pfg.55.2020.12.07.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 10:55:57 -0800 (PST)
Date:   Mon, 07 Dec 2020 10:55:57 -0800 (PST)
X-Google-Original-Date: Mon, 07 Dec 2020 10:55:56 PST (-0800)
Subject:     Re: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
In-Reply-To: <20201204103336.GA7374@infradead.org>
CC:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        corbet@lwn.net, song@kernel.org, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-97fc5874-29d0-4d9e-8c92-d3704a482f28@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 04 Dec 2020 02:33:36 PST (-0800), Christoph Hellwig wrote:
> What is the advantage over simply using nbd?

There's a short bit about that in the cover letter (and in some talks), but
I'll expand on it here -- I suppose my most important question is "is this
interesting enough to take upstream?", so there should be at least a bit of a
description of what it actually enables:

I don't think there's any deep fundamental advantages to doing this as opposed
to nbd/iscsi over localhost/unix (or by just writing a kernel implementation,
for that matter), at least in terms of anything that was previously impossible
now becoming possible.  There are a handful of things that are easier and/or
faster, though.

dm-user looks a lot like NBD without the networking.  The major difference is
which side initiates messages: in NBD the kernel initiates messages, while in
dm-user userspace initiates messages (via a read that will block if there is no
message, but presumably we'd want to add support for a non-blocking userspace
implementations eventually).  The NBD approach certainly makes sense for a
networked system, as one generally wants to have a single storage server
handling multiple clients, but inverting that makes some things simpler in
dm-user.  

One specific advantage of this change is that a dm-user target can be
transitioned from one daemon to another without any IO errors: just spin up the
second daemon, signal the first to stop requesting new messages, and let it
exit.  We're using that mechanism to replace the daemon launched by early init
(which runs before the security subsystem is up, as in our use case dm-user
provides the root filesystem) with one that's properly sandboxed (which can
only be launched after the root filesystem has come up).  There are ways around
this (replacing the DM table, for example), but they don't fit it as cleanly.

Unless I'm missing something, NBD servers aren't capable of that style of
transition: soft disconnects can only be initiated by the client (the kernel,
in this case), which leaves no way for the server to transition while
guaranteeing that no IOs error out.  It's usually possible to shoehorn this
sort of direction reversing concept into network protocols, but it's also
usually ugly (I'm thinking of IDLE, for example).  I didn't try to actually do
it, but my guess would be that adding a way for the server to ask the client to
stop sending messages until a new server shows up would be at least as much
work as doing this.

There are also a handful of possible performance advantages, but I haven't gone
through the work to prove any of them out yet as performance isn't all that
important for our first use case.  For example:

* Cutting out the network stack is unlikely to hurt performance.  I'm not sure
  if it will help performance, though.  I think if we really had workload where
  the extra copy was likely to be an issue we'd want an explicit ring buffer,
  but I have a theory that it would be possible to get very good performance out
  of a stream-style API by using multiple channels and relying on io_uring to
  plumb through multiple ops per channel.
* There's a comment in the implementation about allowing userspace to insert
  itself into user_map(), likely by uploading a BPF fragment.  There's a whole
  class of interesting block devices that could be written in this fashion:
  essentially you keep a cache on a regular block device that handles the common
  cases by remapping BIOs and passing them along, relegating the more complicated
  logic to fetch cache misses and watching some subset of the access stream where
  necessary.

  We have a use case like this in Android, where we opportunistically store
  backups in a portion of the TRIM'd space on devices.  It's currently
  implemented entirely in kernel by the dm-bow target, but IIUC that was deemed
  too Android-specific to merge.  Assuming we could get good enough performance
  we could move that logic to userspace, which lets us shrink our diff with
  upstream.  It feels like some other interesting block devices could be
  written in a similar fashion.

All in all, I've found it a bit hard to figure out what sort of interest people
have in dm-user: when I bring this up I seem to run into people who've done
similar things before and are vaguely interested, but certainly nobody is
chomping at the bit.  I'm sending it out in this early state to try and figure
out if it's interesting enough to keep going.
