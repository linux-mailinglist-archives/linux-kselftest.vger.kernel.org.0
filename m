Return-Path: <linux-kselftest+bounces-25932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56088A2AD30
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB716C897
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40F23315B;
	Thu,  6 Feb 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noo221zP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060322D4EB
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857588; cv=none; b=k0LslNCcbTYDr3JBoJhtNYIraj9EW36edv4RnwlqWIpjd5DjC2Wv+Y/RzHrm5eCg75HqcpRrjhKQV3il906ojo+V7vULiWk6eaZxMS4tNxGImj5oS98HQ1Yql/UPBD50EHq9SpMMunu2D5AZU1Y4kp6jLqk5sqyf4vaIWlxuKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857588; c=relaxed/simple;
	bh=olSie/7EBh8alXKr5hkItA/0Nn+OwVa4XWVccRk5lj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRQkbePIMrrivEQvrymX6kYoAjBuaxj1PbOxdjWBDAfgQmMJf0Os11vxgOo0Q3z2llIDGntTHt0uqr9Mn4nyBprQiUiPo5Dqn8BJdwP5ny8THdXm87mDiBxfZ6NjR1Lzq6V90Tim/1pzlSqnpGDrzMaYbAOm6MfRjaKU+kpsFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noo221zP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4678d6925a4so131cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738857584; x=1739462384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWR9oJPKssdhza1nYQKKsQU21w2ncXfqnG8efMNfd0Y=;
        b=noo221zPO4iGot9+PBGfkYXeqJL4p2VLr7rGUI7QKz90oJdwN37h6o5RpmBif6K0QH
         BISKZsO2slVStbDFz505W51D/mbzpJRYczAY6QrEExU4t6iCt6xAAZCFLtFQd/ySyMqI
         Y/oBYPsgkp2FwEIuoG+7CBhnngY6KOZMdByzWQkgly1E3ooXbTTlL5NBWS15mIul/3g+
         jKPK1TR7PTZnnNwOyQbbtfC/6mKtOEvzkJ8Bk+qbNEOtd8igfUdMiY7nd8O69u82VJi1
         lRPVwE76VtVR6ShLrZWhwItJA6KuJypKDCcx0CdGalaAby3RLQ4BIfY4s0lbjlQOYL6L
         g5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857584; x=1739462384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWR9oJPKssdhza1nYQKKsQU21w2ncXfqnG8efMNfd0Y=;
        b=CAZP1sYdx/S/QqK28s2m/B5D5N2Jc7NusT0ygrl1Jlbpb1FzkH8kplOJqyouvIA6SZ
         e1T8vmQEhZ6zLgc2D+y5swhgBq8z9Fb7JFwS1aP7Bf9sYecAUAhNHNez/wunQIovu3rC
         gkb+kHsJwAf5bPH4YZ1hnKq7D+BxGQkZ+DoCCGcgB77jeOeUprpuciOMuUBJY1I6hDac
         B9OW1lY+PjAvX3NB4bwtTQwaKMVYgp16Xr8fEExXbYLNn8Lk+HMk70SlWilTJEGZ8znG
         gYjXY7MVwW6+OaTQp8cvQCSJQWLjeN0OiE8UO/0mj8gqxOkUr6gifxphX3BFX80lrsDi
         /DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg+BIAhAW9DqjaMOSPY7JEJmTup9j+ImDSr1lX8YjHyGrwfCVRcbG9bQ/wqF3GfvVll02pfJJ+6jAyMoKlBPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwliVFZU6GBeLba8flPqIv+c0/pAcTDgF3KJTB3zJjNnO5iD5vz
	2gVRbfPT8gQMGx4XS4rZYRWVF5yOIOhGzxXiE8yYvrBu4STsbmnvQBkwhYUU5KPrg2RJHkVZ1i4
	WyIHbDJ29WnXLCerdBJfCDgR1JM645w6PPAcf
X-Gm-Gg: ASbGnctY5vsode4ojQYY6PhqPd2RMLCedIUgMYPfbiS5DfF7spVHeGDKnXsg7+dtsGG
	pkidgA61+NTWACqNF8iJoeW8SXli0sDY35dN5R/nYKdrtAv6Xff3p5XXOVY7dJGbqp5RJ+59e1F
	xCIAeTZuPMCks8CmYtNzicUlKgBiC46A==
X-Google-Smtp-Source: AGHT+IGH7hsPF5SPtvgDNjPtztM3BVJU7tfmP0H3iF/9iVPHoSTkUMp5iK1R9AA19xlpHDkDamYS1MpqyylKUWYY6aU=
X-Received: by 2002:a05:622a:1805:b0:46e:457d:3b77 with SMTP id
 d75a77b69052e-47165a82e58mr130811cf.1.1738857583450; Thu, 06 Feb 2025
 07:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204091918.2652604-1-yuyanghuang@google.com>
 <20250204091918.2652604-2-yuyanghuang@google.com> <5c11113e-c7d0-4c71-9f5c-02e7a90940fe@redhat.com>
In-Reply-To: <5c11113e-c7d0-4c71-9f5c-02e7a90940fe@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 7 Feb 2025 00:59:06 +0900
X-Gm-Features: AWEUYZk7cbJAarhb2cqsOUMx5yzgFTIkZpsJTYlSbj3SkN-NU4ddBvCaqMPTFuE
Message-ID: <CADXeF1HWUkDE_dS0sEWcfqRjYca83ESrF6F4TDaOKEVVDd2PhA@mail.gmail.com>
Subject: Re: [PATCH net-next, v7 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The preferred way of handling this case is to define a new class, still
>derived from YnlFamily, setting the correct path in the constructor.

Thanks for the advice. Will fix it in the next patch version.

Thanks,
Yuyang


On Thu, Feb 6, 2025 at 11:23=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/4/25 10:19 AM, Yuyang Huang wrote:
> > diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/=
selftests/net/lib/py/ynl.py
> > index ad1e36baee2a..7b1e29467e46 100644
> > --- a/tools/testing/selftests/net/lib/py/ynl.py
> > +++ b/tools/testing/selftests/net/lib/py/ynl.py
> > @@ -38,8 +38,8 @@ class EthtoolFamily(YnlFamily):
> >
> >
> >  class RtnlFamily(YnlFamily):
> > -    def __init__(self, recv_size=3D0):
> > -        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix()=
,
> > +    def __init__(self, recv_size=3D0, spec=3D'rt_link.yaml'):
> > +        super().__init__((SPEC_PATH / Path(spec)).as_posix(),
> >                           schema=3D'', recv_size=3Drecv_size)
>
> The preferred way of handling this case is to define a new class, still
> derived from YnlFamily, setting the correct path in the constructor.
>
> /P
>

