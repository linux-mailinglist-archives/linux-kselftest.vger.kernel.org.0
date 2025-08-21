Return-Path: <linux-kselftest+bounces-39505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DDB2FC2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FAA1757C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA772E2652;
	Thu, 21 Aug 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxT+wf2H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05B2E0B59;
	Thu, 21 Aug 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785580; cv=none; b=tkPtppB9QnFbS8t/MwWbBRMn4oraf74ZeE6lRCdUrDkFSl6UmxyV/tCIoyzR3/cAu2qQYoJ5QbemD+Kw3cUqYwMT+Tm22/cKxu9fkfbVyt8KPhv7/42vqjok9S3rsjgynjxsavKRbWM9h8GbALSqoSHpmWe3yro58lnE2xQ2Vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785580; c=relaxed/simple;
	bh=JzFlbqvJbyfZExRim+IPsyzHAGmOhUuIklEqAtZssyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXgl7TfOu1HtrwgU1W2r6wa99OdOKek6pK0OFyFRHCRondUms0aobhsgOkzJDeZVf0HCNSzlQR1U1T0qsSZF6CDQK+bmwFGuYEKh0B6SHjHkPYhQc63hUrjXzk4aDKBJdxZuLjBvKhsSQjX6mrvfgCe2G6CP43e/hh4IBEqvKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxT+wf2H; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so673434a12.0;
        Thu, 21 Aug 2025 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785578; x=1756390378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxDcxcJjJWIviKxX8rPKeJ39EKkqJnwDi/gabzi8NQ4=;
        b=GxT+wf2HB/bQEhdRbQHEB1JKrwTxZ2C1O8GufPZP8gSZWhEwKFV+pBuJk5NKLcLNgD
         e8VuwMtUqJlTHJBE8fUsTSjoJalPY2jFS/nj+lFIzjBfsDZ3ybTtgvnpzu7MqmTytYjn
         97Z6EEdaRI8+DgdjXto6+dBKHc/6ft4AQ0Kzcr+WT8iDjJ1BEQvOByKHxIOuSosfhrIG
         0fEFgN+GYmLYpS5dI/+m09ICC4b0y5tZ9mswyF3sdP3W23JFk7HgInbpwr1DqfFOK8fv
         uddeBBRVKKCkA+zO351FYoPOTjNfVtg5X9ZYF42g/L7fu15pwFGcbIx2AU6cDLE6XSn9
         3k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785578; x=1756390378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxDcxcJjJWIviKxX8rPKeJ39EKkqJnwDi/gabzi8NQ4=;
        b=W5M8+e0j6SdlJDfXBs6QFd5hSApqx7gRYPZDLb6Kuszz48L7x6zjL+NY2m8Y3ku51o
         Md4cxkCb1LLN0ezVzzcRQ5IooV3wLLPOI2Zr1ldn7s0InPlvbDA6PtslSZzJTsRwaAlJ
         ZYGiOAd6Vf0ksYC9frTmvXUVJMXfsxtbkmMrQV58VksD/zfg0krmgwvrNdUd5BfCxLtv
         4Yc10Kiugqv3Qm9M+FQrpl83DN2FQS6KNWdkNdcNj3qJ0qCh7vTS5cQasiVkjEGoTuza
         OO5/+hbaCYxmqk2PA50JcceNd+KJEq4X0z2bFh2Z5azBKviCgsO1VdCk59nKsPxTbEyt
         lr8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKMopCqT2p2Jw/1STlaXjiOglKA9cW2ra2MzpjqaBjsGhzVowoqoi4bDOy+fTRc3SsTbOhsvT1aMc=@vger.kernel.org, AJvYcCXq/s/eFPC54GCQeBfaAVoj8pC5uRxL8uzrGwHSYZUT2XVWim0KL8RHofpkfzl8/WA3hldFPjFjSjdhCulAS/p0@vger.kernel.org
X-Gm-Message-State: AOJu0YwboXMexktu+FUxQp1edq8zSYQJ34gxc2TrhTn1dIc5RCIkZv7b
	Gh6AhIkfQJKIGV1gabM/CBg0BQclk2rOYH7YdY/dvm5Aq8uxfy3J1OSl
X-Gm-Gg: ASbGncu7sdSVaQMhIbs1AilfNsM6M4VE734AR3reaRyzSWH1VfCG3CJkVLlU0f47JvX
	fWzhm7EPnnIc5Ni+ZY0dcnsjOm0WbBAUq7iQlKxhLaR93s+LQVmT7VpPjENqfJZu1II/4X7Almg
	vFa7NLCmyUCgcYdzBvvJU+Juzb5+xZdY5KQ3nLu52eVO8YOP7mLpk+f2dz5A4IuGS348YUp2PoX
	c0fOCb79hkOjSSDc/0k4B2id+u7+jvbaklcLzULGpji3U3bQV09nEFq/5wMozM+PKD/OdyXpkzn
	BzJec4DdLX3OHRxCrp0og8gne8T5J63HM/rRQ37xGudTG4FCChmLMCcvB9KbEi7NTvPcb9+LpNL
	/YFizKiCnNDPTWHq4HpF5nixc/BE=
X-Google-Smtp-Source: AGHT+IFcxGoKYxR1wVUGnXRkF/cJwJukRGVJaUzuiohB725dFo1nuTk5EqCkivxP0bKRcCOFCd+mQg==
X-Received: by 2002:a17:903:1786:b0:240:127:85f1 with SMTP id d9443c01a7336-245fec05b1dmr32395425ad.18.1755785577577;
        Thu, 21 Aug 2025 07:12:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375db3sm57226395ad.59.2025.08.21.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:12:57 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:12:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/3] selftests: bonding: add test for LACP
 actor port priority
Message-ID: <aKcpXt_OLrvf4XDN@fedora>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
 <20250818092311.383181-4-liuhangbin@gmail.com>
 <ea44c100-34fc-4dec-a749-454d224fa84e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea44c100-34fc-4dec-a749-454d224fa84e@redhat.com>

On Thu, Aug 21, 2025 at 11:14:34AM +0200, Paolo Abeni wrote:
> On 8/18/25 11:23 AM, Hangbin Liu wrote:
> > +# Trigger link state change to reselect the aggregator
> > +ip -n "${c_ns}" link set eth1 down
> > +sleep 1
> > +ip -n "${c_ns}" link set eth1 up
> > +# the active agg should be connect to switch
> > +bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
> > +eth0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_aggregator_id")
> > +[ "${bond_agg_id}" -ne "${eth0_agg_id}" ] && RET=1
> 
> A few lines above exceed 100 chars, it would be better to wrap them
> 
> > +log_test "bond 802.3ad" "actor_port_prio select"
> > +
> > +# Change the actor port prio and re-test
> > +ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
> > +ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
> > +# Trigger link state change to reselect the aggregator
> > +ip -n "${c_ns}" link set eth1 down
> > +sleep 1
> > +ip -n "${c_ns}" link set eth1 up
> > +# now the active agg should be connect to backup switch
> > +bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
> > +eth2_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_aggregator_id")
> > +# shellcheck disable=SC2034
> > +if [ "${bond_agg_id}" -ne "${eth2_agg_id}" ]; then
> > +	RET=1
> > +fi
> > +log_test "bond 802.3ad" "actor_port_prio switch"
> 
> The test above is basically the same of the previous one, with a
> slightly different style, it would be better to factor the whole
> status cycling, data fetching and comparison in an helper to avoid code
> duplication and the mentioned confusing difference.
> 

OK, I will fix it.

Regards
Hangbin

