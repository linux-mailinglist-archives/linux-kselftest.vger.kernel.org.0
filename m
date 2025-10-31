Return-Path: <linux-kselftest+bounces-44470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30706C22D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4933518912A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDD21019C;
	Fri, 31 Oct 2025 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGz25MqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBF1B78F3;
	Fri, 31 Oct 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872213; cv=none; b=hab3DvW0rTu5vtQ1nUdQ7hu4WCBzkzRit8ZWo9DOH+2iC6s/XGc43PkY+V2B+L5qaY+WIj9BMRFZ/3uaYJ0eMLuBLdeBVaQvGddMguLfYYsopVXpyNWzG38ujpx6brzfUkoCq2uSQUfj/BzaEsNQ4wwrFRaqjHNAxEXrjKNUKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872213; c=relaxed/simple;
	bh=8N1NTpvovWIrm8r+PlFn96LbfAjQIzqsi3XHz4vVQgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDrupC0EY6At7z+W+aCSwgrG3jgEidknWO3fDD0J2vX4+hElOSag9SKCkDebTnKs0X3ulSnJ6Mt0MGd28g7q46xxsc5g6OItIYZsdOaLMZWnPzarkdMV40LeTcVdGw+IlwrZntVX/1h/rM5VOBOVa60j0YQnEtchyv2Sul7hyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGz25MqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC4C4CEF1;
	Fri, 31 Oct 2025 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761872212;
	bh=8N1NTpvovWIrm8r+PlFn96LbfAjQIzqsi3XHz4vVQgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oGz25MqTJssiFwYrHUfgncZWMNpxzghDZfJyuMUwDEDjM6qUQxWCu3U5xlkqdl8ka
	 h/xWLfwwC90RQkdU5VmTQBqgCpCsUS0vBLTIJlBeuCASC3SoMxB98auuxVasAQ+dMu
	 Wf03mRBwXXOYMBoxQ2iKCXzfbGAuEUTZBukooSBDFHt92YPafsN1W3khL/Fk+7L7gx
	 eEK+TdndR7ldVFChqqM+I6zpfVbo0bbOgtntBI296yGvSoX+dWG6soB0aGZ2IiRLmT
	 YYahT3MW98qw4mNVTMklISSldGSAe79kElBRlzSyOucAgTTxEIX1M8dx4oquMjA9p+
	 pOTyz+Rl1rgxQ==
Date: Thu, 30 Oct 2025 17:56:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v5 net-next 00/14] AccECN protocol case handling series
Message-ID: <20251030175650.69d77ddd@kernel.org>
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 15:34:21 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Plesae find the v5 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.

Is this a pure repost or you changed something?

