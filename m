Return-Path: <linux-kselftest+bounces-2366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60481C99E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BF1C2514D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C91799B;
	Fri, 22 Dec 2023 12:01:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01B1A707;
	Fri, 22 Dec 2023 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.43.141] (port=37472 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rGeDG-005iDe-Rv; Fri, 22 Dec 2023 13:01:12 +0100
Date: Fri, 22 Dec 2023 13:01:10 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Felix Huettner <felix.huettner@mail.schwarz>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, luca.czesla@mail.schwarz,
	max.lamprecht@mail.schwarz
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZYV6hgP35k6Bwk+H@calendula>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
X-Spam-Score: -1.8 (-)

On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> conntrack zones are heavily used by tools like openvswitch to run
> multiple virtual "routers" on a single machine. In this context each
> conntrack zone matches to a single router, thereby preventing
> overlapping IPs from becoming issues.
> In these systems it is common to operate on all conntrack entries of a
> given zone, e.g. to delete them when a router is deleted. Previously this
> required these tools to dump the full conntrack table and filter out the
> relevant entries in userspace potentially causing performance issues.
> 
> To do this we reuse the existing CTA_ZONE attribute. This was previous
> parsed but not used during dump and flush requests. Now if CTA_ZONE is
> set we filter these operations based on the provided zone.
> However this means that users that previously passed CTA_ZONE will
> experience a difference in functionality.
> 
> Alternatively CTA_FILTER could have been used for the same
> functionality. However it is not yet supported during flush requests and
> is only available when using AF_INET or AF_INET6.

For the record, this is applied to nf-next.

