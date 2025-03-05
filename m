Return-Path: <linux-kselftest+bounces-28299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4CA4FAE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DC416CDB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A4205ABE;
	Wed,  5 Mar 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ay0jmRYT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC0205507
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168568; cv=none; b=bX27KbrdrjqE5sIKnmK4zJ1wQ64X7Zc6rBvMg0S5QcpXq7OCKRcsVa6Idq+Xie10PJTLtAJj5M3xEL6yMVLzW9m9nYwNvx9GAva0RpyAL2c59IcQgjmAbRB3GRBHKuZWwT68jJjTtB5cDD408mfyxG3PcGpaLYltRc99Dla0GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168568; c=relaxed/simple;
	bh=lKqS/mAvx4HVq33Hmdz699WevQkr9nXw23GBMPTSQaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdSTiW4aNR2WDCemgY4b2VRpJwGQa7srvmhuXbsv2ZLNXhbdnBNessbMmrpLoJYRgvG5qN3sJYNrklFjCVrDhp39rtrH0Hcw6o9ZU6KDD5h1HmPNMnNfwLVn0rWp6ol4OxGP5hkYjgde4Q85gglDe06+FKYUF1cP/7ivtdXbVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ay0jmRYT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so30321085e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741168564; x=1741773364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkxl4a4YQVJ31Qn6F9vVuT6sik+nqtnuunl+H2yyS6k=;
        b=Ay0jmRYTWrsl4EYGmT2NWlDmaxS2LENcQf3c6N1UV//uwak0kMRe9fBbxXnaEXnjAB
         MIC+2nvZAOR256+ZlA+uJAj9pe1aB4GmP0iusOBKRZuCaxsbyTyd738N5fAnvYTnse8Q
         LjF384av2iHSOp6e/HAOe6iAI48zxCTKuG5I94LGIeCIA5Z2h1AlHQcOAJccNvjYXzQ+
         6yyjgndL8gtq09OZPyU7o9Zvjqeem5ttUjHUEoWN/HVvqayS9t2JrhrjoYmHE7kU4xUN
         +a2Ocl3Za1WNRDMie1mukCL8ZALNnN2f/WJvw9isvN2t6eKbeJGF5DhhxfUr5WHQVg0L
         Nnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168564; x=1741773364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkxl4a4YQVJ31Qn6F9vVuT6sik+nqtnuunl+H2yyS6k=;
        b=W75sdWFovv8CIhh5u71DGgy1YqX56aSmzO3IX2erx5C8mLL175OXxYo8KXElugKxYk
         F84QV3YHmsUqNqkAC6wc4SdGB92wxwVDZ2tvzZZRdtQdO4edLbwuZ0SFqNbNfA70VJTR
         4oLifP9nePARKql1QAA+jWAuSxd6rDVDDzEt+HRH1rQBBrfz6u6Mg1g0F5SCtJJLIaiv
         YEYR6A2tRtPt7rFLafbWRzbSaym9TBQWNDtCQDKkrJyHwZ8GrFslLTGyynRf5jLOBs9w
         aqWPgBjsrPmmzCCIx4uOMRnhmU4+/paNld7a+9BVjRJ1U5orOLQmWn7lD5LEFSxEdpEH
         jAAw==
X-Forwarded-Encrypted: i=1; AJvYcCVP5fk3qxwRkdCkrBk2NPuSdxxPlwtzU75CAfx+jVyOYmrGot6+92lTQBEmJmI6RraFDC7Ar9PVc2DUVNKDWiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBvxKbmgY/Xlgd+nhJnyJsP2U8Y7nW8GiU0MxKZFSUXTsNZWg
	oqfIChqx8AzQ8rbTCWhDYZCxKtY7ZdvAyo6oBqngigKa1+myyOAQcwzooMpuF3E=
X-Gm-Gg: ASbGncvWly0uwlnElU2xA5/tOlbgPiQdTGxa2Qnra2Jokxdj7PeunnskaZVLZtcgvTj
	15O+gHLd/qn4mKdH28eFHI4zt2OgDg9vgscG2WUp12LdXs990xq9j17pBsl7hjWYBcjq2e/iSHu
	GdzYuOeTlMLKCmJY2wtbFP4D4/uplS0yOLrU1umS+Pp4s/U+sC7/uT63F9uf/rpZqgFaSGVr1EG
	5BwoGhsYgULmTg4aAeqnhHypi9jOdgl5x7Eg5YSykevp4V+vIQdkHZU0hn+LxdW4b+LATeNI2EG
	IzShvX3/XNOjlynGhIjhXfPVqdGMb4WiTwTb70eSfJ2hZdI=
X-Google-Smtp-Source: AGHT+IFavas8h9Jpgn+Nt6h5D6vRmK+7QGtc1IeskIoqBgpTaq4AuCMVrXevu5HZeem2ji3RiSe5Tg==
X-Received: by 2002:a05:600c:190f:b0:43b:cbe2:ec03 with SMTP id 5b1f17b1804b1-43bd2aeaa86mr15746195e9.27.1741168563908;
        Wed, 05 Mar 2025 01:56:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844c0dsm20059607f8f.80.2025.03.05.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:56:03 -0800 (PST)
Date: Wed, 5 Mar 2025 10:56:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/4] scanf: implicate test line in failure messages
Message-ID: <Z8gfsd5V9wrPKkiA@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:19:58, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/test_scanf.c | 66 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/test_scanf.c b/lib/test_scanf.c
> index 44f8508c9d88..d1664e0d0138 100644
> --- a/lib/test_scanf.c
> +++ b/lib/test_scanf.c
> @@ -24,12 +24,12 @@ static char *test_buffer __initdata;
>  static char *fmt_buffer __initdata;
>  static struct rnd_state rnd_state __initdata;
>  
> -typedef int (*check_fn)(const void *check_data, const char *string,
> -			const char *fmt, int n_args, va_list ap);
> +typedef int (*check_fn)(const char *file, const int line, const void *check_data,
> +			const char *string, const char *fmt, int n_args, va_list ap);
>  
> -static void __scanf(4, 6) __init
> -_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
> -	int n_args, ...)
> +static void __scanf(6, 0) __init

This should be:

static void __scanf(6, 8) __init

The zero (0) is used when the parameters are passed via the va_list.
The value must be the position of the first parameter when they are passed
via the variable list of parameters, aka (...).

Otherwise, it triggers the warnings reported by the lkp@intel.com
kernel test robot, see
https://lore.kernel.org/r/202502160245.KUrryBJR-lkp@intel.com

Best Regards,
Petr

