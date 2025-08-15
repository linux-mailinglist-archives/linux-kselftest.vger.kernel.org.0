Return-Path: <linux-kselftest+bounces-39064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16902B27933
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE087B02F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF71EB5DD;
	Fri, 15 Aug 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcFHxo6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F9319845;
	Fri, 15 Aug 2025 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239697; cv=none; b=UaKjuPw3Jjx80r12jPL9poKqmvA4kzcQ96gt0G+elclFtViA3FAh6R5jQm2Vz3clANvxLDil48/8isBoSl+8lfiTQLkxsAcvqZuXTaGqFIgG8Sz7QNJTgohD/eSNId6bFBbFAJWhfEzPg9n2IT1xk1RR8f/nygkDVPG41oNtMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239697; c=relaxed/simple;
	bh=MacN0KGeA4t3DWMtUj0icSdhxTGZrc4tcuSQ7gZ9mog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDPBpeXCIHavdTDMMudcafQRIzq2jCPLn6W2cADwznlFRQRy1LFYbc6ahmpL4FLiEDH8mv1tlmfIzqH6ToAWmjSvSe6EUVP6AnoOP+LcHr8L8GUE68KM536Bl66Hu5DL3yNMFZ2xavEt3hNKAbfdcjuRvg4mxng0WCp6doyW9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcFHxo6R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso1872587a91.1;
        Thu, 14 Aug 2025 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755239695; x=1755844495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FCSaXvZJLcCbwCHAJdIL4oZiovizLFFotB9EdCoDAXA=;
        b=KcFHxo6R4/Fd7Lg0MamgW9dvRyN7WcoEQfQBvzUpq3pf6WZN6MF4UvBoRqwz3dryPx
         e0awQ1Qoor9e4evCP8rgFXILxFxctZ9j8JogfmwSxnShEOYWEIeD2FKjZgWYoyl12/8A
         EBM2w25sTgAbklmnBv5b6vNRQYRFNC2ef0/QvfPO0hNFENQ/KKF4kicYWX0updF2jRCu
         Y1BKjsXaPEFWpRfhmMwDcNhSZ/PqrwmgVw986BThiP893yeDn0MHTFzUPR2yaKEDVZ2f
         uNsMr3BIaZ1d3fn/YF7roxZZxQVRISpUdoKIIJKBRqLCuTHflRCHhGW8APsSORGtmKvO
         w0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755239695; x=1755844495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCSaXvZJLcCbwCHAJdIL4oZiovizLFFotB9EdCoDAXA=;
        b=D5EM2jWdNIggJvabXG31LZ+XZAyAxfc11llwQuhuKFbP+7lwKJq4fm8f+ZNmPSQy+g
         QtsyadzQBokMQnMmt2czBRZLMULHdowonssKVXr009hTLv/KgH7OGNIgG2mfF8+77AUt
         +wstXC7vIjgcEGAYE5FRvMoKJXCxk2WuAftsryDlMSu4DLewG+uCU3YZrZWPtrVQxtQ9
         1bL3qm6kCi3TVoq1Gir1TWfKhU9S082MKVt4cpNV9J2bOreGwlLAnVlvbRLBPILyXNX9
         VGUtmH0J4qafSYP4sOkLiD8J+JT/yGrBSiKF9oaxtcT6l+gnooYRI4pRDBmpblncjXO2
         4lGA==
X-Forwarded-Encrypted: i=1; AJvYcCXBcQan2PyRzdIbZgylYhAxJ4Ky0Cd5q80sIipmGMkCrlu+Sv6Pq2EnLXqqU5PNClfnFunkqc7SL6BVZoeDIxn+@vger.kernel.org, AJvYcCXdrLoKJU6NC5BatYkUi9r2PXqqBBxjrsbE+xqRIg77yVfVem/NeGYay1RS95nP8WdIWBJn/janWT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnnn+bnGreRTcnspR6eOvI8zEsmYqzS/JyA3LQ/ObvNb65o3DU
	j5aykbdjT2mOVrjx5M6wJKmUFwjQuVYELpPANmQUYQLHLm80KBvmA/6q
X-Gm-Gg: ASbGncvj5eJwp2iksa2l7e8K71A3NY5EAzyzZjiOoHCn9h7BcG9lukkV653H0l47pXP
	B8kv/NvEZLkCX+dGyrrDaE2WTvAmONPamwJYf15K4IfMOBgSN+p2TX+526kAg8bOGYkPXFTawSU
	zPh/U4wFZPZ1Ec/a6rn+htGTd5urC24LmyrsIDOwuefJTAkKquZfQEgVMR2j0LriCJYHYGmyp3S
	Dl+DwordM0A0fNZ6sCfu5o4l0iqGja6JpdVvVwpQrU3hFMoL8hVMJlaVN009PsPkgETa9OGl1Tt
	oW86gTFeNw46H6ye3biR+Gl+8OtojaRBZJhal9iMCX5e1p0LBM6PvhqIy+RsvVGsq29Q3Jm8Ij1
	XqpxlVt9RPuWcNppz8srOzn4lXyc=
X-Google-Smtp-Source: AGHT+IGpF4Bs+C0MhYo0QvtYl1ugIYzHxhrC28IgIWmDuo5WGOrr/faewVuiCRqddXWIU2ZSBKVyxg==
X-Received: by 2002:a17:90b:2ec7:b0:31e:3848:7ca with SMTP id 98e67ed59e1d1-32341e25d1bmr1772221a91.10.1755239695226;
        Thu, 14 Aug 2025 23:34:55 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566701sm435170b3a.58.2025.08.14.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:34:54 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:34:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 1/3] bonding: add support for per-port LACP
 actor priority
Message-ID: <aJ7VBQaaajNeXhsP@fedora>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
 <20250814104256.18372-2-liuhangbin@gmail.com>
 <66bea2a5-b873-4e08-9500-a0093648bc39@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bea2a5-b873-4e08-9500-a0093648bc39@gmail.com>

On Thu, Aug 14, 2025 at 01:46:10PM +0200, Jonas Gorski wrote:
> > @@ -2211,6 +2212,7 @@ void bond_3ad_bind_slave(struct slave *slave)
> >  		port->actor_admin_port_key = bond->params.ad_user_port_key << 6;
> >  		ad_update_actor_keys(port, false);
> >  		/* actor system is the bond's system */
> > +		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
> 
> I don't know the code flow well, but the assignment direction here is the
> opposite of other values, e.g.
> 
>                 port->actor_port_number = SLAVE_AD_INFO(slave)->id;
> 
> so I would have expected this to be
> 
> 		port->actor_port_priority = SLAVE_AD_INFO(slave)->port_priority;
> 
> Is this intentional?

The port priority is initialized in ad_initialize_port() a few lines before.
Here is intend to update the port_priority in slave info, so user could get
correct port priority via ip link, other wise the user will got 0 priority.

I can add a comment for this line.

> > @@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
> >  					ad_port->partner_oper.port_state))
> >  				goto nla_put_failure;
> >  		}
> > +
> > +		if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
> > +				SLAVE_AD_INFO(slave)->port_priority))
> > +			goto nla_put_failure;
> 
> 
> This is an 802.3ad (exclusive) setting, shouldn't this be in the
> 
>   if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) { }

Hmm, the data in this blocks are read only values. I thought the actor priority
is changeable, so I put it outside the block.

But on the other hand, it makes sense to only show the value with 802.3ad
mode. I will update the code.

Thanks
Hangbin

