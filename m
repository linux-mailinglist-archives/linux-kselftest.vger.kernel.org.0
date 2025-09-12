Return-Path: <linux-kselftest+bounces-41271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A8B53FA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 03:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD9A0221B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7650276;
	Fri, 12 Sep 2025 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwbBgGSv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C95381C4
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639314; cv=none; b=JGVBs4tsHndxXiyLbbC6pfNWcMLiUIblCopMDUGmjKLBIV+IKjOpOY9EHwSh34admEKC6HGnsTjZ+l3DadT6UJL8FwAiUoiXdgoOI4XOgSr8Qz9ugsXM5vp7RvLkhuKogN4nG4GIh7oEAFKx1e3XhUpH3TwDKzQ/cA6nKYf6PHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639314; c=relaxed/simple;
	bh=eQpv6kBWgXwZ5ymPbOOxPwWf3GOU0exmn3ci7k/yrAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVjjDNeldoP1DF5zVsyzyzj6Pk5paeFi+x5H6kz17zWNiylRD8gk0S92S8P+DXeP9NigkKpb44vshC8Zz3kGsTe/DmEEVZpKvWYjQ3up9G5AQ3xyskRM37AS7rf0nbO2x14s95L+SjTLwCG/obDtQA9AyvNF/ScmDkYkeOIgbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwbBgGSv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cdd95c422so9056395ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757639312; x=1758244112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3q/WZRKTStLm/cr3Bpe/8OXQEdqzw7U/XTO1V+fg/A=;
        b=hwbBgGSv6W4nhFcSZQGdY++aSGxVWMuURSyUqcitFDDNaMCKQiaEmavCX7wkqkAY2X
         HppIqfsMgrK5OhxMio5Jc7gGei4AmUq8h0mVvSvo18lacTFyhwcz/7bLNJiCAca2yeHv
         6GfFBJZGQeGh7GEjz+UON8qyu8Xq8fsDVNs2988VWVtfnk+SFrK7A9B+0PEEppkQXeGG
         njLpl9fdw3ycDOtLgmxUquguBKia1z285AgvxC31xL59yQZxcPTLEtBL+eCeVc/9MAl6
         yABI8ZSjFCDjDOjsGMTxZjy4vWVFBwtg5DNGvL1kiaovXfW+LO+lE+exoy1PubnJs8XV
         meDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757639312; x=1758244112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3q/WZRKTStLm/cr3Bpe/8OXQEdqzw7U/XTO1V+fg/A=;
        b=XbGlQ3q0g0ZZLMJ8pr5MpcbLrRma26NenrfP9sZAAkV5fgws2ysZZG5fOriJIiUG6H
         ejcLi1u/dCxLDTJCOQsY9+4RCbVLRXSjEgMPHTV1lnbEkM3D17lY+oGzyWZJOJUA311k
         vBatIoO59lT4bhL7VkpLJSA+GacnQMBvehaUx80YVGi13gai0QXsAdxwgKFSi3ExauPK
         kuXPdIPmDKacSzXXIWnCD9RlGhK74gCenucEOemCHHHGBvBmfeSARCiNf5hFjYLz1wBs
         ztKstDxeuznApjtSNAZ5Q+OD/nFSFMwDUb5Ce/51MY+3vjbR1QCcHez4KJg6xq1uzmpR
         Z8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW+MgP2VJlQmioVimbMxYGwzW/ky6xKZwxATFri1ihBggp44v01TfXudHrgAuFWZ4OXZE2zK3de0kRF3sQQIBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFAa1ux9zbLJ6NNyY/sBPP93CO4YQt5auwaztRSR1WCEaHnd+
	EKxskUCk50KL8eCTV43QIgjHhM7EL0xISkyv227Q5PA8rwAml47PU1V1
X-Gm-Gg: ASbGncuz/eCP2jPTa8D/mKavl7h4Ol2HYh60tnERb2X6cwhgLcdYWPMZHjA7RhdTmO8
	a9Nsi4APoDexUGr6PPSLBjkenyQJ8lfAgJflEqtfH1DfBtc1DBL5m6or0KUm18MzF7oCbyQbO3o
	GybAA4REXH3ViW6I0XaHBuwNhSln9bDfTVQG/MaQD1a1OqTtNEKZEUifsloi7uLbJZFiiyn6EOu
	bLk8zb4q0pnNV+uMnQjqAkNBHuRiAyxE9xhmSznzBwysLXi0up3+QmEDeOzeJJ//Yk5w41rtqLA
	Em0wQNFkXf8bzJwlvqkOV5n/MQscQTofXkB18gCKZQZ7RZI8Pb80jPgazxjxPCYSXdY2Ksnh/C/
	aCE+x1RC8K81f/u6pAHTN67MtqrrqOlriiSDDjQ==
X-Google-Smtp-Source: AGHT+IEaxnOMPBCkONkI1ijeqyKr/Allx7jl1xU+fododaurhzB5w02ghEn38iBkjsFdGUAg4fAuYw==
X-Received: by 2002:a17:902:d4d0:b0:24b:e55:34b with SMTP id d9443c01a7336-25d2665fe69mr15407845ad.31.1757639312270;
        Thu, 11 Sep 2025 18:08:32 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37295f9dsm31783235ad.55.2025.09.11.18.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:08:31 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:08:22 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aMNyhuC1DJsajuqs@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
 <aMGLTzACsKLRIsVb@krikkit>
 <aMGwcyKTvmz5StN1@shredder>
 <aMG4W9xUGxjLAVys@krikkit>
 <aMLHz0P4KhHPNIcc@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMLHz0P4KhHPNIcc@shredder>

On Thu, Sep 11, 2025 at 03:59:59PM +0300, Ido Schimmel wrote:
> > > It is not clear to me why we are setting hard_header_len to the largest
> > > of all lowers and not needed_headroom. While bond/team allow
> > > non-Ethernet lowers (unlike bridge, which is also adjusted to use this
> > > helper), they do verify that all the lower devices are of the same type.
> > > Shouldn't devices of the same type have the same hardware header length?
> > 
> > At least not with VLANs. Both basic ethernet and vlan devices are
> > ARPHRD_ETHER, but the hard_header_len of the vlan device will be
> > larger if we're not offloading:
> > 
> >     dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> 
> This looks like a remanent from the time before needed_headroom was
> introduced, aimed at making sure that the kernel has enough room to push
> the VLAN tag when the hardware is unable to. I believe it should be
> converted to adjust needed_headroom instead. Otherwise, looking at
> __is_skb_forwardable(), an skb might be forwarded to a VLAN device when
> its real device does not support Tx VLAN acceleration and dropped
> otherwise (due to a smaller hard_header_len).
> 
> Anyway, I'm OK with keeping hard_header_len for now, but ultimately I
> think netdev_compute_features_from_lowers() should be adjusting
> needed_headroom and not hard_header_len.

Thanks, I will add the needed_headroom update on my todo list.

Hangbin

