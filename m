Return-Path: <linux-kselftest+bounces-27261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E7A4075B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B90319C2A8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50A207A03;
	Sat, 22 Feb 2025 10:26:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA144202C3D;
	Sat, 22 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220000; cv=none; b=Hvz1pTDs0FtUcTYeGjtDAOmUqfgMmrZDFpfIKKwB9j83oh83SurnXdiMPs1jM4wSX9fSs1R2PlTnOMeM/CqXJbm6TrjQdPnorMqs4aThK11ppwmUQvgtbdhN69IQrUe+Bjsf1hJ1+kerIGVNleWcL4GR/liPR0zB34opcKlxMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220000; c=relaxed/simple;
	bh=j5WzgqN4kOuCrsD8hHzHoKIHNrX5mXdR54X+4uHZzHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3wBZw20zfPXcsM6l8WleDM8L9V5CcQEsvX063LIEawEa1VZbDCroGGyI1etcdWwS/yV8cWUp5b2MYjj89Dp6xLDNeGYn3TGF9b8aPG2XHmb5J3OlPOPoZdIpXPftddb9mFo8yUXQW2adKTlTsSuyDicMGuNQ4njToLKWjBg7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51MAQQUb014866;
	Sat, 22 Feb 2025 11:26:26 +0100
Date: Sat, 22 Feb 2025 11:26:26 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Message-ID: <20250222102626.GB13708@1wt.eu>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>
 <20250203143640-70c59c53-af45-40cb-9a52-6395b3fdd263@linutronix.de>
 <937c99b3-3837-4510-be65-4eca3b280ce2@csgroup.eu>
 <20250203165859-8af1246b-6dd8-468a-8e05-68c7b0cad304@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203165859-8af1246b-6dd8-468a-8e05-68c7b0cad304@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 03, 2025 at 05:14:37PM +0100, Thomas Weißschuh wrote:
> On Mon, Feb 03, 2025 at 04:43:22PM +0100, Christophe Leroy wrote:
> <snip>
> 
> > Do you have any plan to get it work with nolibc for all test programs in
> > selftests/vDSO, not only the standalone x86 test ?
> 
> Not directly as next step. I am focussing on some other work which will
> integrate (vDSO) selftests with nolibc slightly differently.
> However if you have interest in converting the tests now, that would be
> great and will also be useful for my future changes.
> The current issues I see:
> * Missing architecture support in nolibc (should be fairly easy to implement)
> * Missing kselftest_harness.h support in nolibc (I'm working on that)
> * Maybe some users want to stick with their regular libc
>   (Nothing should prevent that, but the mechanism may need some discussion)

BTW, I wanted to thank you for this work. Originally when I started with
nolibc, I thought the vdso was out of reach due to the many missing
definitions. Turns out you were braver than me ;-)

Cheers,
Willy

