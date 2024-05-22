Return-Path: <linux-kselftest+bounces-10592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56E8CC98A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 01:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951941C21B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375413DDB5;
	Wed, 22 May 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RFI9/4lW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68B7D3E8;
	Wed, 22 May 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420206; cv=none; b=pVaAM6JfFc52cFZjde6m3dYNpp+cvNW6oo4eUbpPfizQQLH566SVwaesVA/pB2phesSOlorRETjwsdaVM3HS1d1ByMhBFGwQQLYbgZCblzfxOQ6fRcn7Oubu61jitQRycosT5/gWtTfmG24SIPfGbY4ZIrBSpdifedvaW54vjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420206; c=relaxed/simple;
	bh=ux5++dGh6M9Yvr6Ah2XklCcv5ivntTcMYM43FogNXfI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MvFV/XrzRfPUoPE2AZXkQNzoWY7liMgXEdyRcvDsbz2vjLeECwGGkzYwkY5P48QOHydW1DKZYxuyXvS5R1iQ7wnXSp+4SxWCFuWKCvajQqTICVQNRiDPRtIsMdfl28xo60gi6LBAku94zCFzVPuza0QbtxbzwZygHo2bzrxoIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RFI9/4lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D78C2BBFC;
	Wed, 22 May 2024 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716420205;
	bh=ux5++dGh6M9Yvr6Ah2XklCcv5ivntTcMYM43FogNXfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFI9/4lWpb0pVGNGuf28Wr3/bXq0ZZDrEnPzoHLgEsJX6u4e6iZ+XEJGBQx/Okbv4
	 RvagSutQEl3DkodugTgFoGzvIx9v9EHuTAcuMzkJUic9q3i8kduH2bJHX8dJL4iXZ4
	 KWQJoclVvLzlCG9J2fZmGBB1UZ/xm9N/oIlkkXEg=
Date: Wed, 22 May 2024 16:23:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeff Xu <jeffxu@google.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com,
 dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
 skhan@linuxfoundation.org, keescook@chromium.org
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
Message-Id: <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
In-Reply-To: <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
	<CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 May 2024 23:11:12 -0700 Jeff Xu <jeffxu@google.com> wrote:

> On Mon, May 13, 2024 at 12:15 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
> >
> > `MFD_NOEXEC_SEAL` should remove the executable bits and set
> > `F_SEAL_EXEC` to prevent further modifications to the executable
> > bits as per the comment in the uapi header file:
> >
> >   not executable and sealed to prevent changing to executable
> >
> > However, currently, it also unsets `F_SEAL_SEAL`, essentially
> > acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
> > that it should be so, and indeed up until the second version
> > of the of the patchset[0] that introduced `MFD_EXEC` and
> > `MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
> > was changed in the third revision of the patchset[1] without
> > a clear explanation.
> >
> > This behaviour is suprising for application developers,
> > there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
> > has the additional effect of `MFD_ALLOW_SEALING`.
> >
> Ya, I agree that there should be documentation, such as a man page. I will
> work on that.
> 
> > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
> > This is technically an ABI break, but it seems very unlikely that an
> > application would depend on this behaviour (unless by accident).
> >
> > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.com/
> > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.com/
> 
> ...
>
> Reviewed-by: Jeff Xu <jeffxu@google.com>

It's a change to a userspace API, yes?  Please let's have a detailed
description of why this is OK.  Why it won't affect any existing users.

Also, please let's give consideration to a -stable backport so that all
kernel versions will eventually behave in the same manner.


