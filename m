Return-Path: <linux-kselftest+bounces-37935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033EB10363
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9139A161F1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F232749E0;
	Thu, 24 Jul 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h71r/Vgw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A612749CE
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345248; cv=none; b=rNRBWJIk61lthQmqOH7ma016LmsF/VPnHLqQYAqB/0dXJMMQ0y08SXSNjciMJZGXEHNnxAdMxRc1TKHxMnXFKWPBWt0+m/i2GCVKnO79BNKu+uJQLiR1WKLlkjFXC2Wy8ZZIyDt3ZGdz+X79LwnriV5w6/msE26L+jArkAiyiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345248; c=relaxed/simple;
	bh=PY6FA72lx+rsHdWf/O1btP/hvDoM5PWlZyolAQrsaaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpLaI8qg0AZlM74SYVLW+HwiyX4NGY4jvPX4ZzT+x9UKZbthPH2Nk/TK4J2uiPR5mHo5CB+3SKN10Hyn+wWrCOA8y1cJO8qjDeUpGXPkxS0s7voDAAZQODvBXxnpnjfmf970UzmPB0PKUt7hgtUixgJo3V4Vv/StPW94RIdpx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h71r/Vgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753345245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
	b=h71r/VgwubB1cae1WsAI0QVWAvw0P3FY3VhTeFHD/2/ZtGgEV9w6WTyyn5ixpkec/LDXLD
	7FxJuKGub+V1vWUiFlQPe1OhiYbvvdmETVOtcbZF+NpdAHzvdN1KBacDFhpI7yc+NAq2RH
	qV9VOB9CjSOfo/3EpKgwurcpzbXPLvQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-O3wtJevrOVy78kUnfrXT4Q-1; Thu, 24 Jul 2025 04:20:44 -0400
X-MC-Unique: O3wtJevrOVy78kUnfrXT4Q-1
X-Mimecast-MFC-AGG-ID: O3wtJevrOVy78kUnfrXT4Q_1753345243
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e8bc709c7daso890990276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 01:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345243; x=1753950043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
        b=rFwN8tQ2DhITOm7eKA807zmMQMlKwMfC2wOtafrNzdUgZUuVCZ/qmJOPwifEovniIC
         ilqTUJOfmDrd6UGop+rSGBWXShbYhQLcwQtT7Bz9gbmstRjSG9RDyJbf3ANC0D3huGw/
         PLWCEq8S981RgXwWW8v1llqs9UMRZgR9ibi2gP8lA9FOj3NTJzOKowJhmhQsz/rK1rgj
         nkJB0Y4PoPBoeo5ELAMTPyuiMQH01wVQhOG+/jhpzQBD9u9Uqoqek/Hcr+szKiMuyMWJ
         3dNovNPZi7hiWvVDw2W6sq02MaOVgHkT03ZyxCpk1jZbH4pkUcRyD1dCk4NY1vQ7XJCz
         Aefw==
X-Forwarded-Encrypted: i=1; AJvYcCXYb01Xt7/WbOyv0gRpb4rzefM29UE198iE5iRuU0bdJQS2BAZ9Scy/4BJDpNjkjv9A17qFfyzM6NuCvcNdAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOvrxC1zPnRLkPZFU2ml+Op7NsmHim+IRfQoAeWdDUah+o5vm
	wZmRxk3rs+eNwhfV9Y0GlGLQDlXxTMesRr+1nVe7Pxl9pIMJRYRSI3Y7jNjaiy/Zjm+B1+09nvM
	ISihrQwoKZFJhM/Nph2RddhaP+ynUGYdOSkW5F21qnI19Fc7km+0K3sNYhcaglC+/ouUvk3DS8V
	JQyweXBpAgYkmU/TZbrGw95ywxWucuHyZxE6f5aVarU41h
X-Gm-Gg: ASbGnctfrqqsU34tisMnjLkgYVQv1sVnUbDARQgkC8KayK1jeogRmMe9mEsrCTbqqlM
	Kln8Ey6I0miyypg9W3s8MaQywoz4Pk6ISJy0PCaL/oxXOhUttHIXIBrCLl4lRZIHQ8iiL0FaDi1
	rEFun2TZz4pPFyYUXo52Nb+Q==
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id 3f1490d57ef6-e8dc595b0abmr6776116276.33.1753345243438;
        Thu, 24 Jul 2025 01:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtmOQZoG8MJqXUBbHZjrjfL2o69nkUHbskfHC38XgsD1gmsQVJ+5FqH2fq1iw+bluM/HBXchsFWiPGsWmksc=
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id
 3f1490d57ef6-e8dc595b0abmr6776091276.33.1753345242975; Thu, 24 Jul 2025
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
 <aIHRwwOl-FS8KOV0@fedora>
In-Reply-To: <aIHRwwOl-FS8KOV0@fedora>
From: Xiumei Mu <xmu@redhat.com>
Date: Thu, 24 Jul 2025 16:20:31 +0800
X-Gm-Features: Ac12FXzu1I7NXeznfsc628RU_1n_SK2CsVM_ZFesDKVFeRN_1fJs6j-4D1IwnIg
Message-ID: <CADdRzaF5Ck86fyEYaeWjvoVt=8qEhNKJ8J3ye+x0cb9EATqQ7Q@mail.gmail.com>
Subject: Re: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after test
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Long Xin <lxin@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <sln@onemain.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

resent the reply again with "plain text mode"

On Thu, Jul 24, 2025 at 2:25=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Hi Xiumei,
> On Thu, Jul 24, 2025 at 12:55:02PM +0800, Xiumei Mu wrote:
> > The esp4_offload module, loaded during IPsec offload tests, should
> > be reset to its default settings after testing.
> > Otherwise, leaving it enabled could unintentionally affect subsequence
> > test cases by keeping offload active.
>
> Would you please show which subsequence test will be affected?
>
Any general ipsec case, which expects to be tested by default
behavior(without offload).
esp4_offload will affect the performance.

> >
> > Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test"=
)
>
> It would be good to Cc the fix commit author. You can use
> `./scripts/get_maintainer.pl your_patch_file` to get the contacts you
> need to Cc.

I used the script to generate the cc list.
and I double checked the old email of the author is invalid
added his personal email in the cc list:

Shannon Nelson <shannon.nelson@oracle.com>. -----> Shannon Nelson
<sln@onemain.com>

 get the information from here:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Da1113cefd7d6

>
> > Signed-off-by: Xiumei Mu <xmu@redhat.com>
> > ---
> >  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/s=
elftests/net/rtnetlink.sh
> > index 2e8243a65b50..5cc1b5340a1a 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
> >       sysfsf=3D$sysfsd/ipsec
> >       sysfsnet=3D/sys/bus/netdevsim/devices/netdevsim0/net/
> >       probed=3Dfalse
> > +     esp4_offload_probed_default=3Dfalse
> > +
> > +     if lsmod | grep -q esp4_offload; then
> > +             esp4_offload_probed_default=3Dtrue
> > +     fi
>
> If the mode is loaded by default, how to avoid the subsequence test to be
> failed?

The module is not loaded by default, but some users or testers may
need to load esp4_offload in their own environments.
Therefore, resetting it to the default configuration is the best
practice to prevent this self-test case from impacting subsequent
tests

>
> >
> >       if ! mount | grep -q debugfs; then
> >               mount -t debugfs none /sys/kernel/debug/ &> /dev/null
> > @@ -766,6 +771,7 @@ EOF
> >       fi
> >
> >       # clean up any leftovers
> > +     [ $esp4_offload_probed_default =3D=3D false ] && rmmod esp4_offlo=
ad
>
> The new patch need to pass shellcheck. We need to double quote the variab=
le.

Thanks your comment, I will add double quote in patchv2

>
> Thanks
> Hangbin
> >       echo 0 > /sys/bus/netdevsim/del_device
> >       $probed && rmmod netdevsim
> >
> > --
> > 2.50.1
> >
>


