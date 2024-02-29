Return-Path: <linux-kselftest+bounces-5628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C886C7E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A42B1F235F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440267B3C8;
	Thu, 29 Feb 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DrPgchJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11B64A9B;
	Thu, 29 Feb 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205563; cv=none; b=GamjNvL0Cjyndl6qeG6fyOFBYFoZeGVikcY19ufldKReQIga7yBzGnA2JeIHySURHZDGHzRKySvdKZx0MKYimu2MANLb9cPRylxVibIPm9kpifDK0eDq2CjsDdIqZVvd9mahrU275C5QdWxyNvix8zG+Xsib29J3Zp0f4+nZXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205563; c=relaxed/simple;
	bh=7Eihvt86sWz7EP3y44dO8crLxvUcOmGXPcGktOO6u/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgEyE3JmedhwO6jJQCnN0lE52IctYui7+adox5GjW6FCxOKrgC4sfW7NvgoaateqHzXwwSlCKxVCSNmz29WVG/25tKUQwm50Jn1p5NYpRw8SMrB3fe0UK5Lo/X4FeER8AR6kQ//49484zBCS8djz07iW21kmnFVOzyTLkGkt0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DrPgchJl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CA8BC67;
	Thu, 29 Feb 2024 12:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709205544;
	bh=7Eihvt86sWz7EP3y44dO8crLxvUcOmGXPcGktOO6u/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrPgchJl8eyBsuuIvu1KwAAxBvUE2LhSUIkFpyBTTNDzjdFgAe2QAKOs5GKt4FLC1
	 Hu4OTxmiFybg7PokMEe+AuTDBS89RjdgLUEi8PP2idrIgn1lO9betXc1NcDq+3Y+8l
	 Hbdh3a/hEQ2dpoICE8v7cXWXcj4nvPXvdidvztlQ=
Date: Thu, 29 Feb 2024 13:19:19 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, kernelci@lists.linux.dev,
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
	Julia.Lawall@inria.fr, laura.nao@collabora.com,
	ricardo.canuelo@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240229111919.GF30889@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>

On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
> On 2/29/24 11:34 AM, Laurent Pinchart wrote:
> > On Thu, Feb 29, 2024 at 11:26:51AM +0200, Nikolai Kondrashov wrote:
> >> On 2/29/24 01:07, Laurent Pinchart wrote:
> >>> On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
> >>>> **Join Our Slack Channel:**
> >>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> >>>> Feel free to join and contribute to the conversation. The KernelCI team has
> >>>> weekly calls where we also discuss the GitLab-CI pipeline.
> >>>
> >>> Could we communicate using free software please ? Furthermore, it's not
> >>> possible to create an account on that slack instance unless you have an
> >>> e-mail address affiliated with a small number of companies
> >>> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> >>> for me.
> >>
> >> Yes, it's not ideal that we use closed-source software for communication, but
> >> FWIW I'd be happy to invite you there. Perhaps if you try logging in e.g. with
> >> a Google account, I'd be able to see and approve your attempt too.
> > 
> > I don't use Google accounts to authenticate to third-party services,
> > sorry. And in any case, that won't make slack free software.
> 
> Of course. You're also welcome to join the #kernelci channel on libera.chat.

Isn't that a bit pointless if it's no the main IM channel ?

> It's much quieter there, though.

-- 
Regards,

Laurent Pinchart

