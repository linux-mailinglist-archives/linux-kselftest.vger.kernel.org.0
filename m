Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCF4C2D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiBXNuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 08:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiBXNuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 08:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FECF268364
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645710575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W72ne0G9b3MyyFBiSEwGqBYz/xzB4RzahKKge7NcOro=;
        b=X8ghXdUbb9c5nRblZoLAV+on3+vyCKG032dNssXQGSpoW12TdDqOCYjK9RH71urYVLfxZ+
        wZCysG1DqkzCBtMB1DZSOrB8wIwTPkwEVslTZfZyWwNaMJPWlbxW/rnz1VzgQEqsCrwXSy
        VCq/UT/eR0sk8mT9f1QWm1RXX4A72JE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-7LnAArZAPO-TWJKTWYYhXw-1; Thu, 24 Feb 2022 08:49:34 -0500
X-MC-Unique: 7LnAArZAPO-TWJKTWYYhXw-1
Received: by mail-pj1-f71.google.com with SMTP id lp2-20020a17090b4a8200b001bc449ecbceso3614874pjb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 05:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W72ne0G9b3MyyFBiSEwGqBYz/xzB4RzahKKge7NcOro=;
        b=s7ZNmPeStp/r27Os/heUoBDduI2wcKRv8bAqYPThh+XUYlvetejGa5rlm4kcTfeh2I
         rrfrJP/f4iJtirVZrHuFAhCQcP6CjvZsjKgQ4eJMruf+o7ZqYH4jVxSDwihLoh79M1Of
         UG9iL2Xjt10I8q+Wmh4ZeBCjAjJlcPWI057wu66gX8+9ZLeAgABab9gSq6Zr7ANnNVpw
         Rj1uyLq83a17LTUar76j4YOnoU2QzaYm5qEgPI0RfeaH6hAiZaChM+4O4LQbmK53ZYp/
         QhP0ZLk1L2v/SK5I3z74mBoFsu2LtBg6BStWqeAiqeVLZmpW6YxMbS8mRFnFF+3SIVLD
         LDEA==
X-Gm-Message-State: AOAM532wvHGOuvmPVeWUB3GIFmDp9z5Yapp9UJiXSIGHMAd223qzJETR
        dnN/+0cdTzyUhOCjwh2D+9LL7wd64iBItFirzG0OZAJM9T60gKyS4PIWQTJj0hsaZfSeeG7WaVp
        WmliVAhJ2q021TJSnHJlXvDY79fGKw4OzO2AEhszltCPj
X-Received: by 2002:a63:e043:0:b0:36f:e3b2:1f65 with SMTP id n3-20020a63e043000000b0036fe3b21f65mr2320767pgj.191.1645710572676;
        Thu, 24 Feb 2022 05:49:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVsPyxV1f6af6vHhonpw0QODAIZHBBNj9NxHUgER8f4p1IZtmnoRpztn7Iw19G+qUQT9leUes/qss6JhVAQlE=
X-Received: by 2002:a63:e043:0:b0:36f:e3b2:1f65 with SMTP id
 n3-20020a63e043000000b0036fe3b21f65mr2320745pgj.191.1645710572314; Thu, 24
 Feb 2022 05:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20220224110828.2168231-1-benjamin.tissoires@redhat.com> <YhdsgokMMSEQ0Yc8@kroah.com>
In-Reply-To: <YhdsgokMMSEQ0Yc8@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 24 Feb 2022 14:49:21 +0100
Message-ID: <CAO-hwJJcepWJaU9Ytuwe_TiuZUGTq_ivKknX8x8Ws=zBFUp0SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Introduce eBPF support for HID devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Peter Hutterer <peter.hutterer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Thanks for the quick answer :)

On Thu, Feb 24, 2022 at 12:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 24, 2022 at 12:08:22PM +0100, Benjamin Tissoires wrote:
> > Hi there,
> >
> > This series introduces support of eBPF for HID devices.
> >
> > I have several use cases where eBPF could be interesting for those
> > input devices:
> >
> > - simple fixup of report descriptor:
> >
> > In the HID tree, we have half of the drivers that are "simple" and
> > that just fix one key or one byte in the report descriptor.
> > Currently, for users of such devices, the process of fixing them
> > is long and painful.
> > With eBPF, we could externalize those fixups in one external repo,
> > ship various CoRe bpf programs and have those programs loaded at boot
> > time without having to install a new kernel (and wait 6 months for the
> > fix to land in the distro kernel)
>
> Why would a distro update such an external repo faster than they update
> the kernel?  Many sane distros update their kernel faster than other
> packages already, how about fixing your distro?  :)

Heh, I'm going to try to dodge the incoming rhel bullet :)

It's true that thanks to the work of the stable folks we don't have to
wait 6 months for a fix to come in. However, I think having a single
file to drop in a directory would be easier for development/testing
(and distribution of that file between developers/testers) than
requiring people to recompile their kernel.

Brain fart: is there any chance we could keep the validated bpf
programs in the kernel tree?

>
> I'm all for the idea of using ebpf for HID devices, but now we have to
> keep track of multiple packages to be in sync here.  Is this making
> things harder overall?

Probably, and this is also maybe opening a can of worms. Vendors will
be able to say "use that bpf program for my HID device because the
firmware is bogus".

OTOH, as far as I understand, you can not load a BPF program in the
kernel that uses GPL-declared functions if your BPF program is not
GPL. Which means that if firmware vendors want to distribute blobs
through BPF, either it's GPL and they have to provide the sources, or
it's not happening.

I am not entirely clear on which plan I want to have for userspace.
I'd like to have libinput on board, but right now, Peter's stance is
"not in my garden" (and he has good reasons for it).
So my initial plan is to cook and hold the bpf programs in hid-tools,
which is the repo I am using for the regression tests on HID.

I plan on building a systemd intrinsic that would detect the HID
VID/PID and then load the various BPF programs associated with the
small fixes.
Note that everything can not be fixed through eBPF, simply because at
boot we don't always have the root partition mounted.

>
> > - Universal Stylus Interface (or any other new fancy feature that
> >   requires a new kernel API)
> >
> > See [0].
> > Basically, USI pens are requiring a new kernel API because there are
> > some channels of communication our HID and input stack are not capable
> > of. Instead of using hidraw or creating new sysfs or ioctls, we can rely
> > on eBPF to have the kernel API controlled by the consumer and to not
> > impact the performances by waking up userspace every time there is an
> > event.
>
> How is userspace supposed to interact with these devices in a unified
> way then?  This would allow random new interfaces to be created, one
> each for each device, and again, be a pain to track for a distro to keep
> in sync.  And how are you going to keep the ebpf interface these
> provides in sync with the userspace program?

Right now, the idea we have is to export the USI specifics through
dbus. This has a couple of advantages: we are not tied to USI and can
"emulate" those parameters by storing them on disk instead of in the
pen, and this is easily accessible from all applications directly.

I am trying to push to have one implementation of that dbus service
with the Intel and ChromeOS folks so general linux doesn't have to
recreate it. But if you look at it, with hidraw nothing prevents
someone from writing such a library/daemon in its own world without
sharing it with anybody.

The main advantage of eBPF compared to hidraw is that you can analyse
the incoming event without waking userspace and only wake it up when
there is something noticeable.

In terms of random interfaces, yes, this is a good point. But the way
I see it is that we can provide one kernel API (eBPF for HID) which we
will maintain and not have to maintain forever a badly designed kernel
API for a specific device. Though also note that USI is a HID standard
(I think there is a second one), so AFAICT, the same bpf program
should be able to be generic enough to be cross vendor. So there will
be one provider only for USI.

>
> > - Surface Dial
> >
> > This device is a "puck" from Microsoft, basically a rotary dial with a
> > push button. The kernel already exports it as such but doesn't handle
> > the haptic feedback we can get out of it.
> > Furthermore, that device is not recognized by userspace and so it's a
> > nice paperwight in the end.
> >
> > With eBPF, we can morph that device into a mouse, and convert the dial
> > events into wheel events.
>
> Why can't we do this in the kernel today?

We can do this in the kernel, sure, but that means the kernel has to
make a choice.
Right now, the device is exported as a "rotary button". Userspace
should know what it is, and handle it properly.
Turns out that there are not so many developers who care about it, so
there is no implementation of it in userspace.

So the idea to morph it into a special mouse is interesting, but
suddenly we are lying to userspace about the device, and this can have
unanticipated consequences.

If we load a bpf program that morphs the device into a mouse, suddenly
the kernel is not the one responsible for that choice, but the user
is.

For instance, we could imagine a program that pops up a pie menu like
Windows does and enables/disables the haptic feedback based on what is
on screen.

With a kernel implementation, we need a driver with a config
parameter, a new haptic kernel API which is unlikely to be compatible
with the forcepad haptic API that Angela is working on :/

>
> > Also, we can set/unset the haptic feedback
> > from userspace. The convenient part of BPF makes it that the kernel
> > doesn't make any choice that would need to be reverted because that
> > specific userspace doesn't handle it properly or because that other
> > one expects it to be different.
>
> Again, what would the new api for the haptic device be?  Who is going to
> mantain that on the userspace side?  What library is going to use this?
> Is libinput going to now be responsible for interacting this way with
> the kernel?

In that particular case, I don't think the haptic API should be very
complex. On Windows, you only have a toggle: on/off.
And actually I'd love to see the haptic feedback enabled or disabled
based on the context: do you need one tick every 5 degrees? haptic
enabled, if not (smooth scrolling where every minimal step matters),
then haptic disabled.

Note that this is also entirely possible to be done in pure hidraw without BPF.

In terms of "who" that's up in the air. I am not using the device
enough to maintain such a tool (and definitively not skilled enough
for the UI part).

>
> > - firewall
> >
> > What if we want to prevent other users to access a specific feature of a
> > device? (think a possibly bonker firmware update entry popint)
> > With eBPF, we can intercept any HID command emitted to the device and
> > validate it or not.
>
> This I like.

Heh. It's a shame that it's the part I left out from the series :)

>
> > This also allows to sync the state between the userspace and the
> > kernel/bpf program because we can intercept any incoming command.
> >
> > - tracing
> >
> > The last usage I have in mind is tracing events and all the fun we can
> > do we BPF to summarize and analyze events.
> > Right now, tracing relies on hidraw. It works well except for a couple
> > of issues:
> >  1. if the driver doesn't export a hidraw node, we can't trace anything
> >     (eBPF will be a "god-mode" there, so it might raise some eyebrows)
> >  2. hidraw doesn't catch the other process requests to the device, which
> >     means that we have cases where we need to add printks to the kernel
> >     to understand what is happening.
>
> Tracing is also nice, I like this too.
>
> Anyway, I like the idea, I'm just worried we are pushing complexity out
> into userspace which would make it "someone else's problem."  The job of
> a kernel is to provide a way to abstract devices in a standard way.  To
> force userspace to write a "new program per input device" would be a
> total mess and a step backwards.
>

Yeah, I completely understand the view. However, please keep in mind
that most of it (though not firewall and some corner cases of tracing)
is already possible to do through hidraw.
One other example of that is SDL. We got Sony involved to create a
nice driver for the DualSense controller (the PS5 one), but they
simply ignore it and use plain HID (through hidraw). They have the
advantage of this being cross-platform and can provide a consistent
experience across platforms. And as a result, in the kernel, we have
to hands up the handling of the device whenever somebody opens a
hidraw node for those devices (Steam is also doing the same FWIW).

Which reminds me that I also have another use-case: joystick
dead-zone. You can have a small filter that configures the dead zone
and doesn't even wake up userspace for those hardware glitches...

Anyway, IOW, I think the bpf approach will allow kernel-like
performances of hidraw applications, and I would be more inclined to
ask people to move their weird issue in userspace thanks to that.

And I am also open to any suggestions on how to better handle your remarks :)

Cheers,
Benjamin

