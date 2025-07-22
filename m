Return-Path: <linux-kselftest+bounces-37791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA103B0CEE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 02:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21BA7B3994
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18613D8B1;
	Tue, 22 Jul 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3i4iRt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B313AA20;
	Tue, 22 Jul 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145565; cv=none; b=irBxqHJsajViah2L8wO4x5xr6Y+FpzrWy8P6ufD+vbLl8eAwHL/jJq7AZ9lY8gyh3rQVWCrGG+DQUfCKuISO8ZKUUnvjoDCwykYW1dfpdVQxkUm2lMeTbyVM4XD6ar69MiH4MKeYLEgAz6kWbuzLxPzZaGaEsjlqlliQJwE/zGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145565; c=relaxed/simple;
	bh=1oYDVXHkfUMCUI3Hs6/VwGXn5nv999DI1ksZBqpk+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBpAmkwe8HRNXqappWyzKieYML3DHPrWHoq7nQTI6P4VpxeqKly91mD8z0/3ScnRvRH+xITFTq+QyJg1VQiK5gyH033Jujo1K3IOgm3aUHci0eOxFl3p0mn04c99lN4ztAAM4UaP1SZX4Ja8ylxJGg0V7MB0Zez1oyFTbaUQcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3i4iRt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B940C4CEED;
	Tue, 22 Jul 2025 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753145565;
	bh=1oYDVXHkfUMCUI3Hs6/VwGXn5nv999DI1ksZBqpk+eU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3i4iRt1astex1L7wreGCDgQI8iHWjGUredIZq2AHwLFFr4jrklqEaR4I0uqI6yMi
	 PJa56S+cVq8PFrAOB9BOlDZQXM0dDJ9WXe9oGSdkch3AXf7NVD2YjG163mgpXLwjNq
	 CqrOBALd443bBsz55UUQmzer5pgERbHcqQVhYgi+TEzhs9lvajOcvwurbwM9JCEqrg
	 6XrG+K/Q4MFXHcLXJim/DmucjQ9fIpxY6gr9mZ/66SbZTSOs6tFX1BmuSVGiWXIpqn
	 e5/TinR0DhY9whoeFt2WD1sRyJ+vezOSuOH9T4uyVtpVUVl6Yyv9gHRuu22DnXwRpL
	 oyvh7NWWSVLUA==
Date: Mon, 21 Jul 2025 17:52:43 -0700
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
Subject: Re: [PATCH v25 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250721175243.5e620997@kernel.org>
In-Reply-To: <20250719204129.15737-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
	<20250719204129.15737-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 22:41:24 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> +	q = qdisc_priv(sch);
> +	sch_tree_lock(sch);
> +
> +	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_US]) {
> +		NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attributes");
> +		sch_tree_unlock(sch);
> +		return -EINVAL;
> +	}

tb[] is local state on the stack, parsed from the netlink message
(also local). You can move the:

	q = qdisc_priv(sch);
	sch_tree_lock(sch);

lines after the check and then you won't have to unlock on the error 
path.
-- 
pw-bot: cr

