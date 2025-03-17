Return-Path: <linux-kselftest+bounces-29201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2AA64904
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B52188469B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C8230BDB;
	Mon, 17 Mar 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMZvZPEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794D229B28;
	Mon, 17 Mar 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206259; cv=none; b=pyCmnq05l+YgjfIaC82tLuZuE6jSxDW5OX+QmEGGb9vPIJ+61qc5dr5FDCK8FY/Zr1LKLSqnEMCShXP0vfMzgabSNwb12Fbaz0rUshb0N/zn9SQnzxyZWURHK9efx/HZo2bNGv6B4l3PwoQV3HHjASRGFJWLbHMXYGdFn2e7VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206259; c=relaxed/simple;
	bh=Wxs+z1Wms/rz3FZCDLd8lPCpX3EWYhXBgRFH5+EsDvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg5O6WoDgP/io9Gf7KRvu2uhDtjC5aXYUDFqWjiBNjnO/3syCoKyOx+obTGWXBb+6Km0hmp95cbK/ca1C2r/wqhvUg/vabroFxxuST6AdhQO8ghzb0fJF9yZpacfixuXR0QYQsESKaU/gSTzZ/ij+McAHPDC46nREN0OmakPFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMZvZPEV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e573136107bso3864774276.3;
        Mon, 17 Mar 2025 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206257; x=1742811057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14ZjU9nXfljCfIeuLE7AsggRfd6lcojl1mTtLC8IsKk=;
        b=FMZvZPEVl1B85+p0MGMQwQL3+E6s+OvtZ3cpqlAq+6lPZ+QqBs4/Bkn7+9LlB1bFTH
         82G6UJd21KozlEbBQHRQi0VaDCV0zURxrVBA8AJl+6XDvAt+AKbys37pfx2g4EOaYtst
         d6X/MeT/8k8dFvxr1VJOynAXBVnGMiB1Tt8nqBvyAxqpwTI94UVaqG/pDQOYpvW4xcsh
         xzgnf/gNZDlGRpzzQdRhYhtXVPhekUCLL58tbBeePCjViHxWb7s2WQCm19s3hXnGt/0u
         VtQX9QPb81eKL5su4bWhf5o880T2jAl02LQQMltsA2P4xa2LNgCsOaQQoaOmIl1njHHf
         /HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206257; x=1742811057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14ZjU9nXfljCfIeuLE7AsggRfd6lcojl1mTtLC8IsKk=;
        b=ARF3fMsTkkWnKNMED2rocymHfHc0x19RJrv3hNayVXwj0qlv+zAdBwJ3ejv5z2On6A
         g0nU3OLAmd5mohb+xEWykBX8NnXlZFLcQ0c7tYTkffFOGr3OpwveDvF5wdPGKFoljM/8
         Rs9XqtrKPIjUYP1nHcdRh0yDW8jeeEUt6ooYbr1ZcgH2KzYpHai7f2oPq8GNQLPWhSp7
         KCfjI4dR5mQLHfp8Wcj0a9IqoEmUcpJRgyFKb3UpP6KHRA8mX5XFXCJTYC8ZH8UpbAfY
         6gmWq38ewUUxhCoCAs/XA8zsTqdPG+YdsGRqsFNoF4Rxa3IopwK9+I2t4yO6cINO+lT2
         pvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+3BQGkDF854s5ISwEq4FgnCfIIw1cWujEQZyQWPM8uPlzV6HbWDyPUFKIoJe3/mwaB2rbpdsnTq3ptiP/NXX@vger.kernel.org, AJvYcCUmFpjZuka3y4/glUNliHT4RALii7qiyXw/CHWK7XWiJ1nX0EDhbVwRYBdT7qZUfyf3/9wu2k4Z@vger.kernel.org, AJvYcCV8vL2RuG6ssWkYEAUEVq0/yHQBc+s52JzKcnlwmNbpUJ9fExW0huH39v26x52+Di3NEUwoQCJJLZ2bs3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwklkZsw8UOLs0+WoLCi7Y/vGoLxT+oaYLik6SsYGkO1D4Usl3n
	yJ9KeCB42SkEGX2KSryfSOGcJ9eMKDlnFlHNPo/vjnyVra4oGhaxfgH1N/eDkJQpxEAyYSuuwo7
	E0LcVGdr18boCOdlVP1CmKn8BhGs=
X-Gm-Gg: ASbGnct5h5QQhDKn9oTFX68O5o2YJVunOBdTQVLzyDziykII4eEcVRrpD7ExuYvlC8x
	tQjvrNz/9cQJM38Ba9Tmkyq6I5mgBi7Pa9zTgeKWbCru3cBw/pkfs5ODYLO3FigTVkNM73lqKii
	s8iHaPkJ0ZCDorhG+CAriMbmdiMwVWqAZomodCwkLJqg==
X-Google-Smtp-Source: AGHT+IFeEwX2XBlKWWzrkEKnBTAYiIEeloN1LG9w0cpntS5lTgsKiw5wSHUPI3GA92GyKQZHSvhzhxajCnV/EuAnk2I=
X-Received: by 2002:a05:6902:2747:b0:e5a:c5d6:3948 with SMTP id
 3f1490d57ef6-e63f5cf0c16mr13681061276.0.1742206256657; Mon, 17 Mar 2025
 03:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
 <20250317060947.2368390-1-dqfext@gmail.com> <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
 <CALW65jZe3JQGNcWsZtqU-B4-V-JZ6ocninxvoqMGeusMaU7C=A@mail.gmail.com> <0d8a8602-2db4-4c19-ab1c-51efef42cef6@openvpn.net>
In-Reply-To: <0d8a8602-2db4-4c19-ab1c-51efef42cef6@openvpn.net>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 17 Mar 2025 18:10:46 +0800
X-Gm-Features: AQ5f1JrZOv5SDMKrcUIEXFo9D0GgKi-eZeGIu0RavrSG4UmNhD3vkPc4aOtmKg8
Message-ID: <CALW65jYaMBuMqzCFYwUJfLBg8+epQEjCg0MOpssGCwXqxbFP9w@mail.gmail.com>
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: andrew+netdev@lunn.ch, donald.hunter@gmail.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ryazanov.s.a@gmail.com, sd@queasysnail.net, shaw.leon@gmail.com, 
	shuah@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:00=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> On 17/03/2025 10:41, Qingfang Deng wrote:
> > Hi Antonio,
> >
> > On Mon, Mar 17, 2025 at 5:23=E2=80=AFPM Antonio Quartulli <antonio@open=
vpn.net> wrote:
> >>>> +static void ovpn_setup(struct net_device *dev)
> >>>> +{
> >>>> +    netdev_features_t feat =3D NETIF_F_SG | NETIF_F_HW_CSUM | NETIF=
_F_RXCSUM |
> >>>
> >>> Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum=
 is
> >>> not handled in hardware.
> >>
> >> The idea behind these flags was that the OpenVPN protocol will take ca=
re
> >> of authenticating packets, thus substituting what the CSUM would do he=
re.
> >> For this I wanted to avoid the stack to spend time computing the CSUM =
in
> >> software.
> >
> > For the RX part (NETIF_F_RXCSUM), you might be correct, but in patch
> > 08 you wrote:
> >> /* we can't guarantee the packet wasn't corrupted before entering the
> >> * VPN, therefore we give other layers a chance to check that
> >> */
> >> skb->ip_summed =3D CHECKSUM_NONE;
>
> Right. This was the result after a lengthy discussion with Sabrina.
> Despite authenticating what enters the tunnel, we indeed concluded it is
> better to let the stack verify that what entered was not corrupted.
>
> >
> > So NETIF_F_RXCSUM has no effect.
>
> Does it mean I can drop NETIF_F_RXCSUM and also the line
>
> skb->ip_summed =3D CHECKSUM_NONE;
>
> at the same time?

I don't think so. skb->ip_summed might have been set to
CHECKSUM_UNNECESSARY on the lower layer with UDP/TCP RX checksum.

>
> >
> > For the TX part (NETIF_F_HW_CSUM) however, I believe wireguard made
> > the same mistake.
> > Your code both contains the pattern:
> >
> > if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL && skb_checksum_help(skb)) /=
/ ...
> >
> > NETIF_F_HW_CSUM causes the upper layers to send packets with
> > CHECKSUM_PARTIAL, assuming hardware offload will complete the
> > checksum, but if skb_checksum_help(skb) is invoked, the checksum is
> > still computed in software. This means there's no real benefit unless
> > there's an actual hardware offload mechanism.
>
> Got it.
> Then as per your suggestion I can drop both NETIF_F_HW_CSUM and the
> if/call to skb_checksum_help().
>
> Regards,
>
> >
> > +Cc: zx2c4
> >
> >>
> >> I believe wireguard sets those flags for the same reason.
> >>
> >> Does it make sense to you?
> >>
> >>>
> >>>> +                             NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
> >>>> +                             NETIF_F_HIGHDMA;
> >>
> >>
> >> Regards,
> >>
> >> --
> >> Antonio Quartulli
> >> OpenVPN Inc.
> >>
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>

