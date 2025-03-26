Return-Path: <linux-kselftest+bounces-29806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E970DA71081
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 07:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E3E3AEA46
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0E18B47C;
	Wed, 26 Mar 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN/PfR54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78917578;
	Wed, 26 Mar 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970325; cv=none; b=Z6UPNVlCcclEmo07NTEwZUh54XoXLgligHaI9/wyfcZe8v8XIn93mXhE35K8AG78t2tD7v5aaOTuUas9iZnbYdXp8mcuADC6eXb6jElGGdfv4ktpy921Gd2kAnaX1fpr5guqAwsIXdxzGIHMuzzgZ5PjEt29lL+BGDo/ZVnWcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970325; c=relaxed/simple;
	bh=VeS52Ya4cFStBppr0P0ppjIK+rOi6u5HKxczZOTGv/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT+CjZ4BTbCdE8x48nqm0XZxQGKO9zpo3gqmq0Nk7skgxOECA5qC3twF4428oe+eRiRhrtTZy81a5zBnlPxKJ+Fv72VbnK7N5VZ9q9aS9PUW6zoJdiUBAeN4VwP0YFWP2U4CotGtylLNXh2l1f/bRkibU6swJxqTjiGGXAIAPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN/PfR54; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22580c9ee0aso132313035ad.2;
        Tue, 25 Mar 2025 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742970323; x=1743575123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6XnYyjWBkgMuV0QYpprdE1lSJS48p3YW3OVQycrQ3A=;
        b=bN/PfR54DzzXsWB0XT9P5JjuodqZBi7sq4yLYm8sYEf+A8/5FsTN5PjOKwPjPb2q1U
         Zg710SQXddhyYB0XS4sRXRNY2Xo0AIaamfR9cYReeSUOynsp70a7VnkEvXtWYp0uvDbI
         Y+hC2ANGTzzNoih5pyKCSn/qlmRWkWwTLv32N1tfkqBT5M17y79Onv6xkovxdyn87cd2
         0mck1ES5bhgIG15D8QEJyClUeMv+th+cbYTStL15AWl1Q8MBp+Q8ituPSp1WmRtA6UnX
         6a0lyRVijR9735CiispUMA73guJkPu1qT+3vV2s6/mPXcJmSukPIANPadrH1cgQMmL9I
         wU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742970323; x=1743575123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6XnYyjWBkgMuV0QYpprdE1lSJS48p3YW3OVQycrQ3A=;
        b=gWJKkpnKTDe852TyI2GbYzs7SrG4D40QDK3ioFn43kXUNyML9bPuwazplTA2+NbJNw
         ak4tcrQrsNy2m+CmIc+7YGG3zm9Vc3droTRIIPngLKTFCnJTNbXzKbSvqy5ZUYok7U5c
         /XATx6YlvnJROf5GOQjoAIWDiA9LsuKRQz777fAqVSZ3G+5HrDacSfbAErjM3yPYYcaB
         Wgqs3a9tCo2ZVhWxXjkgCYQAa85G90gOn/mpyQqUnr+19O7pat6Kwwmzyz78oGw6kZi1
         +PqEZiNL82HQvzWKJWW0lHR3rW0QFbjehJ/2MfUKCPW6Ml15yucDyqQUSkbBRRGW3XIR
         lDiA==
X-Forwarded-Encrypted: i=1; AJvYcCVOJr2eBjNl1I3akyog3gearpctWZ8qhOrXjNN/vxuPyUmkfJvhLb5s2/WPmk+T4izeSqmP5jSqp09fA6k=@vger.kernel.org, AJvYcCVpn1xd8I4Uv2eWEKauhnbJtf2ZvkjiBH/dyS41RkMc4tmX54H+x/rc/3rEGuwB/9F1tNJO1G3t9ZzU7foVGj2a@vger.kernel.org, AJvYcCWUgBo4yGwABpGPIs9oSXZvZi0/DD/k+qoGoFEkmi4JzXzN9wu5LjJ1kGVNDeSEKyeK2mKUXx/T@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcJEzNzAI4zgbOY+Gi8w7RCCN3xR+b3Op3qrJZSswzALeDO+s
	h6UL0bILyC5Vr37RIhIJIjK47YnVo6FAUnffjfDvhg5vn0RE8io7
X-Gm-Gg: ASbGncv+HSzTpWpEK7zGcpUSVjzaDrooKaRouiLJksHxFZTsgtgsV5esZFeNjlNE2/d
	hntO4N0qiTCW1QGt+FfoGJEEq9rlehSGaBBkX/099Jlg9Ry7p0Z/yLbXl4rdy4tSCg1MsZCoMJX
	Nx02E6Cmlkz1VoLJuyTkveO3HThceTUn5GSKR1SDz0eH/tgSLyb0vdTZenhXAyJ2JHzQZq1Ytsj
	mKyeamgHz38UJcy+gdEMiqenuW3GOSfeUXU7pyYw5QRn1fnxRal8Mumzvc3ufwMqFZ/d+cnC9wW
	PYqbT/Ay9D8qgBSKdWUaYa5CFPd5gpFIMIO1rDOHBorWFLGGAgkP2FgMPZM2
X-Google-Smtp-Source: AGHT+IGbQzaER9p8NCvfFy6KxwukYMbDG7UbjOpY3wRp0sjpX6Rtq+5qFqml7esczeTeUbTF9chCJw==
X-Received: by 2002:a17:902:ef12:b0:224:249f:9734 with SMTP id d9443c01a7336-22780c54cfemr331643715ad.4.1742970322675;
        Tue, 25 Mar 2025 23:25:22 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f44aesm101809365ad.217.2025.03.25.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 23:25:21 -0700 (PDT)
Date: Wed, 26 Mar 2025 06:25:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net-next 1/2] wireguard: selftests: convert iptables to
 nft
Message-ID: <Z-Odyf51XgIuldV7@fedora>
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

Hi Jason, I saw net-next is closed. Should I wait for net-next re-open to post
the new version and fix the typo? I'm not sure about the wg branch policy.

Thanks
Hangbin

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
> 
> Cheers, Phil

