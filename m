Return-Path: <linux-kselftest+bounces-25716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20BA27956
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E384188264F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A0216E3C;
	Tue,  4 Feb 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOXLsaKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF321579C;
	Tue,  4 Feb 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692463; cv=none; b=H/8PksBMc65VCms6zpur0RDIgHhYS3OYLD8Dggk8qmz46px1p6mk6Kp9GjJAAz72BMJKGuthU36hXdAcY0JklLEVtqNul3BgxIwT31yerYzTP/1YLFmkkL3DZ+7hE/RJuSvMoukEYIkOHqXsdeQSYCHbBNADqVdte5Skf8a9U6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692463; c=relaxed/simple;
	bh=uy2RAO0HREHk9jFjYXKnTRCWdGyyTgpHnGz4Tb6pK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl8CFQ6Sci+jGNOb0MuXmDNl49dJ6rqKE2h4eajXrNDZl+4eJ7bNi0myVnaYg+1BQdqAE6WHCmRg5nuWWZPWIkPrkqCVw1m153uoTzMXwBLEEV4JKlXAjF/LxTvgfKiIwatDc95TjFDLfPMvsJ602Z04TK8WM6qta4RlQrMmDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOXLsaKO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so105139995ad.1;
        Tue, 04 Feb 2025 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692461; x=1739297261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUWVYRjU/T6AKCeZ6ytji12eJGMYrefQ1/hONpq4u3U=;
        b=WOXLsaKOmiIqKA3kYWZtpIirMMMYhliyvKivCXUBJkQW97xnCIrZdQEEmE2Nlyb8c9
         hmVAweUtSEnJJrlIqnrFbZywZOjpkb1RePrpA20woOSHrm34qCOLod0jQ1SsAtfOUKod
         /WZl87lRatIZQH+wQ+6JVGUrCMOElhGq0jqrZABaHWNDey/55CVeKqhxHz7FbinUA0Nx
         hS/gDpjBoVVTrrRvtxYYT4wUWCV2shyBuvWJgMz6Hy1FqddQcfZpWXgsHYi1ZFSVG9rT
         R2433z+7QvdnHQ5fhSivcx3SqgtOPc2H9UxU3YPxcPJCddmDU9Na6lZgC5rPkz2W8m5I
         eugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692461; x=1739297261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUWVYRjU/T6AKCeZ6ytji12eJGMYrefQ1/hONpq4u3U=;
        b=WMOSPcHt7KIwytVGkzQ+e/dcSjaKfEFejzvb0YXGDVXSQ7klH9PReyMwnyoCjLPGkf
         dfsPo3pJs3RpYuMacufL7+z2/3oGEPL2IgKXKlpYeVrrj97Sbkp1pf/Q3A/Zhf9sIXih
         7AfK4uk0p/Uhm+KeaepuNf6j7Cm2R8tr9UmeOA/irHnLWAqPBlo7HIKMMuXxzN/q0lia
         VZYA6hdzoxt+N0+VY1WNuaDqPx7uWok3OOefvMpjYKNAgrWCHXRIVgd0ixGDUiUHgTlR
         cacbNtlUKOc2u4HJsm5Ux8CSe/NTYoWHvnDRXvZn/bNJqRFppbwun2jXeMmjbRvKbVum
         uIWg==
X-Forwarded-Encrypted: i=1; AJvYcCWe8PYdcf4AhjJRSnBgcPmi5MPDwrzFq4fWcr17G0O5YEVwQig4OF9xQ53xsm0WWwC8qZ9UXJfBzCNeO3s6@vger.kernel.org, AJvYcCWweAhiYqPIcgpUf9XWDEU6u61y1REsDMEypVIAZyItIhvAvP3DP2WaVufoF/wVdBlKKZ0HSf9g@vger.kernel.org, AJvYcCWzGNecm8MTDnLHOHq+URYZR497VhNMn9NjSa7uuWIGUeKANVdI2WNw9weIgIaZ63HV3Baq62ctTbvVF/CQfZz1@vger.kernel.org, AJvYcCXHibvhh9mqPMkPD3iKD/mSdTaqtZ7S1l9+pB+wwZ/DY3A0Zp1UjboRYfqREwZNqMw8MmfHC28Fw9PK@vger.kernel.org, AJvYcCXyPa7XMxBr3axUuvtaNmCgmLruFG+XmZWKlfS2wCe9yaEsF2WTpgiUQYUVTdltRfrm/+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmbbS68YwDSoogsZckkjDP836WYfBhHsV2lOHH6QElJa/Gv1l
	8QdAY899UP3uPywYzW+l1u5Va5c4tApsCJZIO+4KjsyIIsDOJB0=
X-Gm-Gg: ASbGncvGkA3xkf6oZ7W7vIwLmAMFQa5GXKlDlFbRDVcgsoq1xS+s3Rb4Lmtt4q3IcV7
	mvVIoKUqKCRDHtIGoZr0SOJNCcZaeShb8J3HD46cInEoZaw3QCjMArUtYqrqqAlZcTnLNVv/Yrn
	jMC6KP7M8yO97fvg/6Lu18E2v/djRfint/vBZ7+DyLV0EgDMRLhSeM7XxWXrDGjvzaA4in9fXRu
	+zBWgqWsrRwAP3LwUkVFN16R45APhhmWE5IlR2eXSbV0LbZm5AxkSxWEw1ttNqrrvg+b7hyAnsM
	VQkCHCuvh59sH4w=
X-Google-Smtp-Source: AGHT+IHqa3+XR4upxc7fln2BlqQH6Kpwtj8kZ27zpZtWrtWOX/qB2ZjoxFzkwLakAGYO1L0PhSn1Ew==
X-Received: by 2002:a05:6a20:9f45:b0:1ea:ddd1:2fcf with SMTP id adf61e73a8af0-1ed7a462e94mr41721024637.4.1738692460711;
        Tue, 04 Feb 2025 10:07:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-acec0a65716sm8720645a12.68.2025.02.04.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:07:40 -0800 (PST)
Date: Tue, 4 Feb 2025 10:07:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z6JXaz1AwMhN1wvL@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
 <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
 <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
 <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 9:56 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 2/4/25 6:35 PM, Mina Almasry wrote:
> > > On Tue, Feb 4, 2025 at 4:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > >>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
> > >>>  1 file changed, 289 insertions(+), 11 deletions(-)
> > >>
> > >> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
> > >> only in server (rx) mode, so the tx path is not actually exercised ?!?
> > >>
> > >
> > > Yeah, to be honest I have a collection of local bash scripts that
> > > invoke ncdevmem in different ways for my testing, and I have docs on
> > > top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> > > to look at adding test cases to devmem.py as a follow up, if it's OK
> > > with you, and Stan offered as well on an earlier revision. If not no
> > > problem, I can address in this series. The only issue is that I have
> > > some legwork to enable devmem.py on my test setup/distro, but the meat
> > > of the tests is already included and passing in this series (when
> > > invoked manually).
> >
> > I think it would be better if you could include at least a very basic
> > test-case for the TX path. More accurate coverage could be a follow-up.
> >
> 
> Thanks; will do.

This is what I've been using to test tx-only and tx-rx modes (shared
previously on the list as well):
https://github.com/fomichev/linux/commit/df5ef094db57f6c49603e6be5730782e379dd237

Feel free to include in the v4.

