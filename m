Return-Path: <linux-kselftest+bounces-13612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD692ED22
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F69B20DA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A46B16D9A7;
	Thu, 11 Jul 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hai204IJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307016D4FA;
	Thu, 11 Jul 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716898; cv=none; b=ts3cmTP22lEvI3WIx6UH4cLCbO9PrNdeTfjKphd+llOQyyKRVEndcj46w/F3KgUJR09Jon2YiTM6AtrWkxaoUqEDmFO+dotVAsGMMnKLgqNAxDUzD+Blc6MHN9Ab/LB8mO7vBb7WgW7L3/WTxRpU1UHHFx3Qz6doE4ashc6lEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716898; c=relaxed/simple;
	bh=MVK9BeYHvAOoRfQKzYtA768YXC95atMxl/kzYEyQkyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFF6zeOivUEffWXhfn/Vhcd5xmEKyOGJ5ZTRd57csScCB1iyjVZ6cluCaGKTXZ2YUAkI5tl5MzqKubcAMDIkKnZ6EmIPYHmEDWpt2zYOt2YOOwUbwYj3MA6KFkkCaeA3VtFkmidAxiwpcowQIVi52ChKNvjtbuyMGeYFGUcSVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hai204IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5246DC116B1;
	Thu, 11 Jul 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716898;
	bh=MVK9BeYHvAOoRfQKzYtA768YXC95atMxl/kzYEyQkyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hai204IJH6H7UzIVP0dFSls/fp5lKlW6LpAJF42esXf/V+/jYFf0cQg1pkYBrCZkv
	 riFU/Io8oLwkl0W0DwUGdKJedRaM4EeGyeb0oIKC9MyRKpGhaZoT8GwLAfVSpqkgT0
	 FnM+7a8yOBZdze98ziAimcUnn6W+627GVjSPO9EC5b/txXLOFNoVtlZLMfXpPIP6km
	 QE/VRwxMiN8oNIC2bZc7AgprWcIGNkSMxIAByZu0trZumOWO3UBrzK7V/+PNdnJrHM
	 mQ7V+8EvtVJx5JKTyEe42nDdCviwOEFbuutRkTpIPagiQZmFgChPSZ63q6VzxeMlSs
	 VT3Bc9Ogghb0w==
Date: Thu, 11 Jul 2024 09:54:57 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit: executor: Simplify string allocation handling
Message-ID: <202407110951.664B5E0E@keescook>
References: <20240710000220.work.852-kees@kernel.org>
 <CABVgOSnXgA20O9bHTUP8uwcMH3Wggb2Agjpc3MK9qQa0+oH_Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnXgA20O9bHTUP8uwcMH3Wggb2Agjpc3MK9qQa0+oH_Bg@mail.gmail.com>

On Thu, Jul 11, 2024 at 01:39:15PM +0800, David Gow wrote:
> On Wed, 10 Jul 2024 at 08:02, Kees Cook <kees@kernel.org> wrote:
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > index 3f7f967e3688..7191be9c4f9b 100644
> > --- a/lib/kunit/executor_test.c
> > +++ b/lib/kunit/executor_test.c
> > @@ -286,7 +286,7 @@ static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> >
> >         /* We normally never expect to allocate suites, hence the non-const cast. */
> >         suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> > -       strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
> > +       strscpy((char *)suite->name, suite_name);
> 
> This is broken: we still need to pass the length of suite->name. The
> (char *) cast, which is necessary to remove the 'cosnt' qualifier,
> stops the strscpy() macro from treating suite->name as an array.

Ah! Thanks for catching that. I do build tests with "allmodconfig", and
I saw the #include for executor_test.c, but didn't notice it was for
_builtin_ only...

-- 
Kees Cook

