Return-Path: <linux-kselftest+bounces-5619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9486C55B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBE01C23AA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226335D8FA;
	Thu, 29 Feb 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CDo8BTM8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153F5EE7E;
	Thu, 29 Feb 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199245; cv=none; b=VVVeodg0XGIShn3gft/YkEc77GMKBdUbCZMVte6HjrUkfVudw3BpwHvp5IL2QFwxC9FljtgPZwMAumGcMBqG/k/zGn/MlHEY/0t+D2peRWvHF/dNW8XtfiTsCWvf1P8CJ0GNRCVLXhlXxABidi4JFHMrWk1h5hX0ADm0AhQqW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199245; c=relaxed/simple;
	bh=JYn9O2kHbLW+DuiEmtvcLS087RRhHTFUePdVT6PY9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5NrQIO64gUqXPi1N760jqDzB38Sm5CjLbIPXy3Nt+km5oS6I9ZmS/VoZgi5Wc0JxTNAHOxEBeoIeNy5xmnlCWH+cDM6cQY1Xq5CeYjts+yGVTKYZ86KovxgdpKj/Kyitoqdl9DGgZ959I8dcMaaUhbwFt7fyJcQymwdW0kBMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CDo8BTM8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 320D5673;
	Thu, 29 Feb 2024 10:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709199227;
	bh=JYn9O2kHbLW+DuiEmtvcLS087RRhHTFUePdVT6PY9zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDo8BTM8WDvhct61kEZND1uCGh2rGMB278Y6LChh4iA13UEi6ctYKRgxm8IRIH7Z+
	 VUklmNtpMm9U9z81NLnhCTzs0tEGWcLlPzVGE707haJTgklFApM+WVXv1mw0mYNiAa
	 OzhHpoLhFPs19mbAzNcTLuT0ydllPBpuOo2CbcZY=
Date: Thu, 29 Feb 2024 11:34:02 +0200
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
Message-ID: <20240229093402.GA30889@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>

On Thu, Feb 29, 2024 at 11:26:51AM +0200, Nikolai Kondrashov wrote:
> On 2/29/24 01:07, Laurent Pinchart wrote:
> > On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
> >> **Join Our Slack Channel:**
> >> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> >> Feel free to join and contribute to the conversation. The KernelCI team has
> >> weekly calls where we also discuss the GitLab-CI pipeline.
> > 
> > Could we communicate using free software please ? Furthermore, it's not
> > possible to create an account on that slack instance unless you have an
> > e-mail address affiliated with a small number of companies
> > (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> > for me.
> 
> Yes, it's not ideal that we use closed-source software for communication, but 
> FWIW I'd be happy to invite you there. Perhaps if you try logging in e.g. with 
> a Google account, I'd be able to see and approve your attempt too.

I don't use Google accounts to authenticate to third-party services,
sorry. And in any case, that won't make slack free software.

> Otherwise, our video meetings are generally open to everyone and run in Jitsi.

-- 
Regards,

Laurent Pinchart

