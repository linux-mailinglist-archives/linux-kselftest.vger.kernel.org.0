Return-Path: <linux-kselftest+bounces-24816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43DA17521
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 00:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C691610B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 23:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2426B1F0E2A;
	Mon, 20 Jan 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5YDefIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DD1EEA5F;
	Mon, 20 Jan 2025 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417571; cv=none; b=U6WNydBMI9nLq0Rtp0fuseJ4M7tZf1nuJ38FgDX2nMIAUDK+b9CeBzH4g6lIJYym3zGYlxiuAZ/sxMfjdmypQnhwnmg+HgWREDOAuyxXPTMV2o5B6u5Yv03SOQjKwYXtTn6K9XKqcXD8eLlNksxOqu8wVmktp+yGs2Vf/jaw9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417571; c=relaxed/simple;
	bh=IObzUiPr/ScqnWCLh8ZhshcgyHe6uDV+MkYxYjkhh+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU9kCwolG6RX34fW644ZYDto/5VXqSicQOS4BgwkHJBo89x7yY3h5FeTwLF7S+hmCbGHnCJJ2MFpm6Z+swovBn5merc6EpDdiDPUf9VXtBHCcMaFdAuzVPiIsbhlwnjAagoeIVHGt3UrD29WrqjjO19QkhpFMDB+JGDLPJe1BE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5YDefIf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216395e151bso63857515ad.0;
        Mon, 20 Jan 2025 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737417568; x=1738022368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ/cfXWP5UJdRroai2So4DXPX73O6aD8uax0t7Obc60=;
        b=l5YDefIfCtALIQKw2PEGNaKR5pDqlfRXqLMYnrsESinPg2eqqlzVqufXY3QQZNa2nW
         Wqhb7ZUTv69FQWy9rquJB/tvuRL9PYmI5Ra0e/bkp9ti4WRKkVTgHeDtDPu3lVlmHYwP
         3BW0nZUCKf/9QSigEQ2WpoyCZd4VsbIGM+7k63TZHmnZfZSMYkOAFC+3yq/C+1e5ja6k
         rGZ5OnhqZ6kHTs4NpsmzapNbN0N2vOvoX1F5MdPtDUv2OePxSnaleYY0CJ+C7ntDXYNv
         67bCWrBpyq1Fjc7H2FI2nK7fs67lhyxeJmk8tEjgl43QdKhaL+QRzoAx0bw4wL7WtTaX
         H4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737417568; x=1738022368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ/cfXWP5UJdRroai2So4DXPX73O6aD8uax0t7Obc60=;
        b=stOIduS6v7lRncJuc/HTzoWkr/A7sHl1te3hZ3PnjK3fS/FnqyiHtXnugJ27VSwXMh
         CR2GN+AW4mqbyp6TRhaItrHPnm+PPFhTTJs+9DPZYld520PHoKIanrfVwz20FBboEJtO
         PpwMzuylw+rV3/KWmU5h2HA0SH9wkWcUVa7Z53VfZ8pFe5xil2HBsw+ijcyKexFiAq+T
         fAoe8k0dCLsZSN7aTOjQudNjB25ao5IxmIJZ3n/eiHAgcJQAt/mZKhdOAXfFcS70QQQb
         suc254LzHjtlBrKr9WC14IB1OnCy1vQxiXbNFVOHjZlBKmmefmejd0VFG7Yl7WBdECOd
         vDxw==
X-Forwarded-Encrypted: i=1; AJvYcCUhalb5VjEGZ/epqwA6jlupRQbDiQVSv5RbyZ7BUaXFld18OGwrm4g4xFyd3r+WKllVpV4lD+qEkAeNckQ=@vger.kernel.org, AJvYcCVWsZljNNGbSptHWY1NeunSlYj7o3EqgJM4KC8yI2QbXnapvqtWd347QBO6SilOliRHRVyYbFgZ@vger.kernel.org, AJvYcCW88hqNa83Cz5GE7VG2x/TEq8RKShyq24SadiGnsWvHcIZzui9cLmZEcCopzEwvyXCTUnMZ5475rkuCyVMT0W3R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2S9TZv6CXMIHmmnWecgeigUp8h5Ij9YhZ0xBkoQA3qE/W0wnS
	rznIdf/gdjSXS50XiitYRat1FmbEHhG38IZS8wgPYNpTrg4+DfVo
X-Gm-Gg: ASbGncvoGC81lH0QKMhV3ervC4NdkkvLbZyZ3jOJzupVzWRM7u+PxasjzQHAL2NILih
	FG6PINXRq2CKB8ejxYwxShOjGnb0I94Yxh+2oJovvmPRFr9KdBwOdK4x1EJ5umxrx+PiAwehGK1
	NrDSunxrRCi+fU7W/0wSth9201/QPIKi4C5HFvvqUIRtFHMQoUBbrkt5HoMxq2GdoZxDOoO00TV
	fc3gfSH7G0CQoWAjZAwsaOqAdm2MXy23sdbLFa++OPMbQKix5DcHQbtldXR3r4oWuORiA9k8mg=
X-Google-Smtp-Source: AGHT+IEIBu+SAhuE2A4tRa3Eo8tOHmKS+2nYodlTvPspBaUDG8oubKxQZRAOReURsJy5Y9KnDM00hw==
X-Received: by 2002:a17:903:40cc:b0:215:742e:5cff with SMTP id d9443c01a7336-21c366a6a06mr227310725ad.16.1737417567691;
        Mon, 20 Jan 2025 15:59:27 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9f05dsm66385545ad.13.2025.01.20.15.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 15:59:26 -0800 (PST)
Date: Mon, 20 Jan 2025 23:59:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z47jVoQdO9sD19TB@fedora>
References: <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
 <Z4d9pVshf3RKQp_o@fedora>
 <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
 <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>

On Mon, Jan 20, 2025 at 04:16:49PM +0000, Cosmin Ratiu wrote:
> On Fri, 2025-01-17 at 08:54 +0100, Steffen Klassert wrote:
> > > 
> > > Hi Jianbo,
> > > 
> > > I talked with Sabrina and it looks we can't simply do this. Because
> > > both
> > > xfrm_add_sa_expire() and xfrm_timer_handler() calling
> > > __xfrm_state_delete() under
> > > spin lock. If we move the xfrm_dev_state_delete() out of
> > > __xfrm_state_delete(),
> > > all the places need to be handled correctly.
> > > 
> > > At the same time xfrm_timer_handler() calling
> > > xfrm_dev_state_update_stats before
> > > __xfrm_state_delete(). Should we also take care of it to make sure
> > > the state
> > > change and delete are called at the same time?
> > > 
> > > Hi Steffen, do you have any comments?
> > 
> > Can't you just fix this in bonding? xfrm_timer_handler() can't sleep
> > anyway, even if you remove the spinlock, it is a timer function.
> > 
> 
> I am not sure this can be fixed in bonding given that the
> xdo_dev_state_delete op could, in the general case, sleep while talking
> to the hardware. I don't think it's reasonable to expect devices to
> offload xfrm while the kernel holds a spinlock.
> Bonding just exposed this assumption mismatch because of the mutex that
> was added to replace a spinlock which exhibited the same problem we are
> talking about here.
> 
> Do the dev offload operations need to be synchronous? Couldn't
> __xfrm_state_delete instead schedule a wq to do the dev offload? I saw
> there's already an xfrm_state_gc_task that's invoked to call
> xfrm_dev_state_free, perhaps that could be used to do the delete as
> well?

Yes, I have tried to move the bonding gc work in bond_ipsec_del_sa() to a wq
in https://lore.kernel.org/netdev/Z33nEKg4PxwReUu_@fedora/. i.e. move the
following part out of spin lock via wq.

        mutex_lock(&bond->ipsec_lock);
        list_for_each_entry(ipsec, &bond->ipsec_list, list) {
                if (ipsec->xs == xs) {
                        list_del(&ipsec->list);
                        kfree(ipsec);
                        break;
                }
        }
        mutex_unlock(&bond->ipsec_lock);

But we can see there is an (ipsec->xs == xs). So we still need to make
sure the xs is not released. Can we add a xs reference in bond_ipsec_del_sa()
to achieve this?

Thanks
Hangbin

