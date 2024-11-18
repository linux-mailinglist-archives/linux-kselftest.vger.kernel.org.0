Return-Path: <linux-kselftest+bounces-22177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B79D1102
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED458283027
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3B19884B;
	Mon, 18 Nov 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdOZWBTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB8199239
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934468; cv=none; b=r7dtq52TWx8WveBEaCxvayGSjFejMusEQRRbIYd262UCUbmQkt1pBa4wNmOtFxzQ2sATNRbcUL9UJPxvjJ0cKjKHNoqR2V7dd/3MOrf7eqDa/o8XUhH9Ld/sHNXvulPt3LHHDhagOfFUFosIoU6xShx0CBvdhD3Cnl7mEycS0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934468; c=relaxed/simple;
	bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGOHa1tYGcaXMn6Q7mD2NIfMiKICWkFOOn011r7RFh5EjqK4H+k9Hd6euV1BkxPB46ayClKiwW0WFjCGAIIV1PU4rv4mSZ/VxVneUQo4bhR68V0su5CzRfscn+VFlnR0nY6nOD9YoRp6Qr3iR85hQoyNFILtU4OIdh6nfQ6HxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdOZWBTK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so6172a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731934464; x=1732539264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
        b=TdOZWBTKFiS5gRjdYjk9+2Hyj9TFvL1/Qx0tNNCB2IgLrmjW5yvKKbk73asRnnQBli
         ilMGAV7y2yDGvQNZE4bFat/WU6KH4cC/dc0wRFGOrpcHzRy15FzIvt0K8feDzGZJXunG
         JYao2hKg+OdPml5zil28vesqetiCcX7hhKuAYxEZ+Fzik8EvCKFEDUAJdkZcs6rvXfbj
         t6zhTNj3KN/XtS2f/MLyfUKyacNLOcTiKc7K76Rjg/ZSmqpatC2ogaamGL89Knax+y7J
         QV5IMcL/ymSOWYEtHO1ALD2b7i+Hxc4oHAOFMVyRSkPQq4awbdZZrXAFRiSEvY1Q0em9
         rRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731934464; x=1732539264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZav5imPpDajhAmqlY2eOGgnED4NjQI6+JJoDQ71N0=;
        b=GMFnozHZjQPqwbRiAfOfN0YQEuUfsu97ksaSo+13yE6Ih/W+kGH6OcHy4HyJhEp+cK
         fa3k23cgkxb/GOl6sL4NNQ+WRBxhkuEuuoUJumE1Rmmr2BoUHJ/7fs8OIXpaxc71k/NK
         vfVCXeAduVbahQ8oG2FA9myWKiLHpzDuLhz2V1T0AX+Bji/7W3JkJV8OguxB60eCk+fa
         UErH+s+7oucO17aFMJg+7oTaBhzx/zcIcaJaRN4n0aZhu7hVC6YPglW0xhhK+u2PVo82
         zIW+7MQqbb/9FVjBmWMJU8fdpqr0gfHn95YRywy5AtXShJ+WqQfVzjI0YyyJOq/FFfoV
         jBWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIA8a9u48Wv79b55D5KbpDLiWYUMEpQECujf+tW8kJ1B8+jX1PplRZhIoulT1YrWRIzZj7aNxEk8cB6agIwfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzRGHLOAC1j2pAjbOql4w0VRwX316Ek46KKyU/iCELqreP9cz
	XhAcoT7DjCvbg1hpnTSVRfTp57U6EEcI7d2Uz2MKUUoALXC/p+iuAht98fdMqls8nagnJJ71WA0
	uf5JGWwOB5ZJh4b1Xxp5/j0my5OYQzyo4HpJ4
X-Gm-Gg: ASbGncup4aadJqBq9IDsknxVTjQ+v1Bv9VrUXievAUT4Ke3EMC4X9ZWIhjjySKdgZXd
	OTaYf3uPhemXKED4QrFhleOLk92PuT5ifpVVST28YnkmHI1rUmXjunLKQ4Gg=
X-Google-Smtp-Source: AGHT+IFWl9n8jfw906nl94a7cbMwHIP9Gd4TNcFZWOOm8Tvrj69mcd0XEdLXVwoqv6yIo+K1feYbwLqCVdza/E5/6V8=
X-Received: by 2002:aa7:de84:0:b0:5cf:6f4d:c29c with SMTP id
 4fb4d7f45d1cf-5cfa298afd6mr136645a12.4.1731934463854; Mon, 18 Nov 2024
 04:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
In-Reply-To: <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 Nov 2024 13:53:46 +0100
Message-ID: <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 12:17=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> I mean, even though I'm not a huge fan of kernel pointer hashing etc. thi=
s
> is obviously leaking as much information as you might want about kernel
> internal state to the point of maybe making the whole kernel pointer
> hashing thing moot.
>
> I know this requires CAP_SYS_ADMIN, but there are things that also requir=
e
> that which _still_ obscure kernel pointers.
>
> And you're outputting it all to dmesg.
>
> So yeah, a security person (Jann?) would be better placed to comment on
> this than me, but are we sure we want to do this when not in a
> CONFIG_DEBUG_VM* kernel?

I guess there are two parts to this - what root is allowed to do, and
what information we're fine with exposing to dmesg.

If the lockdown LSM is not set to LOCKDOWN_CONFIDENTIALITY_MAX, the
kernel allows root to read kernel memory through some interfaces - in
particular, BPF allows reading arbitrary kernel memory, and perf
allows reading at least some stuff (like kernel register states). With
lockdown in the most restrictive mode, the kernel tries to prevent
root from reading arbitrary kernel memory, but we don't really change
how much information goes into dmesg. (And I imagine you could
probably still get kernel pointers out of BPF somehow even in the most
restrictive lockdown mode, but that's probably not relevant.)

The main issue with dmesg is that some systems make its contents
available to code that is not running with root privileges; and I
think it is also sometimes stored persistently in unencrypted form
(like in EFI pstore) even when everything else on the system is
encrypted.
So on one hand, we definitely shouldn't print the contents of random
chunks of memory into dmesg without a good reason; on the other hand,
for example we do already print kernel register state on WARN() (which
often includes kernel pointers and could theoretically include more
sensitive data too).

So I think showing page metadata to root when requested is probably
okay as a tradeoff? And dumping that data into dmesg is maybe not
great, but acceptable as long as only root can actually trigger this?

I don't really have a strong opinion on this...


To me, a bigger issue is that dump_page() looks like it might be racy,
which is maybe not terrible in debugging code that only runs when
something has already gone wrong, but bad if it is in code that root
can trigger on demand? __dump_page() copies the given page with
memcpy(), which I don't think guarantees enough atomicity with
concurrent updates of page->mapping or such, so dump_mapping() could
probably run on a bogus pointer. Even without torn pointers, I think
there could be a UAF if the page's mapping is destroyed while we're
going through dump_page(), since the page might not be locked. And in
dump_mapping(), the strncpy_from_kernel_nofault() also doesn't guard
against concurrent renaming of the dentry, which I think again would
probably result in UAF.
So I think dump_page() in its current form is not something we should
expose to a userspace-reachable API.

