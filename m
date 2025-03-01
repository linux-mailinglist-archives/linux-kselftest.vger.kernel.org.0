Return-Path: <linux-kselftest+bounces-27967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29FA4AC90
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C633F3B12B1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CC1DE3CE;
	Sat,  1 Mar 2025 15:30:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A61CA84;
	Sat,  1 Mar 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843046; cv=none; b=t3uo9rVqnvRehnOdXLvmIyeA1sOp9o7JMYSDgC4fmyvBcmxV7jXrpRNYWn9UrgNAugO9w4fNjKO4T9IH7PxIlf59Iq0BC+5hzLRRaZR873HVYfFeL3gMThK+b6476dT7u/auq2FYC+xixnreH/HbfnV3/+pXJD3oRKzGF9cDkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843046; c=relaxed/simple;
	bh=h0GB2+x0stPbXJCozdNGzjv39gFxdFrlUaiF6QxHjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6b0LsghiFZxIIjNGH/VWRWZTPFlWf/aBS6pzI4RK5r/PIp1rYBt55hWNDDiEmMG47++aEJJYv2KoH/jjV3haEXw6RZ+7i879sDdxAaEZOBhGF/JrMirDStrDO+7Gdc2QtgruFMayJgyzqhAd+sJNN5QkeJU9AF+TWGzkXEOQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 521BUpqu019047;
	Sat, 1 Mar 2025 12:30:51 +0100
Date: Sat, 1 Mar 2025 12:30:51 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 09/16] tools/nolibc: add limits.h shim header
Message-ID: <20250301113051.GC18621@1wt.eu>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 26, 2025 at 12:44:48PM +0100, Thomas Weiﬂschuh wrote:
> limits.h is a widely used standard header.
> Missing it from nolibc requires adoption effort to port applications.
> 
> Add a shim header which includes the global nolibc.h header.
> It makes all nolibc symbols available.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Works fine here. Pick any combination you'd like of those below ;-)

  Acked-by: Willy Tarreau <w@1wt.eu>
  Tested-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

