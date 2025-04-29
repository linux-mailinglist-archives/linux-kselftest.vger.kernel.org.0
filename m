Return-Path: <linux-kselftest+bounces-31953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EDDAA3B7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9091B66212
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FA274FDA;
	Tue, 29 Apr 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ld44qHS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726726B96E;
	Tue, 29 Apr 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965772; cv=none; b=aMNzX34YsPbRM+FyA2bwbqwJeu6DVWLqrB6lqg+0PK+kg7SUDPQ2I2Pr4a8xqzqImlSyakLMpxh8Uts/Hm0QzxYAXMXZ2gKfde3ogwg3G1l5AnedrYclIIGO81Nu5knfvTZi7EOPaGIFu/LmZdJ8Ao2eAyT6e7qX6u1ZtbGtsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965772; c=relaxed/simple;
	bh=qjz/+d76D08d/+B9irlBXawinqB7oHwGYPoV3VPiX7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXlTv3Ups0skoTB7P4SRee9PldSYJVkxPNJz0uUFBtIjhhjKv9GnHUTAlxpSJ/m1IgMzj/oHJUxgijlU0HeSfP0tbgmDHk2FbfgxA9G7ch5189fHgzcgYo6MOrEX8MVJ4KU162CIziBAkfsKl6CZxQM9dEZbhHP5EWkPGwoPCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ld44qHS0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=0StKhParhLRrtFAvHtrKFAnFIIOM13HGCeJplew4c7o=; b=ld44qHS0iU5vdBLxGj/rBHVQUB
	3LRP++FAV3qTVozVsM8GyKUAO5AfnTrMmK0K/nyL6B4wKPzdckINhFF24H5xk2RrWOO9SlUW7OEL4
	R30jRhneRj1mdwNfPEh2d82nF6zfW7l1z/ulpMcCy0E/iWdhy47i2FyVzEYFvHUDunEhlrCFjojV5
	dnGpAm2ns67AbLQhSyM/cm15mfKzHJRgATMVpI5hgpJIUyzl5TUF1OqFlDuByKmHDQ4hYU7fAMCqk
	v59NXfIB27cBA5isqz3qvlgxg7todSXWKPWRV0BrnQrumwQsprwRg20RI1aIPcgxSEWaUQ7whmxIb
	vIcAbm/A==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tS6-00000007j1J-2h7X;
	Tue, 29 Apr 2025 22:29:22 +0000
Message-ID: <c3333ef9-f266-4260-8f75-0da65bcff1da@infradead.org>
Date: Tue, 29 Apr 2025 15:29:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: kunit: add information about cleaning source
 trees
To: Shuah Khan <skhan@linuxfoundation.org>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <7104475f60568f6a580b03d84e61abe311d63e46.1745965121.git.skhan@linuxfoundation.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7104475f60568f6a580b03d84e61abe311d63e46.1745965121.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/25 3:27 PM, Shuah Khan wrote:
> If kunit run happens in a tree in which a x86_64 kernel was built,
> the source tree could be dirty.
> 
> "make ARCH=um mrproper" will not clean the x86_64 build artifacts.
> Running "make ARCH=x86_64 mrproper" is necessary to clean them.
> 
> Add this information to the documentation.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/dev-tools/kunit/start.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index a98235326bab..568e29aebd6e 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -39,6 +39,18 @@ can run kunit_tool:
>  	``make ARCH=um mrproper``, just be aware that this will delete the
>  	current configuration and all generated files.
>  
> +	You may see the following error if a prior build leaves behind
> +	header files which 'make ARCH=um mrproper' fails to clean:
> +
> +	"undefined symbol sev_es_trampoline_start referenced ..."
> +
> +	This is special case scenario when a prior x86_64 build populates
> +	the source tree with arch/x86/realmode/rm/pasyms.h. This header
> +	will not be cleaned by 'make ARCH=um mrproper'
> +
> +	If you encouter this problem, run 'make ARCH=x86_64 mrproper' to

	       encounter

> +	remove generated header files.
> +
>  If everything worked correctly, you should see the following:
>  
>  .. code-block::

-- 
~Randy


