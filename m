Return-Path: <linux-kselftest+bounces-40139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C578AB3922E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 05:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E7464EF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255024728E;
	Thu, 28 Aug 2025 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYcNbLkR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9821CC47;
	Thu, 28 Aug 2025 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351507; cv=none; b=WQvRh4qbTNrX3h3GWGP+gk7+7GYwW42R2ZiQ+dfuwkJghqkatUKQjx+P54g8idM7GWwohfxSg3+KuoJc20ita25Q6I0UxWJuhNjQ7Z286b2zDuQMxUnuJjT/LZqumZzAe/PCpAFHZZTz0NLVdBMHSO775Exeh8PduH+38eRyCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351507; c=relaxed/simple;
	bh=VYK52dIq5ithVBRXhtSUMCwCpkoQVxauo174v6CEHKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn2GH281IfapQtdE3ygZSHwzSy0q3CwGKnEAk6U/ZGCyNxghQaj2/J2WPU47pD3iJcMUvXPMR0e0U5rCCNBYohZzbXuRDgDgL0LbaQ1/oQSMcO+9HvghhHk/QQIKK0M/luX57aPi1EIAoWuASldFURdF62PeWEGEdJErDIMu7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYcNbLkR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so1309029b3a.0;
        Wed, 27 Aug 2025 20:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756351505; x=1756956305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLyx6ML0KJAS+1NvI+nDMGvNH+1iNlA/o7NMKd8ru7Q=;
        b=SYcNbLkRbAJn25uZCBV9t+3Xd+f96Z/fSpL69Cqt1iKqHZiF+F5Tda6WVCLAmKuNSx
         O8mVpPL3dNnjgqPnUAEDA9Fvwjoc16BIPaY8t7oA7Uba19xvX2JLy/bwTl616+uZIQaC
         z7kjbqaNOgz6nddTUs/4oZPkhfvgDLiCiav41Jhd1xVxl88ju1eyYaXcZZ85GhB12TlG
         s080UrjW7BQanig4SCA2EVe5N99f/pNWo6+suEiFTCquWJ/GRPV6PpldRI8p3DpiGRb4
         sCpbw/yYLTXaaOzMQYq75xNAeFu/okHJas97XBlbXT0hJBhFQVSNszblpcWBk6uaCB9n
         nvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756351505; x=1756956305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLyx6ML0KJAS+1NvI+nDMGvNH+1iNlA/o7NMKd8ru7Q=;
        b=ZfawNw+LAeeRd1DS0XA54IlyAPPUoCk67N1SsD/GJBTLVju4cyhnfN89Q6tZMcf1VQ
         hGqpjzeCUTAh6Ihw85BXX5HKpdHoyXzEEUoAQsCGntEDT9tHjAfm++/F7hvLthwbYkhf
         FYwRuQIl6c8yi2ADBe4aQwRt1+F6qR/gRHNvVsdyu2vhKbZD0LJRpcJfQo+HX4qoSkop
         8Ki0szp8ui4iWqzq2g/zqVuuw+syR41PC66WuNLb5RAVQgh7p+yT4ZBbSvYWKPgTXnGn
         Hcqw0EEweHYIeKKQrvliQzEf5xDK6aozU0rpYrz9nCLlD0YJWGjaNJytgK/1oA9zDQKb
         pnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUSiVCMh5pKieGs1Gs7jCKx6ipBPn+12EXPI6RhM7EMFBeLTtPehIW2EEd9JlnjlRGSEeK+z3g2TUE=@vger.kernel.org, AJvYcCXHg20lZ+S1/YoN87wFnP+QOBvSNhNO9qrPqaC6xsmiRQL0XBdZaqmEERbnb1R1u5xLJgowyJe4tsvKPjgGcdJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdHa8q/u/FBPQs0SxQoHbEZ6St7cg4sMU2FE8wk0RTV5rT2BN
	bY/zhwGlSVFI3SAexEiODTUVkOmpbKGbsTzEcKqcLyLZYkN3Oo2raXKe
X-Gm-Gg: ASbGnctw5fMSxRARwA0kJQM6WkJiQnm85HpbfmIuzlS72pGF5MJF94zvYx3yLYZkPMD
	UYlZJy5o9G9re+LGQ0wMIGbKAEafTQilYm7exEokvdi02CAmqSPPaDOUALpTQn6MYoE82L3EwU/
	KDCpre2dUnxhxDDuwtxz+IX4BtGmJ7vja8QJQpJFpfGDcGhyAKpnAZZ35HMWYx0lpI7/brs52Ge
	i1Tzuux3tKwJcAj4LrLRrHD8QvwzswzAsDOZqH5bFUz7f2vFCA0joKVF56lN/JT7ZEV0FuY8tR5
	GC7v/VOf5PS3PnJ99SIs4AVQ4WDyDQq9eDpuDWRI7DfX6v7JYjMdmSqULAhbQn7Mf580lctUQfD
	5/qW9QbtK864qJScAeQEd8Ew+7yo=
X-Google-Smtp-Source: AGHT+IHspYn3n01oCVanCisayOBpzEX9n1l0rBErbk+dYTSa259uJbdyVIwQ/0yywctKmGk8IZVleQ==
X-Received: by 2002:a17:902:cecc:b0:237:f757:9ad8 with SMTP id d9443c01a7336-248753ada89mr94764985ad.1.1756351504807;
        Wed, 27 Aug 2025 20:25:04 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467de528fesm127471915ad.97.2025.08.27.20.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 20:25:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 03:24:55 +0000
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
Subject: Re: [PATCHv4 iproute2-next] iplink: bond_slave: add support for
 actor_port_prio
Message-ID: <aK_MB7ikY0hUhGqn@fedora>
References: <20250825070528.421434-1-liuhangbin@gmail.com>
 <1859262.1756320199@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1859262.1756320199@famine>

On Wed, Aug 27, 2025 at 11:43:19AM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Add support for the actor_port_prio option for bond slaves.
> >This per-port priority can be used by the bonding driver in ad_select to
> >choose the higher-priority aggregator during failover.
> >
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> >v4: no update
> >v3: rename ad_actor_port_prio to actor_port_prio
> >v2: no update
> >---
> > ip/iplink_bond.c       |  1 +
> > ip/iplink_bond_slave.c | 18 ++++++++++++++++--
> > man/man8/ip-link.8.in  |  6 ++++++
> > 3 files changed, 23 insertions(+), 2 deletions(-)
> >
> >diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> >index d6960f6d9b03..1a2c1b3042a0 100644
> >--- a/ip/iplink_bond.c
> >+++ b/ip/iplink_bond.c
> >@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
> > 	"stable",
> > 	"bandwidth",
> > 	"count",
> >+	"prio",
> 
> 	Should this be actor_port_prio?

hmm, actor_port_prio correspond to the ip link option name, which is also
acceptable.

While in kernel, we defined the select policy as

        { "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
        { "bandwidth", BOND_AD_BANDWIDTH, 0},
        { "count",     BOND_AD_COUNT,     0},
+       { "prio",      BOND_AD_PRIO,      0},

So I think the prio here should also be OK.

You can decide which one to use.

Thanks
Hangbin

