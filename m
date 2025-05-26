Return-Path: <linux-kselftest+bounces-33797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33734AC414D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D7F189A45C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931EC20FA81;
	Mon, 26 May 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FaoY7DB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481620F089
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269376; cv=none; b=R5H9ggvCfZq65TK+SewCuvekle6C1LfOcKBG8/fpDwEBL3BCxohFTC5mDBRF1T4xH58w28LDODvtD7KchiK3X1lSEooR+kMigzRKwdyPxTIYdl2Ao1njPmvLuZ+t9H8laP9BhlwspYVQyzutv5UL6VXSfNivrfpIMeDt0Cyf10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269376; c=relaxed/simple;
	bh=6tyZzFxwTEh7vwm56WBVSH9nMTmVdJ60mb2zHCZCeHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu3R+1pdcWGGwkJxhtwJX/VE6qGQhfbFz2vMfSyxY7vMIPxaecvJY2rNUS/o1kY2FLEVCbhY3WA9n51KA/JRPONJAnijQ9XZRgJpGMp6KfxFkHBbaswdwvm3hAwo4K2Eheh7AOqgYTNnX5ujyt9qKKfzHPTMrqZzIHtJqL8m2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FaoY7DB1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 May 2025 16:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748269372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0jJ419c9TQJYpt8/HdhSjujvIg2qtT/0uU4zHv/OUs=;
	b=FaoY7DB1eb92OEvQEM/Bd7zXr+LKpNn5fDIEF+n85ZBimrjFNJtDAzEZeyRmRRIKbtYMIu
	3Lua8ADw9+04wDepr/JB6P2UcyTOu3LimORzN64NY/wEbgmOgJzMoV7n9aTrhE7SJhe/4i
	IkawBw03qS5psCUQt3sj5cilOvk9FlA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 10/11] kunit: uapi: Introduce preinit executable
Message-ID: <20250526-woodoo-hoatzin-from-tartarus-538641@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-10-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kunit-kselftests-v2-10-454114e287fd@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 09:42:47AM +0200, Thomas Weißschuh wrote:
> UAPI selftests may expect a "normal" userspace environment.
> For example the normal kernel API pseudo-filesystems should be mounted.
> This could be done from kernel code but it is non-idiomatic.
> 
> Add a preinit userspace executable which performs these setup steps
> before running the final test executable.
> This preinit executable is only ever run from the kernel.
> Give it access to autoconf.h and kconfig.h to adapt itself to the
> tested kernel.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  lib/kunit/Makefile       |  9 ++++++-
>  lib/kunit/uapi-preinit.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/uapi.c         | 11 ++++++--
>  3 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 1b6be12676f89cafa34f0093d8136b36f4cf5532..0e9a26d90bf4d5128e270ecaa8f3465f28da0fa2 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -12,7 +12,14 @@ kunit-objs +=				test.o \
>  					device.o \
>  					platform.o
>  
> -kunit-$(CONFIG_KUNIT_UAPI) +=		uapi.o
> +userprogs +=				uapi-preinit

as for kunit-example-uapi, please add a 'clean-files' definition:

clean-files +=				uapi-preinit

-- 
Nicolas Schier

