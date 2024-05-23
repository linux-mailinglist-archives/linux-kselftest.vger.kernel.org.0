Return-Path: <linux-kselftest+bounces-10632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2848CDAFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8761F234A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F283A08;
	Thu, 23 May 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="STAvvTVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCD5FB9C;
	Thu, 23 May 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493522; cv=none; b=NbIoT0Z0w2AwesFKsy+62GTO2NWJ/AUXCx5nN3kDAjd+aRnxasC2gYDDVWbyKGq5yxx0D2RNA+jLbVz3skrBtmucU32aQM3iUsvRwBMFyW5M+HVfkQeXEU+QgFrsgS49RE7AWVs0B7Pt3kA3pQzkZz9mI2aUxyLAof+yAmXhQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493522; c=relaxed/simple;
	bh=t0orVRpMQ2TKtiB7VH6XOYM3LYyB2qqnNE9rKqfRp/Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TRjAQe6/zCOZcHrKdPzut4+Tnc38QApULDg4A8EVChKm8CRMY8qe3DZIrRWtk5IhvGh9yQNt+ochhEo81uI04bUze1MXgAPIqGylJ+DsQ6EAqDVZnO3ZLNnBdNLV9nfeFx65As3gnPt0X4Xk3czPsF/T+2yHHcdrjMfzxv6I9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=STAvvTVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7433C2BD10;
	Thu, 23 May 2024 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716493522;
	bh=t0orVRpMQ2TKtiB7VH6XOYM3LYyB2qqnNE9rKqfRp/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STAvvTVzBYeeYtMAR4rcP0Cgi9iM9Rx+w3MaVMYJjlI1iQG2xRjQWByb5+m1YRGu9
	 W7DZ+g/eSDTYcq4y3JfQ60Ej5nCw+KN20a5eILdppvOw/UNJaiqXvbnIT2j/YqK8Ah
	 y7X1KdxHtJniVxNxiff7jTO0AI57+Bw1xgJo0oAA=
Date: Thu, 23 May 2024 12:45:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeff Xu <jeffxu@google.com>
Cc: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com,
 dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
 skhan@linuxfoundation.org, keescook@chromium.org
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
Message-Id: <20240523124521.99a798d645b0939d331d70c1@linux-foundation.org>
In-Reply-To: <CALmYWFuLe6RaJkZ4koQpgZR-77b9PP=wooPYN-jFFw1KQ5K3aQ@mail.gmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
	<CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
	<20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
	<CALmYWFuLe6RaJkZ4koQpgZR-77b9PP=wooPYN-jFFw1KQ5K3aQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 19:32:35 -0700 Jeff Xu <jeffxu@google.com> wrote:

> >
> > It's a change to a userspace API, yes?  Please let's have a detailed
> > description of why this is OK.  Why it won't affect any existing users.
> >
> Unfortunately, this is a breaking change that might break a
> application if they do below:
> memfd_create("", MFD_NOEXEC_SEAL)
> fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE); <-- this will fail in new
> semantics, due to mfd not being sealable.
> 
> However, I still think the new semantics is a better, the reason is
> due to  the sysctl: memfd_noexec_scope
> Currently, when the sysctl  is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> kernel adds MFD_NOEXEC_SEAL to memfd_create, and the memfd  becomes sealable.
> E.g.
> When the sysctl is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> The app calls memfd_create("",0)
> application will get sealable memfd, which might be a surprise to application.
> 
> If the app doesn't want this behavior, they will need one of two below
> in current implementation.
> 1>
> set the sysctl: memfd_noexec_scope to 0.
> So the kernel doesn't overwrite the mdmfd_create
> 
> 2>
> modify their code  to get non-sealable NOEXEC memfd.
> memfd_create("", MEMFD_NOEXEC_SCOPE_NOEXEC)
> fcntl(fd, F_ADD_SEALS, F_SEAL_SEAL)
> 
> The new semantics works better with the sysctl.
> 
> Since memfd noexec is new, maybe there is no application using the
> MFD_NOEXEC_SEAL to create
> sealable memfd. They mostly likely use
> memfd(MFD_NOEXEC_SEAL|MFD_ALLOW_SEALING) instead.
> I think it might benefit in the long term with the new semantics.

Yes, it's new so I expect any damage will be small.  Please prepare a
v2 which fully explains/justifies the thinking for this
non-backward-compatible change and which include the cc:stable.



