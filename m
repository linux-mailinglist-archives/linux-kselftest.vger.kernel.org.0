Return-Path: <linux-kselftest+bounces-11042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6828D693B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD861C21C8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CFB7E78E;
	Fri, 31 May 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxUr6zS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545C7E0FB;
	Fri, 31 May 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181582; cv=none; b=fxXLi01DaN4snlu2to1hhcRKXq4W1+iLJFFE7YpdVyLYlShvtiAQaoOQ/L7BAhNJkOGGVc7aN/IFymICbOZncpJ9qsSj7ND5olbgreYtJMKfUUzWPN9MuGRPwUFRs1v65YbiBH46k2BKjLeq4FuYde4kmbCCwz7/QKxFRZ+nBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181582; c=relaxed/simple;
	bh=alAGf+hoGe9w4xNackz5+NTh5YYwaN66OO8rFdNrCI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlPDwHoAmHD0eQwGZypsWAc/apu19SVjk1JJobBpIaGy6P8NZYVLd4/5nvdCnvO4zHgoLfYaqnpUpTKELsatLkYCk66Wox7KoZdULXRbpyjGpIE7/C65zU7nKZnodC52SwZQidTcYQxzUEBTGwF3mlL73oGgEu7H/AFSr5BzXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxUr6zS1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4211245e889so22375565e9.2;
        Fri, 31 May 2024 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717181579; x=1717786379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvFU/amD5xfx3xyLZtbEi3anS8Y5e06mWisgXrkvZ00=;
        b=RxUr6zS1TlfwEF6KYxCLcOsGY/rMEANQpBx4GLDlY7qQsQWpu1v7mwrIPXIsAeDFuJ
         gEal9L8TeSICgdzGIYMTh3vwS+hps0awEN4s3p11bTE9HL6mz4kvzbAruKF0Zc9wRrwN
         DsJYS2B3c35a2Aqb76l4WuFgqOgUhfHTKeXFhgS2jpbhpg2//PAzBJJV8U1xwlO1icFX
         DMPZaHYLhP49zozc517glOkS9CK6rgjni+RtkkqZrJn8CcPrjbmV7oMyohBqCjvlCqyM
         RcCOwy7QXix0n5W30cxJexXv9Xl1OOMxxpkM4XQc+jEqfeQBlj7DZ6n25EZeD5ux8Xfd
         +Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181579; x=1717786379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvFU/amD5xfx3xyLZtbEi3anS8Y5e06mWisgXrkvZ00=;
        b=VEoCPS9kh3VMOrvubAlGUbAN1es+VARFhDKCHKYH7vwf0DwyDpXbizYA6JRWmElE50
         xC24RyBYQfea+AlJTo2C6RroKu3nz8Uez2ROQaE3sOV1abXoCEv3LAjN4/h6vEsBUky8
         Rm7sRZ+kEAb3rqFiNZWjGycKR48rllZFwuJGAJXnVv15XXoRMM/al8nN3ZSnjWMWROWF
         kKZ73Lua+GFloz0Qq3xkx3myHC8XnshM4yUEJXCOLub18FwUANO+aC7iRaxJ/CuZtkDm
         /MZC9UbJiExD07wr/ZncZ3FS1vjhZ1BUdKBcmNPUt5mu0QavrsBIc4U3UTtpn/f/smvd
         aT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxC7wWsJRyhbNcwAlx1EKo9Ao27gPbr6R5/gpNRPIO7RdZ8TN7cHVR1btxC10y++XU2OSUvvvGBJa2Mgdj98BQ0TC5hYHp7JZ2bStWvTj/s6woML5/9ZbZ/8tAc8/wQtGEBbfKS8gtEfiA5OWQx3tjTjp3qLHLwdO1ErTLZbLenDfgBPB2NkysMnqOksWc9hPddz2+fD+zRD0NWSdtIyxrz5VNdZwrTZNd1fjDYtV8aPBk8yTXsPxrANU=
X-Gm-Message-State: AOJu0YwQNMUedlX8ozSv2yFscrqz0Ff9+doB+3Dp4Wf9ag1M5kQXTHyR
	ahrbfNbtw+/wY0DMUN7LgMXcqD7TBCcFulScOETN8nwSWBLfFHCu04FS8ehAZRMxi6x/Mgip8DH
	cjqevYzXmTOUWM/zGiM7Ht4+j1yAE5dT4
X-Google-Smtp-Source: AGHT+IHBMg21qPkjzFruK+M1hbzn0tWuB5gx1V6I+5jFW7DiW6MxJ30/c5hGpj7fcavQD5SeN1bli1hplIYDuByDrVU=
X-Received: by 2002:a05:600c:1d85:b0:421:2efe:5aa8 with SMTP id
 5b1f17b1804b1-4212efe5bebmr18344335e9.18.1717181578869; Fri, 31 May 2024
 11:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
 <20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8@kernel.org>
 <CAADnVQJbc4uVmhh+ABPMBGFjTYwQQp3wGLeTBYEUWti3R8V8aw@mail.gmail.com> <bbmrcmm2tsbxm3f7bdjbdprqt62hkrw3d7w4w4taxaxx24rlu5@iu5krfvhcaru>
In-Reply-To: <bbmrcmm2tsbxm3f7bdjbdprqt62hkrw3d7w4w4taxaxx24rlu5@iu5krfvhcaru>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 May 2024 11:52:47 -0700
Message-ID: <CAADnVQJfNxdZebtu9f8a+JwXn0tJLhRK7bnG+dhcnb0BN2kOSw@mail.gmail.com>
Subject: Re: [PATCH HID 03/13] HID: bpf: implement HID-BPF through bpf_struct_ops
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:38=E2=80=AFAM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
>
> > Take a look at include/linux/bpf_mprog.h
> > I suspect it might be useful here too.
>
> From the quick look of it this is interesting, but for plain struct
> bpf_prog, right?
>
> So I would have to adapt this include for struct_ops?

yeah. It needs work to be adapted to work with struct-ops.
I mentioned it mainly from uapi perspective.
BPF_F_BEFORE, BPF_F_AFTER, BPF_F_REPLACE.
Would be good to keep things consistent.

> > > @@ -112,6 +113,63 @@ struct hid_ops {
> > >
> > >  extern struct hid_ops *hid_ops;
> > >
> > > +/**
> > > + * struct hid_bpf_ops - A BPF struct_ops of callbacks allowing to at=
tach HID-BPF
> > > + *                     programs to a HID device
> > > + * @hid_id: the HID uniq ID to attach to. This is writeable before `=
`load()``, and
> > > + *         cannot be changed after
> > > + * @flags: &enum hid_bpf_attach_flags to assign flags before ``load(=
)``.
> > > + *        Writeable only before ``load()``
> > > + */
> > > +struct hid_bpf_ops {
> > > +       /* hid_id needs to stay first so we can easily change it
> > > +        * from userspace.
> > > +        */
> >
> > hmm.
> > patch 5 just does:
> > +       skel->struct_ops.mouse_invert->hid_id =3D hid_id;
> >
> > I don't see a reason why it needs to be first.
>
> See the selftests (and my external loader, udev-hid-bpf):
>
>                 map =3D bpf_object__find_map_by_name(*self->skel->skeleto=
n->obj,
>                                                           programs[i].nam=
e + 4);
>                 ASSERT_OK_PTR(map) TH_LOG("can not find struct_ops by nam=
e '%s'",
>                                           programs[i].name + 4);
>
>                 /* hid_id is the first field of struct hid_bpf_ops */
>                 ops_hid_id =3D bpf_map__initial_value(map, NULL);
>                 ASSERT_OK_PTR(ops_hid_id) TH_LOG("unable to retrieve stru=
ct_ops data");
>
>                 *ops_hid_id =3D self->hid_id;
>
> Basically, I want to have to deal with .bpf.o and not the skeletons for
> the generic case. I want to be able to drop a file in /lib/firmware/hid
> and have udev-hid-bpf load it without having to recompile udev-hid-bpf.

and with additional restriction of only one struct-ops prog per elf file,
right?
Otherwise multiple hid_bpf_ops will be in the same elf section and
the same map.

> I couldn't seem to be able to access the struct_ops BTF information from
> libbpf, so I decided to have hid_id and flags first and consider this to
> be ABI while I figure out how to get to the real offsets :)

I see. I guess it's ok for now.

