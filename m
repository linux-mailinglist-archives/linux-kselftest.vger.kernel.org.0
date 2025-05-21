Return-Path: <linux-kselftest+bounces-33464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF1ABF681
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E004E8481
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC638385;
	Wed, 21 May 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jFXO8i7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150F4A3C;
	Wed, 21 May 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835147; cv=none; b=lzxkvwg2UdMv+VB8dMCM7rwczy1B/gdmNwMicCb/1Rwq/GRlr752YQ+taPpT1yLWd0RgC0qoblJCzQL8EIz9M0wt95WT56oNtPJ0O3BU7UqEKTHn70J8gVnV5W7zrm7+2w9C5HnrUoCczRmi6f2aAsR/hRlrR9SwXXibmE4gvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835147; c=relaxed/simple;
	bh=hx9EAyMNBqoj/aG1NmgHhN/MjwuVyWn7maaU7B7ayuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA9RZxQxGA3XG1xjX22OLgE2LZYvJ1XOVnu33SAZElrB99FoPv2qubPE6WMnK7b5CcrKXOLMZZY9O77tquv7Q8hhGjJadEWhir/8DPR1TpxBeBL1Q8tL3hzv1NMbiIub8CBBORLCkpdUREf8dr5vu8Px/2c3g9k0vV0fqgDl/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jFXO8i7Z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747835143;
	bh=hx9EAyMNBqoj/aG1NmgHhN/MjwuVyWn7maaU7B7ayuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFXO8i7Z7jC48u8qWZRrNqVJtjA9N8sr2YcLKGWhMrWSQ/OPiJMB4j7B4/Rjebmu6
	 ELu826BpMc18fIvPyzP/xXSMB4H5AY89zvvHmgb6SOKlZHVH+QDVneBWd9ccIhn1IY
	 lcf8qIuSr/PNo7aYbvSV5K1SX+BfgjWp32wuGUOY=
Date: Wed, 21 May 2025 15:45:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
 <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>

On 2025-05-21 14:22:30+0100, Mark Brown wrote:
> On Wed, May 21, 2025 at 03:08:05PM +0200, Thomas Weißschuh wrote:
> > On 2025-05-21 14:03:37+0100, Mark Brown wrote:
> 
> > > > +/* make sure to include all global symbols */
> > > > +#include "nolibc.h"
> 
> > > assumes that the nolibc include directory is in the include path, or
> > > otherwise set up with a -I path, previously you just had to include
> > > nolibc.h with the includes that are there working due to being relative
> > > to nolibc.h.  I'll send a patch for the arm64 tests.
> 
> > Thanks for the report.
> > Inside sys/ this should actually be #include "../nolibc.h".
> > I'll doublecheck all of sys/ and see why our new header checks didn't
> > catch this.
> 
> Ah, you expect what's currently there to work - good.  I noticed that
> the vDSO tests had a -I for the nolibc directory which made me think it
> was expected that it be there, it's the only user on most arches.

The -I is useful to compile applications without guarding the system
includes with #ifndef NOLIBC.

What do I have to do to cross-compile these selftests?
I get various compiler errors.
Or you could run your testsuite with the new nolibc for-next branch
which should be fixed now.

<snip>


Thomas

