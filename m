Return-Path: <linux-kselftest+bounces-39205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD6B29B82
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606DE3AB40A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4329B205;
	Mon, 18 Aug 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ+JGlqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A827146F;
	Mon, 18 Aug 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503944; cv=none; b=XV/t8uZT2Gs+Hc9j5CXeI7IAVHq+1a4/MPsIjOrtL0ODYHSNY8zmGwtS5tjFyk+4Jic5TGUSTE/YPj1GTx26zsIoeew8+ZUGMG7Ujhi9/XUHh/KxfFUczfXrnYtJ6Rq7umuiAM/ha9R6+E30LlWUG4IN8PVWGmwPjxqtjc+/K6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503944; c=relaxed/simple;
	bh=EWJyRicAuWP1Cg/ciYf3MN0Nic24YzVk9b4CA7dDzVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWxfA6XXm5aIC7yvVmd6vLpCdgve3KmfP9sgH/GJ1Ig/c/dsDTYM+oMxCjXJI3vVCyV20ArXm2q272xR6jyCd+WQd6eMPxo0cSvyzszZ/2Jj/BjRmOMtQRUP7s7H04YWGVy121FNM7Ri60sWdyfLGW1LoKc1vE0g48GERl21vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ+JGlqa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e60433eso2811602b3a.0;
        Mon, 18 Aug 2025 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755503943; x=1756108743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDHYS3CJkI8uOuo2f3JfxcvG8D5qpzTnjM5fht13qCU=;
        b=kZ+JGlqaCiQwhLuYthJ7ospTwF9jIuXEoE5yMN0UV61pZUzXHDqwvul8vIZcSISVyM
         QNJO4GCLgisTtnU038rOBjiS4Rh+eo8zCjs4CzjxAVl/gENwIXVL+AqiISYdVbI8zZzJ
         X8Cq5qAX4+hmfoEMR9SpAEC3BA1ubqgDYkABw4aZkIYzCDEU9p8jZAkMltgM2YJIg4h2
         NuANNQjab0Uexq0VlcLW+zx2qiazGX2MKiH1I6nlNZwdvsIvaLh4p6b4lVB+jDdC+0Bw
         R49w4yVpjF6QuPlrisN+f1lIMPMiJLpmfvg88KbcMu/bv22/eMkOXWIKfhb+p0APUBgQ
         jxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503943; x=1756108743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDHYS3CJkI8uOuo2f3JfxcvG8D5qpzTnjM5fht13qCU=;
        b=raZcX+adB63zoJJ+Q3DYHhky8yMtKzJprxzIUgkBS1mRohnP7dxalAGDvpf1SB1IpG
         NX/dV7jXX6TiEX4ee1c9NIFOKG1BA6ehMGeGa5ezGrMoZDmDYQU+vIeNSZ+V05UZgQlE
         /P3obVrlUyH74cDjgP+RilT2MbbGlmtNhdxtdKOaA/u+/O2nUbB3A0QB+BG2Fr5YD14J
         aULB3MtjPtHYtmyk5c9KdnrnE7ZCr3G9Cx5W+RKHsL0QOtwMJ2emQn+vAs9fBeAmA25c
         EDu4++VmwnREXHLx49RJh0LdXE84d3jOQuF0iI+YxrLoM62pq/l/2LtAwgTjqHAL2Q30
         dyeA==
X-Forwarded-Encrypted: i=1; AJvYcCWTnStFd2UJsENoPg+3P3/keU7d0SRI3aT2wGXNFDJpVXJ1IShUm51r2ce+9VEGnncHx6Ja2w0LXFg=@vger.kernel.org, AJvYcCWdaQJ2+qXg0hRb6WuKn/G35v/2nUVH8QIWBBHFyXUKiv/+Y73aqdw6lwuPR5hsQL4rPrBeG7R7e4J+uqV2nqkN@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQWQGHJW+xtr+VsdKT348cxCYWUDu+teo7s02N+TY+rz1j3gP
	QPf+VLWIWAAnPYcSkJgIRzSsKIwkWh4sA+iACx2EQIpfnSXper21EKCU
X-Gm-Gg: ASbGncv4LVeTzMnZm5Tm2NfXr1Ku7uDejoWOXM8DSmiYZVAvcWhlIXyKFr+LcRN7NM8
	eTrnf+8ElpEfLMU3kLLUpwhCGWQZFYZgXoWCjWYYHEpVsYOBnyGJyNaL7eZICWKP3nBvLxgwzx7
	/3SLQYRF9hLn3S23IEtGKDjvo2E1bT27t+P4WPge47tE6HttsAdCgGhEFNsgDOMxydX3dOHpim9
	cHicxMBnnErIAMPt/3cKbdN016ffzdPY5b/P0AAHI+ax1XxnvEV8u6DRikLraiHRi/is136pZyK
	9hcCY96ik7tVCfpHqrV/gYo2Ji+9ze/mSEPzrOi9Vm3VFPpEwg1GsED1bpeqs2aAlow/F+tJU+v
	e/4m1+SoahBRrt3g/WmoQOPh6YLo=
X-Google-Smtp-Source: AGHT+IGmANJdnVmkKUlr6WDwVqAb8dtFwddRjg9HaR2K4S6JlvmzwYGJnMaEm0GVSS5sXXS+/JFTbg==
X-Received: by 2002:a05:6a21:32a3:b0:23d:e568:e5ad with SMTP id adf61e73a8af0-240d2ec5e45mr15707814637.28.1755503942656;
        Mon, 18 Aug 2025 00:59:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4738635006sm5850065a12.52.2025.08.18.00.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:59:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 07:58:52 +0000
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
Message-ID: <aKLdPPL0w3XqiEDZ@fedora>
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
> 
> block above this?

Oh, just notice the change is already in the block. The code looks like

	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) {
		if (agg) {
		}

		if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO, ...)
			goto nla_put_failure;
	}

Thanks
Hangbin

