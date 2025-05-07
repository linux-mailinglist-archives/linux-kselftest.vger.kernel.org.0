Return-Path: <linux-kselftest+bounces-32582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE372AAE35C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C03B176904
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CBD289376;
	Wed,  7 May 2025 14:38:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD7289363;
	Wed,  7 May 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628724; cv=none; b=QUeQhkW9DIJVlektU2SVIuZh2nuB0oLj8CAO0cNwJ6JRrEiIUVa396JPIv9pIvCbZ/VfuEM+DOu+9IYOUyWoJIRos3m1s7q8YMD0pIptSUZwhZzoTKBi7XP6bQPGCLJANXKLPICHb/ODYhg0oVdEk1bhUsh9/ZLEC4wiBXkmZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628724; c=relaxed/simple;
	bh=SKMiGV/a5vX4UvXYmAF/sPCupdNjXubsNhKo+TEu59c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgxVemusmDiF5xAkXPuCddYt1ahiq54bTzVrw+gvbbGBgv7aM2yw8o/vgpTHwjjsTGqLWjolIsFkckjTAHGux93jWjM3g610+i8A2Jm9NfgXMWg+lisK5gZMGs5cDJT9U/PAVf+tLs6R3XVun4g8vEX10BH/jynumbVCQwSR3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1uCfui-0004II-GR; Wed, 07 May 2025 16:38:24 +0200
Date: Wed, 7 May 2025 16:38:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 5/6] selftests: netfilter: remove rp_filter
 configuration
Message-ID: <20250507143824.GA16483@breakpoint.cc>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
 <20250507131856.78393-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507131856.78393-6-liuhangbin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hangbin Liu <liuhangbin@gmail.com> wrote:
> Remove the manual rp_filter configuration, as setup_ns already sets it
> appropriately by default

Acked-by: Florian Westphal <fw@strlen.de>

