Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D950D7CCB80
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJQTBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjJQTBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED490
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697569215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufWNltmtm9MEQJk/HA+zcNGOIx26ETEdVffppRZYG34=;
        b=EvLgWgLuBUKboXT4xsQewNNqKsjMDUVc4Ol8iVYU3+wb77aD4r41yo1aeWxXcVOKkErDrR
        xrOg62LoJ3EZWDeEpPoLpJJB+kiGZfbsSrc9oKBMELHJ3TqIRqhx2+iRaRJMoeox+BNkcW
        gHs/qEG+YW1OBQkglawvD7WGHzJtJSw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-fn5SJ9dLMPSetQG3SVWcPQ-1; Tue, 17 Oct 2023 14:59:59 -0400
X-MC-Unique: fn5SJ9dLMPSetQG3SVWcPQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66cfa898cfeso11918446d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 11:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569199; x=1698173999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufWNltmtm9MEQJk/HA+zcNGOIx26ETEdVffppRZYG34=;
        b=SEKDfbQEWnv2JKfwiwgzT6E7FVDWfhWjz2yGcNe97IuJ/U3huKywTRvXli/cye3hNo
         sAXIcb0aX4pBePdBrSnG6JijHjPpVjD815dHZ7Z5v25U1LZbLAyUB3h8D1QazydgCBCl
         7qdZEDEJ/X+VGDHlZ3Q+1dqS1WgUWu+9AKy9exlO+O2/vvL3ihhFeoIeUnsRdSbiLObV
         ldfmGvsQBrfE5bois1TQPLhzWmqFjEL1Ql0DGENFieacP1QPgRuuxPatJG0dBN0zazji
         RPFWeG8VxX0exNGgrJFlegBSg/p2vThCL5OuqIxuAvBhsp0lEb1emSNnIT+aPDAQoUFb
         2eIw==
X-Gm-Message-State: AOJu0Yz3nEaQi7R3fmzLHYZOyDNGw9BJJg9ra+mDgi5eh5hA9ZpA6eUQ
        kr9+2Gn7ZdVe3fgWxA/wuqvgrentuUElVEF2l9/hRKvPCZePZ3yFpYUt8SZCECVGdcP+AmaFM+l
        Q+CMMvLJNTD9XseANtXafgjb88gFW
X-Received: by 2002:a05:6214:5b04:b0:668:e12a:1d1c with SMTP id ma4-20020a0562145b0400b00668e12a1d1cmr3335098qvb.3.1697569198763;
        Tue, 17 Oct 2023 11:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAk0RrwzkoW0kvuWM0ng2wrDDvK/L2bekMKE0E2CdX9MEwa+UJ0DieBoe9T3ZhdsG80o5WLA==
X-Received: by 2002:a05:6214:5b04:b0:668:e12a:1d1c with SMTP id ma4-20020a0562145b0400b00668e12a1d1cmr3335060qvb.3.1697569198391;
        Tue, 17 Oct 2023 11:59:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id pz2-20020ad45502000000b00655e428604esm768163qvb.137.2023.10.17.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:59:58 -0700 (PDT)
Date:   Tue, 17 Oct 2023 14:59:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZS7ZqztMbhrG52JQ@x1n>
References: <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d187891-f131-4912-82d8-13112125b210@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David,

On Tue, Oct 17, 2023 at 05:55:10PM +0200, David Hildenbrand wrote:
> Don't get me wrong, but this feature is already complicated enough that we
> should really think twice if we want to make this even more complicated and
> harder to maintain -- because once it's in we all know it's hard to remove
> and we can easily end up with a maintenance nightmare without sufficiently
> good use cases.

Yes I agree it's non-trivial.  My point is adding cross-mm doesn't make it
even more complicated.. afaics.

For example, could you provide a list of things that will be different to
support single mm or cross mm?  I see two things that can be different, but
I'd rather have all of them even if single-mm..

  - cgroup: I assume single-mm may avoid uncharge and charge again, but I
    prefer it be there even if we only allow single-mm.  For example, I'm
    not 100% sure whether memcg won't start to behave differently according
    to vma attribute in the future.

  - page pinning: I assume for single-mm we can avoid checking page pinning
    based on the fact that MMF_HAS_PINNED is per-mm, but I also prefer we
    fail explicitly on pinned pages over UFFDIO_MOVE because it doesn't
    sound correct, and avoid future changes on top of pinning solution that
    can change the assumption that "move a pin page within mm" is ok.

Is there anything else that will be different?  Did I miss something
important?

[...]

> BTW, wasn't there a way to do VM live-upgrade using fork() and replacing the
> binary? I recall that there was at some time either an implementation in
> QEMU or a proposal for an implementation; but I don't know how VM memory was
> provided. It's certainly harder to move VM memory using fork().

Maybe you meant the cpr project.  I didn't actually follow that much
previously (and will need to follow more after I took the migration
duties.. when there's a new post), but IIUC at least the latest version
needs to go with file memory only, not anonymous:

https://lore.kernel.org/all/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/

        Guest RAM must be non-volatile across reboot, which can be achieved by
        backing it with a dax device, or /dev/shm PKRAM as proposed in...

        Guest RAM must be backed by a memory backend with share=on, but
        cannot be memory-backend-ram.  The memory is re-mmap'd in the
        updated process, so guest ram is efficiently preserved in place

My understanding is there used to have solution for anonymous but that
needs extra kernel changes (MADV_DOEXEC).

https://lore.kernel.org/linux-mm/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/

I saw that you were part of the discussion, so maybe you will remember some
more clue of that part.

IIUC one core requirement of the whole approach is also that it will cover
VFIO and maintenance of device DMA mappings, in which case it'll be
different with any approach to leverage UFFDIO_MOVE because VFIO will not
be allowed here; again I hope we start with forbid pinning. But it should
be much cleaner on the design when with UFFDIO_MOVE, just not working with
VFIO.

One thing I'd need to measure is latency of UFFDIO_MOVE on page fault
resolutions.  I expect no more than tens of microseconds or even less.
Should be drastically smaller than remote postcopy anyway.

I'm probably off topic.. To go back: let's try to figure out what is
special with cross-mm support.  It'll be very weird in the future for
anyone to propose a patch just add a feature flag and declaring cross-mm
support, if the code is mostly all there.  Nothing stops us from discussing
what a cross-mm design will need.

[...]

> Is that and will that remain the case? I know people have been working on
> transparent user-space swapping using monitor processes using uffd. I
> thought there would have been ways to achieve that without any corporation
> of the dst.

Any example?

For what I am aware, all corporation requires uffd desc forwarding.  I
think the trick here is any userfaultfd desc must be created by its own
process, so far nobody else.  That's more or less saying "I want to do
this" from its own opinion.  The next is forwarding that to someone else.
Parent process is fine taking uffd of child with EVENT_FORK, as I
mentioned, but besides that nothing else I can think of that can violate
this guard to manipulate a random process.

Thanks,

-- 
Peter Xu

