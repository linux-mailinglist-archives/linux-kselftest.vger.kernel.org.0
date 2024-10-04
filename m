Return-Path: <linux-kselftest+bounces-19066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E7990FA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0FD1F21139
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68831D958F;
	Fri,  4 Oct 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="OFWcBZ6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88741D89FB;
	Fri,  4 Oct 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069505; cv=none; b=dRVfVXbSfInqM1HHjo9pSmlODashl0VX1BUVLHyZSiNQ5RYEH8Vu/Rk8IxaPQ3TRveUIOmq6vr/5/SK6Ne/b0tSlo91MBgWy9ERfd8VKjG6bLfOWDhjcI6BeLyl7JXq7JwDXErhmjMPGRATcM4kzTSgajqpJ/4MTSGx3P4jnzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069505; c=relaxed/simple;
	bh=6LD92QJ4XebEfFMsCs9B8yNyFeac4apJu4y37rt39aI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=IhcTwxqxrpgkCtX8Z8s9CLDSeA6s8jK6OV3+0o5KHoUb5GGR7oa/P7cYPucvWB9j6c3Chs8Q5haD3OSvwKslWQ7pq0k88SvTn/mW2tkXOcJSECPWnByaxoI/Shza+5/QQa7YgagVKY0qNiz/TaMInofOyP4BM4qzWGyaQ39VG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=OFWcBZ6+; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=6LD92QJ4Xe
	bEfFMsCs9B8yNyFeac4apJu4y37rt39aI=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=OFWcBZ6+xSEw2Tt3FoRs5BusBaR550el6
	FfBROrwB8uRdRboCZSiNSthykXJnBjLKYd+iouEIskglSmV1GBhiJ20t508SURLRgHCgsO
	ihWy1SzJK92zk3P0pv9N+NukSakaLaOZctoTDSTQrrZy4Gj8/1xSP8htmAql48fL40t17r
	Hb67vUiBl9O5AlMmKBs39920R6VdEC69YwiJatwGXfDP6GZ8AEXIo28ICVsBrm9zwrAYvK
	ph3P7Y+gk7ueIR8mWN1Abbk4WEMlaINuDgMnSSO1UXoKRq4o46IK5+2BpWx/Q0jRosoG1c
	hkiuqAGGGkfPuhe2KIgQxrVXbpsXA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id c705fde2;
	Fri, 4 Oct 2024 13:11:42 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
    keescook@chromium.org, corbet@lwn.net, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    jannh@google.com, sroettger@google.com, pedro.falcato@gmail.com,
    linux-hardening@vger.kernel.org, willy@infradead.org,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, surenb@google.com, merimus@google.com,
    lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
In-reply-to: <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org> <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org> <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Fri, 04 Oct 2024 09:52:43 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13799.1728069102.1@cvs.openbsd.org>
Date: Fri, 04 Oct 2024 13:11:42 -0600
Message-ID: <51463.1728069102@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> > > +   replacement with a new mapping with new set of attributes, or can
> > > +   overwrite the existing mapping with another mapping.
> > > +
> > > +   mprotect and pkey_mprotect are blocked because they changes the
> > > +   protection bits (RWX) of the mapping.
> > > +
> > > +   Some destructive madvise behaviors (MADV_DONTNEED, MADV_FREE,> +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > > +   for anonymous memory, when users don't have write permission to the
> > > +   memory. Those behaviors can alter region contents by discarding pages,
> >
> > above is not a sentence but I don't know how to fix it.
> >
> Would below work ?
> 
> Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> threads without write permissions. These behaviors have the potential
> to modify region contents by discarding pages, effectively performing
> a memset(0) operation on the anonymous memory.


In OpenBSD, mimmutable blocks all those madvise() operations.


I don't understand the sentence supplied above.  Is it saying that
mseal() solves that problem, or that mseal() does not solve that
problem.

I would hope it solves that problem.  But the sentence explains the
problem without taking a position on what to do.

