Return-Path: <linux-kselftest+bounces-4003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D277846EB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6320284EBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131813BEA7;
	Fri,  2 Feb 2024 11:12:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2377995B;
	Fri,  2 Feb 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872334; cv=none; b=g4jebpIDiTesX5rWO1Ceusr05bHP79DyYkzEt0O2SLsnfE4/4ue2oA3G4TRquBjLum/vgyGUm9I5eYgiJU5/US6T207qau/vmL2o4QnsuHlfV3uae8rKqj9Fw9y3dYAqYkh9POVECJQiuA0DsmkaI6Rp4gPw4EsKAMx0hYFoMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872334; c=relaxed/simple;
	bh=DHXhgGTeA1+lWgExd1fQrxzIbyU8ibghu/opgphfpvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McXv43nvkVBBWLqjQ5K5q/VBUuVOCIeMVmCrqMlQGLsHNWbzHRgV6tQV+lBbKkfSkvgw+6aWBl4ORJCUqYgus9gQkOMNDpJALKkVvYs6zMNiIzUnjjjs0Y6DqhuGjT0wXBP0CiYIMmgcRypunOlp8dVbzza/BclpFEUk3SnBDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=57718 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rVrSm-001lhN-5h; Fri, 02 Feb 2024 12:12:06 +0100
Date: Fri, 2 Feb 2024 12:12:03 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Felix Huettner <felix.huettner@mail.schwarz>,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, luca.czesla@mail.schwarz,
	max.lamprecht@mail.schwarz, Simon Horman <horms@ovn.org>
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZbzOA1D1IGYX2oxS@calendula>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZYV6hgP35k6Bwk+H@calendula>
 <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
X-Spam-Score: -1.8 (-)

On Fri, Feb 02, 2024 at 12:04:35PM +0100, Ilya Maximets wrote:
> On 12/22/23 13:01, Pablo Neira Ayuso wrote:
> > On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> >> conntrack zones are heavily used by tools like openvswitch to run
> >> multiple virtual "routers" on a single machine. In this context each
> >> conntrack zone matches to a single router, thereby preventing
> >> overlapping IPs from becoming issues.
> >> In these systems it is common to operate on all conntrack entries of a
> >> given zone, e.g. to delete them when a router is deleted. Previously this
> >> required these tools to dump the full conntrack table and filter out the
> >> relevant entries in userspace potentially causing performance issues.
> >>
> >> To do this we reuse the existing CTA_ZONE attribute. This was previous
> >> parsed but not used during dump and flush requests. Now if CTA_ZONE is
> >> set we filter these operations based on the provided zone.
> >> However this means that users that previously passed CTA_ZONE will
> >> experience a difference in functionality.
> >>
> >> Alternatively CTA_FILTER could have been used for the same
> >> functionality. However it is not yet supported during flush requests and
> >> is only available when using AF_INET or AF_INET6.
> > 
> > For the record, this is applied to nf-next.
> 
> Hi, Felix and Pablo.
> 
> I was looking through the code and the following part is bothering me:
> 
>  diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
>  index fb0ae15e96df..4e9133f61251 100644
>  --- a/net/netfilter/nf_conntrack_netlink.c
>  +++ b/net/netfilter/nf_conntrack_netlink.c
>  @@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
>          if (filter->family && nf_ct_l3num(ct) != filter->family)
>                  goto ignore_entry;
>  
>  +       if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
>  +           !nf_ct_zone_equal_any(ct, &filter->zone))
>  +               goto ignore_entry;
>  +
>          if (filter->orig_flags) {
>                  tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
>                  if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
> 
> If I'm reading that right, the default zone is always flushed, even if the
> user requested to flush a different zone.  I.e. the entry is never ignored
> for a default zone.  Is that correct or am I reading that wrong?
> 
> If my observation is correct, then I don't think this functionality can
> actually be used by applications as it does something unexpected.

This needs a fix, the NF_CT_DEFAULT_ZONE_ID is used as a marker to
indicate if the filtering by zone needs to happen or not.

I'd suggest to add a boolean flag that specifies that zone filtering
is set on.

