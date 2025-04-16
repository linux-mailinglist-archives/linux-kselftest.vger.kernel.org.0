Return-Path: <linux-kselftest+bounces-30944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08CA8B664
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81D3189D6DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD2723814C;
	Wed, 16 Apr 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jdQgAJ8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kB8hYdt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22580241C80;
	Wed, 16 Apr 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798008; cv=none; b=bp+Nd6wycY8CMrSgn2V3/Z8D/jCZsH2xr0dhDCvv+bq5cs+dgEPW7I9KJGFUbjQViytTx86FCCoo5LJGv9Dexen+8IBLRf1taz8qN1Vdxxstj1UINdQsQk7fo/+galXQtfsfcMr9y/oiM5dP77iW6pf3+5cojTsAk2hlb3PDbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798008; c=relaxed/simple;
	bh=J0J03S0MuI1xf1hk5FMRg1X2vPocAhPeGyoONKYbtl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRZxnlxmmyWkXxu5H+5y0GptG29R7cVO9DUQs0m3N8E5BPdnN4lOj/cZR92xD+u5KQ4po9QaAOGGPbuf8XlVB71ZmnZ+/h+z0/wxns+Oh97VnmAHH1RhE8j3xXs6Vi/nKWg/nZsKSa1IpnhRzz5wDlWjPr8pJFt19JfIDi+nRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jdQgAJ8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kB8hYdt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 12:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744798003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vd82YYWzBKhYh/DSbHaOruA1iMgu4YMAxvJ6YF3SxgA=;
	b=jdQgAJ8Rp2H/sBZyCFfUwsF/Myo7fPxYiThM7QGvJE2osn5QW7+EKS2hbWqkAToBtOyGWe
	bh4duWyfd8e2nb8qN30oQTnVNS/V/fq3OTNWwQjbrP0PrzoXa9ifROC3tLdhZlzy0ojXhp
	vTapbU7v3u6Sb7LsP83G/Mt1leHupfZ+KkJ9VLJBKz5s1pevspuV4fmNRMGvIokiPHWOYZ
	/NjiG50Ddpip+B0NmLa7Y0od2KZj901xFSIy446ikHW/R71Hn3aYAFTXFYeTzuznme55hW
	lMszqTjTukS5wPoJlkKrzlpQvY4Gm+YyUWFbZrWNgOcnXMJBUlllufBdxvtM/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744798003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vd82YYWzBKhYh/DSbHaOruA1iMgu4YMAxvJ6YF3SxgA=;
	b=kB8hYdt7ou+sPmXp6T+YUkvBfl0GolQVC1nVJOsb+6wOKbbi2k3b529PguGdIHNkRRqPHC
	r137fUTRkQjPbeCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: qemu_configs: Disable faulting tests on 32-bit
 SPARC
Message-ID: <20250416120254-182b9ffb-746c-4bd1-854b-8a2d8ca3c5b2@linutronix.de>
References: <20250416093826.1550040-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416093826.1550040-1-davidgow@google.com>

On Wed, Apr 16, 2025 at 05:38:25PM +0800, David Gow wrote:
> The 32-bit sparc configuration (--arch sparc) crashes on
> the kunit_fault_test. It's known that some architectures don't handle
> deliberate segfaults in kernel mode well, so there's a config switch to
> disable tests which rely upon it by default.
> 
> Use this for the sparc config, making sure the default config for it
> passes.
> 
> Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
> Signed-off-by: David Gow <davidgow@google.com>

Thanks!

I am wondering if this should instead be done in lib/kunit/Kconfig.
Not all users of kunit are guaranteed to use kunit.py.

In any case:

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
Tested-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

FYI the usercopy test is also broken:

[12:05:43]     # usercopy_test_valid: EXPECTATION FAILED at lib/tests/usercopy_kunit.c:209
[12:05:43]     Expected val_u64 == 0x5a5b5c5d6a6b6c6d, but
[12:05:43]         val_u64 == 1515936861 (0x5a5b5c5d)
[12:05:43]         0x5a5b5c5d6a6b6c6d == 6510899242581322861 (0x5a5b5c5d6a6b6c6d)
[12:05:43] legitimate get_user (u64) failed to do copy
[12:05:43] [FAILED] usercopy_test_valid

I can send a patch for that later,
but if you are on it anyways that would work for me, too.


> ---
> 
> Another quick fix to the sparc qemu_config I noticed while testing [1].
> 
> ---
>  tools/testing/kunit/qemu_configs/sparc.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
> index 3131dd299a6e..2019550a1b69 100644
> --- a/tools/testing/kunit/qemu_configs/sparc.py
> +++ b/tools/testing/kunit/qemu_configs/sparc.py
> @@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
>  
>  QEMU_ARCH = QemuArchParams(linux_arch='sparc',
>  			   kconfig='''
> +CONFIG_KUNIT_FAULT_TEST=n
>  CONFIG_SPARC32=y
>  CONFIG_SERIAL_SUNZILOG=y
>  CONFIG_SERIAL_SUNZILOG_CONSOLE=y
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 

