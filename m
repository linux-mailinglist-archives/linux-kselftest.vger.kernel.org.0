Return-Path: <linux-kselftest+bounces-35620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84008AE421C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCBE188C301
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EDC24E019;
	Mon, 23 Jun 2025 13:14:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A581F1522;
	Mon, 23 Jun 2025 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684473; cv=none; b=g+DBXa2xFu73obaKSMfY6BggALqaVAcejUJ+Bb3cwMoNE4FcvN3kqiaZ8IwDUhvPtnmVbMqHXQFzq3/Jr++uiAhekAbxZCyWPczdI1vmMvfKKr7kONRPP4qfSKlY/4NXX7AtzFEu6cEmaZuStz2GvVEaDgfZ0OMdQasH6swh1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684473; c=relaxed/simple;
	bh=8mrBYqfBJExkCbVQi1DioqFkQ2okW6DU1/fDAPdkKcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG6CJyYzIKA6aZ6Q/00JlyqCYjcsXe/Vk4Db+dWC+U2yYMMczDic5oe9nSRH+uslc5tjFlfLEl0it7JiiXjr5eJ8DaxdZ6U2U19QLqE/2X2OvX03I4TU+lbLuCsw9OYjTqlqullZ7YY58SD9saB5VvPZ30tEhMNJbv5vLfFeO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 19BE260388; Mon, 23 Jun 2025 15:14:29 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:14:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 nf-next] selftests: netfilter: Add
 bridge_fastpath.sh
Message-ID: <aFlTNAsZh-g1SvWQ@strlen.de>
References: <20250617065930.23647-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617065930.23647-1-ericwouds@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> Without patches:
> 
> PASS:  unaware bridge, without encaps,            without fastpath
> PASS:  unaware bridge, with single vlan encap,    without fastpath
> ERROR: unaware bridge, with double q vlan encaps, without fastpath: ipv4/6: established bytes 0 < 4194304
> ERROR: unaware bridge, with 802.1ad vlan encaps,  without fastpath: ipv4/6: established bytes 0 < 4194304
> PASS:  aware bridge,   without/without vlan encap, without fastpath
> PASS:  aware bridge,   with/without vlan encap,    without fastpath
> PASS:  aware bridge,   with/with vlan encap,       without fastpath
> PASS:  aware bridge,   without/with vlan encap,    without fastpath
> PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
> PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
> PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
> ERROR: forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4/6: tcp broken
> PASS:  forward,        with vlan-device,    with vlan encap,    client1, without fastpath
> PASS:  forward,        with vlan-device,    with vlan encap,    client1, with fastpath
> PASS:  forward,        with vlan-device,    without vlan encap, client1, without fastpath
> PASS:  forward,        with vlan-device,    without vlan encap, client1, with fastpath
> ERROR: bridge fastpath test has failed

Would you mind sending a version without RFC tag that passes
without any of the patches?

I'll leave it up to you if you prefer to remove the subtests
that don't work without your changes or downgrade them to
a SKIP or similar.

That way, at least this patch could be applied.  And I think we
can all agree that it would be good to have it in-tree.

