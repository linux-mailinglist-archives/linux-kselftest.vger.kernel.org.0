Return-Path: <linux-kselftest+bounces-9010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8F8B58FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EFC28B995
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75153371;
	Mon, 29 Apr 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rFwDiDYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BDFC2C6
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394745; cv=none; b=hzyctw89pjW6wfP2vD2aF9VxCMeh81EQBujx8Y/8uZ/+NeEn5cwCmOuqvXUjrbOcbIxL0/ifzjjKNlgFLkE/iEJj4K0g09vfWIeofC9E5OOakJIhGma5CILpoLePClCnkmMk21vxLK6kS5SGBtoHUGGI0CUpYcwv8f+PTWywW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394745; c=relaxed/simple;
	bh=xQ8IhuGGKzgAOYqouVROPG5PwWz+5I9v/foLO8Is22A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kee9fAgjzDLmFXc2aDWEDTRqUXaiLkGwsCIY5hUg756hk5Jj4lCezd7mTb+QuS+SwRFlhZKBILBGXGMscm2MtNhRosMlys7o9T+FR9f/CLMgTiYpKe989mK12d3gY5qevqewx579dY/ecQSuFduZT7grrTU1cy1R7xdwXiNVP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rFwDiDYF; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSjZ61JRYzfY;
	Mon, 29 Apr 2024 14:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714394350;
	bh=xQ8IhuGGKzgAOYqouVROPG5PwWz+5I9v/foLO8Is22A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFwDiDYFNB8MxT+ieMChfPIAdInVvvEJdRgRTxPGApFXlh/QprCCHOWvjRrUYHguF
	 nZhQ4PxUCPLZNQGOgx42jZGckE6sYYVJkIyjyp3+Amez+B617zmBCOO7RRhfVYtvEC
	 EQP1B8jyNjb13m/oJMz5c5+AG9oyT8B9/QvO63lw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSjZ46STDzT34;
	Mon, 29 Apr 2024 14:39:08 +0200 (CEST)
Date: Mon, 29 Apr 2024 14:39:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/5] selftests/landlock: Fix FS tests when run on a
 private mount point
Message-ID: <20240429.Chahf2sai1au@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-3-mic@digikod.net>
 <202404261237.C703A7B1F4@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202404261237.C703A7B1F4@keescook>
X-Infomaniak-Routing: alpha

On Fri, Apr 26, 2024 at 12:38:17PM -0700, Kees Cook wrote:
> On Fri, Apr 26, 2024 at 07:22:49PM +0200, Mickaël Salaün wrote:
> > According to the test environment, the mount point of the test's working
> > directory may be shared or not, which changes the visibility of the
> > nested "tmp" mount point for the test's parent process calling
> > umount("tmp").
> > 
> > This was spotted while running tests on different Linux distributions,
> > with different mount point configurations.
> 
> Which distros did what?

Actually it's not related to distros, but rather container runtime
(Docker) vs. non-container environment.  With Docker (at least on my
environment) all mount points are private, which is not the case (by
default) when running the same UML environment not in a container. See
https://github.com/landlock-lsm/landlock-test-tools/pull/4

I'll update the description.

