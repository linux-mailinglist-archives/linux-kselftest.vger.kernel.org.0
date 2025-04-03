Return-Path: <linux-kselftest+bounces-30059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F8A7A368
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D9418944E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023324E011;
	Thu,  3 Apr 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgOkT+YW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CC24E004;
	Thu,  3 Apr 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685753; cv=none; b=Zb1DjDrfk/O8+q99zNLPSQQrnHodZzPZ2e8KanfUXEeHFk386/xhNR2ApkUvYC9fHU7CO9aNlA4eYYKVXv0QMTQCnECQXqzqCxpS7pzA+St2iTqeQDQ+3Ft6mPNRRMq44KUQRiaS/yERIbvx20jCQwIdQLee1Suk9o4K4oYtsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685753; c=relaxed/simple;
	bh=WLyV2+Pb2bnxm2PkxBpCPFyjgfAd+7Qgvtq2U1NUuI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX/a3sWn5VhiDMuaZ7Q5sZDG2NAKkacXoduH8vwzg8WIaOxWvSN5G+r3pZpIYGvsszuiYVZD03Zhh9Y09Lrz6zp2O4Y0Jfy+72ij/leOa+y2RF0FLVltQkvACiWTOI1ybNBXnQj6VILI6bObBrqzjdWhE/MTFs8NAFZLRKHcj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgOkT+YW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so9763645ad.1;
        Thu, 03 Apr 2025 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743685751; x=1744290551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ7Vrq7J8vgATCF9GSsF7lV1TUk6qnniEF/+hhwVgXs=;
        b=EgOkT+YWsC+fxki3CjeEbmQaTqSrOlv1dCcElYl6vQK7fjfDzm88BDUSAa5AdXSz1m
         2ZrXQLHRmYj4tberGZx47nlOzllmim1C7DcuPcb/zVEY0Dw7ddtO64Yy81PlEcTHbxBl
         Xz/1iz1dBDUt6RfROL5ddr/Z8zfAWok+tE3wOmCEPTBtoos3nDpsre/4l1goAFo9KPlr
         05OImO93dTXkPAaMjzXCUPr284p/Al2PuoVjVaNnm0DMd37wY/Us5kNlmRYXqif4sM/1
         Vuo8qvRmSgZk2x5/4Jpec7wDso4ZjD6Fo11nooTTiCfVQ7tEt8YpP2G/KkH/KGwNtm/7
         zsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743685751; x=1744290551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ7Vrq7J8vgATCF9GSsF7lV1TUk6qnniEF/+hhwVgXs=;
        b=uQZU2G3EL6PWb1K/HxhG+QcX7cKe0dcPqPH352rErkHiFNBry6VEyKGCp2itKz7w0Q
         pUuYjn5F056rtSd+K4BS9KS5srun2HWghCwlZVxbsYD+7x6//D8+4fiulYsJsS5yCt2w
         NQPIJllFe6HZkDNwLjQNJwFYJMvnPvkSNcKkqQoxO7L4RZPDOD4TWldS3ua8El7K5OsJ
         FbRvH+fIYu8PcOnd1s1p7hnYf3pcFbtfo7lP5orHF0mbZgdpGFoS24slrD9rTW5Zqqy9
         Ou8xtt8uLE4bcxB68zj8Zm31mR1636bJ7Cmp8l+CYAi8n/gkcXYExmIKDuT7Rzt/UZYN
         5B1g==
X-Forwarded-Encrypted: i=1; AJvYcCUJnT9tvmC1liq0SvDq5ERISlT2/njkDPcrP2Abd0zxmD6uOs/BAtzeudBPRu5C1giwldntqutEazRNkXuylNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJG2KZhvsJcakOfE+/fk+9frpToc6IpmK9bOpycAWwxp7LPEx
	TylbeDV7vXkZGSC9aNILh/huYq/qUiQPL25i3PUoBr6hcjjev4TQ
X-Gm-Gg: ASbGncsMtVblmmyoaRTB8TQH2+d+8BpQoBuTBmQ+ha1wNGTCQOfhhlYC3wcANUdyvTw
	Gx18v8FO/24zE1W+VFlm9Lx9RUnerJ+EHCx6/D7Z9lQ0vtAaSlYLhyyLvbm5brm86SWrlJxb7hI
	4OVGxRjHn9ggg81hPsX7m9vdXJIF8e0TJZUDZfbPft2tINdmB4NrJmbDTk4NPxYHVfVbV1QowkZ
	bhrmlC64u9tNEMwnpVsjXh9J8VA92F4ShcQ/6T90AlDn/E3JY9VuqYLk9jpI5bJlVaptSuBT25E
	GMVsLTXCnloPbY/ccRqs9/+K97Wzq8kbkfgknvQfkaRe3wf1iA==
X-Google-Smtp-Source: AGHT+IHJ3LHUOkPXVTe3epEVRszZxtJye1meI0S6Swey8u+aR3nBA6D6/0L/1Lkm+poXC+we+sVhpg==
X-Received: by 2002:a17:903:19e6:b0:224:26f2:97d6 with SMTP id d9443c01a7336-22977da7cf2mr40776075ad.28.1743685751214;
        Thu, 03 Apr 2025 06:09:11 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787764ffsm13551355ad.248.2025.04.03.06.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:09:10 -0700 (PDT)
Date: Thu, 3 Apr 2025 13:09:02 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Message-ID: <Z-6IbvorOVx6hpxM@fedora>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
 <20250403085857.17868-2-liuhangbin@gmail.com>
 <Z-5i5rsrIyE0fM-V@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-5i5rsrIyE0fM-V@krikkit>

Hi Sabrina,
On Thu, Apr 03, 2025 at 12:28:54PM +0200, Sabrina Dubroca wrote:
> Hello Hangbin,
> 
> 2025-04-03, 08:58:55 +0000, Hangbin Liu wrote:
> > When setting the lower-layer link up/down, the ipvlan device synchronizes
> > its state via netif_stacked_transfer_operstate(), which only checks the
> > carrier state. However, setting the link down does not necessarily change
> > the carrier state for virtual interfaces like bonding. This causes the
> > ipvlan state to become out of sync with the lower-layer link state.
> > 
> > If the lower link and ipvlan are in the same namespace, this issue is
> > hidden because ip link show checks the link state in IFLA_LINK and has
> > a m_flag to control the state, displaying M-DOWN in the flags. However,
> > if the ipvlan and the lower link are in different namespaces, this
> > information is not available, and the ipvlan link state remains unchanged.
> 
> Is the issue with the actual behavior (sending/receiving packets,
> etc), or just in how it's displayed by iproute?

The upper link in netns up while lower link down will cause the traffic break
in the pod.

> 
> > For example:
> > 
> >   1. Add an ipvlan over bond0.
> >   2. Move the ipvlan to a separate namespace and bring it up.
> >   3. Set bond0 link down.
> >   4. The ipvlan remains up.
> > 
> > This issue affects containers and pods, causing them to display an
> > incorrect link state for ipvlan. Fix this by explicitly changing the
> > IFF_UP flag, similar to how VLAN handles it.
> 
> I'm not sure this change of behavior can be done anymore. And I'm not
> convinced vlan's behavior is better (commit 5e7565930524 ("vlan:
> support "loose binding" to the underlying network device") describes
> why it's not always wanted). IMO it makes sense to have admin state
> separate from link state.

Thanks for the comments, that's also what I am worried. I have send
a question email[1] 2 months ago but not reply yet. So I post this
patch and welcome any feedback.

[1]https://lore.kernel.org/netdev/Z67lt5v6vrltiRyG@fedora/
> 
> If you want a consistent behavior, the admin should also not be
> allowed to set the link UP again while its lower device is not, like
> VLAN does:
> 
> static int vlan_dev_open(struct net_device *dev)
> {
> 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> 	struct net_device *real_dev = vlan->real_dev;
> 	int err;
> 
> 	if (!(real_dev->flags & IFF_UP) &&
> 	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
> 		return -ENETDOWN;
> 
> 
> (but that would almost certainly break someone's scripts)

Yes, so let's wait for others feedback first.

Thanks
Hangbin

