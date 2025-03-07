Return-Path: <linux-kselftest+bounces-28451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6BA55DC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0427A47CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A212188733;
	Fri,  7 Mar 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcyMEv9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D118785D;
	Fri,  7 Mar 2025 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315168; cv=none; b=GV27WZDyMiXVuNUs1jFnOLS+MCnLbKPGkboH2V4ZC/sCO0depgF0e9B5Uxvy+DlZKB+i7VBe6jL1drZVPOn7+5T+B4Kd2z9eNa0bae5PyBJOv/D0UtCbQOvNal0JB2R4EwCXkwdrmIg5oSw9mig2skhgcAjsgW2sMDNejWM5IwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315168; c=relaxed/simple;
	bh=6OU9bNzpGoUP8m+6t7CMEqs1s2CSGxSHRzD25S3S57U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoINMAxd9aVKmT6JiqxKq7wnT3SKWvxTuI0YFUsKWWMJj2syb3u0nEgEO4C/wtgaqmVdfl3cLd6bQPn3HvX5CsHwH+L7we8HEoI5ARSgB+G4KIpOPqDhw/m+DH1ly7aXeNp6MLcLmziOVSYQKfSCxBgPfN///vsL1IR3/vQmkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcyMEv9I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso2515642a91.3;
        Thu, 06 Mar 2025 18:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741315166; x=1741919966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0d4XpVOjBbNecE/XmRwQFw87n6IpADVfzl27NW7S8cM=;
        b=XcyMEv9I4r/BZMDwgjJ5W8b9t45sKBExMoYdnoQEDng5YuLvkFvM/XboNNGy1YS89g
         fBPmXQq6Q1YW7yPyObVkckNgirBchJAsfwf22TK2jooHQqYM5ZNFh7fXLbLDPb0lUjO8
         rhDtaJBN+b1uSJduBidqHIJDzS2CeoBuESn1fALKvO66gZJppsEIUe0m07c489sXBloz
         nKADFvh5iPKOjvA6qaq/Yr1Hx4jn9C6Wh971yJWuToDAbxEog0QIMcZESQ3KC8WYMxrw
         8SyU5NaXiNdfMWIZzWWtCiJN1H9P/z6i7YJclVd5294A9fXaleEO7mjYW8qQ3/GzDKHV
         p04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315166; x=1741919966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0d4XpVOjBbNecE/XmRwQFw87n6IpADVfzl27NW7S8cM=;
        b=WqMTcUbrHSIaNJ09U105vDSSZZr3JnOq+YOAExd9pX652moeLTtq5d1UKr9hfTvZvm
         tmHot1LM24GBWAsr7V2Xvqn/sag1hpciEpBqpASFUtsmYA/SdGzHwWmOmSbn+JtigDwn
         +V5+xnvW1NFbwGr6qM5HkY/AOli9ykfx8zIO1Br3fQIF5ByOPk9uBJlDXK2HYoJCocmK
         rxGDBEJxiFKoZjKQ+6yg3GfxpPH18urt7KahPSwp4+JJGvLEMqPiZ93iw8VFz0R3U0Tn
         jHDBHGQeozssU8BJYgQEoyKlKdvzslBUfMFKHA2TWnmx2+ztSvLwfkOC0VCirxpKjVFp
         HNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUCmuirdKSEsKy6M0YeygREpQJqtEeNVpRQ5UMRqHettpxoTpaRlT48SShLMHzJrV+w+olVpcvo6fLVvlc=@vger.kernel.org, AJvYcCVOQGhiSCi1C9yIXPIohLTnRgQjSAT7srMvimd7lRdpZkflduItasWHdprQeSq7P44RBSLQvqKO@vger.kernel.org, AJvYcCVjStzII0q3g7xQQC+QgnYHV7YfqUU471Jhxrgxr73gxqtU36MJDmXXxsQzcCLCn1+EjzDnbiGIgnukF2WOauRf@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOOxre6u9RBsP1DB+IKZoD4NsF9yDogfAH8vKUPxHM4fdjlGX
	409L0zoZcMcq1d3f/XDkebA3FJPRqYv58c0QRE0k0DfpckUBDkDE
X-Gm-Gg: ASbGnctj/ZPhr44r7yP51wBqMHATIM5BOTwM6BAtaIUFbHIuIK+x5rk3baRPBHiSip5
	knZFMOpVhQ5SMjBUuHxiaOxrq23zHBPfpyUB47q9Bc6YAThnbLfQ7PJL3Qn5CfEcnWx90XH+gsG
	NR9TKKwGiNZVU9L8GFllyOs4Lxq87gdbeDRx9xAX5koz8dtliZypgAg0cnSf/uPawTrs/x7zQdy
	+Gfrt7pHrgFYrdzlqqhaeBfqRp8wDyoWrT9BS1XCLfTETFNkfwNCKYlzR/wpIIR7FMgAlZAHsKI
	s/utqjsb7EnVhrZD/OeXmgx5oofB0/iuVdlZRwKfhWRiV1xEaQ==
X-Google-Smtp-Source: AGHT+IFIZCp6xuHzpUsYKy0v3LgrML3vB01/8gnmD5Qfx9LBkQTRH+vITz9B5AClpfZbdNC2kQVIgw==
X-Received: by 2002:a05:6a21:3287:b0:1f3:1b78:ceb2 with SMTP id adf61e73a8af0-1f544ad7944mr2951706637.9.1741315166026;
        Thu, 06 Mar 2025 18:39:26 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a336010dsm1378308b3a.59.2025.03.06.18.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 18:39:25 -0800 (PST)
Date: Fri, 7 Mar 2025 02:39:16 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Jianbo Liu <jianbol@nvidia.com>,
	"jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8pcVHdEkwk2w0En@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
 <Z8hcFSElK7iF8u9o@fedora>
 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
 <Z8ls6fAwBtiV_C9b@fedora>
 <Z8lysOLMnYoknLsW@fedora>
 <60cfc1af3f85dda740ac19ac06a27880e79c9c1e.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60cfc1af3f85dda740ac19ac06a27880e79c9c1e.camel@nvidia.com>

On Thu, Mar 06, 2025 at 01:37:15PM +0000, Cosmin Ratiu wrote:
> On Thu, 2025-03-06 at 10:02 +0000, Hangbin Liu wrote:
> > > For bond_ipsec_add_sa_all(), I will move the xso.real_dev =
> > > real_dev
> > > after .xdo_dev_state_add() in case the following situation.
> 
> xso.real_dev needs to be initialized before the call to
> xdo_dev_state_add, since many of the implementations look in
> xso.real_dev to determine on which device to operate on.
> So the ordering should be:
> - get the lock
> - set xso.real_dev to real_dev
> - release the lock
> - call xdo_dev_state_add
> - if it fails, reacquire the lock and set the device to NULL.
> 
> Unfortunately, this doesn't seem to protect against the scenario below,
> as after dropping the spinlock from bond_ipsec_add_sa_all,
> bond_ipsec_del_sa can freely call xdo_dev_state_delete() on real_dev
> before xdo_dev_state_add happens.
> 
> I don't know what to do in this case...

Yes, me neither. How about add a note and leave it there until we
have a solution?

Regards
Hangbin
> 
> > > 
> > > bond_ipsec_add_sa_all()
> > > spin_unlock(&ipsec->x->lock);
> > > ipsec->xs->xso.real_dev = real_dev;
> > >                                 __xfrm_state_delete x->state = DEAD
> > >                                   - bond_ipsec_del_sa()
> > >                                     - .xdo_dev_state_delete()
> > > .xdo_dev_state_add()
> 
> Cosmin.

