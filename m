Return-Path: <linux-kselftest+bounces-42755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBDBB8D23
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA13C50CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B522259F;
	Sat,  4 Oct 2025 12:19:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBC1E0DCB;
	Sat,  4 Oct 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759580356; cv=none; b=A/a2pFcX2Fsz+DHR6sU0cMczsMouXdwINFGxHj8aH9MDVVRTl4ZQ5ORS8MAo6fiMjcMDuQo/KpniIobJ11hgv6zEONJa2GtJ9+lhZswsh+px7w90/g1zvHwAhbKUbcu+dpnAjg9euBTny/bdU1O3CjeebBgIKV2adxFLc+EEh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759580356; c=relaxed/simple;
	bh=kOYbZUZU6CdVybM0QIN6kMmBHcqS8AEfDCHW9NbqSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbswKfP8Fgv6v5MNrLqaaIZxaKEOgloiJ2FF6z5ykXLqY/yFk4SXdcK/qefc0LagteKmMffnZwBdVMOTozoo69goiZiBG/gwmDthfpEhMGQACUpNyKtUQQePbqTVxg1PqX4x3w6XIZxxqJ3J5iHh6ULPct2zjmqDFT8aSUG9rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8BD6B6011D; Sat,  4 Oct 2025 14:19:11 +0200 (CEST)
Date: Sat, 4 Oct 2025 14:19:07 +0200
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
Subject: Re: [RFC PATCH v3 nf-next] selftests: netfilter: Add
 bridge_fastpath.sh
Message-ID: <aOEQu2fgvx1GlrAA@strlen.de>
References: <20250925183341.115008-1-ericwouds@gmail.com>
 <aNwtMiC22yOAO4Y6@strlen.de>
 <be179c64-8c14-4f38-bab2-4597afc63341@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be179c64-8c14-4f38-bab2-4597afc63341@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> Changes in the patchset "conntrack: bridge: add double vlan, pppoe and
> pppoe-in-q" has lead to changes in this script. I'm waiting for that
> patch-set is to be accepted. Then I will send this script without the
> rfc tag.

Can you send this script standalone?  You can extend it along with the
feature patches.

> > Its a pre-existing bug, br_vlan_fill_forward_path_pvid uses
> > br_vlan_group() instead of _rcu version.
> > 
> > Will you send a patch for this?
> I had this as part of an upcoming patch-set, but I will remove it from
> there and send it as a separate patch. I assume this can go to nf
> instead of nf-next, as it is a bugfix?

Yes, standalone fix for nf, with "Fies" tag pointing at the patch
that introduced this bug.

