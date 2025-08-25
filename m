Return-Path: <linux-kselftest+bounces-39816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E27B33416
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 04:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B118D7A2E09
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 02:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F5229B2E;
	Mon, 25 Aug 2025 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6V0EK2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0618FC91;
	Mon, 25 Aug 2025 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090141; cv=none; b=dDmH/XSeZJlAZzitMWmsdlHBtmHqtQjhIj1FlmMDccv2kVJMiFL73R71ohCu4eTEwHmzPvN9RT7PdaacQJuKdP1VPr83Ld5uAuDU5XwXfrWuHHmCGsi2gMZo47MU+GVHbgG/FPkWl6Aie5JThvdrnHoMtr8jZOhexdedASUeAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090141; c=relaxed/simple;
	bh=UNMbrd7hgvAtuRFWyNNxOWTM4EmKwRV0uuqjzMO9iSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmBju0udSmtPyuHONEEh1vrKCFgswRKtZNYmwlVeBxYkYuZ9fubfcz8vbPdUAJyRkW0rZA9WS51iufJmPj+xI2xxlbDDr1wQVPV2VgMIXR0g7w4FY1sIETdCysusAA+ZmZm6jusfoAGrnwJDYymDp2aeIw976vbDbkS1w+cOaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6V0EK2K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3305923b3a.1;
        Sun, 24 Aug 2025 19:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756090139; x=1756694939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCLwb/EDAA4ippM35qYgVy/WRmFSEboUwsaV433ebuA=;
        b=H6V0EK2K0EVnUPFpVP08jcJC32qTfaQm6SWjbZGmWdpIt3DPnKBgB3G9iqddqyS1xz
         fqrCLuwzqnRcQ6kcBl7vkNPaLNq91nQnOIBNQLL74Ha9+XsKtcX9QFwxWH01n5YmZ8Ig
         nJ9GKKm5FylIDCyUGkvu80Pc3Zi8wb+jGQd7zAMXkxIv5aqg17O870T89cxYNEgyOA8R
         qdV10DfLDqI1SVsNqALmKBhfep9p9RIXplC/Y15lAv7VyYitcvNmalfrc1kn5esj/9ld
         Zs8jou758yJRjyeyRbMogUK+knbp0gjO66UUPCnFDA/Vrl97Po7h2BwVZz+ks9moh4g+
         yGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090139; x=1756694939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCLwb/EDAA4ippM35qYgVy/WRmFSEboUwsaV433ebuA=;
        b=MQXGKX5ncZ8gDpdyZhiA1skIo/wC610LE3o7m1ajQIvsaCvbcJ3P42StSOKxdXfHBR
         S4yFY9etxRxwu3BlgW717L+YDEDUaI+et+fL9IiwFUoLHwxJQS1E0LajQGOpOW1+nj3o
         FA+oYphWwifsZT0N5Fo4uVtME0aODQjt/KH2mzvOKS+/uBA9jgSxL3+9QwgGtaiuXHms
         D+Ye99MYEnUbO8V/DGOspMcRRv5q8CKqclGvMocMVo4oxv6kpVMkfe2RwUTxYtxJzy6P
         G+uEcwynkJR9pRlb3Paqh3TZlxlnqXBMvQ5GoUIZ05ChjqiOoVTo7xrj+g7p7xrRj773
         BFCw==
X-Forwarded-Encrypted: i=1; AJvYcCUvh6F56k9Xpjkas6Wuf1WstJHckah922LD5z8z4JIPe6JKacpdGNJ3WnhOc+ii8tqvuvqRuRVy/OA=@vger.kernel.org, AJvYcCXxUxYZMAJCkPK3NbQERte4dFg8xVukLSjC4nZGnc+U5gque7JentdoVsPkeIC7GKDU+pwacaE1RFcSZSJpQQui@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZJXVBIH1ISxcCUsrQ6KG8qviu5ioKhAQeA+hOIrz2GjU+4pa
	sJ0ImtYPnTvl2+aLip24P6fn4CvImx5wmdiL/A9Unzaz32PIC0lu/wWU
X-Gm-Gg: ASbGncvRVPMEMOJW8jRGDij3BJ6nC3sylCqjyZS13tBhlLcrb8sSmsWo8yypiU9A3M7
	0wB1JGi3KrwAFf70t3gufgOGvo1SaMDMSh0s28nCjcadesOM2HJNwkJfGD5vFgHDIEPj02liQOs
	XHY3961SsYjK/k6hUlCVk8xxa7XNWQhgXNCKi5bt8ovTE3uPlRztj1ly7dYNIv3v0j7TWJh0Mjv
	iwfw1kVTQJdDUJODiNRRptIChIIpNGqV0s7j2Tc9VPKf4VE6wE1LkJPP6HKzKEnAqXF7uB49Zb6
	dJt2YvQGm7OnJ4xQIhfHdu0Ia8bH51RIzyzMxLYedwAIhVrjvKcaMdrinfC3BAWuIgVG/x1AOFl
	rz/lfeOz7sjopYw2D9cA5lF3Dgjk=
X-Google-Smtp-Source: AGHT+IHcXBzFHVDS6JF3cjZ2GEDtTnnPVuRO91B/XKp81mhgYJt6SoHA5RpDPSM3y7rxhcIuU8ZTZw==
X-Received: by 2002:a05:6a00:3927:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7702fadba93mr12801609b3a.19.1756090139483;
        Sun, 24 Aug 2025 19:48:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704001eb82sm5865845b3a.47.2025.08.24.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:48:58 -0700 (PDT)
Date: Mon, 25 Aug 2025 02:48:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 1/3] bonding: add support for per-port LACP
 actor priority
Message-ID: <aKvPERQJS3pz_DTW@fedora>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
 <20250818092311.383181-2-liuhangbin@gmail.com>
 <1547622.1755909223@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547622.1755909223@famine>

On Fri, Aug 22, 2025 at 05:33:43PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Introduce a new netlink attribute 'ad_actor_port_prio' to allow setting
> 
> 	Nit here "actor_port_prio"?
> 
> 	One more comment below ...
> 
> >the LACP actor port priority on a per-slave basis. This extends the
> >existing bonding infrastructure to support more granular control over
> >LACP negotiations.
> >
> >The priority value is embedded in LACPDU packets and will be used by
> >subsequent patches to influence aggregator selection policies.
> >
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> > Documentation/networking/bonding.rst |  9 +++++++
> > drivers/net/bonding/bond_3ad.c       |  4 ++++
> > drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
> > drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
> > include/net/bond_3ad.h               |  1 +
> > include/net/bond_options.h           |  1 +
> > include/uapi/linux/if_link.h         |  1 +
> > 7 files changed, 68 insertions(+)
> >

...

> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> >index 2fca8e84ab10..eb0fb7374391 100644
> >+static const struct bond_opt_value bond_actor_port_prio_tbl[] = {
> >+	{ "minval",  1,     BOND_VALFLAG_MIN},
> >+	{ "maxval",  65535, BOND_VALFLAG_MAX},
> >+	{ "default", 255,   BOND_VALFLAG_DEFAULT},
> >+	{ NULL,      -1,    0},
> 
> 	Does the standard forbid actor_port_prio being set to zero?  The
> description I'm finding says only that it's an unsigned integer and two
> octets in size (802.1AX-2014 6.4.2.3 LACPDU structure).
> 
> 	-J

Yes, I also can't find a clear doc about the minimal value of port priority.
I will set it to 0.

Thanks
Hangbin

