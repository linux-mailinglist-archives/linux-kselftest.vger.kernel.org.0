Return-Path: <linux-kselftest+bounces-12455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E32912B50
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D591A1C23E30
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAE15FCFE;
	Fri, 21 Jun 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aid5b4T7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5410A39;
	Fri, 21 Jun 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987175; cv=none; b=TlWBFeEbw/Lyj1Rd7n9GniNrefJ9OQdYxS1/CoCj0eVMCcX22u3WWi+s5qTYcSzbl28tJnFEQof0GEmq0Z/5pQtpR3G3itStU7RhK9y52DlW8HGSp0S+G253hY0erjuAkWRmWAvufy7y0++SbMHu69ZfA1v8WpiC8BbmWP5t/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987175; c=relaxed/simple;
	bh=syaw2j1CKNhKileFRhZaU0gaJjIh+YpnaVjx+YB5jbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIRWPwqAfi6HQMumrgbeciWomlY3V8l+7gDOV2/56lm36B2XZFwe/efsdRiTb472cZxfd1eGJw9jqtclKgX0DlPOnaH+LRkGJxzLIoRQx0+sxVWufhDAqRa2fAiIneM8jZG/1HMrv6RkSLYVVR/cgfK0DLtmEtRrMjQ7aFeqqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aid5b4T7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso24593105e9.2;
        Fri, 21 Jun 2024 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718987172; x=1719591972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G5sctyY5+akJotF0NYZBVeqJ4gLFW6IE6iMuGoc2hc=;
        b=Aid5b4T7HqsUpD2CeIijka/5BYSfZX2u67OiQNvQEMNtbd3mUYD+8ti1CwIMJONcnY
         kby1LW1FC2CG1t9dsLKOgNjCDbGS344LPkYTwHQSBgr9BjMLx84I4G3dxOfJVP1P/1aF
         Iyh0/C4VzxTLyRgC3k5GHbNphkCAiGrh1J4TKQSGJWbYDNt9KuinjiVWiDD42srsdwvp
         qSyBrPpkQP3JxMoJ8KkPA3pCULL8lHXERqAB2UlXBlo+eL0C0VJj3sM0HxptRnnMLpa5
         Am+4r6hWt1ZOx2yX2KVxktSdu4YVcwqKAFkfsMoArHdRzH/E8zbKt4TcQ5+GP8xTzrJ0
         IwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987172; x=1719591972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G5sctyY5+akJotF0NYZBVeqJ4gLFW6IE6iMuGoc2hc=;
        b=sX4PTazIsenMU6EtxHDYvpP8qEtn+JhnPP7NKXk5Zq3fiOE+JEqabVvVsjeERmLYew
         twiqpVI5G6qtLJyhA45oF8EFomevQ92LqxuOyc1y7UhoDS6AchgBQzaD00iUr9+kM2hc
         zCbq/ZjGXRBgsj5c5Or54gE/TdbujMDinQl6hqau/v4WrJbo59hu+MQoz7r8WmXHcIIK
         aQNcL5JTldUX7xPivhwrpFNPis0ZH34uGYJuz6VWVqGFcD7aGuxKVso2pO6KO1ZRz1T8
         41cwyB9hri7EzGzzG7BYaZGq8dFvS3aPuw04vCYYnLri+X+NB4nW+f/zn2jDzypLdC/b
         lrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVomdJeHiYxc9eDA+NiLSOP3uIFuMTvj7uALfkYWYHqXi6R61CCwaKLhPcy7Hmk//fOHlbWy+eoI0F5qux9buWopOO+oH9iS0NWYfT60W6bxOtfCR9BGATglA1gnTPfUAw1cDAIO+yIm8GkJBEpsDn4s9On/cpyBV7vrsrBilYrWI+UjJOJhA1LiWNWFYzBaRCJqs/t/LG4q7kYc1C1PVWUglfj78wMxldx64fepnmqkMx6z/qwJJGGDLY=
X-Gm-Message-State: AOJu0Yz/2Tmu4PXP2rmdEKkd4ZX+fA8KUvrykZvw2vhQaseKUsjxv62q
	mem9RbbprAiso/vH1xsISFq+ktm0Te5Wxz1howDd6Ct0mJt51E1tfieHHx6Hx4ZsCSh1PZqBp1s
	2p3SGlRq2MhLTNrPjCyH0zo35rbc=
X-Google-Smtp-Source: AGHT+IFSihQV0lS2A8sdrIWW8qjAtXJa85Cfo+eO9dbfvheawX77yi34eO4/SQ3D/TDwMdwQ6G6tYXsv4r3cj5RyB98=
X-Received: by 2002:a05:600c:181c:b0:422:1a82:3ed2 with SMTP id
 5b1f17b1804b1-424752969b0mr86309965e9.27.1718987172113; Fri, 21 Jun 2024
 09:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
 <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org> <CAADnVQ+us6cQepSGWbOB4K1bb_0Wh43Cpo4zXJxB2d+SVpYinQ@mail.gmail.com>
 <dcbgoe7gija3fn5zsooulnq3jey4twwqvsxjv4yjijacnrlt2h@q6obu65ifctt>
In-Reply-To: <dcbgoe7gija3fn5zsooulnq3jey4twwqvsxjv4yjijacnrlt2h@q6obu65ifctt>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Jun 2024 09:26:00 -0700
Message-ID: <CAADnVQKE6RyGUhQbTiOfa15=D9B_vtAg=VMDv8cfYrUKOv5UFQ@mail.gmail.com>
Subject: Re: [PATCH HID 06/12] HID: bpf: add HID-BPF hooks for hid_hw_output_report
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:08=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Jun 21 2024, Alexei Starovoitov wrote:
> > On Fri, Jun 21, 2024 at 1:56=E2=80=AFAM Benjamin Tissoires <bentiss@ker=
nel.org> wrote:
> > >
> > > Same story than hid_hw_raw_requests:
> > >
> > > This allows to intercept and prevent or change the behavior of
> > > hid_hw_output_report() from a bpf program.
> > >
> > > The intent is to solve a couple of use case:
> > >   - firewalling a HID device: a firewall can monitor who opens the hi=
draw
> > >     nodes and then prevent or allow access to write operations on tha=
t
> > >     hidraw node.
> > >   - change the behavior of a device and emulate a new HID feature req=
uest
> > >
> > > The hook is allowed to be run as sleepable so it can itself call
> > > hid_hw_output_report(), which allows to "convert" one feature request=
 into
> > > another or even call the feature request on a different HID device on=
 the
> > > same physical device.
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > >
> > > ---
> > >
> > > Here checkpatch complains about:
> > > WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU =
code
> > >
> > > However, we are jumping in BPF code, so I think this is correct, but =
I'd
> > > like to have the opinion on the BPF folks.
> > > ---
> > >  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++=
++++++----
> > >  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
> > >  drivers/hid/hid-core.c               | 10 ++++++++--
> > >  drivers/hid/hidraw.c                 |  2 +-
> > >  include/linux/hid.h                  |  3 ++-
> > >  include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
> > >  6 files changed, 68 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid=
_bpf_dispatch.c
> > > index 8d6e08b7c42f..2a29a0625a3b 100644
> > > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > > @@ -111,6 +111,38 @@ int dispatch_hid_bpf_raw_requests(struct hid_dev=
ice *hdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
> > >
> > > +int dispatch_hid_bpf_output_report(struct hid_device *hdev,
> > > +                                  __u8 *buf, u32 size, __u64 source,
> > > +                                  bool from_bpf)
> > > +{
> > > +       struct hid_bpf_ctx_kern ctx_kern =3D {
> > > +               .ctx =3D {
> > > +                       .hid =3D hdev,
> > > +                       .allocated_size =3D size,
> > > +                       .size =3D size,
> > > +               },
> > > +               .data =3D buf,
> > > +               .from_bpf =3D from_bpf,
> > > +       };
> > > +       struct hid_bpf_ops *e;
> > > +       int ret;
> > > +
> > > +       rcu_read_lock_trace();
> > > +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> > > +               if (e->hid_hw_output_report) {
> > > +                       ret =3D e->hid_hw_output_report(&ctx_kern.ctx=
, source);
> > > +                       if (ret)
> > > +                               goto out;
> > > +               }
> > > +       }
> > > +       ret =3D 0;
> > > +
> > > +out:
> > > +       rcu_read_unlock_trace();
> >
> > same question.
>
> re What is this for?:
>
> e->hid_hw_output_report might sleep, so using a plain rcu_read_lock()
> introduces warnings.

Ok, but just replacing rcu_read_lock() with rcu_read_lock_trace()
doesn't fix it.
rcu and rcu_tasks_trace are different.
If you're using call_rcu to wait for GP to free an element in that
list the thing will go wrong.

If you really need rcu life times here use srcu. It's a much better fit.
There will be srcu_read_lock() here, paired with call_srcu().

