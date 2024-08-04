Return-Path: <linux-kselftest+bounces-14779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690F946FBA
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D322B20E3A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64974424;
	Sun,  4 Aug 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TcvsdE2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC13BB32;
	Sun,  4 Aug 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787183; cv=none; b=YZxDFxK2qPsXgLTct/sQebaAOuW44XJBE/3Op55hUJws5snlw6OeijX049fFmkmIpaEiGfpgCrRPgilQckNXDpjn+JOyHIR6AVKA1BMo+UWTeuRzn6TeY8KyExZnzmJHA8QHwQsbb2So8TFhBbbca5kJd/8ANef5IdzmDcKBtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787183; c=relaxed/simple;
	bh=icHrCmaReSdn3RUMzEBKCUOhA8rfPg3hShtqhlc36rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd2iIMpng6/76e3BHuUWHhr2ff1hXbTiPhCYFwCD9JknxGRX/Zxo6+IXqJCCdey4pIBR5qUDJ7oG3dg9UF6H6WaiyoxJKrNbOZ9zJqJt/uuFX+JynHAI2BA64b+H/x/0bHUTgp/b5d6lBA5wSHXIdRq9/0RDyuDsI7hOnDFuWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TcvsdE2t; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722787178;
	bh=icHrCmaReSdn3RUMzEBKCUOhA8rfPg3hShtqhlc36rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcvsdE2te6ouj4c90AkAZNxLKNA4iE9/U7sedh6QcmJP+sKD/5uad5hph11Nk5/8M
	 8Ftpf4LKxmVbog8+FYMDsYWcqB+TNMEZTdxhk0aYY/vpFNCY1MHnJ3ZlY/FWqzFMBa
	 0irmLfSwCU9ISgQ7whXa5tFP0wjppxNuLHl4/GPs=
Date: Sun, 4 Aug 2024 17:59:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] selftests/nolibc: add support for LLVM= parameter
Message-ID: <911336fe-0f5e-40fa-ba50-ce982d69f8ba@t-8ch.de>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-9-bc384269bc35@weissschuh.net>
 <20240803094530.GE29127@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803094530.GE29127@1wt.eu>

On 2024-08-03 11:45:30+0000, Willy Tarreau wrote:
> On Sun, Jul 28, 2024 at 12:10:03PM +0200, Thomas Weißschuh wrote:
> > Makefile.include can modify CC and CFLAGS for usage with clang.
> > Make use of it.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 8000bc3c408b..cdff317c35f2 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -155,6 +155,9 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wex
> >  		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
> >  LDFLAGS :=
> >  
> > +# Modify CFLAGS based on LLVM=
> > +include $(srctree)/tools/scripts/Makefile.include
> 
> I'm confused, doesn't it precisely undo the previous patch, which
> said that we ought not to include Makefile.include as it makes it
> harder for LLVM ?

The previous inclusion doesn't make it harder.
The problem is that Makefile.include does two things
1) objtree setup and 2) LLVM handling.

For 1) we want to include it as early as possible, necessarily before
using $(objtree).
For 2) we need to include it after "CFLAGS ?=".
Reshuffling the Makefile to satisfy both requirements will look bad.
So the first commit removed the usage of Makefile.include for 1) because
that is easy to do and the second commit includes it later to satisfy
2).

> If so, I suspect that both commits should be squashed with a better
> explanation for both operations at once (e.g. maybe "move makefile
> inclusion later to benefit from LLVM=..." etc).

Ack.

