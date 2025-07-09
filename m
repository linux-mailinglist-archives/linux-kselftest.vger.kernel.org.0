Return-Path: <linux-kselftest+bounces-36839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46EAFEEE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7E61C44660
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3421CC43;
	Wed,  9 Jul 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NIp5ymGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130513C9C4
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079079; cv=none; b=dRobBqpqc9NDwxwAOcrZBksYEYF7JkdfLRU4d4vhgmY2l+5INkKz9tdP6kKLUI1BTioL5C+PGG6WLCzu/+psVLKcC3P/UkG4bGs8rdWAwcL1X6XG4u1xHUzfvG8svzlQQNF134/1HbYLrEs3qQYCL91YQDXQa/QG3DbooZFdXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079079; c=relaxed/simple;
	bh=I1BI6lOXdUW8UBJqE4tWHezfP0e8wijBYpG9E5ci3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQmmPjpLZJFWRX8ktjAMfMEzBEjqyBioq6OlpBsgalbm775KS5/PEZlDPCa4XJacRwou0VSwzWFE58+9HPMPEttC+MQ6JA8F02EbVYBknGSCy680AIZK1izBqaNmTcliFufFGLI8fyJI/86K6qs/B+KqlgYXvgnPH4IAusLmOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NIp5ymGI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752078479;
	bh=I1BI6lOXdUW8UBJqE4tWHezfP0e8wijBYpG9E5ci3K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIp5ymGIGE8Gd8uuzR+9shRJaKFuIyJAgJc1bB2uOqOBII5tUtFZGIZXXJmejpuvx
	 E0qZ1NklmAPE098lgvo/hXbWCHbHVRr+RmOWgtj8hWzO7E+CsxvbZQlwlwm0OJphnj
	 1jmnNMWGpa/bhb94FbbLJ7eXd54NNIf4e5quiKwc=
Date: Wed, 9 Jul 2025 18:27:57 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 1/3] tools/nolibc: show failed run if test process crashes
Message-ID: <93269df7-b638-4023-aa72-33a702897295@t-8ch.de>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
 <20250709155512.971080-2-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709155512.971080-2-benjamin@sipsolutions.net>

On 2025-07-09 17:55:10+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The logic would not catch if the test process crashes and would
> incorrectly report a "success" state. Fix this by looking for the final
> "Total number of errors:" message and printing "failure" if it was not
> seen.

Nice, I'll pick this up directly.

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/testing/selftests/nolibc/Makefile.nolibc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
> index 8cb65392fa10..51ba853dd97e 100644
> --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> @@ -245,8 +245,9 @@ endif
>  include $(srctree)/tools/scripts/Makefile.include
>  
>  REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
> +		/^Total number of errors:/{done++} \
>  		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
> -		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
> +		if (f || !p || !done) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
>  		printf("\nSee all results in %s\n", ARGV[1]); }'
>  
>  help:
> -- 
> 2.50.0
> 

