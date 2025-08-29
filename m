Return-Path: <linux-kselftest+bounces-40246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB64B3B034
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 03:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344F0167A98
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC019E992;
	Fri, 29 Aug 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvQ4HjzT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971B3FE7;
	Fri, 29 Aug 2025 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429475; cv=none; b=tA4dD0fIsWdkQI0qLF3K8GGF2BP2Lmat3k372wzz5lUaFE97CKrznRKD3+EA8/VzHoQY/3EWQOt47gPx49YbHZ1PLbIL8xlNDIt+84Ae2YL5uzLKzB1VpQ6CFZUJx8tK563GoJIpzqV7HxDF+ffWcW2K9PajAnXAk5G9Mt2mIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429475; c=relaxed/simple;
	bh=brqDBod1HNkAcOD50GZUMfVIW4UoRq+ogyXQGnH6wwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG3YhgUx0CNDPP5VDcJjfE1YK2suGJGH8jvmCq7os6gh1G4VyhcfYpdkO/2Pm8ttgrdkirwAPgGiYQg3ZReF052kPdAt8/8nDVIXCJguIQqhZxZ/P5PPmnr8MV1+MNk3gZoUz+3cp2aMtm2G6ENnvjnrZunKwGpXMQmRm2dGvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvQ4HjzT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722c8d2846so170748b3a.3;
        Thu, 28 Aug 2025 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756429473; x=1757034273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhINLXc6gRiAceFS/6RLaCvcp0dKelw5yj+a8m5ab20=;
        b=OvQ4HjzTCHfGR9HYh/H6MijHoV+QGjMEHQbWNyIAehQD+wJBo8mxqYOla5N44DxOJp
         B04AmYBk2pRhnhZk10d2i9xUgW2UzRokc0lS3XsKjT3GgbO3EB5w+l/V4QEU7vzlAB1D
         wlAeLp+qcq5ftwZjTc3jLXmIJsU7CXyeIUax1yaWhxuEYm+LNeg+t3XivFL812P1qD+f
         mKiYenv8jVBo/URbxbFH74Skkbp6iiagu+aTZgFfq4tYeqfvHMSDFwjhEzF2HZkoDYkd
         O6/mAbLHJ7Dj5Z5Z1WIwD0K96LRCqrPHTMw5Bk+L2Mdr8peS5dBQGQnr51jQJsS1l2BO
         9syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429473; x=1757034273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhINLXc6gRiAceFS/6RLaCvcp0dKelw5yj+a8m5ab20=;
        b=nFBGRSRA2rkbj3+UGQG81zrdiF0gm1gTNIfrpikQJHudU/AHhPFUoahwEMZsT7IBfb
         qGC7/UbypZXeeNmSd2sRwh+D8f8jkKZFRxZCEQ+jf9ZXLO/vvmh1WDPJC8JThjH0AP1m
         uw6bKK7/VhqOvsd8krCp3njIRJhrJK8D7k9qCcr7b9J7h3Tx2hQZqce8PMwuH8IJRcn7
         QQ8sJUBqBI13WuNlMlOLDUUFij1wG3G13TmHvTPzT8C/3UkVskK3OQsJLc2sPvTDQkO5
         6g3B+Zct2YrObrKbCI4+lmqEnEZ3jhJUUHYObmZh5pFInTN+sBT4oRwEket5nJB1aa+w
         y8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUUnGwK3n7EPu24EEsfwcUHxJ4buxSnO5iu1G0bpWaKASzsN2zZEmFLJ42QJI8hl/wisb7EiHLP4XE=@vger.kernel.org, AJvYcCXs7bpDuv18AJdqyr7PvZolM63wmlFGFVlWsK6DcRk8YYrNmQPYtXBy1pBwkVFGAZpOfHhpgCSKWQ6JpjrCuFeK@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwH/Q5SM1Shkq+dBSzyYI8s8oUn4fpnylF/h1JdwDlm0SGj6M
	vcRbF0yNUlWGVjmJXGv3wOGkZgp145b5nuMQ8JX8zmsnyNkHiAM7Ze7f
X-Gm-Gg: ASbGncsjepNdM5qHMc0SVhaWL6DVrxHlo/S9hlJFV9UtJORQSN0hhxokKovoyEIilef
	XAApXsp93sUfQqsSCuuYjSGa2pURiULFF8H+1vWUH47BXDtDoG+TdNHjmhjYZyg7n6g7e49OYQz
	sYU/FzN80myAoVWSII5rbHXUeg+zTxcbkpP2PTSTit2kjhNjZzBMYQj7VZ220wsT4ZTrpdwcmKR
	R4xt6V+IHm8xHQa/uvQNrR1LRAgE3C/SbQ7Dqx8SDKdgrHzFEV7gcYd4orraIBKqaK92qnVedx3
	RJNkv9boesF0eg2pfpxHqBfbGBdBBzhBn3PCaE/DP2leDAFyQoAWQyIJ+H0iOHzjYqX7Zb1yKjO
	AdNwrqN1DqoQ7W1aO/66OEIjF/UY=
X-Google-Smtp-Source: AGHT+IEz+JdbwRijFiQVG98lgp4hSFpunx8yafn3G62ItpjynIszd6atZWbi2xllhd7h06r7CxcM5w==
X-Received: by 2002:a05:6a20:1596:b0:240:1f14:f6c5 with SMTP id adf61e73a8af0-24340daf373mr36945848637.32.1756429472763;
        Thu, 28 Aug 2025 18:04:32 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2a0485sm676279b3a.25.2025.08.28.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:04:32 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:04:23 +0000
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
Message-ID: <aLD8l9xPd2nnl_gt@fedora>
References: <20250825070528.421434-1-liuhangbin@gmail.com>
 <1859262.1756320199@famine>
 <aK_MB7ikY0hUhGqn@fedora>
 <1918694.1756400360@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1918694.1756400360@famine>

On Thu, Aug 28, 2025 at 09:59:20AM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >On Wed, Aug 27, 2025 at 11:43:19AM -0700, Jay Vosburgh wrote:
> >> Hangbin Liu <liuhangbin@gmail.com> wrote:
> >> 
> >> >Add support for the actor_port_prio option for bond slaves.
> >> >This per-port priority can be used by the bonding driver in ad_select to
> >> >choose the higher-priority aggregator during failover.
> >> >
> >> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >> >---
> >> >v4: no update
> >> >v3: rename ad_actor_port_prio to actor_port_prio
> >> >v2: no update
> >> >---
> >> > ip/iplink_bond.c       |  1 +
> >> > ip/iplink_bond_slave.c | 18 ++++++++++++++++--
> >> > man/man8/ip-link.8.in  |  6 ++++++
> >> > 3 files changed, 23 insertions(+), 2 deletions(-)
> >> >
> >> >diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> >> >index d6960f6d9b03..1a2c1b3042a0 100644
> >> >--- a/ip/iplink_bond.c
> >> >+++ b/ip/iplink_bond.c
> >> >@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
> >> > 	"stable",
> >> > 	"bandwidth",
> >> > 	"count",
> >> >+	"prio",
> >> 
> >> 	Should this be actor_port_prio?
> >
> >hmm, actor_port_prio correspond to the ip link option name, which is also
> >acceptable.
> 
> 	Isn't this the text of the ip link option name right here (in
> the sense of what goes on the "ip link" command line)?

"stable", "bandwidth", "count" are not ip link parameters, and same with
kernel names, so I also used the kernel name "prio" here.
> 
> >While in kernel, we defined the select policy as
> >
> >        { "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
> >        { "bandwidth", BOND_AD_BANDWIDTH, 0},
> >        { "count",     BOND_AD_COUNT,     0},
> >+       { "prio",      BOND_AD_PRIO,      0},
> 
> 	Maybe my memory is starting to go, but I thought in a prior
> discussion we'd agreed to change this as well for consistency.

Maybe I didn't get your comment[1] correctly. I only changed
`ad_actor_port_prio` to `actor_port_prio` last time.

> 
> >So I think the prio here should also be OK.
> >
> >You can decide which one to use.
> 
> 	I would prefer that the two options have discrete names, or,
> really, that we not repeat "prio" as it's already used elsewhere.  Plus,
> who knows, maybe in the future we'll have another priority option.

OK, do not use same name for different usage. I will also change the "prio"
to "actor_port_prio" in next patch.

[1] https://lore.kernel.org/netdev/1109153.1755380673@famine/

Thanks
Hangbin

