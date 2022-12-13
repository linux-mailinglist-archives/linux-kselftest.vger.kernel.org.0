Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5164B0AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 09:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiLMIAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 03:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiLMIAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 03:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6631C17E1D
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 23:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670918355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFqAyp486VxHBW/rh0z5cNT8CQKi3KWcwqHcpX33JJc=;
        b=HApDkL/dPOVCslOfSFPS36LR9DB3HdtuZNAXBMZA7ccYP3Hld5dZz13oXDssIchbXYGIWz
        PsuxxKqSuCPGrqtTSVGo68lQj+HF+b4Hr16PBLy9rH8AOlod3sgAL43ffj0NYwklDCgoLE
        PUnf0SkFC4RHQFGFyM8u6XEXHCvEygI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-AJMtAVf5MlSPleyZ2rV5sg-1; Tue, 13 Dec 2022 02:59:14 -0500
X-MC-Unique: AJMtAVf5MlSPleyZ2rV5sg-1
Received: by mail-il1-f197.google.com with SMTP id k6-20020a92c246000000b003035797fa8cso6835626ilo.8
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 23:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFqAyp486VxHBW/rh0z5cNT8CQKi3KWcwqHcpX33JJc=;
        b=elggc/zDrzSIRWuClybTwGeWJTPJ9rX9PWuhSBCm0EdMpp1pNKGhMh6+O8wf1J6fDm
         SX00e+LrOf+Xe79OD7XIzFBLHH/IMKFkWsTGS7cJPmTdznHeim7PrHj0KeY6G/wpv8WG
         AEsOw3EaSbOaxF4h/bE7PukH06n4vA6zTDuxgKio96z2SNIZHwsB1C+I+lvOuVt+X9/t
         qOkncHc0p8Z/1ysDGm3OrBqks+U1MXztQyV7HYTR2SNjp7nqxJShNgZRWOL6wZSuHyvR
         nrupuikZfEMbpZk2a9BDQw405tJnqEXU1F3Gb9U0UBapKMfstxT6o0kZVps/3Im7XOeR
         +glw==
X-Gm-Message-State: ANoB5pkMzfW6ue64fRBNPw6hENOXnTH2+m5CgPcKyitxdZa5Nrmu9VDn
        EN6tLOKd9zI15u+O2PSkRvT3zA/dZm3uKExWhX0Zy2DBNKqdCCclA/lR0nTuhpLavBuPtPR6IpW
        f8YW5SpY7vPxEITJD+xbC8ThaE9+wcH680/qnPDmlEy7i
X-Received: by 2002:a05:6e02:de1:b0:303:4414:8ea8 with SMTP id m1-20020a056e020de100b0030344148ea8mr12363606ilj.124.1670918353392;
        Mon, 12 Dec 2022 23:59:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51VT1t55LjXTVNhkuJSBctYXn0AktGweNXi3fQ/x2ZU6mKpAxCi6mJtBBpovEerJCMzX2bPS9ksh1rccU3g5o=
X-Received: by 2002:a05:6e02:de1:b0:303:4414:8ea8 with SMTP id
 m1-20020a056e020de100b0030344148ea8mr12363601ilj.124.1670918353170; Mon, 12
 Dec 2022 23:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-6-benjamin.tissoires@redhat.com> <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
 <53f21d98-4ee6-c0e9-1c0a-5fae23c1b9a8@meta.com> <Y5dxAz3QTQnaB71Q@kroah.com>
 <43e6e9ec-3a0c-7238-30b2-daa7e71b169b@meta.com> <Y5gbg820K5LHI7K6@kroah.com>
In-Reply-To: <Y5gbg820K5LHI7K6@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 13 Dec 2022 08:59:02 +0100
Message-ID: <CAO-hwJLs3a41cUvQ-sU04Pg4vJDiBGHfU=N_d_APhjEdQsR3Xg@mail.gmail.com>
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yonghong Song <yhs@meta.com>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 13, 2022 at 7:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 12, 2022 at 10:39:26AM -0800, Yonghong Song wrote:
> >
> >
> > On 12/12/22 10:20 AM, Greg KH wrote:
> > > On Mon, Dec 12, 2022 at 09:52:03AM -0800, Yonghong Song wrote:
> > > >
> > > >
> > > > On 12/12/22 9:02 AM, Benjamin Tissoires wrote:
> > > > > On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
> > > > > <benjamin.tissoires@redhat.com> wrote:
> > > > > >
> > > > > > Kind of a hack, but works for now:
> > > > > >
> > > > > > Instead of listening for any close of eBPF program, we now
> > > > > > decrement the refcount when we insert it in our internal
> > > > > > map of fd progs.
> > > > > >
> > > > > > This is safe to do because:
> > > > > > - we listen to any call of destructor of programs
> > > > > > - when a program is being destroyed, we disable it by removing
> > > > > >     it from any RCU list used by any HID device (so it will never
> > > > > >     be called)
> > > > > > - we then trigger a job to cleanup the prog fd map, but we overwrite
> > > > > >     the removal of the elements to not do anything on the programs, just
> > > > > >     remove the allocated space
> > > > > >
> > > > > > This is better than previously because we can remove the map of known
> > > > > > programs and their usage count. We now rely on the refcount of
> > > > > > bpf, which has greater chances of being accurate.
> > > > > >
> > > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > > >
> > > > > > ---
> > > > >
> > > > > So... I am a little bit embarrassed, but it turns out that this hack
> > > > > is not safe enough.
> > > > >
> > > > > If I compile the kernel with LLVM=1, the function
> > > > > bpf_prog_put_deferred() is optimized in a weird way: if we are not in
> > > > > irq, the function is inlined into __bpf_prog_put(), but if we are, the
> > > > > function is still kept around as it is called in a scheduled work
> > > > > item.
> > > > >
> > > > > This is something I completely overlooked: I assume that if the
> > > > > function would be inlined, the HID entrypoint BPF preloaded object
> > > > > would not be able to bind, thus deactivating HID-BPF safely. But if a
> > > > > function can be both inlined and not inlined, then I have no
> > > > > guarantees that my cleanup call will be called. Meaning that a HID
> > > > > device might believe there is still a bpf function to call. And things
> > > > > will get messy, with kernel crashes and others.
> > > >
> > > > You should not rely fentry to a static function. This is unstable
> > > > as compiler could inline it if that static function is called
> > > > directly. You could attach to a global function if it is not
> > > > compiled with lto.
> > >
> > > But now that the kernel does support LTO, how can you be sure this will
> > > always work properly?  The code author does not know if LTO will kick in
> > > and optimize this away or not, that's the linker's job.
> >
> > Ya, that is right. So for in-kernel bpf programs, attaching to global
> > functions are not safe either. For other not-in-kernel bpf programs, it
> > may not work but that is user's responsibility to adjust properly
> > (to different functions based on a particular build, etc.).
>
> So if in-kernel bpf programs will not work or are not safe, how will
> in-kernel bpf programs properly attach?

Sorry if that wasn't clear. Loading a bpf program from the kernel is
fine and safe. But it was the use of it that wasn't.

In my case, HID-BPF to fix devices is safe (whether the program is
loaded from the kernel or from userspace): the bpf JIT/verifier
ensures that there are no out of bound read/write and the API is
properly defined. But the problem I am facing with the generic bpf
implementation is that it is made to be a global processing and to
attach to one given function, when I wanted to have a couple function
+ device.

So in this patch, I actually abused BPF to get free event
notifications when the bpf program was released.
The first implementation (HID: initial BPF implementation) was safer
than this patch because I was using BPF for notifications of my
internals but I wasn't messing up with the reference count. So if I
did not get the events, I wouldn't decrement the bpf_prog and the end
result means that the bpf program would stay forever attached to the
device. Not user friendly but it doesn't introduce a kernel crash.

However, this patch is messing with reference counting of an internal
kernel object assuming I would always get the event. This is not the
case and so I get read after free errors.

TL;DR: (ab)using BPF internally for kernel introspection to manage
kernel structures is just plain wrong. Mea culpa.

Cheers,
Benjamin

