Return-Path: <linux-kselftest+bounces-5635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377C86C92C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B431C22C45
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384B7D070;
	Thu, 29 Feb 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wcBsRyjr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AC7C6CD;
	Thu, 29 Feb 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209504; cv=none; b=bCpwLoveYA4mEfFuxCkmLGvBeKqHMLjXiUH+8/Fsyurs7H+TUAtWFLqoK+XyA7fpa3cGsO3a6EpJsvtnLJaEVcdWwFR8hoWslW3rBpAyRS7g/oQHKlc8UyneWrYQ8hITA1ZOYFWnpGI9H+re6cfzJbpTQPFcGPGHCJGhXcRyheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209504; c=relaxed/simple;
	bh=K6neWUIvFeoUW8xXFJdX5R3tPB5XjlIDUunhao1jtTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7wWpTCUpsSNfmVU1cvmVPRLE1MAitivZtgNzwP0SSMHwyVmTaCZnKvUOl2hEUNyLdMcSPQqyPJALRpBliJMDt4kSroMqWRnOHYcM6YJJ/SdnhL8yChm0wez/n2gn68H2jKh7CWWzwpuJlTz3kSfAzNPBnWujDMFnkiYpA3K5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wcBsRyjr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDB93673;
	Thu, 29 Feb 2024 13:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709209488;
	bh=K6neWUIvFeoUW8xXFJdX5R3tPB5XjlIDUunhao1jtTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wcBsRyjry5kHLIzEbjm/NFi/nTIml+y2541VxIqpb3C8yubjlwE8UsajGdDLFH389
	 D0Z6S/eV/nzltcCvWj9KNHyE+vYdlE3MkXlYXglPUTSKBRwzWpgOBXeLeUO/yelXKn
	 Dg7fnds8NhKgxTm8mvtHILYR/TNTkjA8+vvwO3W8=
Date: Thu, 29 Feb 2024 14:25:03 +0200
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
Message-ID: <20240229122503.GH30889@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
 <20240229111919.GF30889@pendragon.ideasonboard.com>
 <a4fc23e1-5689-4f86-beb7-5b63a0d13359@sirena.org.uk>
 <b3fb89aa-56b4-4b3c-88f6-c6320bf5c489@gtucker.io>
 <20240229122040.GG30889@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229122040.GG30889@pendragon.ideasonboard.com>

On Thu, Feb 29, 2024 at 02:20:41PM +0200, Laurent Pinchart wrote:
> On Thu, Feb 29, 2024 at 12:53:38PM +0100, Guillaume Tucker wrote:
> > On 29/02/2024 12:41, Mark Brown wrote:
> > > On Thu, Feb 29, 2024 at 01:19:19PM +0200, Laurent Pinchart wrote:
> > >> On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
> > > 
> > >>> Of course. You're also welcome to join the #kernelci channel on libera.chat.
> > > 
> > >> Isn't that a bit pointless if it's no the main IM channel ?
> > > 
> > > It *was* the original channel and still gets some usage (mostly started
> > > by me admittedly since I've never joined slack for a bunch of reasons
> > > that make it hassle), IIRC the Slack was started because there were some
> > > interns who had trouble figuring out IRC and intermittent connectivity
> > > but people seem to have migrated.
> > 
> > In fact it was initially created for the members of the Linux
> > Foundation project only, which is why registration is moderated
> > for emails that don't have a domain linked to a member (BTW not
> > any Google account will just work e.g. @gmail.com is moderated,
> > only @google.com for Google employees isn't).
> > 
> > And yes IRC is the "least common denominator" chat platform.
> > Maybe having a bridge between the main Slack channel and IRC
> > would help.
> 
> If the gitlab CI pipeline proposal wants to be considered for inclusion
> in the kernel, I think it needs to switch to a free software solution
> for its *main* communication channels.

And to clarify, I didn't meant the kernel CI project, but only the
gitlab CI pipeline for the Linux kernel project. I don't know how
tightly integrated the two projects are though.

-- 
Regards,

Laurent Pinchart

