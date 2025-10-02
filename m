Return-Path: <linux-kselftest+bounces-42668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413FBB38DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB745189EBB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C482EB5CD;
	Thu,  2 Oct 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="n8R9O5J2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED22D5939;
	Thu,  2 Oct 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399794; cv=none; b=s1JcnLolloKi27MYjZPgQVzFVnU0BVRL72WwdKgvG5QyHts5dr6JhigE6AmlDYbCxtxDTF22Lex/PnAnuBwLDm0c5DhGFkPLqkdtJuw7fS54t7mjfRHvF/LEQDoRVEYo3QQYO4cBPRPLr20Xb2IVyP8tOUhxTq3J9bSwc1G8clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399794; c=relaxed/simple;
	bh=aWuPMAxochyezlEMrYGn3mLzqwHBPe1+qLQ8BngueOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyP7OubNFsQHGBSLPn57k4eUxC87FfaPlX40jBnsGhzDqOaWIQ0eIfyYXRAsqh4DtQcQJV0hV0KNhwTM7Q79sjGFwCvoiHDFPfXoJIKmK6iZWdHwLasGX4ntHA1mJDJ0O/VJRlUjGnIMK2kAQ2ofX2t7t+0lN+AG9Ucz4oM6DdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=n8R9O5J2; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jAtBxARjbGAiZyrHvaZ2gbnrgfqQIv/7WsirpJP41Us=; b=n8R9O5J2/CITXU7WTgFgfG5cg3
	UZoZfPY2A42m3qn53E1U02M/5bEA72JevtjeS74clRDxgU71ODbTPqwY3MrWu32iqcj+sY49XIJZy
	9l+jQ3z800fPxm2penBSa4Irb/iH0nGOcrjwx3jXfcgqIiEdDjBDtvXGGH/WUlg98OVTufULktEI8
	VayjyLnON2JpSwa0JU69d8EVYejAMnHYdCPM8hUpwCBsuQO6ACoQ1My38uXan/9oU82Lkjkx7psyw
	JURriAxC5RvFX+bKxSRWuIm2jAHxWpYKR093VxmlsVmBft85sKoU9yDstamikeXOtL7sqTvySh/cV
	viNTXcUg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1v4GFm-000000000BL-11iW;
	Thu, 02 Oct 2025 12:09:38 +0200
Date: Thu, 2 Oct 2025 12:09:38 +0200
From: Phil Sutter <phil@nwl.cc>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jv@jvosburgh.net, shuah@kernel.org, kuniyu@google.com,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	antonio@openvpn.net, sd@queasysnail.net, razor@blackwall.org,
	idosch@nvidia.com, yongwang@nvidia.com, jiri@resnulli.us,
	danishanwar@ti.com, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net] selftests: net: sort configs
Message-ID: <aN5PYtHSdp4XIWtO@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
	shuah@kernel.org, kuniyu@google.com, matttbe@kernel.org,
	martineau@kernel.org, geliang@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, antonio@openvpn.net,
	sd@queasysnail.net, razor@blackwall.org, idosch@nvidia.com,
	yongwang@nvidia.com, jiri@resnulli.us, danishanwar@ti.com,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20251002015245.3209033-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002015245.3209033-1-kuba@kernel.org>

Hi,

On Wed, Oct 01, 2025 at 06:52:45PM -0700, Jakub Kicinski wrote:
> Sort config files for networking selftests. This should help us
> avoid merge conflicts between net and net-next. patchwork check
> will be added to prevent new issues.

The patch does not apply to my net/main (at daa26ea63c6) for unclear
reasons, though I verified that it does neither add nor remove lines by:

diff -u \
  <(sed -n 's/^-\(CONFIG_.*\)/\1/p' /tmp/sort.patch | sort) \
  <(sed -n 's/^+\(CONFIG_.*\)/\1/p' /tmp/sort.patch | sort)

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Phil Sutter <phil@nwl.cc>

