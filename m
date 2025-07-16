Return-Path: <linux-kselftest+bounces-37456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8BB0811A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC01E16AF4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC02D46DB;
	Wed, 16 Jul 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUKeH0r/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFC323E;
	Wed, 16 Jul 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709693; cv=none; b=cJZvWlvFCFXId9DkgCApjcFrVBK9Cts9QPzRlsMgF9ljGg+vcjV470EHyU4Qd2kXVBkJtctcZ2+K5U0UUHddqqVpe4/iWrLVSU9xI7Gw3DlvLcALnuawTemC6ymmxKAchd/sdUIS6SRz3SnErgT+l9oBZXVhzI3/MQ+4Uhb1W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709693; c=relaxed/simple;
	bh=NJsXTQai3lK/Hkhq02Y1ejtBeQF7JxaP4uVkY0f0paQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTCFdx00rXEE0y/KFTo1Obc8OATd7WAtdn1D/JSeIMUjdm6tHPwJDQTDTsQy6J5e58fiTaUWQ6B7+l4Ur8F++oCFzNvlBLQiZd04u6UK0HYSCcL0KWTBHN2aakDfpH/oGV6xst1tNQW9jFm2NLPtspdoo4sbiFEKL+eGNhukro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUKeH0r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B18C4CEE7;
	Wed, 16 Jul 2025 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752709692;
	bh=NJsXTQai3lK/Hkhq02Y1ejtBeQF7JxaP4uVkY0f0paQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUKeH0r/JDDrIJ4HPDUFDOMV35cfTM4iGpIu3MvVukqi5909MS86AWjQkj7lVl+pg
	 MkRylvCiGrAc2Ke74EHWk1aJDmDY9Gp9dkBAOgGtqJ+hs2uuPGOOWn+dRWukwDzxjN
	 ya+lR7YBjuibUakQaaMeb0rq5RZz+JHaxIjXalZUTXKKvTvemwt5hdqcr7xdAxj+gb
	 aT6zlWFaOZYimaw7Vc+JxFfRCuy9jhg7+IeGjvOLRoH7tamrYKKJSiEjECY/zN+bVe
	 ySAXGOMPFOp9ZlAhvIZHhQ9S+yEdXdvvi4OxTez4aXJkZGhvS7LGSPrC7J/DcVzsdH
	 LPi2Frw0KWEqw==
Date: Wed, 16 Jul 2025 16:48:10 -0700
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
Message-ID: <20250716164810.60cb683f@kernel.org>
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
> +	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
> +			       extack);
> +	if (err < 0)
> +		return err;

We should probably have:

+	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_US]) {
+		NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attributes");
+		return -EINVAL;
+	}

here?

