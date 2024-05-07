Return-Path: <linux-kselftest+bounces-9607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F58BE79C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1091C23EC0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83797165FD4;
	Tue,  7 May 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MUOnRR6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164515F30F
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096565; cv=none; b=fp92dlW+ZWQEoMg1ZBGO8uR9saC//7Nu3W9/ZBZXoBpo3Moi1aG771scgRJd/miPZ10AgTwgi3LQs2YB7rWzcO39/x5svCP2n5GTriHJ5osRFOLJP16Fuu7/0LXH/SgAQDIB+1XlKxg7fL2qRkHWSCxKu1ILtgbiJrc3d/E4CcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096565; c=relaxed/simple;
	bh=tG7GC4Detn+hIijiFJM2CHvKICrWG0m6s3hG3mjp4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeE5iYhRuahKvibI6iIX9b4gsv05fm4QHlBdToNWSG7e41mbiXEvIxBoqYTwbYE/PGYkT4zE+5bx+Gg8797WN0cU8Eft6lIBFpF9wZfTxqJwI7QhRakH0GUbzu06gdusNtN5Rv3vck6RQtvKjsmvnFUlDyOhHLK4DmVhiDu9He0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MUOnRR6p; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VYjG70TZqz7Y0;
	Tue,  7 May 2024 17:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1715096558;
	bh=tG7GC4Detn+hIijiFJM2CHvKICrWG0m6s3hG3mjp4q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUOnRR6pm2mGnKlpB/Nx/dz12RcHc2yr2ELwVY5eOLXq+GbViBrtPNka3Kz/TNG1G
	 IXKw6TApqZkuD21ikd/ZZkAzz3GK8OguOaVYUg/E3n8Uy4YsQVND5YqqjlHnJjIl1E
	 mAJ2LaDL5NK9EBeihxeYw60XkVtzrqtRprU+xOsQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VYjG42vCWzb2J;
	Tue,  7 May 2024 17:42:36 +0200 (CEST)
Date: Tue, 7 May 2024 17:42:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jakub Kicinski <kuba@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>, 
	Ronald Warsow <rwarsow@gmx.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v6 00/10] Fix Kselftest's vfork() side effects
Message-ID: <20240507.aevi0xaeWohb@digikod.net>
References: <20240506165518.474504-1-mic@digikod.net>
 <202405061002.01D399877A@keescook>
 <Zjo1xyhjmehsRhZ2@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjo1xyhjmehsRhZ2@google.com>
X-Infomaniak-Routing: alpha

On Tue, May 07, 2024 at 07:12:51AM GMT, Sean Christopherson wrote:
> On Mon, May 06, 2024, Kees Cook wrote:
> > On Mon, May 06, 2024 at 06:55:08PM +0200, Mickaël Salaün wrote:
> > > Shuah, I think this should be in -next really soon to make sure
> > > everything works fine for the v6.9 release, which is not currently the
> > > case.  I cannot test against all kselftests though.  I would prefer to
> > > let you handle this, but I guess you're not able to do so and I'll push
> > > it on my branch without reply from you.  Even if I push it on my branch,
> > > please push it on yours too as soon as you see this and I'll remove it
> > > from mine.
> > 
> > Yes, please. Getting this into v6.9 is preferred,
> 
> Very strongly prefered for KVM selftests.  The negative impact on KVM isn't that
> the bugs cause failures, it's that they cause false passes, which is far worse
> (and why the bugs went unnoticed for most of the cycle).

FYI it's now in linux-next.

