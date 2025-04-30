Return-Path: <linux-kselftest+bounces-32043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F9AA543B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DAD9E10A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD12620CB;
	Wed, 30 Apr 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/VUJi0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4471DFDA5;
	Wed, 30 Apr 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039241; cv=none; b=J7ndQoiXAocoY8gMJghaRCuhk3SrO33qtPLc/p64zRPVb7z6gnH2911e+4kva/TIH8U8ulWCTwPTG0cxs/dOu0hNUE7vW9x6+Lgh9wR9t+QtrP+TV8BsgJb0DPSz9FOl/83vXulQEdv6Gn6CgnNvehg/xJrSP4Be2hoexuFJRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039241; c=relaxed/simple;
	bh=INqp31oPH6YlSTaHcFPVax+oSPwJTWRqHYvfXqiVndg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZBL1Yd+mbC2qwTxl91WV9i6923oUV8kOTwNHHxmpIFW16B3ED0bn5/KSXzTWW+27x3LgaU+HMtQyzTpmdxkxQF6HvOdrrmOzoJFTdZmshEQP8OemEcEYY6T9v9bKuma7zDgxe1HHhV7xk8WIo6iazDZdn7g/+MV+g409mpDI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/VUJi0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C621C4CEE7;
	Wed, 30 Apr 2025 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746039240;
	bh=INqp31oPH6YlSTaHcFPVax+oSPwJTWRqHYvfXqiVndg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/VUJi0jjbbNa+TFHpHtWlZVwRW81Aw+AZNcQwqfjM0xYAwbk76vc+hWuOlN5N3IY
	 0EEY5IYiA3UMh6Ge/tB4eTU1TmLUVXalcSlSn5lExVVf+xM7Z2FRotV7+yYommlmxx
	 8wG2bxSAqdYbwjDoIb0l0pA5DGQl9Hd54n3/2aHrOXLno/PAv8jUr7FdKSCz8PZkfV
	 21UjKaq0th7CFyvnAh3vLAlsbtz6hPbFyne0L0xCjxHW9oZos/yHDgU5H7bGOrqXX/
	 UrQ3ZpS+hP4ecCwdaCIrv7dwJ69uyBZqFr6zyf1BMYv/qFqb82xuFZlI/tSKnQPRA1
	 vy+ONWiHeJwLA==
Date: Wed, 30 Apr 2025 11:53:57 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/32] kselftest harness and nolibc compatibility
Message-ID: <202504301153.E2D0C4ED@keescook>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
 <20250422085145.GB14589@1wt.eu>
 <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>

On Thu, Apr 24, 2025 at 02:06:34PM -0600, Shuah Khan wrote:
> On 4/22/25 02:51, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > On Tue, Apr 22, 2025 at 10:48:28AM +0200, Thomas Weißschuh wrote:
> > > Hi,
> > > 
> > > On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weißschuh wrote:
> > > > Nolibc is useful for selftests as the test programs can be very small,
> > > > and compiled with just a kernel crosscompiler, without userspace support.
> > > > Currently nolibc is only usable with kselftest.h, not the more
> > > > convenient to use kselftest_harness.h
> > > > This series provides this compatibility by adding new features to nolibc
> > > > and removing the usage of problematic features from the harness.
> > > > 
> > > > The first half of the series are changes to the harness, the second one
> > > > are for nolibc. Both parts are very independent and should go through
> > > > different trees.
> > > 
> > > I need a few nolibc bits of this series (snprintf() and prep patches) to base
> > > further patches on. For that I'd like to pick up all the nolibc patches from
> > > this series through the nolibc tree. They got Acks from Willy.
> > > 
> > > Any objections?
> > 
> > No objection on my side!
> > 
> 
> Thanks.
> 
> Kees, do you have any comments on this series? If you are okay
> with it, I would like to apply this for next.

Fine by me! :)

-- 
Kees Cook

