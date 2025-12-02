Return-Path: <linux-kselftest+bounces-46893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D5C9C2C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1033D3AB08F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE425FA10;
	Tue,  2 Dec 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MokDP01/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541428373;
	Tue,  2 Dec 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692212; cv=none; b=ZphnEh7pg0WVghssxGaJKJU1nRwLrMLZMBJqm00NWljj5o1fqaegPQ/y421hWOnYhQQrLJdoXcR8yKtJ65Zava/RROtvZxl59hb2TK5aHwVn6eKaidh2cuE5XGWW5igegcvxr6GfBiSZTq1738yOSRZ6t9pTkTBKRf18JWgGgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692212; c=relaxed/simple;
	bh=PVARMYIL5iKuFDPs7ScHjrzq7cOp+Ln4nZRlGCcro7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO3lYXL7EI270WozAaZ6p+lWfJTL0NRty8OrRvrmgY9HIkvqdOncLrEUU60rdM3D/eyTGfk+fVoOXqODlde/u5OZeEjlBmypmxl/0ZZnc7UgbslKZbyUMals+B8ECZ1xtGJFcD+jzdhxGcB3ff/C3hJATjKAvuI7JskNa2kPcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MokDP01/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458C4C4CEF1;
	Tue,  2 Dec 2025 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764692212;
	bh=PVARMYIL5iKuFDPs7ScHjrzq7cOp+Ln4nZRlGCcro7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MokDP01/56WXAAh+8PEEtoCe8UOTGEiGK13/4SGlm4JRKGeuY2MX8nENhIaBnenKy
	 4xp2CykeqPMLqOJG8y87/ufmWk6Kl4cCf2keBBxIzsK3PCTqjGo3PLbPmMKlTgTE12
	 R0pqEwyZbMkbkBzNLc7iK/vMx/jJesaCiblgozIE65p4QrXd3IojOQxy5DzPvp9hMh
	 eOZFneaLw7mmH0NSQ6Mtb0p1JtDSHqHxlu31jvTwk4Chn2RnCQbI+gQfL/VaH4c3TE
	 aKH2v/4qOrh6GFsqnmBVwIBAsg0MHvE3qZgi0YRVAtVCjXtJ7sD2DkvWOUJ1GO3hRy
	 zLADVZkO4BXVA==
Date: Tue, 2 Dec 2025 16:16:47 +0000
From: Simon Horman <horms@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with
 existing 8021q upper on any port
Message-ID: <aS8Q7yCvvhXn5iYu@horms.kernel.org>
References: <CAOiHx=mog+8Grm1QTnqU_F3=BnWmJqTj+ko-nZiRMAb4-hvSqw@mail.gmail.com>
 <20251201224855.4102774-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201224855.4102774-1-clm@meta.com>

On Mon, Dec 01, 2025 at 02:48:48PM -0800, Chris Mason wrote:
> On Mon, 1 Dec 2025 20:52:34 +0100 Jonas Gorski <jonas.gorski@gmail.com> wrote:
> 
> > Hi,
> > 
> > On Mon, Dec 1, 2025 at 3:48 PM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Dec 01, 2025 at 11:28:13AM +0100, Jonas Gorski wrote:
> > >
> > > ...
> > >
> > > > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > > > index f59d66f0975d..fa1fe0f1493a 100644
> > > > --- a/net/dsa/user.c
> > > > +++ b/net/dsa/user.c
> > > > @@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
> > > >
> > > >  /* Must be called under rcu_read_lock() */
> > > >  static int
> > > > -dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
> > > > +dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
> > > >                                    const struct switchdev_obj_port_vlan *vlan)
> > > >  {
> > > > -     struct net_device *upper_dev;
> > > > -     struct list_head *iter;
> > > > +     struct dsa_switch *ds = dp->ds;
> > > > +     struct dsa_port *other_dp;
> > > >
> > > > -     netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
> > > > -             u16 vid;
> > > > +     dsa_switch_for_each_user_port(other_dp, ds) {
> > > > +             struct net_device *user = other_dp->user;
> > >
> > > Hi Jonas,
> > >
> > > The AI robot is concerned that user may be NULL here.
> > > And I can't convince myself that cannot be the case.
> > >
> > > Could you take a look?
> > >
> > > https://netdev-ai.bots.linux.dev/ai-review.html?id=47057e-e740-4b66-9d60-9ec2a7ee92a1#patch-0
> > 
> > At this point it can be NULL. But it being NULL is not an issue, as ...
> > >
> > > > +             struct net_device *upper_dev;
> > > > +             struct list_head *iter;
> > > >
> > > > -             if (!is_vlan_dev(upper_dev))
> > > > +             if (!dsa_port_bridge_same(dp, other_dp))
> > > >                       continue;
> > 
> > ... this condition will filter all cases where it is NULL. For
> > dsa_port_bridge_same() to return true both ports need to be attached
> > to a bridge (and to the same bridge), and to be attached to a bridge a
> > net_device is required, so other_dp->user cannot be NULL. And we only
> > access user after here.

Thanks for the explanation Jonas.

I wasn't very confident with this report.
And I was too focused on working out if user could be NULL rather
than if it matters. Still, I may not have worked it out.

> 
> I reproduced this false positive here, thanks for the explanation.  This is an
> example of a class of review mistakes I've wanted to fix, so I used it to
> improve the prompts around NULL pointers that are protected via other checks.
> 
> I'll test this on some more commits and push it out.

Thanks for following-up on this Chris.

I guess everyone has their own opinion on AI.
And, in a similar vein, many have opinions on the review-prompts.
But, FTR, I've been impressed by the output I've seen,
having used them for a few weeks now. And I look forward
to that improving further.


