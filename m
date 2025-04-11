Return-Path: <linux-kselftest+bounces-30603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091EA85FAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B547BB0F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7F1D7E4C;
	Fri, 11 Apr 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lynEyBVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHXPK9Yc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218C1C3BEB;
	Fri, 11 Apr 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379457; cv=none; b=N0gwma7Skw0kxG5g8wQH+vPwBbZNVJA1mnpQXr5JU7c0QA3/ebI3u6VorFNtNak40s/a4CRqWG5YTwBWUNDQ0EphB4viW2Sm/pe+aD4gJZVOa5LA2CKWzuVTQC8dw/p1FQtI+O4mgoQYzB2WcvTWcHc3oeXWHWoaC0n8MMXaNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379457; c=relaxed/simple;
	bh=qtOV60ECJZu9Fi40Bf5lH+RBr8bVEl7SPzPMLSpbslo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtgGemACEBpDKCsa8KvWOynEi4Z3HFuBLTNxRcFgWSqFCBe9DMJhxZzf0C9a8qJpV9uTesi9YVDWj3W2YYo9Od7+Gzo9gnbWJvbmEZJ6HAzrCYGTtZvdquumMXDYJ7WSeH0lI044U3a4v5g2NcGlX/5sgZZCDNObJUsSP+qV8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lynEyBVh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHXPK9Yc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6439B13802B1;
	Fri, 11 Apr 2025 09:50:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 11 Apr 2025 09:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744379453; x=
	1744465853; bh=Y1OSHZSZRnVHTncatSZJml8c2A69m+s5Vr0UXqqvqfQ=; b=l
	ynEyBVhe4Sz+Xi3AgsWBDOxUNFh1FL2InBt59AGa0xdbXkhQbP3Py3G+rIiJ/muD
	uUAx72fAM68BKOMI8SsflJXBdxdj8iF7hYB2VSn68oEezdOA2JM5hcXzTwxLBw5+
	SUh/HUyGIlm5+gmzhvGNkztrKNXmm5+oQJ++g8Jq2YZak3QJMX9tTyEOtg5Wp51M
	8VaAFzToLV4boXfRtUsOmCkzUKIhUH170zQez89cehVjTQ4SEHlu2TOaG4BA6nae
	khQRT9xB5xdWFvwbWWFtqW3DyxL9UOc3xESSWCzs6iuCEKYtb20kaoKxP2COSmvl
	g0m//ZjNJJt3JEpbQzMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744379453; x=1744465853; bh=Y1OSHZSZRnVHTncatSZJml8c2A69m+s5Vr0
	UXqqvqfQ=; b=XHXPK9Yci0zzoHLVvgAwg6ZA28WsHFw+TPedlNEN/8jdvkxE+ue
	Q2yja/SAS3xV1Ys8uqmqQpFHaPYNWPFDqmVrQpj5eXhg+CY35o6px4EKw+6T14aW
	Rv+H7v7H/jrWjOm6s7zo1mD/SDGftbgh2h87SFkvG8Q3cmfDx1i7LBp7bMv2fEeG
	gkxuiiS4bdRiI+ihbVi+/PhvkYTwktIL/4xlRcXQZjQTzHmwWw+pqjHMTxhFAJrn
	LiyDV8qg+UnkDQZ53OKIOvLJkzCbQ7zHGEC3C7F3uk/GweJYrU2AxfZ+BOpRIFWB
	HPgS65+AuPKK86Drjw8VCedc4H4py3RJ/qA==
X-ME-Sender: <xms:PB75Z3PdTJWbL-EYX19JeLDwA77yl_nbEC3AUrCvQdrLM5Dw8OQyvA>
    <xme:PB75Zx-4qciYr6TILHli5NCvqcg72ZXbvOHQgnYIxKiN_oqR_dB3GX08Xg7Rh3Ixz
    j7PjHDXRniOeGiQtMM>
X-ME-Received: <xmr:PB75Z2SXo4FLPtLgP3cE6RJRZFw92yb4F_2ChNYkc5tPDtP2kv5i8KDHkcxb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:PB75Z7u5vrlCWPEgZTQsqDxNamNyQkNBDuL0n0IXaH8LXqRleJZCiA>
    <xmx:PB75Z_faug92tfCJp0aKdS57AkNXwJ0P11VU0mwuKnqz7FzwrU5GeA>
    <xmx:PB75Z33B4yHa1LlSkzJ-o-9W3PKUeMMklwsDAoqjWDC2chNLdoGcTw>
    <xmx:PB75Z79BqUUcq0xQYbFg3nn2Sj4DmiSy_fOEwUu_oNrBtEMe9KP0Tg>
    <xmx:PR75Z6rliDh_6ma4bSc2SFswX7tQTDhYEiTk5D2w52UXpS81YpxnnaTy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 09:50:51 -0400 (EDT)
Date: Fri, 11 Apr 2025 15:50:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <Z_keORW4OWc8i5Vz@krikkit>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
 <20250410195440.3ba7ba0f@kernel.org>
 <f11e8a14-deb0-456f-bb4a-b5e4e16a79d7@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f11e8a14-deb0-456f-bb4a-b5e4e16a79d7@openvpn.net>

2025-04-11, 10:04:10 +0200, Antonio Quartulli wrote:
> Hi Jakub,
> 
> thanks for taking the time to go through my patchset :)
> 
> On 11/04/2025 04:54, Jakub Kicinski wrote:
> > On Mon, 07 Apr 2025 21:46:09 +0200 Antonio Quartulli wrote:
> > > +static int ovpn_netdev_notifier_call(struct notifier_block *nb,
> > > +				     unsigned long state, void *ptr)
> > > +{
> > > +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> > > +
> > > +	if (!ovpn_dev_is_valid(dev))
> > > +		return NOTIFY_DONE;
> > > +
> > > +	switch (state) {
> > > +	case NETDEV_REGISTER:
> > > +		/* add device to internal list for later destruction upon
> > > +		 * unregistration
> > > +		 */
> > > +		break;
> > > +	case NETDEV_UNREGISTER:
> > > +		/* can be delivered multiple times, so check registered flag,
> > > +		 * then destroy the interface
> > > +		 */
> > > +		break;
> > > +	case NETDEV_POST_INIT:
> > > +	case NETDEV_GOING_DOWN:
> > > +	case NETDEV_DOWN:
> > > +	case NETDEV_UP:
> > > +	case NETDEV_PRE_UP:
> > > +	default:
> > > +		return NOTIFY_DONE;
> > > +	}
> > 
> > Why are you using a notifier to get events for your own device?
> 
> My understanding is that this is the standard approach to:
> 1) hook in the middle of registration/deregistration;
> 2) handle events generated by other components/routines.
> 
> I see in /drivers/net/ almost every driver registers a notifier for their
> own device.

I think most of them register a notifier for their lower device
(bridge port, real device under a vlan, or similar).

I've mentioned at some point that it would be more usual to replace
this notifier with a custom dellink, and that ovpn->registered could
likely be replaced with checking for NETREG_REGISTERED. I just thought
it could be cleaned up a bit later, but it seems Jakub wants it done
before taking the patches :)

-- 
Sabrina

