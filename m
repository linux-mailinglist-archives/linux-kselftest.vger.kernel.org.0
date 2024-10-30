Return-Path: <linux-kselftest+bounces-21086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465B9B5D4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192591F22CF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D501DE8B9;
	Wed, 30 Oct 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZz4SeTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3648194C69;
	Wed, 30 Oct 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275213; cv=none; b=pgjjN3nvsIa9wK4qQtBcUHIJgmjIY3x3JZXekegVpIuhGb1/ug6LLM+EB6yrHzdJRZCFdz4i1eTcz0hwI2LEZm7Q7EKrBwn0Fcm6sRYceHu1bAQELDtohCXT6ZALtfKW36vlbLtYM9HKjy8CXaE+A/fQLmWgUbwIJfyODsTVyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275213; c=relaxed/simple;
	bh=fa9DgDsgu4iLAoH7uVAKdBg4ZTtwtHF9kcohSHCeFWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVezhioCUDlYAwTqEqCt7zefEBqhCTw5vmEoJec+hT4sUcDkJO+3raGXxsGepruLRhELZ3P+IjXt/9Hz3tjU9kr+zoRU7gpS1xdkNTksStY+zLb/SFY75OT6gkh7EednAqKCbQiksWPgOZuHObyGKIP27KlcoLndX1hjgNLTxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZz4SeTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20684C4CEE4;
	Wed, 30 Oct 2024 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730275212;
	bh=fa9DgDsgu4iLAoH7uVAKdBg4ZTtwtHF9kcohSHCeFWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZz4SeThJU2EDv7v9n7K/mtpAg5xvefxT135neB9/UUOMaypcjARB9OMqGcmj3emn
	 tcd1C6u4vhU83wqz/pTdD2KQORCQ/Jhw69K5KkGwrH7l3dZwjxCbRr/qUw6lBOIaiX
	 ZhFQIe6ijMvBo/FO9uv0no7NkGUSjw+G1GHzTeX5otex7Lp/CcYT69B91SExhlYBRc
	 qKpje9lKFecpYOWzRsIh6zaLx2YZU7B5qCpKUgXzYEuwwavBNUzOVEyJs30cPksCM/
	 afWp5sgqkjWpUQ0pydiDbYiv2MSY2AuHpWsmBAAJaGDH3EG4inVHxBiwb3o25MgkND
	 83CJPItmKLxbw==
Date: Wed, 30 Oct 2024 09:00:08 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Yun Lu <luyun@kylinos.cn>, jikos@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/hid: increase timeout to 10 min
Message-ID: <4pfwh24gmu4ujb5iwjjo5oxh4mfja2ajtkrkbzbbshjkoz5wjx@ac4tfdc5twxe>
References: <20241029090746.179108-1-luyun@kylinos.cn>
 <85570e57-1af3-4d17-8a21-58c75e6bac9c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85570e57-1af3-4d17-8a21-58c75e6bac9c@linuxfoundation.org>

On Oct 29 2024, Shuah Khan wrote:
> On 10/29/24 03:07, Yun Lu wrote:
> > If running hid testcases with command "./run_kselftest.sh -c hid",
> 
> NIT - When inestead of "If"
> > the following tests will take longer than the kselftest framework
> > timeout (now 200 seconds) to run and thus got terminated with TIMEOUT
> > error:
> > 
> >    hid-multitouch.sh - took about 6min41s
> >    hid-tablet.sh - took about 6min30s
> > 
> > Increase the timeout setting to 10 minutes to allow them have a chance
> > to finish.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yun Lu <luyun@kylinos.cn>
> > ---
> >   tools/testing/selftests/hid/settings | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/hid/settings b/tools/testing/selftests/hid/settings
> > index b3cbfc521b10..dff0d947f9c2 100644
> > --- a/tools/testing/selftests/hid/settings
> > +++ b/tools/testing/selftests/hid/settings
> > @@ -1,3 +1,3 @@
> >   # HID tests can be long, so give a little bit more time
> >   # to them
> > -timeout=200
> > +timeout=600
> 
> Okay - maybe this test shouldn't be part of the default run if it needs
> 600 seconds to run?

Agree, but is it possible to be more granular?

FWIW, there are some tests that are quick in the hid subtree that should
probably be run regularly. For instance, the hid_bpf program is
interesting to be run when there are bpf changes, because it's relying
on the bpf architecture.

I think hid-core.sh, hid-mouse,sh and hid-keyboard.sh are fast enough
and should also be integrated in the default runs.

hid-multitouch, hid-wacom, hid-sony are definitely taking a lot of time,
so they should probbaly be run only when there are changes in those
areas, i.e., not by default.

Cheers,
Benjamin

> 
> thanks,
> -- Shuah

