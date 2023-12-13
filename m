Return-Path: <linux-kselftest+bounces-1819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C12810E45
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 11:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5416D1F2117D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A545224F1;
	Wed, 13 Dec 2023 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cieKq56x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AEAC
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702462942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKZ/Lgffh6YItnjPVn4vBB8RPVFHrOo+shUDIGrxj94=;
	b=cieKq56xiuDa0BJbwafnxTw49dnaxMprmRZJaQa3Xb26fJbqfMwSCpDBc+Uj0zhFIt66OU
	F94PtY2wFT6gr0DcjF5yhaclY8iqIixPgDBAbdl6+yAcYqlofcJMitmI4VSrgzYJEsDNqM
	WxRVwvkE1sc9hjx4RcSZ1AXFoiWiBGc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-6IuMDqIRM-Wr_2nXZQyXlA-1; Wed, 13 Dec 2023 05:22:21 -0500
X-MC-Unique: 6IuMDqIRM-Wr_2nXZQyXlA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a0c510419caso149390066b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 02:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462939; x=1703067739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKZ/Lgffh6YItnjPVn4vBB8RPVFHrOo+shUDIGrxj94=;
        b=UPA1/jgbdCgijnZrYh/6iDYyEWnYOn3U0wtIGGhEzZqj1d5wa2QIUv63vWAlmYTJJB
         Tw0vLASh9awJXTrVUQaLlPse7uDwK34Aiq21nHfyKF26gjVsrpAiZZtk0IkE7i+7S/OJ
         uC8aYwT5a1i8P+KPn/TkvFPI7Pxar3wIIxuNztMfwsQQigFixndJM8dRkj6yfjahFl9V
         mWzdYPap1kA67z3w4yHCNhybPogW8AzBsXQ/agRJVuH3zX+jHsp3zNZ+XWshLE4Cq5eq
         Z36uCfD+V7ZjuR5krEm2YDlRVAYk0OvsiQ8rISQQVYKRz5B//xcnbBIBTRG/2tg4AhNS
         TJsQ==
X-Gm-Message-State: AOJu0Yy53I7zPnQB4k+9MXN3Oz/kV8T0Kz4o4o39JB8FUXZMXRLZ9uJY
	qae/MJgHDvRXGc1dd5Hq9Tj3KL1/U9l+bM248rUNFHVyXGgShP99iCR2TzyS3jlJyZkzz0lELJ+
	Uzhe+YXbYb1J13FRjS9S/MvPZi42HP/7nPe0z7r0tBFZv
X-Received: by 2002:a17:906:225a:b0:a1d:14a6:2f6e with SMTP id 26-20020a170906225a00b00a1d14a62f6emr2930357ejr.56.1702462939394;
        Wed, 13 Dec 2023 02:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+jZ3nrLP+Wa+070vj84Vz+sqk6KDzCdmeuCiXsoUH30QJib9E+95nujJxOKEw6sQZT25ubnuLQgdExHfby+c=
X-Received: by 2002:a17:906:225a:b0:a1d:14a6:2f6e with SMTP id
 26-20020a170906225a00b00a1d14a62f6emr2930335ejr.56.1702462938844; Wed, 13 Dec
 2023 02:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
 <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com> <e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
In-Reply-To: <e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 13 Dec 2023 11:22:06 +0100
Message-ID: <CAO-hwJKMrWYRNpuprDj9=k87V0yHtLPEJuQ94bpOF3O81=v0kA@mail.gmail.com>
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

On Tue, Dec 12, 2023 at 1:41=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/12/12 19:39, Benjamin Tissoires wrote:
> > Hi,
> >
> > On Tue, Dec 12, 2023 at 9:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> Hi,
>
> Hi,
>
> Thanks for reply.
>
> >>
> >> It is said eBPF is a safe way to extend kernels and that is very
> >> attarctive, but we need to use kfuncs to add new usage of eBPF and
> >> kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to a=
sk
> >> some questions:
> >>
> >> 1) Which should I choose, BPF kfuncs or ioctl, when adding a new featu=
re
> >> for userspace apps?
> >> 2) How should I use BPF kfuncs from userspace apps if I add them?
> >>
> >> Here, a "userspace app" means something not like a system-wide daemon
> >> like systemd (particularly, I have QEMU in mind). I'll describe the
> >> context more below:
> >
> > I'm probably not the best person in the world to answer your
> > questions, Alexei and others from the BPF core group are, but given
> > that you pointed at a thread I was involved in, I feel I can give you
> > a few pointers.
> >
> > But first and foremost, I encourage you to schedule an agenda item in
> > the BPF office hour[4]. Being able to talk with the core people
> > directly was tremendously helpful to me to understand their point.
>
> I prefer emails because I'm not very fluent when speaking in English and
> may have a difficultly to listen to other people, but I may try it in
> future.
>
> >
> >
> >>
> >> ---
> >>
> >> I'm working on a new feature that aids virtio-net implementations usin=
g
> >> tuntap virtual network device. You can see [1] for details, but
> >> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four mo=
re
> >> bytes.
> >>
> >> However, with long discussions we have confirmed extending
> >> BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfuncs =
is
> >> the way forward. So I decided how to add kfuncs to the kernel and how =
to
> >> use it. There are rich documentations for the kernel side, but I found
> >> little about the userspace. The best I could find is a systemd change
> >> proposal that is based on WIP kernel changes[2].
> >
> > Yes, as Alexei already replied, BPF is not adding new stable APIs,
> > only kfuncs. The reason being that once it's marked as stable, you
> > can't really remove it, even if you think it's badly designed and
> > useless.
> >
> > Kfuncs, OTOH are "unstable" by default meaning that the constraints
> > around it are more relaxed.
> >
> > However, "unstable" doesn't mean "unusable". It just means that the
> > kernel might or might not have the function when you load your program
> > in userspace. So you have to take that fact into account from day one,
> > both from the kernel side and the userspace side. The kernel docs have
> > a nice paragraph explaining that situation and makes the distinction
> > between relatively unused kfuncs, and well known established ones.
> >
> > Regarding the systemd discussion you are mentioning ([2]), this is
> > something that I have on my plate for a long time. I think I even
> > mentioned it to Alexei at Kernel Recipes this year, and he frowned his
> > eyebrows when I mentioned it. And looking at the systemd code and the
> > benefits over a plain ioctl, it is clearer that in that case, a plain
> > ioctl is better, mostly because we already know the API and the
> > semantic.
> >
> > A kfunc would be interesting in cases where you are not sure about the
> > overall design, and so you can give a shot at various API solutions
> > without having to keep your bad v1 design forever.
> >
> >>
> >> So now I'm wondering how I should use BPF kfuncs from userspace apps i=
f
> >> I add them. In the systemd discussion, it is told that Linus said it's
> >> fine to use BPF kfuncs in a private infrastructure big companies own, =
or
> >> in systemd as those users know well about the system[3]. Indeed, those
> >> users should be able to make more assumptions on the kernel than
> >> "normal" userspace applications can.
> >>
> >> Returning to my proposal, I'm proposing a new feature to be used by QE=
MU
> >> or other VMM applications. QEMU is more like a normal userspace
> >> application, and usually does not make much assumptions on the kernel =
it
> >> runs on. For example, it's generally safe to run a Debian container
> >> including QEMU installed with apt on Fedora. BPF kfuncs may work even =
in
> >> such a situation thanks to CO-RE, but it sounds like *accidentally*
> >> creating UAPIs.
> >>
> >> Considering all above, how can I integrate BPF kfuncs to the applicati=
on?
> >
> > FWIW, I'm not sure you can rely on BPF calls from a container. There
> > is a high chance the syscall gets disabled by the runtime.
>
> Right. Container runtimes will not pass CAP_BPF by default, but that
> restriction can be lifted and I think that's a valid scenario.
>
> >
> >>
> >> If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle th=
em
> >> is to think of BPF programs as some sort of kernel modules and
> >> incorporate logic that behaves like modprobe. More concretely, I can p=
ut
> >> eBPF binaries to a directory like:
> >> /usr/local/share/qemu/ebpf/$KERNEL_RELEASE
> >
> > I would advise against that (one program per kernel release). Simply
> > because your kfunc may or may not have been backported to kernel
> > release v6.X.Y+1 while it was not there when v6.X.Y was out. So
> > relying on the kernel number is just going to be a headache.
> >
> > As I understand it, the way forward is to rely on the kernel, libbpf
> > and CO-RE: if the function is not available, the program will simply
> > not load, and you'll know that this version of the code is not
> > available (or has changed API).
> >
> > So what I would do if some kfunc API is becoming deprecated, is
> > embedding both code paths in the same BPF unit, but marking them as
> > not loaded by libppf. Then I can load the compilation unit, try v2 of
> > the API, and if it's not available, try v1, and if not, then mention
> > that I can not rely on BPF. Of course, this can also be done with
> > separate compilation units.
>
> Doesn't it mean that the kernel is free to break old versions of QEMU
> including BPF programs? That's something I'd like to avoid.

Couple of points here:
- when you say "the kernel", it feels like you are talking about an
external actor tampering with your code. But if you submit a kernel
patch with a specific use case and get yourself involved in the
community, why would anybody change your kfunc API without you knowing
it?
- the whole warning about "unstable" policy means that the user space
component should not take for granted the capability. So if the kfunc
changes/disappears for good reasons (because it was marked as well
used and deprecated for quite some time), qemu should not *break*, it
should not provide the functionality, or have a secondary plan.

But even if you are encountering such issues, in case of a change in
the ABI of your kfunc, it should be easy enough to backport the bpf
changes to your old QEMUs and ask users to upgrade the user space if
they upgrade their kernel.

AFAIU, it is as unstable as you want it to be. It's just that we are
not in the "we don't break user space" contract, because we are
talking about adding a kernel functionality from userspace, which
requires knowing the kernel intrinsics.

>
> >
> >>
> >> Then, QEMU can uname() and get the path to the binary. It will give an
> >> error if it can't find the binary for the current kernel so that it
> >> won't create accidental UAPIs.
> >>
> >> The obvious downside of this is that it complicates packaging a lot; i=
t
> >> requires packaging QEMU eBPF binaries each time a new kernel comes up.
> >> This complexity is centrally managed by modprobe for kernel modules, b=
ut
> >> apparently each application needs to take care of it for BPF programs.
> >
> > For my primary use case: HID-BPF, I put kfuncs in kernel v6.3 and
> > given that I haven't touch this part of the API, the same compilation
> > unit compiled in the v6.3 era still works on a v6.7-rcx, so no, IMO
> > it's not complex and doesn't require to follow the kernel releases
> > (which is the whole point of HID-BPF FWIW).
>
> I also expect BPF kfuncs will work well for long if I introduce its
> usage to QEMU in practice. That said, the interface stability is about
> when something unexpected happens. What if the interface QEMU relies on
> is deemed sub-optimal? Without following kernel releases, QEMU may
> accidentally lose the feature relying on eBPF.

In the same way, anybody can tamper with your ioctl or syscall without
QEMU knowing it.
And what you need to follow is not the kernel *releases*, but the
changes in the kfuncs you are interested in.

>
> >
> >>
> >> In conclusion, I see too much complexity to use BPF in a userspace
> >> application, which we didn't have to care for
> >> BPF_PROG_TYPE_SOCKET_FILTER. Isn't there a better way? Or shouldn't I
> >> use BPF in my case in the first place?
> >
> > Given that I'm not a network person, I'm not sure about your use case,
> > but I would make my decision based on:
> > - do I know exactly what I want to achieve and I'm confident that I'll
> > write the proper kernel API from day one? (if not then kfuncs is
> > appealing because  it's less workload in the long run, but userspace
> > needs to be slightly smarter)
>
> Personally I'm confident that the initial UAPI design will not do a bad
> thing at least. However, there is a high chance that the design needs to
> be extended to accommodate new features.

Not trying to offend you or anything, but designs can change for
multiple reasons. Floppy disks were a good design at the time, and it
took decades to remove support for it in the kernel. In the same way,
removing an architecture from the kernel is hard, because even if you
can not run a new kernel on those architectures, "we do not break
userspace".

The whole BPF approach is to say that users of BPF are not plain
random users, and they have to know a little bit of the kernel, and
they know that once the kfunc is here, it doesn't mean it'll stay here
forever.

>
> > - are all of my use cases covered by using BPF? (what happens if I run
> > QEMU in a container?) -> BPF might or might not be a solution
>
> Yes. Containers can be used to 1) have a different userspace or 2)
> isolate things for security.
>
> Regarding 2), QEMU and libvirt has sandbox mechanisms so we can rely on
> them instead of containers so we can just pass capabilities to the
> container. At least, we can always have a setuid helper outside
> container, and pass around file descriptors it generates.
>
> So 1) is the only problem that matters.
>
> >
> > But the nice thing about using BPF kfuncs is that it allows you to
> > have a testing (not-)UAPI kernel interface. You can then implement the
> > userspace changes and see how it behaves. And then, once you got the
> > right design, you can decide to promote it to a proper syscall or
> > ioctl if you want.
>
> I expect it's possible to have testing ioctls. Quickly searching online,
> there are experimental ioctls[1][2]. I also know DRM has a relaxed
> policy for closed-source userspace[3].

Sure, but handling a change in the API in those cases is tough in the
kernel. You probably need to bump versions, return different values
depending on how many parameters you are given, and you are never sure
the caller is using the right parameters. BPF simplifies this by
actually checking the types of the caller, and if there is a
discrepancy, it'll notify userspace that it is doing something bad.

>
> So I'm seeing the distinction of UAPI/kfunc even less definitive; UAPIs
> can also be broken if the subsystem maintainers agree and there is no
> real user. I also think it's natural to say a kfunc will be stable as
> long as there is a user, but it contradicts with the current situation.

Please read more carefully the kernel docs [4] (just quoting here the
beginning):

"""
Like any other change to the kernel, maintainers will not change or
remove a kfunc without having a reasonable justification. Whether or
not they'll choose to change a kfunc will ultimately depend on a
variety of factors, such as how widely used the kfunc is, how long the
kfunc has been in the kernel, whether an alternative kfunc exists,
what the norm is in terms of stability for the subsystem in question,
and of course what the technical cost is of continuing to support the
kfunc.
"""

> kfunc is expressed as EXPORT_SYMBOL_GPL in the documentation, and Linus
> expects kfunc is for users like big companies or systemd, which closely
> follow the kernel, according to the systemd discussion I cited in the
> last email.

Please re-read the doc[4], it's not a 1-to-1 matching to EXPORT_SYMBOL_GPL.
And being the one who reported Linus' words in that systemd thread,
Linus was not concerned about "potential situations that may or may
not happen", because he expected the people who use kfunc to do the
right thing. Because they are not average programmers. And QEMU
developers would definitely fit in that category IMO.

And the whole "you can consider kfunc similar to EXPORT_SYMBOL_GPL" is
just a warning for user space that the kfunc will never be kept only
for stability reasons. So when you want to use a kfunc, you need to be
aware of it and not segfault if it's not there (which can not happen
TBH unless you don't check that your program was correctly loaded).

>
> According to the discussion above, it may be better off abandoning BPF
> and implementing all in kernel, with ioctl as I have a (hopefully) sound
> idea of UAPI design. But I'll also continue considering the BPF option;
> BPF is still attractive due to its extensibility and safety.

We can not tell you to choose one solution over the other. The choice
is yours. I personally find BPF more appealing because it allows the
user space application to define its own kernel API for its own needs
while relying on just a few defined kfuncs.

But again, sometimes it doesn't work, like the systemd thread you
linked, it's too big overhead for little gain compared to an ioctl in
that particular case.

IMO the biggest issue for you is not the stability of the API, but the
container capabilities. Because allowing CAP_BPF allows for a whole
lot of nasty things to happen :)

Cheers,
Benjamin

>
> Regards,
> Akihiko Odaki
>
> [1]
> https://www.kernel.org/doc/html/v6.6/userspace-api/media/v4l/hist-v4l2.ht=
ml?highlight=3Dexperimental#experimental-api-elements
> [2]
> https://www.kernel.org/doc/html/v6.6/userspace-api/media/dvb/dmx-expbuf.h=
tml?highlight=3Dexperimental
> [3]
> https://www.kernel.org/doc/html/v6.6/gpu/drm-uapi.html#open-source-usersp=
ace-requirements
>

[4] https://www.kernel.org/doc/html/latest/bpf/kfuncs.html?highlight=3Dbpf#=
kfunc-lifecycle-expectations


