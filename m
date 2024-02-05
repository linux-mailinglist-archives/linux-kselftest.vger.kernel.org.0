Return-Path: <linux-kselftest+bounces-4127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FFF849748
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9013128FFE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD9134BA;
	Mon,  5 Feb 2024 10:04:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127450; cv=none; b=cHMn2GmyP9nBXxks4XWTBErvIwFvcodmOSNiNhjqsO7pB+6j/AvDZyRJmbXlc03GxH8COZ6PZU1NXRqluMof/Az/7TcChtRwmpua9SeWmktDnFodQOwvegdwnEsa6Hm17uH6y5lpKWdPTyOZEKVJZceByTotAPo3uKQcp7bghoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127450; c=relaxed/simple;
	bh=5gL+3MHfdNohSQskxHC9i2nTuWBLsbEx3SuLjHbIVfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFPON7DPbPPyNddwa+CIHrbbpsaZBu90FRE6SLH+GN8jTLZRe8EIaO0Z9NG/2bYoo22Cp8UjYDgrqZaXwTfwlztpKtJlG7aOMW2tYQsUzmP84syuxOtxkfhHABiqgAFpY+W18HbN7AUAiCXpgrEX9dd5ecqj7RjkOvl2SvhH17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACF97;
	Mon,  5 Feb 2024 02:04:05 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 i.maximets@ovn.org, kadlec@netfilter.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:04:04 +0000
Date: Mon, 5 Feb 2024 10:04:03 +0000
From: Felix Huettner <felix.huettner@mail.schwarz>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Ilya Maximets <i.maximets@ovn.org>, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	luca.czesla@mail.schwarz, max.lamprecht@mail.schwarz,
	Simon Horman <horms@ovn.org>
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZcCyk3/evNdYMJK0@felix.runs.onstackit.cloud>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZYV6hgP35k6Bwk+H@calendula>
 <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
 <ZbzOA1D1IGYX2oxS@calendula>
 <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>

> > > 
> > > Hi, Felix and Pablo.
> > > 
> > > I was looking through the code and the following part is bothering me:
> > > 
> > >  diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > >  index fb0ae15e96df..4e9133f61251 100644
> > >  --- a/net/netfilter/nf_conntrack_netlink.c
> > >  +++ b/net/netfilter/nf_conntrack_netlink.c
> > >  @@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
> > >          if (filter->family && nf_ct_l3num(ct) != filter->family)
> > >                  goto ignore_entry;
> > >  
> > >  +       if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
> > >  +           !nf_ct_zone_equal_any(ct, &filter->zone))
> > >  +               goto ignore_entry;
> > >  +
> > >          if (filter->orig_flags) {
> > >                  tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
> > >                  if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
> > > 
> > > If I'm reading that right, the default zone is always flushed, even if the
> > > user requested to flush a different zone.  I.e. the entry is never ignored
> > > for a default zone.  Is that correct or am I reading that wrong?
> > > 
> > > If my observation is correct, then I don't think this functionality can
> > > actually be used by applications as it does something unexpected.
> > 
> > This needs a fix, the NF_CT_DEFAULT_ZONE_ID is used as a marker to
> > indicate if the filtering by zone needs to happen or not.
> > 
> > I'd suggest to add a boolean flag that specifies that zone filtering
> > is set on.

Hi everyone,

i build a patch along with tests for the mentioned issue. However the issue
was rather that the filter would be skipped if we wanted to flush zone 0,
which caused all zones to be flushed.

The fix is available here: https://lore.kernel.org/netdev/ZcCxn9HDsB8DUPrI@felix.runs.onstackit.cloud/T/#u

