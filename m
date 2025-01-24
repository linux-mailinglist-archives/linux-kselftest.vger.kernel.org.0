Return-Path: <linux-kselftest+bounces-25137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0AA1BDA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D87216EE30
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334C1DB958;
	Fri, 24 Jan 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Q8Es6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E71DB158;
	Fri, 24 Jan 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751842; cv=none; b=h85h9Q/WbcPq0RtMWG40GfEiLhTDGxfz08fGpqp6AcnsT+sqx/pAcTsLwajvWrX9cgdYX74j7VefZ451S8+emeonoLQNazfWhpdiLSyvxeSlemDPgl+KUCSr01enUfhjrT81UPe5vUTyzFWjhM92gbNcHi2CV7kDtSYB4R4hBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751842; c=relaxed/simple;
	bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpY4ljxZhoBDgqKDzvXzJ+GE1N7zxqYgTsmXrXt03kNr7jqBlWHERHhPB2VgdOm/nesJ9CcrjdZRy3LEcatzYl6t9mVH8CURTXK+jiqag5FexBGq3WdGXQbMY02KPQcLPi1PtXEAnvc83sXqyHbfUkpRslw7Ma6ZvYB8ESE9ZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6Q8Es6q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21a7ed0155cso44488245ad.3;
        Fri, 24 Jan 2025 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737751840; x=1738356640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
        b=F6Q8Es6q3adFyMmykPGNXaUD1M5y87uTxNVWU3c8zrO7MqR2WyQg/vVP1kL+PiJAIa
         aUfJGU1pLKHHNT8wyA/lnF9e1C3ECt75VZfoXW8W1ySt7e4niGImBkb2S3XcTUbB8GmX
         5HwlV10FKMPClBWzsKLqUn/vHknWbttS20oP6DnO15XXMOfW3X1tdyr+BnG0Iw8lOpVP
         AU79UvCBYju3sE1yRGbzl5omS6CXZNjve4WhxmY2IwsU5/iFXyjoFmfLNC4PtZqe3prO
         j+wAlfU2Isgiq+z9XyrVE9fCOOMAjIPfoRRmtI4xkA70+COo+WHonofoZgccI7JytWox
         onUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737751840; x=1738356640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdzsCT8xL6jHZ+tnR3Hwgg863MADe4016kWtdjp4rcw=;
        b=BZ7PAURfaVJhbIdZVClxxBb2f3liHbsoVniXxGPsdEUXwbOvxtoSGEDSRcM8mosnJg
         TTrh86AZQP4gDTEmLSlXeOx/RQEFFnWuijtres34gjeaW+8FAcs2v/F3rvRTFyzJqwgH
         LJPKzbT184AuNtGT4jKtD0mZbPINUNjWkS0s8kR2qw7IX0p0QnSzD0uHKJbM50R7LJvl
         RYqxsHQXG21me4M5QxhO825hjo1QtQQ3gcS0dX9va26mnD7dD83cjoJvWMHoDxxXxtGb
         O6x1FATsU+MptHuQv/p/23MSPTpjpl4dcB8H8FE16KfxwJrogtwwHO4OfKPKK/pUql9J
         UKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGjzEC4f7c5U/LnFPaBqc9OuOCEFe8y3876NBAsLXWuFKzd+6ngFip74QeK+DqOn7GjegAlZiUDK3KVeA5cX6Q@vger.kernel.org, AJvYcCWZpXiU3kdODsofOOiXsXG/3Cu7IU9JTKOwDRxIXek3/rLeYidyqZ3ubrpemXmpObQvuN9mjY4gu11f@vger.kernel.org, AJvYcCXZ0/ohdGwX6clqI/MpAJTgxUb/GJNYhjGuwlEuOOnNHfnz7KJfvo3vkZjcQCxpdSIxRRiHBT3KJjH7UTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGg07t7nBMcEHY4uZ6s+DflAWIBsqV3KRxGq6/Vmx9GgLZ9L6
	kokdsct+PHwXo5/wD1SnrNi0N7GZKOShn4mcgq/djxjnxMvcGed3
X-Gm-Gg: ASbGnctY6K0OiK+eAjXUUUoUL2ImiXSujy+oMLF7TOvx5fyRiWIdszu2hw4A/nNy7Uu
	Hx9h4csEeOjvOiPHvlP3uIjQJZexlcbcbZ+K1f3ifB1f+Uv0cRCQ3M+D+Yz0tcJZulTaK2qkinY
	Ukhh/LUbaVcy0GqCMZfZ3rLuyDFrCo/J8kvN2mXRI2RlPf00n6RXED+o/UUPg8Beia0O+PWJBgQ
	QE8atO4uYmj1Gq9soXIsGLin7NGpzTqlbRWXCgNfxAKKpLNP9aC6JO3P0vzAwXlNHhmSCYiKrZO
	cP9ac3UNzDtrtEy06Y0TkEjp+a0CRfaxvfT7fb2QuWkmQcmccwk=
X-Google-Smtp-Source: AGHT+IGwvSer+unLlVc6WTlhBYxGObsMsLAI7zUMsLtcBkSVhBWiPYvxWe7dxKBqk+OHgzBCgn4BNg==
X-Received: by 2002:a17:903:2449:b0:211:7156:4283 with SMTP id d9443c01a7336-21c355fcb7emr524423085ad.43.1737751840090;
        Fri, 24 Jan 2025 12:50:40 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb? ([2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da555a428sm18349685ad.84.2025.01.24.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 12:50:39 -0800 (PST)
Message-ID: <5acfbe92315d93aceb467fec1d239d6a7a7ba499.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com, 
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, 	torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Fri, 24 Jan 2025 17:50:29 -0300
In-Reply-To: <20250124135203.040d0852@foz.lan>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
		<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
		<20250124081250.GA24731@pendragon.ideasonboard.com>
	 <20250124135203.040d0852@foz.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 13:52 +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 24 Jan 2025 10:12:50 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
>=20
> > > It's been a few years since I first thought on finding a good way of =
helping
> > > kernel developers testing their patches, while making use of the free=
 runner
> > > minutes Gitlab offers. It can greatly simplify the testing for people=
 who are
> > > new to kernel development, or students trying to understand it better=
.
> > >=20
> > > And this patchset allows that to happen :)
> > >=20
> > > Actually, I spoke to Helen last year, and to enable it to run on the =
free
> > > Gitlab-CI runners, there is a small extra patch which is needed:
> > >=20
> > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.co=
m/ =20
>=20
> Sounds interesting!

Thanks! :)

>=20
> > Gitlab as an open-source software project (the community edition) is on=
e
> > thing, but can we please avoid advertising specific proprietary service=
s
> > in the kernel documentation ?
>=20
> Every time Gitlab is mentioned, the brand of the company that
> developed it and has been providing proprietary services is also
> advertised. If you're not happy with that, you should move to use
> a git forge developed by some open source community.
>=20
> The way I see, the best would be if the CI integration could work
> with more than one type of forge and being able to use any
> free Git??b-CI runners that would be available for developers to
> use, as this would allow testing more subsystems with CI, thus
> increasing code quality.

Completely agree!
I think that this Gitlab contribution will set a base for implementing othe=
r
forges / CI systems as well, and allow us to make use of those resources fo=
r
better kernel testing.=20

Thanks!
Leo

>=20
> Thanks,
> Mauro


