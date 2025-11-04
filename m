Return-Path: <linux-kselftest+bounces-44708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05784C30B41
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC873BA902
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D422E426B;
	Tue,  4 Nov 2025 11:19:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A62D5C6C;
	Tue,  4 Nov 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255157; cv=none; b=ZWXB7vdpAgbZfeqoyPx0h+HP+6eF3D1J6keebLv2S36GhGwKqZVEcByAC7OQPVuIzUXLagy9YWm2KaIRq+s6SIXUABnDkdOotx9XsRU0+JhyUQUiMeJz0XuUfm6N1P7B0B3XvHRnxjAgOU3LfxjusUnYbhkrNMWlXpufzlHd8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255157; c=relaxed/simple;
	bh=w0ramgtEA8FtANkRsO8mFVj0MJQjLRWM2jsFdI9BC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaWv1s3c7iAVNxkWHt/N/YEawymONWOc2hjpTHkgcExtdrCjF0ZPxURk6WEXwu1BqCfitStupb3I4yINUynEav13A8VKoHfzDELDLxTNgQ1O/ZYW+n6FSCmbFkhbNqXs8q+9Xjgal1pAcCEgyjl70gL/poDBmo3JVeRU8sTUcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7CAC6603B8; Tue,  4 Nov 2025 12:19:12 +0100 (CET)
Date: Tue, 4 Nov 2025 12:19:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v8 0/3] Add IPIP flowtable SW acceleration
Message-ID: <aQnhMGuUqjut2jG2@strlen.de>
References: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
 <aQnelp8RNlMfw4nr@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnelp8RNlMfw4nr@lore-desk>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > infrastructure. This series introduces basic infrastructure to
> > accelerate other tunnel types (e.g. IP6IP6).
> 
> Hi Pablo and Florian,
> 
> Do you have any updates/comments about this series? Thanks in advance.

I haven't looked at this because it depends on a series that isn't
in nf-next yet.

