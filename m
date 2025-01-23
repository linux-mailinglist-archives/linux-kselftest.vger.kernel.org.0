Return-Path: <linux-kselftest+bounces-24992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DCA1A21F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 11:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7813AF4F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8420DD68;
	Thu, 23 Jan 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPncNLAS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899220DD63
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629100; cv=none; b=c7w9TUpIU9XNRwuZ2AK9itaHNinCd5pEtfGeWszYNSI9LOF6mBOqFrbOvPS7trRFuGmt9DHWbdQqhVuc9dyLDU3N7OpgIjazQCU9PF606X8Mcq8R8HJsvZSB9MDXP8qNiJKSTCmzpogbxlsQtzco6ONFIzeMLjImW0G/rBTNz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629100; c=relaxed/simple;
	bh=xwRVHrqyj1XQk3Qj6l+3RxP1Vsf6r8O+Nj+33p8dqkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ+yhegtfzIUb8AO0SMbQQksf+rbfkJ7OTabDGsERdCHtd2oeb7XiY9UIXkDjzNms/0KWS510Ke8pTpjtxVIrb5swpcwqGhJQWTXnJAGmgxAbX+6998mSRKNgR50oAScM3+pFhK6ySP9SliEGdYbX6AJJmxHZw4fbXyXRnzJn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPncNLAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737629097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKHMH0NHU1XDhlPLu3+SYuxAeIimPILkE6Cj8AAaCQQ=;
	b=HPncNLASVYx6ceqfJYyQt8Oxm9HT9NeTYQgjHAak2QV+yAMCFilb4imeYkIfmKqDcgHKSt
	eoMJhXTLlkiL5G/Zp1WVHoc6nd30Z20nJKYB/gnZEW/u5UM7YggeywJbkhv0j+Xt4MRxuj
	DZKLXKv+guOj/J+9R9Lkddf2ZLIgdsw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-mA52fxwzNUiiIkw8eEwg3w-1; Thu, 23 Jan 2025 05:44:54 -0500
X-MC-Unique: mA52fxwzNUiiIkw8eEwg3w-1
X-Mimecast-MFC-AGG-ID: mA52fxwzNUiiIkw8eEwg3w
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71e1356a00bso578774a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 02:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629093; x=1738233893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKHMH0NHU1XDhlPLu3+SYuxAeIimPILkE6Cj8AAaCQQ=;
        b=AUV2J6guFYFNQicFzfBbLRQKF/OHTz2HFFeh+IaGbsHth6Oszt+TrBe/Fp0dKSRtoj
         a06p6HeqSCEpDHAu/1kWyP6h5F5i7Tyhykg/35kXrPDTzQ4CE0ISA7u1HR9KW4A3wjy7
         viA+dLvGMltCLWYhZIPH0ka9KhBk+TOqUBFvYfp/jiCKsSUOKj/mSRCdZrXRZBKPRvFB
         GU6vot9oAlNWu6eaftW1GOjfJ89GQW2UfnPOYPI1BMYswk913fmpQKaY7TDD4kP7yNQv
         z+vXfebl3LElTTNuYTSwtEZz2U3Jr1WjWzxfZ8p3DH3L5mhluCmVb/MBtKJ3ZpsVWFDP
         NHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAiIl0blbvqw8HWxmFBMIIzZSJQ5sDtVWDfR6+kGku48F9+2tINTqEMZvTLHvPiINyN28wH0/aixvqmtEIqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iP57StNHzBlMrpjtwJmUTqcODB293pG+kr/uR42S+REvE3Ck
	JyJ6vrZniYP7MIougIMis/onzeuZ1eUIgD3ZQjKP8Y51lOxD+W8hRlZZ42HS3oZ/oFuD4Q7Z/+q
	765InQeu1gQR2eL8bKR8V7/x6tS1PgysQahcq3kKmMSb+QtYc5K3S+71rkvicuYb+b+4NJEeIT2
	2bJ4n0j7/c3GgCbXv6/nOQO9gLBlamEGv4tSK4crf4
X-Gm-Gg: ASbGncvu+d8UbGS5t3EuUPfrLmpdaRKrBBGeZ/jVhzKbtjmYLgj/EzDZTR0gJ7NaVMY
	YuftaF/o5sZ/0TqO8OKx61hF3EpS8O+N8bDpKv3NaSxDSIZonDhQ=
X-Received: by 2002:a05:6830:600d:b0:71d:415a:5d18 with SMTP id 46e09a7af769-7249da56ce2mr17703508a34.3.1737629093566;
        Thu, 23 Jan 2025 02:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi6WLIndQdZXsemrfl2iOkDN0XoKsqLxfvKzEEANxD/42Ao5OkC5eQ4YGyrCpagt0VMOKs6wPnVEcEU1Eb+Qs=
X-Received: by 2002:a05:6830:600d:b0:71d:415a:5d18 with SMTP id
 46e09a7af769-7249da56ce2mr17703499a34.3.1737629093275; Thu, 23 Jan 2025
 02:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora> <Z5IBPOGvfPozjrl5@fedora> <8ee5ad75-c550-4559-b46f-e511767b3302@kernel.org>
In-Reply-To: <8ee5ad75-c550-4559-b46f-e511767b3302@kernel.org>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2025 11:44:37 +0100
X-Gm-Features: AbW1kvbfBjT3WVjr-q_-Wl_3bczkryyrXglCzumXVRe52qfWdH0gjvrAotDYNL4
Message-ID: <CAASaF6z4vEKq2Oc+UW-XzMxk4z+U9bppKrTvYenmh8O0h=ChWQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from environment
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Hangbin Liu <haliu@redhat.com>, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 11:26=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Jan, Hangbin,
>
> (-cc <eliang@kernel.org>: wrong address apparently)
>
> On 23/01/2025 09:43, Hangbin Liu wrote:
> > On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
> >> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> >>> Package build environments like Fedora rpmbuild introduced hardening
> >>> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> >>> and LDFLAGS.
> >>>
> >>> mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which lead=
s
> >>> to a mismatch and build failure, for example:
> >>>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/m=
ptcp_sockopt] Error 1
> >>>   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.roda=
ta.str1.8' can not be used when making a PIE object; recompile with -fPIE
> >>>   /usr/bin/ld: failed to set dynamic section sizes: bad value
> >>>   collect2: error: ld returned 1 exit status
> >>>
> >>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >>> ---
> >>>  tools/testing/selftests/net/mptcp/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testi=
ng/selftests/net/mptcp/Makefile
> >>> index 8e3fc05a5397..9706bc73809f 100644
> >>> --- a/tools/testing/selftests/net/mptcp/Makefile
> >>> +++ b/tools/testing/selftests/net/mptcp/Makefile
> >>> @@ -2,7 +2,7 @@
> >>>
> >>>  top_srcdir =3D ../../../../..
> >>>
> >>> -CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/incl=
ude $(KHDR_INCLUDES)
> >>> +CFLAGS +=3D  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/inc=
lude $(KHDR_INCLUDES)
>
> Thank you for the fix, it looks good to me too:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> >>>
> >>>  TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh=
 \
> >>>           simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> >
> > Hmm, net-next is closed. Not sure if we can target this to net since it=
 fixes
> > the build errors.
>
> I think this should target -net. It should then have a Fixes tag (and cc
> Stable). Not sure if we need to backport that all along. Maybe enough to
> use the following one, because I see it fixed the same issue in net and
> tcp_ao:
>
> Fixes: cc937dad85ae ("selftests: centralize -D_GNU_SOURCE=3D to CFLAGS in
> lib.mk")
>
> BTW, I guess you will need the same fix in
> tools/testing/selftests/net/lib/Makefile and
> tools/testing/selftests/net/openvswitch/Makefile.
>
> @Jan: Do you mind fixing them too please? Also, please next time add the
> target in the subject, e.g. [PATCH net], see:

Will do.

Regards,
Jan

>
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> @Netdev maintainers: this can be applied directly in -net, no need to go
> through the MPTCP tree first. But it can if you prefer me adding the
> Fixes tag.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>


