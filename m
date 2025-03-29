Return-Path: <linux-kselftest+bounces-29918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC111A75710
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9E16F01E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D841D5AA0;
	Sat, 29 Mar 2025 15:51:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67C249F9;
	Sat, 29 Mar 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743263484; cv=none; b=BWxQBtglDQ59grzaijF/CVZZCVq8TrPImArJ8bbsB8XhJAoyr3QzYPRDg9WxmMbxAajUoa0sgB1ANjwO0fEzbcD2PEBGwxfC6uZc4mGbi4iXNX05VnGryzqLdPMGwluZsl/sjwpR42wtGCdKTQ+DSgnSPOUcM14BHIGFKoA5wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743263484; c=relaxed/simple;
	bh=qhPImErkXT8AvoFaN3C4HhIKxwjrCem4qz4/hMbv2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0cDkCK0O3oo1Br38dp1E6l9a6RVHR3bpe2UvY3eFQFqLuPKyTSzpT2f+HuXwWVZDMWXP0av/9HvmDQ4K8Z1dK635m6CRX/3eXqnwpw8NCf2RM/TyUtmFaLwx0BiVWcyLybdU/ERBtS/hStW7n+9eLj9s4BiqNc5PEDNs1NaRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52TFhlwe011390;
	Sat, 29 Mar 2025 16:43:47 +0100
Date: Sat, 29 Mar 2025 16:43:47 +0100
From: Willy Tarreau <w@1wt.eu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH] selftests/nolibc: drop unnecessary sys/io.h include
Message-ID: <20250329154347.GA11338@1wt.eu>
References: <20250324-nolibc-ioperm-v1-1-8a7cfb2876ae@weissschuh.net>
 <76eb91c8-4c66-4e2a-8d32-f2e5d545bb74@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76eb91c8-4c66-4e2a-8d32-f2e5d545bb74@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 28, 2025 at 04:23:38PM -0600, Shuah Khan wrote:
> On 3/24/25 16:01, Thomas Weiﬂschuh wrote:
> > The include of sys/io.h is not necessary anymore since
> > commit 67eb617a8e1e ("selftests/nolibc: simplify call to ioperm").
> > It's existence is also problematic as the header does not exist on all
> > architectures.
> > 
> > Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> >   tools/testing/selftests/nolibc/nolibc-test.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 5884a891c491544050fc35b07322c73a1a9dbaf3..7a60b6ac1457e8d862ab1a6a26c9e46abec92111 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -16,7 +16,6 @@
> >   #ifndef _NOLIBC_STDIO_H
> >   /* standard libcs need more includes */
> >   #include <sys/auxv.h>
> > -#include <sys/io.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/mman.h>
> >   #include <sys/mount.h>
> > 
> > ---
> > base-commit: bceb73904c855c78402dca94c82915f078f259dd
> > change-id: 20250324-nolibc-ioperm-155646560b95
> > 
> > Best regards,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Fine for me as well.

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
willy

