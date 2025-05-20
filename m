Return-Path: <linux-kselftest+bounces-33437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F5ABE7AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 00:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CD8A46AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D3256C79;
	Tue, 20 May 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXcIAs7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DD254AF4;
	Tue, 20 May 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781583; cv=none; b=lFrAczRmG49GzOCR1fp56JbNECRLyiyJ+VnCBOZuofvvRKk7VZb4r3NaQY+wYl6PZ9hfDXE7JeONeT7uaU/DfzzRWt1mmXojfZEXTEW4c4PFknBGPJdHCZ5IIM0qfB3DxzmcqDXxg/RJW3aXwqZq72F4c49avDrkQukkCrvf1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781583; c=relaxed/simple;
	bh=4IJAh+T16/DP3mxpxGcw2sD3tCUE3Vhcn2hYXsvzc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWeYqEuwueThPyjUfmjGpQqIYtz+yDL+5bCSaJEK9Psw+Mwd0t844yyaeq3uQyqnwKRrFxtzaLtilOILVwCKlUx2ZGSWhPgh5jLgNHn58nQA67m9ovPA3lDIUiSj8tSrjeoLaYLAumDAVe6VJMOTDw7O2lBPg6GGKOaXGMhAUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXcIAs7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED37C4CEE9;
	Tue, 20 May 2025 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747781582;
	bh=4IJAh+T16/DP3mxpxGcw2sD3tCUE3Vhcn2hYXsvzc4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXcIAs7tKy0HyaPcxDUF8kEY2saC13DVi1SwHnYZzWBn9dzzUuqSKOcKacT37Pl5h
	 YrkBRU0psLgQ0/TXtQMO76wd+Bxft/icfBFogL366YwaXK+hKmvfAbfgH+bi2Arz7M
	 6JUs04FhEhz6KEAgrFq53FR26QiZjKstrMJsucuxO+LsbYl+E5uqc3dz/d0l2yvI8P
	 e8QSITRa3nu4wZuedBAbPHBWrrsyepoKlINkUhIBLSByFeSw63rfmyW4iio1oprG3f
	 yhIj6n9zLXh/BdNqyKNpWJZh9QST9urLHG9McO+G1bw57Kgr/ZHDg3I5SuTdRi31Cn
	 n9755K6VZC7aA==
Date: Tue, 20 May 2025 15:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, "Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Moshe
 Shemesh" <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Carolina
 Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V10 1/6] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250520155301.5217dd81@kernel.org>
In-Reply-To: <1747766287-950144-2-git-send-email-tariqt@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
	<1747766287-950144-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A few quick comments here as the test is failing

On Tue, 20 May 2025 21:38:02 +0300 Tariq Toukan wrote:
> +      -
> +        name: rate-tc-bws
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: dl-rate-tc-bws
> +      -
> +        name: rate-tc-index
> +        type: u8
> +        checks:
> +          min: 0
> +          max: rate-tc-index-max

no need for min: 0 on an unsigned type ?

> +      -
> +        name: rate-tc-bw
> +        type: u32
> +        doc: |
> +             Specifies the bandwidth allocation for the Traffic Class as a
> +             percentage.
> +        checks:
> +          min: 0
> +          max: 100

Why in percentage? I don't think any existing param in devlink rate 
or net shapers is in percentage right? Not according to what i can 
grok about the uAPI.

> +static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
> +				       unsigned long *bitmap, struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
> +	u8 tc_index;
> +
> +	nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest, devlink_dl_rate_tc_bws_nl_policy,

Let's error check this, I get that we already validated via the policy
but what if we do memory allocations during parsing one day, or some
other failure-prone operation.. better check the return value.

nit: over 80 chars for no good reason, the line overflows anyway.
Please use checkpatch --max-line-width=80 for core code, 
at the very least.

> +			 extack);
> +	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
> +		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_INDEX);
> +		return -EINVAL;
> +	}
> +
> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
> +
> +	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
> +		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_BW);
> +		return -EINVAL;
> +	}
> +
> +	if (test_and_set_bit(tc_index, bitmap)) {
> +		NL_SET_ERR_MSG_FMT(extack, "Duplicate traffic class index specified (%u)",
> +				   tc_index);
> +		return -EINVAL;
> +	}
> +
> +	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
> +
> +	return 0;
> +}
> +
> +static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
> +				     struct genl_info *info)
> +{
> +	DECLARE_BITMAP(bitmap, DEVLINK_RATE_TCS_MAX) = {};
> +	struct devlink *devlink = devlink_rate->devlink;
> +	const struct devlink_ops *ops = devlink->ops;
> +	int rem, err = -EOPNOTSUPP, i, total = 0;
> +	u32 tc_bw[DEVLINK_RATE_TCS_MAX] = {};
> +	struct nlattr *attr;
> +
> +	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
> +			  genlmsg_len(info->genlhdr), rem) {

 nla_for_each_attr_type() ?
 or better still add a _type() version of nlmsg_for_each_attr() ?

> +		if (nla_type(attr) == DEVLINK_ATTR_RATE_TC_BWS) {
> +			err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap, info->extack);
> +			if (err)
> +				return err;
> +		}
> +	}

