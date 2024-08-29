Return-Path: <linux-kselftest+bounces-16689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB296491C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFEB21AAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD31B0135;
	Thu, 29 Aug 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8G+dVg5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F818C331;
	Thu, 29 Aug 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943185; cv=none; b=BgMli6XcIjJgQ4RTMgcsqdH3BNEWASHCxDTPJlT4zfgPnjOGV0bASCwrSVOb1M1w6urEFNjwalnr7W3+rS9OrPS0uSslKP/+QLr+Uj5+692oHWDZiFHPOIiqqXLQRC4hDsNbEDuHWSv/YOltKjncbkxyxwZcVmEy4QeSf5VEMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943185; c=relaxed/simple;
	bh=y+XTkh4W6BCVe6ik0oYvCZEaUAHuGkmtcSWc6t/13pM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsJDuKqTUNZUJ0DG4tX+EQ0nwNuVIYCgYIscQ5jo8MG/+ljF899zJAzlj0VT1u1C/K8wXBdtN5ufIEOn9zlt4Rqgq2pgDSRpxy+D9XqWkU2M3Jy7AfSGM9PtFq1+gOvBy6/5TC1TriHSU1K81aP+g9nFQoGoP4o0FyVEZ48giQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8G+dVg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E1EC4CEC1;
	Thu, 29 Aug 2024 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943184;
	bh=y+XTkh4W6BCVe6ik0oYvCZEaUAHuGkmtcSWc6t/13pM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8G+dVg5hG0VsWhvjV1Bhu+X4Or6heyfFNsIJ+80TqLiiTTs1OfhsA00FJqOtvaqu
	 J4g3t4P06hzxXdCukDVuKuD30FBBpHB9gQx2OrNzSE+PFSlhVJQ8cDwBN47l0H7owQ
	 OOoAZSC2J9e6gtbpil3KF0QaCN1kask14kqMy+Tb0HZWFzs04rETSeVYw44CCP4cWD
	 pojvEgjcse4JRXUiISGbdPyJNVk8X79Tejr+0M3RmI56Jv314/PxKJpgQcvrOncO/6
	 jQwA5+l6VR63bWbQro2LKETwmRRsLZfI81QTjeX/QHxu3nPiJHrV9Tfdil4afotQwL
	 uVP9GF1lbfGZQ==
Date: Thu, 29 Aug 2024 07:53:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>, Shuah
 Khan <shuah@kernel.org>, rbc@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, "open
 list:NETFILTER" <coreteam@netfilter.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <20240829075303.775fce1d@kernel.org>
In-Reply-To: <ZtBIgekUyptmCqRa@gmail.com>
References: <20240827145242.3094777-1-leitao@debian.org>
	<20240827145242.3094777-2-leitao@debian.org>
	<20240828074240.2abaa74c@kernel.org>
	<Zs88pbEadxLWLLbn@gmail.com>
	<20240828114123.3c85a9a5@kernel.org>
	<ZtBIgekUyptmCqRa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 03:08:01 -0700 Breno Leitao wrote:
> > There are various configs in the tree. Grep for the configs you convert
> > from select to depends on, they will all need updating.  
> 
> I am looking at all files that depend on these Kconfig options, and
> there are a lot of tests.
> 
> Thinking more about the problem, it doesn't seem to be a good idea to
> change dependency from all NF modules to NF_IPTABLES_LEGACY. In other
> words, the `s/selects/depends on/` is the part that is causing all this
> hassle, and it seems unnecessary.
> 
> That said, I would suggest we do not change the dependency, and keep the
> "select NF_IPTABLES_LEGACY", and keep NF_IPTABLES_LEGACY user selectable.

Good idea, sounds much simpler!

