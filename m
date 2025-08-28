Return-Path: <linux-kselftest+bounces-40140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5BAB3924B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 05:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B794206B59
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 03:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B1257423;
	Thu, 28 Aug 2025 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrTwlv4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B37248896;
	Thu, 28 Aug 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352633; cv=none; b=aKotHN4hWUALWqK9z112G+vklJwHc3Dalx/dsVyELV0548QivDh0kVYSN244c6b7Hv20RHzDvIrrlLHazv/SrSQZYqIzUTWFaFLDe51MibS6M4MtgPRfDzU1sJ17yapLHIWPiiX56oC+eeEx4Q8fKcZ+IwEZsiaF8tZMzfilINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352633; c=relaxed/simple;
	bh=mT7QVFkd1HFJKhkkVtqDzPDsef9uoIZ8HLh801tlqDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbKG0I2YCyw+F9mzSPS1S4VM8+7mMWi0rqdSPfCdDlL3CjxliHQHB/tRz5KpC0AGN8W8TURU9U1FjidAb4li8ZjyIjjfg/reZXrEgE38UpNek8qQg3S7EQXcwq1sXqwW0w26a6K9VtcHtZRLpFf74wOCN/RJWhgHag3wA49ZfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrTwlv4H; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7720c7cbcabso388254b3a.3;
        Wed, 27 Aug 2025 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756352631; x=1756957431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S4WDlGefKt5xy9C/zsJV6CmCe3c7ouyAGnX3rHICtc=;
        b=UrTwlv4HLBwheDdi1R0qdqarD7CIFOzMPXRR4Wd+ux9t1SG2WsjLo3LCH7+7h/E32j
         I1uzvaM5vvCb0frhguVXpBnANCSwVwFklWdEPyBioUA7nYTgoYK9N+Du5EgAjFX7Ya7e
         PydgIZwOxcxat5Cv+yhNpf1fhGfDRC8E+r1QMeEdz8puIfYnxyfOgl0f+hZOLkcePn4L
         WsTrzh+Yx1zS+zG2XGvqDS5QJatFcDTl4MC9z68Yvxv8MK6ytT97FfEzG8yQ2ggaet6l
         nRZfZVedYmi8CUdvTS9zS/cWFzAziHy3j0UG30gQvQaew9E8QxpEny5ecGzsRRjNIe4g
         9EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756352631; x=1756957431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S4WDlGefKt5xy9C/zsJV6CmCe3c7ouyAGnX3rHICtc=;
        b=hItY/yyPr0DXTvKSReOqsVylk9JRb9Cd1OhrTiyOOg/bWKGPsu43iAzQLY3yxQ23q/
         WMhdSO4E7Px9wiiqJgacy/XlqJAddIZxVCftii7eoUN1I/eER2QaTpJRY3HMS1H4DhR9
         zcbnJJjABFL3i1cD2fgL/Ar1S6wrKNftg3iRmgqOWP9S9HJf4/5+LrSvQ7PJOK7CXDsH
         UTLnyoxUPhxnNqnYsieUOmWNJszPQtaSvOysbrBL3hHE0jh9YkF7g3t4lbM1Z5ExRhp/
         yK0tj2jhhATV4JwqZK++cCLs0YdrXw5fbFb0/0lqgtR6ook7Wgx5oi/GCnqMQFV2o+2H
         YzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVSnc7ajqEVMEWxU8VYuXXs/G8SF2mD8CNsOqqGwqbAlGreW/vIm9AGafXCOWUmQ7d2Bo0TMBE52E=@vger.kernel.org, AJvYcCXkkx2pYbo4y5BVAqiPfl0L/HeRTZ5KitF50Yc3spDSsJti5CbRaJVijPMjsBcQhXouutGLfYFQKASB+hMfuM5y@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnhewHAqHsXBdKWMWVVuR3BDLBxBUWNjxmPM9bi0fagv8eS2B
	a0FGdcIl0WHSfzHEcWqTl2EaDiTL8/CmzmRKpIcayKro4kzP56MpD5jQ
X-Gm-Gg: ASbGnctKDU3355MrUa8BeWIOLmVRrtfNrdpr5WBW+DPGfvaeHuwbB96o0yCzoOgTZqH
	vZBfXDUmC+ZjM+SP5OafXs5AiKd0DJAboUhJeDBghChX4JmrMunuchkGHGEwErsRS82sIO6lDUq
	MMd72myjEuWm1gA7NSDDu+unl8dD7lb9QVnDH6ALhWv0R/QkIBfW03p3a1J2sAlYpNM7626VHMY
	ttOtyCe6aw1vZ2vf6mktUR0lKwKjZ/WxeyBY1QcDRLL33WKSKufm9LVyzdpjQvL10VfMiKqQS+j
	Pdv7nJ/57d+5wBc3ws/ShS7Iz42cqeZYmnmSXE5GXFn10oEulbiPV+AcYOSSWDUx3Hq2yRPLkrR
	76RmUldANLoQZ8mdVISTdtUx4T+o=
X-Google-Smtp-Source: AGHT+IHprgs3ybOVkkOnTnqjqDicdUyfcGG/SK6nnJ2ne3AqT3PeUCPY0vINW1Nv9fHOyc6CqQzBWQ==
X-Received: by 2002:a05:6a20:431f:b0:240:f4c:ce10 with SMTP id adf61e73a8af0-24340dafba3mr29795245637.30.1756352630940;
        Wed, 27 Aug 2025 20:43:50 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fa8864fesm5889618b3a.68.2025.08.27.20.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 20:43:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 03:43:41 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 3/3] selftests: bonding: add test for LACP
 actor port priority
Message-ID: <aK_Qbfo_AUHrxSPT@fedora>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
 <20250825064516.421275-4-liuhangbin@gmail.com>
 <20250827064638.6fc32630@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827064638.6fc32630@kernel.org>

On Wed, Aug 27, 2025 at 06:46:38AM -0700, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 06:45:16 +0000 Hangbin Liu wrote:
> > Here is the result output
> >   # ./bond_lacp_prio.sh
> >   TEST: bond 802.3ad (ad_actor_port_prio setting)                  [ OK ]
> >   TEST: bond 802.3ad (ad_actor_port_prio select)                   [ OK ]
> >   TEST: bond 802.3ad (ad_actor_port_prio switch)                   [ OK ]
> 
> The last case failed twice since posted:
> 
> https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh-retry/stdout

Hmm, not sure why it failed. Maybe sleep a few time to make sure the link is
up and reselect finished..

+       # Trigger link state change to reselect the aggregator
+       ip -n "${c_ns}" link set eth1 down
+       sleep 0.5
+       ip -n "${c_ns}" link set eth1 up
+       sleep 0.5


Thanks
Hangbin

