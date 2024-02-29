Return-Path: <linux-kselftest+bounces-5633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07BD86C915
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6FF1F25484
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1147D07C;
	Thu, 29 Feb 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IqN3QhQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8F7D074;
	Thu, 29 Feb 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209245; cv=none; b=ArrBF9Lu/A3y9o6TEMaRoRkod4QMR2FUB5vAWJZM9Cx2nGkoLI3lT6iLdORUUOHjZNQ/ZG5qs5h9ms3t/GZWghJr8gtbGYWAAvRbIdQD81mKXhKtAijRzBpMwGsRlmAcq4XJa/pFTl6hth12D4Sp49qnLCymA5cDEg43NPYvKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209245; c=relaxed/simple;
	bh=emQm7hFesm1ix53qkhKXk/Ui+MWdzCkGTzLlugguFwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9gSDqmaaw08S1KYB8pqvsGr5pU7lrjETWNQfS3E0BPJQW+dm0FZrQD9clO42HKWFAzMcEOjWBnIv9ZmbTuxNotp5ns9TqxphF2sDW2R7BKgAa7zvJM3O7gzI0xRdDFYkGyuKaJjbdxGBxd9TrML82qgS40hkKOJbJhkpMvXAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IqN3QhQZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04C6E673;
	Thu, 29 Feb 2024 13:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709209225;
	bh=emQm7hFesm1ix53qkhKXk/Ui+MWdzCkGTzLlugguFwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqN3QhQZMd06ouU9VAf2MIJT4ISmQMj11yF1qHSQEqULk6VFr9BVsMVkwwcty4L9U
	 3kcec5y7Ii/cM1IvKdbrbm66BC/F7dPzgm10TZNwomr15OXWS8mOtFMkw4oGWdlZrh
	 m1PJta3Pe42j2OYxP0d3lsvvJDtu4m8HhZ8ECO7g=
Date: Thu, 29 Feb 2024 14:20:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guillaume Tucker <gtucker@gtucker.io>
Cc: Mark Brown <broonie@kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>,
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
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
Message-ID: <20240229122040.GG30889@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
 <20240229111919.GF30889@pendragon.ideasonboard.com>
 <a4fc23e1-5689-4f86-beb7-5b63a0d13359@sirena.org.uk>
 <b3fb89aa-56b4-4b3c-88f6-c6320bf5c489@gtucker.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3fb89aa-56b4-4b3c-88f6-c6320bf5c489@gtucker.io>

On Thu, Feb 29, 2024 at 12:53:38PM +0100, Guillaume Tucker wrote:
> On 29/02/2024 12:41, Mark Brown wrote:
> > On Thu, Feb 29, 2024 at 01:19:19PM +0200, Laurent Pinchart wrote:
> >> On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
> > 
> >>> Of course. You're also welcome to join the #kernelci channel on libera.chat.
> > 
> >> Isn't that a bit pointless if it's no the main IM channel ?
> > 
> > It *was* the original channel and still gets some usage (mostly started
> > by me admittedly since I've never joined slack for a bunch of reasons
> > that make it hassle), IIRC the Slack was started because there were some
> > interns who had trouble figuring out IRC and intermittent connectivity
> > but people seem to have migrated.
> 
> In fact it was initially created for the members of the Linux
> Foundation project only, which is why registration is moderated
> for emails that don't have a domain linked to a member (BTW not
> any Google account will just work e.g. @gmail.com is moderated,
> only @google.com for Google employees isn't).
> 
> And yes IRC is the "least common denominator" chat platform.
> Maybe having a bridge between the main Slack channel and IRC
> would help.

If the gitlab CI pipeline proposal wants to be considered for inclusion
in the kernel, I think it needs to switch to a free software solution
for its *main* communication channels.

-- 
Regards,

Laurent Pinchart

