Return-Path: <linux-kselftest+bounces-9147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC328B7B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F071C22855
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8D13D275;
	Tue, 30 Apr 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhhbo27p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7F77114;
	Tue, 30 Apr 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489986; cv=none; b=NSUprchNsWoQ05SyRW3u5V3CBPjEu5n+ByZrF18aTWG67M0Ma3Rk9WLyvBnBl84dhFpTldkszB8iNFVp6KBdfESJYZxnZe889SvOO9NfB1Kfjou0UenRCLEJoF+myOYG4ZWWGBh+C0fLF7N1J+tQsv0ps9WPmXozEWHUbITWzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489986; c=relaxed/simple;
	bh=nOwMaSqHQwcfDVq6ZqpmuNjtJXFF8T+FONAfEMpGSzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWFcz/5IZdZIjsD74sFe0wKyZziAE/XWLkEKsmYSMST0hVq4JTYoDAOl84QPLuGWtTlCHd07kmVGUsLiM5RG2V3TiHIZvSL5MDtsT+jHr/PSoS3cfe94evdnpDT8YgMG1RJVldDTmCB1spoQo1drwPd1tCBHI53K6gPjjOHCgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhhbo27p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1BBC2BBFC;
	Tue, 30 Apr 2024 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489986;
	bh=nOwMaSqHQwcfDVq6ZqpmuNjtJXFF8T+FONAfEMpGSzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhhbo27pq8QgRNr8LR/rO74saLT0MGz6Fbw+tJ0W9OU/t9+jbAFs/og8G7o5eDSBx
	 kHHawb2sfGlWSBDsKh+hjsBcnOovPyKlrAUT0ukYi791Lq2mBqO2bFcRcOxo2Yrsr5
	 fLKIIix1eCkRwEgvX6vFVZhhmKCnS13gjjG9zf+9XuIEckYqv341c9YYIqZ37ZR6mn
	 HkgxN+lpCbIDiwcufcSM0EePXzurxIO6V4sKw1tg3ISepQ/Ec9E1c6fPK6gNGFjB8Z
	 rvCc3cwzESCE/vJXh17mvZzJz5evnYC9U9ZnNIv7Amyh00y+wzzWnuwDHPiBH9n1sk
	 QPuINmErxmhgg==
Date: Tue, 30 Apr 2024 08:13:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Shengyu Li <shengyu.li.evgeny@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
 Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fix Kselftest's vfork() side effects
Message-ID: <20240430081304.0cc6bd8d@kernel.org>
In-Reply-To: <20240430.eudae0Mahbie@digikod.net>
References: <20240429191911.2552580-1-mic@digikod.net>
	<20240430.eudae0Mahbie@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 15:54:38 +0200 Micka=C3=ABl Sala=C3=BCn wrote:
> Jakub, can you please review it?

I looked thru it. I don't have the cycles to investigate and suggest=20
a better approach but the sprinkling of mmaps(), if nothing else, feels
a bit band-aid-y =F0=9F=A4=B7=EF=B8=8F

