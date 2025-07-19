Return-Path: <linux-kselftest+bounces-37611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C9B0AD1E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 02:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC445A4927
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74972627;
	Sat, 19 Jul 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZfdOod1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942917260F;
	Sat, 19 Jul 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886461; cv=none; b=IvdOV5+hOavnNAEa9rdIl6/4Q3C2FOh5OS/6RMJhItGbwrf1OLyf4lH0hR0g3Nh3UlmA74Jp7x6OMNTA3PRvNn2YSp+LlJDcFShvlRET+apWWSZKv1fhCob3O14JzdlrJhghyEmQL/Ak/kK8u1sl3nY4+G8AVfkbkkGoj9u/USg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886461; c=relaxed/simple;
	bh=GhZ8PuUegOKC7EY0RAb1O4C48rrmKLKJ9zn948DsyNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3EOmEbMO6sqVWUEWgHyKCXIx3F6E7LhupbBSmY8sTnABFjAt+uSsKFIWKL0P26YMrxHYYGMfJpR6JU18oDmJ26iGmjvajy1pTUToYJ8fLcyYIF3ZVbl9xReVyM2m6smm+n8ByCyH+4nYzIFJ7/g8fdAUsXh+1izdJvEyCclWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZfdOod1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2102AC4CEEB;
	Sat, 19 Jul 2025 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886460;
	bh=GhZ8PuUegOKC7EY0RAb1O4C48rrmKLKJ9zn948DsyNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dZfdOod1cBxxbyU4SRfz/sPCpM6ejAxYPzeZ7d+vqqu2XjoKFls11Kpl82zh95Lzu
	 jeovaJUZP7RFNspoNDmacsNVbwI2XPeWqzWX7XFdanmM8AcOPzaPJB3+zXcbdUM9Zx
	 qATquOg/78YQB4Gio4UuDrD42TIDVkvHwVc4pWhamQjoqDC6wu1lI2Qp9H/2cd3iQz
	 ZTYvLVebHaoKP5GeTnRaldTTkR8167trvnHrqwAlOqwCRD20Sh5FBmia0EZs6DkO6W
	 cvegqwz3RVXEZXhz5B6ZbgstE6m+XR59vHsib5pLbGeSpZA20jUjxzJxHLrCND5ICz
	 WeZfnJhUqmL8g==
Date: Fri, 18 Jul 2025 17:54:18 -0700
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
Subject: Re: [PATCH v24 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250718175418.0b6a62c5@kernel.org>
In-Reply-To: <20250717232427.69216-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
	<20250717232427.69216-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 01:24:22 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> +	if (!opt || !nla_len(opt)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are required");
> +		return -EINVAL;
> +	}
> +	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
> +			       extack);
> +	if (err < 0)
> +		return err;
> +
> +	q = qdisc_priv(sch);
> +	sch_tree_lock(sch);

[...]

> +	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_US]) {
> +		NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attributes");
> +		return -EINVAL;
> +	} 

You're missing an unlock, please place the validation before
sch_tree_lock().
-- 
pw-bot: cr

