Return-Path: <linux-kselftest+bounces-1667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896A80EC33
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0241C20A7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B95FEFC;
	Tue, 12 Dec 2023 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="DP9TISn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA84F4
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 04:41:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d307cf18fdso11748225ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 04:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702384881; x=1702989681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0UI/+qhCr+lBggOzWzGiJKh9KuolOqGxWBzrz2xh3g=;
        b=DP9TISn8zf08FZXUq56BoHUgCAQHw+p9tIUnqHGu9kzaFh8CvJVKQD+K8IUAUCtVR0
         lyPznRnfzDlqiorl06ViVw9LnVtKzX7k3f7vAYE8hLjRXndwSDZvYL/UDohFk/VEfq3h
         4pSpSuYXDIyAKm6xrSAUL3J6LDNrNsd0l/IHWeexFNdVd6w3LyI9bxI5MO9+7kbDY5wv
         CNWRjOQUnS7j0XIlut8HA4dFAM88Ik2XjDqYf3mm8G2nyE86EddsaoXvhBrAOpgEY9xx
         uDu34XkgBzk9jOb/oXm20erZUTK0yXNdcXLC8w7UTcTIgN/D2M+ArGxVv5CmrFMYzHg5
         UJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384881; x=1702989681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0UI/+qhCr+lBggOzWzGiJKh9KuolOqGxWBzrz2xh3g=;
        b=AQ0zZuUCqp1zzTPL7XpVCJQ0JtP8FXgHfxMxsJBh8UF78UZsQ2XzWuCC1o04zSTTAE
         R6DbAexZHyAnLDNk6GbwyxxjynlV0D9oI+XnOBt7z/Q7qF2ApZXG4xwAQKYo6WQnNS4e
         jKQrgC9k1fLKA92l+dbfZP3vLMiTdZQPxnrNVTarf5ypPHhk7eTi/DsyzD2k8wuPKf92
         0GS5igqiM+HL3hy+b7QEV5T3lGPtj6UzxPgI28CFTffN+cSeCHvM6wSZNblQdJWBQsGw
         euDl274Vt/i/hE7bydz+x/cqlwzUaxgkzehn6UYAquu9aNfx5Cw9MbSORuH70t+mRSCE
         S73A==
X-Gm-Message-State: AOJu0YxKMtu+bEOMNUaPlKfSmF5NxQVD4B2MeZG7ZZN8zDUe+nAOtuCG
	XCw0qKSV4SdAy3lsnfV/g7QhzADJh1ZdyUMfliam/A==
X-Google-Smtp-Source: AGHT+IHS/Z+mwvpoVVeNK3a4KjPTd64ECoTEIFO60YHkegn5DEbwuewms4n2mKqZR5d7o3VqKAPu8g==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:cec8 with SMTP id h12-20020a170902704c00b001d06ffdcec8mr3005669plt.129.1702384880602;
        Tue, 12 Dec 2023 04:41:20 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm8500451plt.71.2023.12.12.04.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 04:41:20 -0800 (PST)
Message-ID: <e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
Date: Tue, 12 Dec 2023 21:41:13 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Content-Language: en-US
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
 <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/12 19:39, Benjamin Tissoires wrote:
> Hi,
> 
> On Tue, Dec 12, 2023 at 9:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Hi,

Hi,

Thanks for reply.

>>
>> It is said eBPF is a safe way to extend kernels and that is very
>> attarctive, but we need to use kfuncs to add new usage of eBPF and
>> kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to ask
>> some questions:
>>
>> 1) Which should I choose, BPF kfuncs or ioctl, when adding a new feature
>> for userspace apps?
>> 2) How should I use BPF kfuncs from userspace apps if I add them?
>>
>> Here, a "userspace app" means something not like a system-wide daemon
>> like systemd (particularly, I have QEMU in mind). I'll describe the
>> context more below:
> 
> I'm probably not the best person in the world to answer your
> questions, Alexei and others from the BPF core group are, but given
> that you pointed at a thread I was involved in, I feel I can give you
> a few pointers.
> 
> But first and foremost, I encourage you to schedule an agenda item in
> the BPF office hour[4]. Being able to talk with the core people
> directly was tremendously helpful to me to understand their point.

I prefer emails because I'm not very fluent when speaking in English and 
may have a difficultly to listen to other people, but I may try it in 
future.

> 
> 
>>
>> ---
>>
>> I'm working on a new feature that aids virtio-net implementations using
>> tuntap virtual network device. You can see [1] for details, but
>> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
>> bytes.
>>
>> However, with long discussions we have confirmed extending
>> BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfuncs is
>> the way forward. So I decided how to add kfuncs to the kernel and how to
>> use it. There are rich documentations for the kernel side, but I found
>> little about the userspace. The best I could find is a systemd change
>> proposal that is based on WIP kernel changes[2].
> 
> Yes, as Alexei already replied, BPF is not adding new stable APIs,
> only kfuncs. The reason being that once it's marked as stable, you
> can't really remove it, even if you think it's badly designed and
> useless.
> 
> Kfuncs, OTOH are "unstable" by default meaning that the constraints
> around it are more relaxed.
> 
> However, "unstable" doesn't mean "unusable". It just means that the
> kernel might or might not have the function when you load your program
> in userspace. So you have to take that fact into account from day one,
> both from the kernel side and the userspace side. The kernel docs have
> a nice paragraph explaining that situation and makes the distinction
> between relatively unused kfuncs, and well known established ones.
> 
> Regarding the systemd discussion you are mentioning ([2]), this is
> something that I have on my plate for a long time. I think I even
> mentioned it to Alexei at Kernel Recipes this year, and he frowned his
> eyebrows when I mentioned it. And looking at the systemd code and the
> benefits over a plain ioctl, it is clearer that in that case, a plain
> ioctl is better, mostly because we already know the API and the
> semantic.
> 
> A kfunc would be interesting in cases where you are not sure about the
> overall design, and so you can give a shot at various API solutions
> without having to keep your bad v1 design forever.
> 
>>
>> So now I'm wondering how I should use BPF kfuncs from userspace apps if
>> I add them. In the systemd discussion, it is told that Linus said it's
>> fine to use BPF kfuncs in a private infrastructure big companies own, or
>> in systemd as those users know well about the system[3]. Indeed, those
>> users should be able to make more assumptions on the kernel than
>> "normal" userspace applications can.
>>
>> Returning to my proposal, I'm proposing a new feature to be used by QEMU
>> or other VMM applications. QEMU is more like a normal userspace
>> application, and usually does not make much assumptions on the kernel it
>> runs on. For example, it's generally safe to run a Debian container
>> including QEMU installed with apt on Fedora. BPF kfuncs may work even in
>> such a situation thanks to CO-RE, but it sounds like *accidentally*
>> creating UAPIs.
>>
>> Considering all above, how can I integrate BPF kfuncs to the application?
> 
> FWIW, I'm not sure you can rely on BPF calls from a container. There
> is a high chance the syscall gets disabled by the runtime.

Right. Container runtimes will not pass CAP_BPF by default, but that 
restriction can be lifted and I think that's a valid scenario.

> 
>>
>> If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle them
>> is to think of BPF programs as some sort of kernel modules and
>> incorporate logic that behaves like modprobe. More concretely, I can put
>> eBPF binaries to a directory like:
>> /usr/local/share/qemu/ebpf/$KERNEL_RELEASE
> 
> I would advise against that (one program per kernel release). Simply
> because your kfunc may or may not have been backported to kernel
> release v6.X.Y+1 while it was not there when v6.X.Y was out. So
> relying on the kernel number is just going to be a headache.
> 
> As I understand it, the way forward is to rely on the kernel, libbpf
> and CO-RE: if the function is not available, the program will simply
> not load, and you'll know that this version of the code is not
> available (or has changed API).
> 
> So what I would do if some kfunc API is becoming deprecated, is
> embedding both code paths in the same BPF unit, but marking them as
> not loaded by libppf. Then I can load the compilation unit, try v2 of
> the API, and if it's not available, try v1, and if not, then mention
> that I can not rely on BPF. Of course, this can also be done with
> separate compilation units.

Doesn't it mean that the kernel is free to break old versions of QEMU 
including BPF programs? That's something I'd like to avoid.

> 
>>
>> Then, QEMU can uname() and get the path to the binary. It will give an
>> error if it can't find the binary for the current kernel so that it
>> won't create accidental UAPIs.
>>
>> The obvious downside of this is that it complicates packaging a lot; it
>> requires packaging QEMU eBPF binaries each time a new kernel comes up.
>> This complexity is centrally managed by modprobe for kernel modules, but
>> apparently each application needs to take care of it for BPF programs.
> 
> For my primary use case: HID-BPF, I put kfuncs in kernel v6.3 and
> given that I haven't touch this part of the API, the same compilation
> unit compiled in the v6.3 era still works on a v6.7-rcx, so no, IMO
> it's not complex and doesn't require to follow the kernel releases
> (which is the whole point of HID-BPF FWIW).

I also expect BPF kfuncs will work well for long if I introduce its 
usage to QEMU in practice. That said, the interface stability is about 
when something unexpected happens. What if the interface QEMU relies on 
is deemed sub-optimal? Without following kernel releases, QEMU may 
accidentally lose the feature relying on eBPF.

> 
>>
>> In conclusion, I see too much complexity to use BPF in a userspace
>> application, which we didn't have to care for
>> BPF_PROG_TYPE_SOCKET_FILTER. Isn't there a better way? Or shouldn't I
>> use BPF in my case in the first place?
> 
> Given that I'm not a network person, I'm not sure about your use case,
> but I would make my decision based on:
> - do I know exactly what I want to achieve and I'm confident that I'll
> write the proper kernel API from day one? (if not then kfuncs is
> appealing because  it's less workload in the long run, but userspace
> needs to be slightly smarter)

Personally I'm confident that the initial UAPI design will not do a bad 
thing at least. However, there is a high chance that the design needs to 
be extended to accommodate new features.

> - are all of my use cases covered by using BPF? (what happens if I run
> QEMU in a container?) -> BPF might or might not be a solution

Yes. Containers can be used to 1) have a different userspace or 2) 
isolate things for security.

Regarding 2), QEMU and libvirt has sandbox mechanisms so we can rely on 
them instead of containers so we can just pass capabilities to the 
container. At least, we can always have a setuid helper outside 
container, and pass around file descriptors it generates.

So 1) is the only problem that matters.

> 
> But the nice thing about using BPF kfuncs is that it allows you to
> have a testing (not-)UAPI kernel interface. You can then implement the
> userspace changes and see how it behaves. And then, once you got the
> right design, you can decide to promote it to a proper syscall or
> ioctl if you want.

I expect it's possible to have testing ioctls. Quickly searching online, 
there are experimental ioctls[1][2]. I also know DRM has a relaxed 
policy for closed-source userspace[3].

So I'm seeing the distinction of UAPI/kfunc even less definitive; UAPIs 
can also be broken if the subsystem maintainers agree and there is no 
real user. I also think it's natural to say a kfunc will be stable as 
long as there is a user, but it contradicts with the current situation. 
kfunc is expressed as EXPORT_SYMBOL_GPL in the documentation, and Linus 
expects kfunc is for users like big companies or systemd, which closely 
follow the kernel, according to the systemd discussion I cited in the 
last email.

According to the discussion above, it may be better off abandoning BPF 
and implementing all in kernel, with ioctl as I have a (hopefully) sound 
idea of UAPI design. But I'll also continue considering the BPF option; 
BPF is still attractive due to its extensibility and safety.

Regards,
Akihiko Odaki

[1] 
https://www.kernel.org/doc/html/v6.6/userspace-api/media/v4l/hist-v4l2.html?highlight=experimental#experimental-api-elements
[2] 
https://www.kernel.org/doc/html/v6.6/userspace-api/media/dvb/dmx-expbuf.html?highlight=experimental
[3] 
https://www.kernel.org/doc/html/v6.6/gpu/drm-uapi.html#open-source-userspace-requirements

