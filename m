Return-Path: <linux-kselftest+bounces-4812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B38856D9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF6284CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369D139590;
	Thu, 15 Feb 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n5jF2kOw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNYC7ovG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n5jF2kOw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNYC7ovG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B6136983;
	Thu, 15 Feb 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025019; cv=none; b=BlK+UHtnClfrth+pklDxMD+0smi9sOPemE0AWOMC7xSVAZ4dg3gH7QRUkx8O+XZ/3zndvfaosNcvLZ+pmMQnGnypctxxtsJkojAR3cwKSwRJWe1PrgXxOb5B0lpZ7ZwM/LZro1NIoJMcoChUoPWqZnAiW8hnnHWTIw+rSAhxOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025019; c=relaxed/simple;
	bh=5FzjDGGdF/LEJ1+yyKQUEfGfpUmI8UPYzcH+PLbeksU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTqw9bX+uKMx3BDwSgY2QTWeWrHy+2tOg6D8uXVfIN251CnHFaqWCXazI1F5zfAl/L70Fa6skdJtrMxx8qpgTX/mEU0O38KQD8H4nESw9o7odqArRTGQ9x+WQ3azHC8UfQZQvt1IziH0tsXiKraTPgCXRe2cRX5jD4TradmwiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n5jF2kOw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNYC7ovG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n5jF2kOw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNYC7ovG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BE6E1F8C5;
	Thu, 15 Feb 2024 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708025015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6fwskS/XeiRHwRWUxIzXg8lpFOjokK1ZaMlxoJ2Js=;
	b=n5jF2kOwc96NXtoFvQ1Hkh5Mh9MbyJm7BrMp6hp76bEoK8o/S4LqzLkHiyIhIEVMNzXUFE
	Eb/Im8zINT9e1syoklSHnFRaYWvyaIZhsPI3q6pvMa3WE7L94HAIVaK48VGnnbgC4X0Bbe
	JRwG8uVPISOsNDaIPHr3Y4BTpxbFi2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708025015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6fwskS/XeiRHwRWUxIzXg8lpFOjokK1ZaMlxoJ2Js=;
	b=LNYC7ovG2ARcRpqnpuw0r2PZgT8nAQqOgtZ39N0lUO4LMO3/EH/MNGCYdmsfbaUrBbyQ2M
	O+ABg1wn8TZxNiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708025015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6fwskS/XeiRHwRWUxIzXg8lpFOjokK1ZaMlxoJ2Js=;
	b=n5jF2kOwc96NXtoFvQ1Hkh5Mh9MbyJm7BrMp6hp76bEoK8o/S4LqzLkHiyIhIEVMNzXUFE
	Eb/Im8zINT9e1syoklSHnFRaYWvyaIZhsPI3q6pvMa3WE7L94HAIVaK48VGnnbgC4X0Bbe
	JRwG8uVPISOsNDaIPHr3Y4BTpxbFi2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708025015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6fwskS/XeiRHwRWUxIzXg8lpFOjokK1ZaMlxoJ2Js=;
	b=LNYC7ovG2ARcRpqnpuw0r2PZgT8nAQqOgtZ39N0lUO4LMO3/EH/MNGCYdmsfbaUrBbyQ2M
	O+ABg1wn8TZxNiBA==
Date: Thu, 15 Feb 2024 20:23:34 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Nathan Lynch <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: powerpc: Add header symlinks for building
 papr character device tests
Message-ID: <20240215192334.GT9696@kitsune.suse.cz>
References: <20240215165527.23684-1-msuchanek@suse.de>
 <87cysxilr5.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cysxilr5.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[lists.ozlabs.org,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,vger.kernel.org];
	 BAYES_HAM(-0.00)[30.55%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu, Feb 15, 2024 at 01:13:34PM -0600, Nathan Lynch wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> >
> > Without the headers the tests don't build.
> >
> > Fixes: 9118c5d32bdd ("powerpc/selftests: Add test for papr-vpd")
> > Fixes: 76b2ec3faeaa ("powerpc/selftests: Add test for papr-sysparm")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  tools/testing/selftests/powerpc/include/asm/papr-miscdev.h | 1 +
> >  tools/testing/selftests/powerpc/include/asm/papr-sysparm.h | 1 +
> >  tools/testing/selftests/powerpc/include/asm/papr-vpd.h     | 1 +
> >  3 files changed, 3 insertions(+)
> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-miscdev.h
> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-sysparm.h
> >  create mode 120000
> > tools/testing/selftests/powerpc/include/asm/papr-vpd.h
> 
> I really hope making symlinks into the kernel source isn't necessary. I
> haven't experienced build failures with these tests. How are you
> building them?
> 
> I usually do something like (on a x86 build host):
> 
> $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux- ppc64le_defconfig
> $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux- headers
> $ make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux- -C tools/testing/selftests/powerpc/
> 
> without issue.

I am not configuring the kernel, only building the tests, and certainly
not installing headers on the system.

Apparently this is what people aim to do, and report bugs when it does
not work: build the kselftests as self-contained testsuite that relies
only on standard libc, and whatever it brought in the sources.

That said, the target to install headers is headers_install, not
headers. The headers target is not documented, it's probably meant to be
internal to the build system. Yet it is not enforced that it is built
before building the selftests.

Thanks

Michal

