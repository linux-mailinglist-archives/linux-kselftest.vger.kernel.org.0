Return-Path: <linux-kselftest+bounces-34151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F453ACBB07
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E2316CFD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724E1624E1;
	Mon,  2 Jun 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9mDuzE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734015E96;
	Mon,  2 Jun 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888346; cv=none; b=nVL6A5dl/Q3Wl3Y2pXjcOO36M/0HLtrKhp2BOfzeZc9AqJgzLqULdSHkbcjMa86eM5ZAejmv1/8gtV2g5bLS9OE8Nr1Vz5XJUyLyqcf3KV3+phWNsHn9R9nm7C+T5dHVC13fNncjOpkNWW05GGcwso82jbYDJGzg9sQvJDXdaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888346; c=relaxed/simple;
	bh=2oasVvl6DH7CI44BAtmn9xYVnrVzUp8Orzbu9CRPEr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqFym4bFkcIt3xZU0MI1ojcrti4XAgA1pjQ2WYN5ykVRWIZ7zSx/OSfpWVtMbH39SHYNiorKRK/iTwU+yuJwPYul5rlig5DfM0c/0FZ0BiLFELYrdlvPcHeQ4SciKBZ3d1DlSGCW7wxjEJQbb5rem7JBs5Ryqg0aTQEJSQIgtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9mDuzE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC5AC4CEEB;
	Mon,  2 Jun 2025 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748888345;
	bh=2oasVvl6DH7CI44BAtmn9xYVnrVzUp8Orzbu9CRPEr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9mDuzE14MJLaPAVcTzdtTu+XXMzmBlp2SaAeyEKFPgRUJD0L4y9hDMatglszqpzg
	 NmRYabmZJybi1U2UeFRZLzz4Cw8NVkMM2AIanQOO2DlqtmjCQ4G+VFvxO5a6j6MCnD
	 FvFbRBs7gze5LAVW1glgcD38SKPaQuANE6+rSQvKZ4e+JVeRCAARYNhlv29N29rY5U
	 4LEJocwz5tlWSKSRb7nWXOkkkQ9DcHwsiBkhq2VfKUzhpweo97UrpyU7S57UT/udcE
	 I3SfiheHV1TXz25I2xWt/Dds+fHRyXoiUf5ljCAp+EWvamS7Lt/Hre5JAzQobmwpIZ
	 z3JvGwCu4WRew==
Date: Mon, 2 Jun 2025 11:19:02 -0700
From: Kees Cook <kees@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/tests: Make RANDSTRUCT_KUNIT_TEST depend on
 RANDSTRUCT
Message-ID: <202506021115.82342FB9@keescook>
References: <22d9c2fa9e751a9de3c599aa082be588ea82a7a0.1748875640.git.geert@linux-m68k.org>
 <202506021107.EA2F1CBDB8@keescook>
 <CAMuHMdXN_1zwWuTGYuv4aH57cynsNA8443dbRgp+UTMzdvyLNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXN_1zwWuTGYuv4aH57cynsNA8443dbRgp+UTMzdvyLNw@mail.gmail.com>

On Mon, Jun 02, 2025 at 08:14:08PM +0200, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Mon, 2 Jun 2025 at 20:08, Kees Cook <kees@kernel.org> wrote:
> > On Mon, Jun 02, 2025 at 04:49:51PM +0200, Geert Uytterhoeven wrote:
> > > When CONFIG_RANDSTRUCT is not enabled, all randstruct tests are skipped.
> > > Move this logic from run-time to config-time, to avoid people building
> > > and running tests that do not do anything.
> >
> > I don't like doing this because it means that looking at CI output means
> > I can't tell if the test was not built or if the config was not
> > included. I want to always have the test available, but skip the test if
> > the config is missing.
> 
> So should we drop all dependencies from tests?
> Do you want Zorro bus, NuBus, ... tests (assumed we have them) to
> be built on all platforms, and "run" on all CIs?

I can't speak for those authors, but I think they are pretty different
from treewide instrumentation tests. As a consumer of CI output, I would
like to be able to always see this kind of test output. Sometimes it's
Kconfig settings (like here) and sometimes it's architectural capabilities
(as seen in LKDTM tests). If the test is always run and explains why
it has been skipped if it is skipped, I always get actionable details
without needing to do a round-trip with the CI runner, spend time
locating .config files, etc, etc.

-- 
Kees Cook

