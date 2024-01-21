Return-Path: <linux-kselftest+bounces-3279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7E8353FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 01:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20042830E2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CA15AFA;
	Sun, 21 Jan 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="xNrlzLrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8E14AAB;
	Sun, 21 Jan 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705797815; cv=none; b=N2abBiUY7m71MNBXVi2HICiLqT5s7/IYVHh51nVw1i/BnPi5J3VFVXiHxj2FbC+vJ0VvjRypGAFgdWb2aGsn1BY2ndqDRNoYikzIOg0Dr1qXJxzg4NvQ9sZltCWEtCMtwYExnYkOHr+AphohFN/8AjS/7X2GsutR9C2MOksEoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705797815; c=relaxed/simple;
	bh=6zClxfyv71M0RluUbCbllO0533ZG0kWqfL4wR73NjHM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=tY2psya8QUMrKVNbFfMKW1/SjR5NNXIMlD1QVabFk9/hMCE0cM21Ir9Vxyrh1R2wGW4t8wjBYe0FGAs2U4fdyI3M4lIIFm5pVSddDm+xbcuf361J2cIy9d4XeMPJzfHUeurIowtEwtf6+wCUlT9Fr9tsZWa3Dc5iEQxJNSHWDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=xNrlzLrv; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=6zClxfyv71
	M0RluUbCbllO0533ZG0kWqfL4wR73NjHM=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=xNrlzLrvdn5TiEK+r0xytg+ig0YyyOzsG
	5h72+KeTLSNfAWSgxuoV28p6LgEBSpKPm2uXpufBZ9QJ/n/+3TV+7DPPn/2NuEmrqFcBst
	3q9SxFEPMPkmr5ofcpN1Y4nU2IINcyvAo8zpPHQBiQMvYNKFe3+DgFPjV/Mm1y8fRq8WKK
	bO+y+/L+iBqm1en9uyXnWDP+77ycPtFteeXzwjPFOq31DSjtchzRjeKcMZkkGWXCFazv7r
	LHMmUTP8KfXq5K8NgRv1dNfIh05fsSBsZnHoCRFpH0J2BNMMosJtSlzpVknRPVr38/fiY3
	M318gjyH361AmN6EuvpAvkSoNnb6g==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id d3cb4755;
	Sat, 20 Jan 2024 17:43:32 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
    Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
In-reply-to: <CABi2SkVXgyG4r-SzkXx0-MOQ2dqhy1ewwhvfXMJLw066i1zJKw@mail.gmail.com>
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org> <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com> <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com> <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com> <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com> <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com> <78111.1705764224@cvs.openbsd.org> <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com> <CABi2SkVXgyG4r-SzkXx0-MOQ2dqhy1ewwhvfXMJLw066i1zJKw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Sat, 20 Jan 2024 16:16:39 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98518.1705797812.1@cvs.openbsd.org>
Date: Sat, 20 Jan 2024 17:43:32 -0700
Message-ID: <44186.1705797812@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> > Jeff - mind changing the EACESS to EPERM, and we'll have something
> > that is more-or-less compatible between Linux and OpenBSD?
> >
> Sounds Good. I will make the necessary changes in the next version.

Thanks!  That is so awesome!

On the OpenBSD side, I am close to landing our madvise / msync changes.

Then we are mostly in sync.

It was on my radar for a year, but delayed because I was ponderingn
blocking the destructive madvise / msync ops on regular non-writeable
pages.  These ops remain a page-zero gadget against regular (mutable)
readonly pages, and it bothers me.  I've heard rumour this has been used
in a nasty way, and I think the sloppily defined semantics could use
a strict modernization.

