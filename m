Return-Path: <linux-kselftest+bounces-49056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E4D281CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8483065146
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61D3101AE;
	Thu, 15 Jan 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyictmxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449C30FC05;
	Thu, 15 Jan 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505501; cv=none; b=jGS7ICC9mZH9CpLNAxkBCOuN/+ljy01RdmC3E34eNxEhWXbQPe3EbdLuSCiMxqKhdM5oAUrQ9T+PdKRlOUlAu1WgiiC7kjmidsymUjv5wTAuY9V1lXW5sXL/7jPKKkVxIgWfMKfTmeAY/Z29Ff5S9RxN55YIUwrYYrja3PzrHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505501; c=relaxed/simple;
	bh=TzEbV7kNArAPqx9BEvc6EsvJhZcc73P2b4+5IZ89gcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWbG7+WwynUAryalBF1QR3BGSTMmbLBN4P4MSNjxAEd88AuoJn3Eow/UxNKmqkOkudU2y+cwztmsc9QvGWnIgnfsy8Dmf39ECoBdh3HsFf+oXcfz0h1LX6NwnSDsefJVNgBiyLxOFplAmLs7zyNfmy80TtX66BKpQ91wSaVt4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyictmxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0735C116D0;
	Thu, 15 Jan 2026 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768505501;
	bh=TzEbV7kNArAPqx9BEvc6EsvJhZcc73P2b4+5IZ89gcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VyictmxAtCwjBueu48+VhEBam9UoV3zHUXyEzYzpv1uvd41iUbBy4BDz7rqC8KZEo
	 x3fLz/d3ze0wyMW//k3LQY7eGEtwTJbwm6UCCYNZogNsrcgnQ8RwilveoL3Y3poEWJ
	 exkYDl5BC4Bi5qFCNEAwHDxXH/5ZjEaJnuiuvvReb0vgiZjFk64tFHAK4F2sa2OPK5
	 US9imMyqM92cShOW+tJEl7wt6CUlr/UgoopyxRljOhtSPId1kQThPXHmh3HAq5dWjI
	 gQgoXIlQ+DvoJ7Zv6v9vxz+e0gdQJdJ9N6a+U7vsBerekFoSMUCsnW+W7AqIuvnx0R
	 g56hUFZLBtRtg==
Date: Thu, 15 Jan 2026 11:31:39 -0800
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
Subject: Re: [PATCH v8 net-next 03/14] selftests/net: gro: add self-test for
 TCP CWR flag
Message-ID: <20260115113139.51d048e9@kernel.org>
In-Reply-To: <20260115122846.114576-4-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
	<20260115122846.114576-4-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 13:28:35 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> -        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
> +        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr"
>          "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",

Missing a , at the end of the line here.

Please hold off v9 until packetdrill side is reviewed.
-- 
pw-bot: cr

