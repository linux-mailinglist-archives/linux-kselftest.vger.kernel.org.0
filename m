Return-Path: <linux-kselftest+bounces-4017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1384702F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 13:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB121C26FDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E114077D;
	Fri,  2 Feb 2024 12:24:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876651; cv=none; b=Y17LKBAM0Feokj9RhxoPkpKPlJH7om2hy16pBHjq8u/RDM4hr6Zn81qXbmgTNt8XSkaMtjK/h0XNlMi72fkJz7bq308/W6GN05OhkROpFTuoyndMU/DvZdnY0mFGLKJ6TYsRyvhns9ZessLLs4hz0nQfwVVhQgD2fTv08IXoNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876651; c=relaxed/simple;
	bh=m8mtqnWI7hjKWBDfyKsbopyfLerJiS3T9hkaNbjWoX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coYabtE/ct7GKowzm5coJ1YpnzTBbffXLX9+KJvFpV67MH+1uQvKaujwjUJRz/hQZnoZcZbzbPqwLWrEBGg1MyCs3uW77tWVLRBTVwjujyIEO9l8mxIpoNA3qFHT0PPvrRhDcaVzHAHYoouT6SFZAySe1+/DslsadYNpg+/w3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Feb 2024 04:24:03 PST
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5E97;
	Fri,  2 Feb 2024 04:24:03 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 i.maximets@ovn.org, kadlec@netfilter.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:22:56 +0000
Date: Fri, 2 Feb 2024 12:22:55 +0000
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
Message-ID: <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZYV6hgP35k6Bwk+H@calendula>
 <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
 <ZbzOA1D1IGYX2oxS@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbzOA1D1IGYX2oxS@calendula>

On Fri, Feb 02, 2024 at 12:12:03PM +0100, Pablo Neira Ayuso wrote:
> On Fri, Feb 02, 2024 at 12:04:35PM +0100, Ilya Maximets wrote:
> > On 12/22/23 13:01, Pablo Neira Ayuso wrote:
> > > On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> > >> conntrack zones are heavily used by tools like openvswitch to run
> > >> multiple virtual "routers" on a single machine. In this context each
> > >> conntrack zone matches to a single router, thereby preventing
> > >> overlapping IPs from becoming issues.
> > >> In these systems it is common to operate on all conntrack entries of a
> > >> given zone, e.g. to delete them when a router is deleted. Previously this
> > >> required these tools to dump the full conntrack table and filter out the
> > >> relevant entries in userspace potentially causing performance issues.
> > >>
> > >> To do this we reuse the existing CTA_ZONE attribute. This was previous
> > >> parsed but not used during dump and flush requests. Now if CTA_ZONE is
> > >> set we filter these operations based on the provided zone.
> > >> However this means that users that previously passed CTA_ZONE will
> > >> experience a difference in functionality.
> > >>
> > >> Alternatively CTA_FILTER could have been used for the same
> > >> functionality. However it is not yet supported during flush requests and
> > >> is only available when using AF_INET or AF_INET6.
> > > 
> > > For the record, this is applied to nf-next.
> > 
> > Hi, Felix and Pablo.
> > 
> > I was looking through the code and the following part is bothering me:
> > 
> >  diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> >  index fb0ae15e96df..4e9133f61251 100644
> >  --- a/net/netfilter/nf_conntrack_netlink.c
> >  +++ b/net/netfilter/nf_conntrack_netlink.c
> >  @@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
> >          if (filter->family && nf_ct_l3num(ct) != filter->family)
> >                  goto ignore_entry;
> >  
> >  +       if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
> >  +           !nf_ct_zone_equal_any(ct, &filter->zone))
> >  +               goto ignore_entry;
> >  +
> >          if (filter->orig_flags) {
> >                  tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
> >                  if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
> > 
> > If I'm reading that right, the default zone is always flushed, even if the
> > user requested to flush a different zone.  I.e. the entry is never ignored
> > for a default zone.  Is that correct or am I reading that wrong?
> > 
> > If my observation is correct, then I don't think this functionality can
> > actually be used by applications as it does something unexpected.
> 
> This needs a fix, the NF_CT_DEFAULT_ZONE_ID is used as a marker to
> indicate if the filtering by zone needs to happen or not.
> 
> I'd suggest to add a boolean flag that specifies that zone filtering
> is set on.

Hi Pablo and Ilya,

thanks for finding that.
i will build a fix for that.


