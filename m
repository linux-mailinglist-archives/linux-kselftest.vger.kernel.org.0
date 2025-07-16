Return-Path: <linux-kselftest+bounces-37455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA367B08117
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F641C251CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819426FA6C;
	Wed, 16 Jul 2025 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGWitIsG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC5323E;
	Wed, 16 Jul 2025 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709550; cv=none; b=kCqioQYQQFdt98H4DKSadjtzUeuh0j9lyL/cR9nhZljiRJ5EDZpmDQHpWJevl0lWYVnBcaXwxvhJWX1JT6z5izhz9wwoIeIy//MhtzpzXnrW8YLe+AYn1qp0To595f6pQg/H0OLfY3CM9peqix+FApkyMbRzYIir+eropRpCz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709550; c=relaxed/simple;
	bh=vBM9czmrXToUKG1lyvvneANcAdWqFDty725FbaM7osg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db5bzAv1byEohjwlClhA1dAXX6UZaU7Lmho1ClTAAxepngJqRYOFTJ48BJaDolCjXlcQST077N5Zv8jAlYUZg19iWeNpg/Djy9FPqn4ERYGHMPd5tQy1kxQtWZFA9kHZffIZCrhQskGEJxmUPN2ce2NUj4Ess67HIQ8o/KKaL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGWitIsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBF9C4CEE7;
	Wed, 16 Jul 2025 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752709549;
	bh=vBM9czmrXToUKG1lyvvneANcAdWqFDty725FbaM7osg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mGWitIsGmNFgpAZyAY3FIxV/vbbCDXh6QGoYq1Q9Hf3wS6Rz6vRPaDAidoL59XQYK
	 0hZuYxN8BcKeNrEeFd564AXbsjqUHdoZas+7LY2dMavdJr0fwJO7g+eZUVLjcKbyot
	 OxqkewMKmow2aRfBq51j7vHBhcnmMZrU3b2Q/yfkXHK7qw0vXL9ySINc4BJ7mpFQn6
	 4UMNlja/QZZ9yig1e+wOLqOQMAz5e5UIvgn+OvbzmxxQiBVMVBxGttuE5G/jlBzC4+
	 0LFp69uYqpN9Qpp9bJcDCKnHZjO8d60LxiypBJo8LWay+X9frJHzL5VdjkfO/Sb7su
	 ++cg7VXHtm9Xw==
Date: Wed, 16 Jul 2025 16:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: alok.a.tiwari@oracle.com, pctammela@mojatatu.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v23 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250716164547.6d415024@kernel.org>
In-Reply-To: <20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
	<20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 12:52:29 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> +/* DUALPI2 */
> +enum tc_dualpi2_drop_overload {
> +	TCA_DUALPI2_DROP_OVERLOAD_OVERFLOW = 0,
> +	TCA_DUALPI2_DROP_OVERLOAD_DROP = 1,
> +	__TCA_DUALPI2_DROP_OVERLOAD_MAX,
> +};
> +#define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)
> +
> +enum tc_dualpi2_drop_early {
> +	TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE = 0,
> +	TCA_DUALPI2_DROP_EARLY_DROP_ENQUEUE = 1,
> +	__TCA_DUALPI2_DROP_EARLY_MAX,
> +};
> +#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
> +
> +enum tc_dualpi2_ecn_mask {
> +	TCA_DUALPI2_ECN_MASK_L4S_ECT = 1,
> +	TCA_DUALPI2_ECN_MASK_CLA_ECT = 2,
> +	TCA_DUALPI2_ECN_MASK_ANY_ECT = 3,
> +	__TCA_DUALPI2_ECN_MASK_MAX,
> +};
> +#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
> +
> +enum tc_dualpi2_split_gso {
> +	TCA_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO = 0,
> +	TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO = 1,
> +	__TCA_DUALPI2_SPLIT_GSO_MAX,
> +};
> +#define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)

Looks like you fixed the type name but not the entry names :(
Once again, TCA_ stands for TC Attribute. These are not attribute IDs
but values. YNL will expect them to be prefixed with TC_DUALPI2,
for example:

static const char * const tc_dualpi2_ecn_mask_strmap[] = {
	[TC_DUALPI2_ECN_MASK_L4S_ECT] = "l4s-ect",
	[TC_DUALPI2_ECN_MASK_CLA_ECT] = "cla-ect",
	[TC_DUALPI2_ECN_MASK_ANY_ECT] = "any-ect",
};

Only the last enum you're adding in this file, which defines the
attributes IDs should use the TCA_ prefix.
-- 
pw-bot: cr

