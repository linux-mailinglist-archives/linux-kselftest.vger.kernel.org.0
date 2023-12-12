Return-Path: <linux-kselftest+bounces-1663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDD80E955
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF0FB20B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5995CD00;
	Tue, 12 Dec 2023 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMAyum48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD8A0
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702377595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fggtRaV/8orZgO1gMNRIxp3acepW1r0vajRNrmoShyY=;
	b=cMAyum48wIBJj5VAD1MgNLRgEdL+bWiIP9boCXCsQ9AO/AmuAcDtjcq9MiGADFUf87//fs
	BtyFYWAkeNVc1HuN1+644on39Y1i7WnnM/A5sb80KpZ8WlHlrFcq0vMWjMxKTlWL/gDeyL
	NOG8Rt6AObUit9+qfKWulR2v7lMD8wU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-f14YaOfsPkmtzJ7jwcu0Kw-1; Tue, 12 Dec 2023 05:39:53 -0500
X-MC-Unique: f14YaOfsPkmtzJ7jwcu0Kw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1eb3f3dc2eso83637866b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 02:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377587; x=1702982387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fggtRaV/8orZgO1gMNRIxp3acepW1r0vajRNrmoShyY=;
        b=QCp6BMYFK83pwq3jyA1KrjqOkJ3KlBixEwvGA1nTGpw17dMuEGq80DHb3pjf4tGP7c
         dOk7lRBDGtQkV5yWomBVFPTv+wiVzG9oOO440Nc9/Z/x6h81Bk4H5hpUXSIYNRyUT1rv
         JspRFlW2Y3mOl5DBV3Bo1sDlwjH7dLuOmtRihwnnAIUF+Uk1mzqZnXeR7fIu4KUZz3T0
         GGlPseNpBX8lGs17XZfS5uIyV9H2Wg55pwkkl4jbnO+OICKeCJMydNm8B8VEm8b5MqzP
         HqyuauRwzkOev6aK60bgRcjNe53XFkaKE5jmkxEjoClk+ZztkhrVIWTxVMjJ9UByoH/B
         q1aA==
X-Gm-Message-State: AOJu0Yyr6Xo6dAznRhX1hxGtM1+DXtHhdZyXDrXyIPQ2PdNfTaLwy9dV
	HGHm8Lr6+lXmBEeWuyZqhrmZP53fSqxkinwqlfqqifuPlNJsFOAdwBCwTgLRiuToVDzQ8m+GwBJ
	5uog8nGp2gpHD5GYEcV3i6wEXAzfMFoyEGu2n9vLDsx/b
X-Received: by 2002:a17:906:5194:b0:a1a:4a36:66fc with SMTP id y20-20020a170906519400b00a1a4a3666fcmr1343851ejk.16.1702377587457;
        Tue, 12 Dec 2023 02:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1s9ejU0QHSLLSTC9/iMEf46k/k5nUUYOzmG44Y4BEDGsQWW58tFcSfCa8zIUz3Ryox9pKp23WQ8EeadbhgOA=
X-Received: by 2002:a17:906:5194:b0:a1a:4a36:66fc with SMTP id
 y20-20020a170906519400b00a1a4a3666fcmr1343842ejk.16.1702377586761; Tue, 12
 Dec 2023 02:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
In-Reply-To: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 12 Dec 2023 11:39:34 +0100
Message-ID: <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2023 at 9:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Hi,
>
> It is said eBPF is a safe way to extend kernels and that is very
> attarctive, but we need to use kfuncs to add new usage of eBPF and
> kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to ask
> some questions:
>
> 1) Which should I choose, BPF kfuncs or ioctl, when adding a new feature
> for userspace apps?
> 2) How should I use BPF kfuncs from userspace apps if I add them?
>
> Here, a "userspace app" means something not like a system-wide daemon
> like systemd (particularly, I have QEMU in mind). I'll describe the
> context more below:

I'm probably not the best person in the world to answer your
questions, Alexei and others from the BPF core group are, but given
that you pointed at a thread I was involved in, I feel I can give you
a few pointers.

But first and foremost, I encourage you to schedule an agenda item in
the BPF office hour[4]. Being able to talk with the core people
directly was tremendously helpful to me to understand their point.


>
> ---
>
> I'm working on a new feature that aids virtio-net implementations using
> tuntap virtual network device. You can see [1] for details, but
> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
> bytes.
>
> However, with long discussions we have confirmed extending
> BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfuncs is
> the way forward. So I decided how to add kfuncs to the kernel and how to
> use it. There are rich documentations for the kernel side, but I found
> little about the userspace. The best I could find is a systemd change
> proposal that is based on WIP kernel changes[2].

Yes, as Alexei already replied, BPF is not adding new stable APIs,
only kfuncs. The reason being that once it's marked as stable, you
can't really remove it, even if you think it's badly designed and
useless.

Kfuncs, OTOH are "unstable" by default meaning that the constraints
around it are more relaxed.

However, "unstable" doesn't mean "unusable". It just means that the
kernel might or might not have the function when you load your program
in userspace. So you have to take that fact into account from day one,
both from the kernel side and the userspace side. The kernel docs have
a nice paragraph explaining that situation and makes the distinction
between relatively unused kfuncs, and well known established ones.

Regarding the systemd discussion you are mentioning ([2]), this is
something that I have on my plate for a long time. I think I even
mentioned it to Alexei at Kernel Recipes this year, and he frowned his
eyebrows when I mentioned it. And looking at the systemd code and the
benefits over a plain ioctl, it is clearer that in that case, a plain
ioctl is better, mostly because we already know the API and the
semantic.

A kfunc would be interesting in cases where you are not sure about the
overall design, and so you can give a shot at various API solutions
without having to keep your bad v1 design forever.

>
> So now I'm wondering how I should use BPF kfuncs from userspace apps if
> I add them. In the systemd discussion, it is told that Linus said it's
> fine to use BPF kfuncs in a private infrastructure big companies own, or
> in systemd as those users know well about the system[3]. Indeed, those
> users should be able to make more assumptions on the kernel than
> "normal" userspace applications can.
>
> Returning to my proposal, I'm proposing a new feature to be used by QEMU
> or other VMM applications. QEMU is more like a normal userspace
> application, and usually does not make much assumptions on the kernel it
> runs on. For example, it's generally safe to run a Debian container
> including QEMU installed with apt on Fedora. BPF kfuncs may work even in
> such a situation thanks to CO-RE, but it sounds like *accidentally*
> creating UAPIs.
>
> Considering all above, how can I integrate BPF kfuncs to the application?

FWIW, I'm not sure you can rely on BPF calls from a container. There
is a high chance the syscall gets disabled by the runtime.

>
> If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle them
> is to think of BPF programs as some sort of kernel modules and
> incorporate logic that behaves like modprobe. More concretely, I can put
> eBPF binaries to a directory like:
> /usr/local/share/qemu/ebpf/$KERNEL_RELEASE

I would advise against that (one program per kernel release). Simply
because your kfunc may or may not have been backported to kernel
release v6.X.Y+1 while it was not there when v6.X.Y was out. So
relying on the kernel number is just going to be a headache.

As I understand it, the way forward is to rely on the kernel, libbpf
and CO-RE: if the function is not available, the program will simply
not load, and you'll know that this version of the code is not
available (or has changed API).

So what I would do if some kfunc API is becoming deprecated, is
embedding both code paths in the same BPF unit, but marking them as
not loaded by libppf. Then I can load the compilation unit, try v2 of
the API, and if it's not available, try v1, and if not, then mention
that I can not rely on BPF. Of course, this can also be done with
separate compilation units.

>
> Then, QEMU can uname() and get the path to the binary. It will give an
> error if it can't find the binary for the current kernel so that it
> won't create accidental UAPIs.
>
> The obvious downside of this is that it complicates packaging a lot; it
> requires packaging QEMU eBPF binaries each time a new kernel comes up.
> This complexity is centrally managed by modprobe for kernel modules, but
> apparently each application needs to take care of it for BPF programs.

For my primary use case: HID-BPF, I put kfuncs in kernel v6.3 and
given that I haven't touch this part of the API, the same compilation
unit compiled in the v6.3 era still works on a v6.7-rcx, so no, IMO
it's not complex and doesn't require to follow the kernel releases
(which is the whole point of HID-BPF FWIW).

>
> In conclusion, I see too much complexity to use BPF in a userspace
> application, which we didn't have to care for
> BPF_PROG_TYPE_SOCKET_FILTER. Isn't there a better way? Or shouldn't I
> use BPF in my case in the first place?

Given that I'm not a network person, I'm not sure about your use case,
but I would make my decision based on:
- do I know exactly what I want to achieve and I'm confident that I'll
write the proper kernel API from day one? (if not then kfuncs is
appealing because  it's less workload in the long run, but userspace
needs to be slightly smarter)
- are all of my use cases covered by using BPF? (what happens if I run
QEMU in a container?) -> BPF might or might not be a solution

But the nice thing about using BPF kfuncs is that it allows you to
have a testing (not-)UAPI kernel interface. You can then implement the
userspace changes and see how it behaves. And then, once you got the
right design, you can decide to promote it to a proper syscall or
ioctl if you want.

Cheers,
Benjamin

>
> Thanks,
> Akihiko Odaki
>
> [1]
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/
> [2] https://github.com/systemd/systemd/pull/29797
> [3] https://github.com/systemd/systemd/pull/29797#discussion_r1384637939
>

[4] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXj=
ywWa0AejEveU


