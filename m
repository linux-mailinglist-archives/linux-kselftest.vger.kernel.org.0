Return-Path: <linux-kselftest+bounces-29623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F989A6D346
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 04:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28440188D1CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB572EB1D;
	Mon, 24 Mar 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAlnpQjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B812E3393;
	Mon, 24 Mar 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786153; cv=none; b=CzLlYOlnwFJnZA5Klyrfh+b1z93SFLA1u+T9Zev2Hjiq8tpB4AeQ25WfMUE2efxaCoIExeAxa/ZGFnrR0I11KVsDovhciX4t7e3W/zEwRNjPr9UYEjVk2j8DaFftueitvgkQtkq5Ye7g7eY0AKPZ3Pzx7S2DLHSLc8aWjanPNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786153; c=relaxed/simple;
	bh=vJXjiPQclcKJr94KhBV2/PvWFdooNrk6foq0Ulyl4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo/omXiEa9a4UfohqCskvopWMvWxAoRKOoHWicLWV6D4Q5z5RoXZpllblOzjyke87+GC8IATQJlyc1OsDL5VRi8noHYeCEg1ynXOze2Ru5MlDbjAxvEnkb0D5AE/2tjPh3rpb7umJCNTu7c2JtqlGNyKhwOd9oxUo4isTpozTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAlnpQjo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2254e0b4b79so56982055ad.2;
        Sun, 23 Mar 2025 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742786151; x=1743390951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbPO7g2pp562SD8YE2yC6B6rGfgGkiRuF9xabS6hR30=;
        b=FAlnpQjouTqnKiOCTOK/pdQQCXO1v+yomLdtReHHWDMzLLCwGOiSpl8zskmiPvC9gj
         WlcqnDQWQvqmWAeMvhbPKRLnxZryDOszwx/canwDFv5tJtGWqIbvXM5k87oQM9DxKaJp
         ZaztpAivrgk9+fAH9ggnIUh2rIatwKFbCiem/VVbO+2fd5byYvwlyHgcog001mHo+BgX
         7EwRLS9Lu5s57QqZYC79+6xpdKMM+UQb1NuhblqYif4CPEQDjgZR9CgmeNviCxvUK06e
         u/0htlJ60a7KOCuFysy0MmAUw+Ok/rF2PUt5/7ssNjHgojtsj+vVdzB3yAajq0fbURN+
         vOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742786151; x=1743390951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbPO7g2pp562SD8YE2yC6B6rGfgGkiRuF9xabS6hR30=;
        b=llUPbuAkk6VUTUt3VSSfi8JfuEB+O/bAA8tZmQarkQ4Nk1l8wsSMCxVc0pejuxJ0At
         13Y2PBU42arJtGNuIoOzWy2l8zaOVGpeivp+EEbt2os+f2ih6LbC14UMN42d9Pz9TAEp
         VTdLA9qWWXFWDexIj/sllP/Tf5Hzsqvo9+uIZOk7PQyPxUiwilxqcy3AavEqLCl0w4iQ
         91aVWg5zzfgvbHrAFW/JduCXtoAbzbcQheJNSafQVi3HmwyrcyMwU8aFnVFWlO86vJ7P
         CWsnT7+NzbzrVH6NvJ+fJxvXydTkAQwyrV4rZFiIddkhYr7wyacLjsx61q9Sc55WV078
         zIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKy+2rru8rxSxp5BDVV7ZbNRvXMjeEp3bxMzG+PmHnAQmxN9+D89BxfOSGlHOufJiaSD4fBPvyXdTEQ10hpccS@vger.kernel.org, AJvYcCXGdQdr7hLXnGkPxSdlr0pezQouBye8OJ0IqEG0K7pezLnUQ2b7Y6FKa6q3D5CivRZJHmMge5ucP87gtu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUjZdikTaju6ToLgHuS/bhRMXn2ZvUZsUAKmtVDR+V/5QLSSk
	6QNVWF+052w4RQbSOjdI1G+NaNaADw0wMrJjLrbaZcldOhftD+A0GOATgsiBzIM=
X-Gm-Gg: ASbGncs+Gr/Ipv+SZ51wvEJGBfyzKLBwJry3vpHTB/0fuWI3l0t3/0eCJOauaK4+xGZ
	7phNBeieiCBslygEA+ejAPgsWI0Iwe22752MnuOVJ8DTMKQ/PwhmFtYMVlOL8yJwpQ9c5IdVdsD
	9Cti+da1YNYnpMKc6VtEFiYmrOzU1bRn7PvZDdy4bMYjeKB2wha/dYp+pH2D7YgYTUBdzhp0zgk
	9Uzv7hHh9Z4Kp00oMBaBLI3HyxuTfrXckLkvyLSPNpoilfc/u3n9RGuzPrVTFp17vJjh34YAvkI
	I/+MUB7s8A482Wo5KCldaDvwoXptXHcvn1jYtTtCpD7IXnypdg==
X-Google-Smtp-Source: AGHT+IGaaYhWfHcEkvaSBr0W/VndL8LcxHEFgy/XsRLyxKQzY/wjBZcbB9qTsOYo1wE24M5XjEBsWw==
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id d9443c01a7336-22780e0969cmr174217795ad.42.1742786150821;
        Sun, 23 Mar 2025 20:15:50 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f44bbsm59159555ad.232.2025.03.23.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 20:15:50 -0700 (PDT)
Date: Mon, 24 Mar 2025 03:15:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Phil Sutter <phil@nwl.cc>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net-next 1/2] wireguard: selftests: convert iptables to
 nft
Message-ID: <Z-DOXpknpAn-yC_P@fedora>
References: <20250322093016.16631-1-liuhangbin@gmail.com>
 <20250322093016.16631-2-liuhangbin@gmail.com>
 <Z-B4yfBvm2aXW_Ar@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-B4yfBvm2aXW_Ar@orbyte.nwl.cc>

On Sun, Mar 23, 2025 at 10:10:33PM +0100, Phil Sutter wrote:
> On Sat, Mar 22, 2025 at 09:30:15AM +0000, Hangbin Liu wrote:
> > Convert iptabels to nft as it is the replacement for iptables, which is used
>           ~~~~~~~~
> 
> Typo, but I would write "Convert the selftest to nft ..." instead since
> that is what you're converting, iptables is just replaced. :)
> 
> > by default in most releases.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  tools/testing/selftests/wireguard/netns.sh | 29 ++++++++++++++--------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
> > index 55500f901fbc..8b840fef90af 100755
> > --- a/tools/testing/selftests/wireguard/netns.sh
> > +++ b/tools/testing/selftests/wireguard/netns.sh
> > @@ -75,6 +75,11 @@ pp ip netns add $netns1
> >  pp ip netns add $netns2
> >  ip0 link set up dev lo
> >  
> > +# init nft tables
> > +n0 nft add table ip wgtest
> > +n1 nft add table ip wgtest
> > +n2 nft add table ip wgtest
> > +
> >  ip0 link add dev wg0 type wireguard
> >  ip0 link set wg0 netns $netns1
> >  ip0 link add dev wg0 type wireguard
> > @@ -196,13 +201,14 @@ ip1 link set wg0 mtu 1300
> >  ip2 link set wg0 mtu 1300
> >  n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
> >  n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
> > -n0 iptables -A INPUT -m length --length 1360 -j DROP
> > +n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
> 
> You may skip the 'policy accept \;' part in all 'add chain' commands as
> this is the default for all chains. Unless you prefer to explicitly
> state the chain policy, of course.

Yes, I would prefer to keep the "policy accept" unless Jason has objects.

Thanks
Hangbin

