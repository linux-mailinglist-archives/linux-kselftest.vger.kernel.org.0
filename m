Return-Path: <linux-kselftest+bounces-25710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A9A27858
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215853A035B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232E216388;
	Tue,  4 Feb 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OftOmaUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10E215170
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690076; cv=none; b=pkyQPDY2PjD/31kjjiAxOsj2A3k9iWJN4PyPjEDc5gf4N8q536y8vVpMg5zjjZdLb0/jeC5+MKhnZ6+l0FZ1sa7Vx6XmNB44tB1ZzR0rKk+ckDgaEwkItJNKD1PBEQaBbPH/8B47ZyuKoxk/jvyOAc8Q1UBNxs7zA/lBio6CNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690076; c=relaxed/simple;
	bh=V4uv66MK680ClXu6f6Ker2AP5D+vs5LU4+W5Eqq9fDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CehyNp+pqDF4ZoPlV9hezi3fXqbXU3pXVZeTv+2Lken4VsnJUtt2gKlyBpjxIYiBUzwpstkK/zEDYwHbCVwJE131rxKUll++AF4C2/lBK4cgNKpARq4TmpPqUzT3W1tDgpIq97Y79wYnVUmE2UL0TZyix8axOdnRCfB+ccQKAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OftOmaUJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163affd184so138585ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738690074; x=1739294874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfuayBjlRpeNZsUXyFm5cOwCbpbAk9szfdT3xIhInHw=;
        b=OftOmaUJrSf6tTIWxvgCdnZPkkJuuhxPCe5Lf/UTIRn9nq3TTaVAmc4uVZTNqLTW4n
         VcwpswN4g8JyfIyqWObrF4TpF4tLPo0hC3Bz89YaDcdwa/LcUrAigg016lMxWrB0t8nR
         AXYpDuLlXq2QCnKuj4X8wICSmZPbIwnlf9aKllME7CWIMCXvi4/P28iMEbDsGGAQ1nSN
         L5qnKeUCWe2i4WHHfXWqiw/AA+bQwv2Iud4UEiuMVo6Ab2Efo+JTHmHTaL27XogA/BmW
         X1xXst6mDWUXaCAYHNXCVUNjfW/girinU2noXsXSMNAUf4/xjn5i+gZ2JCMc2EqVYEcn
         8I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690074; x=1739294874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfuayBjlRpeNZsUXyFm5cOwCbpbAk9szfdT3xIhInHw=;
        b=ZQUwEf17w14yFSyi1ZUexh4bPE0dVhC3SneYw+2o7enxXH9KU31QfJVPXqIg6AmJUb
         IZODinrHoW7NaSodQQncxiwSDDLhGYNmuc+hRZ6em/pV068gvctXY9XDL+CaxVYgDyDg
         GshRI+hmctpjHIrACxgEpIxgZSLa/kyc1Msis7tPqkihrEDcJZoDwuLrkJAPg+kSdtN3
         2+l8h56TOP1vOtNzc8pdiNZJjCEuGol8VaBdr1m9yws6WutuN1pmmPzYtBfSm03YxUD4
         6qF3CObf8twbk7/mfc0uP/GQJly0DKA0kL4EcmJ0NLkZhy3V94w2y6VDlXggHQmgSmdO
         OjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0Xgbc2dSuok1Gk4DzcI98McEDZEdnnFA8LGMJsARRTpxGB2BPrbJLJzXJbxAhC+tmfHdqB5AxVRk8kPbfOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6AHWjQR/jjDTehD6Pm+H8M1kB2eYplPhRQxE0O5X9SCfgzvr
	PYA9o6/M42Ldsk1vAEF0KPyaKswMDCBWzHVsSqz/lxyP1ZirFB6XSOQMboK/SPh8cm5mV2yVay0
	poBDSlBWvRAx1SHUkwmxMCHurv3EJb9ejILLZ
X-Gm-Gg: ASbGncvgD10RFTyc+9W76NAvH5c5TfAS2+amf5Su3iS7ywYgUJfnCWq+SHcNnkAWefP
	BfetxF5NpJq4wEHadMxbq3pgp0a9tkC4HikMzZJ8xRphgyCmGBhCxZLi9Ayl87J6XQk4v2/5g
X-Google-Smtp-Source: AGHT+IE6dDHOUbSqrO0D169k4b7qsYEqIapGMMKqj/OrRCHutVQk4Tk9SbBciNiSXSLiP161vvVY/cJhza5i3Kply9Y=
X-Received: by 2002:a17:903:1a2f:b0:216:2839:145 with SMTP id
 d9443c01a7336-21f03afd716mr2749705ad.1.1738690073656; Tue, 04 Feb 2025
 09:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com> <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
In-Reply-To: <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 09:27:40 -0800
X-Gm-Features: AWEUYZmyHp3Gf6q5ty9WsLiNHfSw5QJWVWhu7wvqA18o91D3NGgPmvSyJ9NXuus
Message-ID: <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/3/25 11:39 PM, Mina Almasry wrote:
> > The TX path had been dropped from the Device Memory TCP patch series
> > post RFCv1 [1], to make that series slightly easier to review. This
> > series rebases the implementation of the TX path on top of the
> > net_iov/netmem framework agreed upon and merged. The motivation for
> > the feature is thoroughly described in the docs & cover letter of the
> > original proposal, so I don't repeat the lengthy descriptions here, but
> > they are available in [1].
> >
> > Sending this series as RFC as the winder closure is immenient. I plan o=
n
> > reposting as non-RFC once the tree re-opens, addressing any feedback
> > I receive in the meantime.
>
> I guess you should drop this paragraph.
>
> > Full outline on usage of the TX path is detailed in the documentation
> > added in the first patch.
> >
> > Test example is available via the kselftest included in the series as w=
ell.
> >
> > The series is relatively small, as the TX path for this feature largely
> > piggybacks on the existing MSG_ZEROCOPY implementation.
>
> It looks like no additional device level support is required. That is
> IMHO so good up to suspicious level :)
>

It is correct no additional device level support is required. I don't
have any local changes to my driver to make this work. I think Stan
on-list was able to run the TX path (he commented on fixes to the test
but didn't say it doesn't work :D) and one other person was able to
run it offlist.

> > Patch Overview:
> > ---------------
> >
> > 1. Documentation & tests to give high level overview of the feature
> >    being added.
> >
> > 2. Add netmem refcounting needed for the TX path.
> >
> > 3. Devmem TX netlink API.
> >
> > 4. Devmem TX net stack implementation.
>
> It looks like even the above section needs some update.
>

Ah, I usually keep the original cover letter untouched and put the
updates under the version labels. Looks like you expect the full cover
letter to be updated. Will do. Thanks for looking.


--=20
Thanks,
Mina

