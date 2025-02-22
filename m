Return-Path: <linux-kselftest+bounces-27280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96AA40B15
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B246189F587
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12B1E7C24;
	Sat, 22 Feb 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql4uXnIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47E13A3F7;
	Sat, 22 Feb 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740250830; cv=none; b=LU7So4fjcTR0qAZU0Z+MfvEg0wQyRojJc6JNs4XH25pbejlfJNSUPLoIdHwYPa0N2+lVfkRDYLamh3+y9Q4GyWNMXJTS2njYqqBzs0avw6uAtMKFh/lCsrfyO84QGMXmqhamF9KjOoJDBNObpmot12w/77UiRt/+Tqska+H/nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740250830; c=relaxed/simple;
	bh=zWRtAtqNqzxiBe46ewrMrlO3cYmG11wRcuinLSkGivQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgRBcfEZHZBrbNd0+xDkihm5IwaSzW8ZbBrAzwbJmH/Yd+R6a17NVpP2e+Xk4KUMLlOSm6t3Asz9pxEleXpr6o3BeoQHoeHNQqgNbZoWcxz6GVsFQSfulRDaH/6JzlF+sSsT6n1GlOb38b5WYMKptpRFiF4ZiuaVRh2lp0srFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql4uXnIe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47200236004so31084291cf.3;
        Sat, 22 Feb 2025 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740250828; x=1740855628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mf3WLnT/uqvc4jU09LwEl+Y0jld6Kz+6VRNuRCDxgs=;
        b=Ql4uXnIe+qlLq1NqMFVjbIbxWSO+NE1vYf/05a2MyZgWd9ljAoeAvdbHILN3D1y0Sm
         YHCn/NYLdVIRjYdAAABu1m8otrELMKapu78WtDiVIfrCoXiJxr4W/atnJ6DUltNKU3cU
         s2awLoiWpYr9hbAZwvy5IqJl+c0aI2KkKDtK5JgnxCGGG+HqG646pXJ67BBz6a+WvXSZ
         cuACNWiJCLjvwMf/XTKie1DmxnbM88OfHAZM48pqgYm0fHgvR9AQJVSzx1Lugf31h4oj
         taPdBXwH7TxShcYJt9qx+MbG6tFK42hEObpNlI99G6h6k5u+FH7U9lY4NLdxvB4wb8hd
         KCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740250828; x=1740855628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mf3WLnT/uqvc4jU09LwEl+Y0jld6Kz+6VRNuRCDxgs=;
        b=GyCrpDngsrIH6eJVfhTzvJcZHfOC6sYkMjvbDbksr/z2OhBngUTPjWPgyO0d05Vv7Z
         rTi6LdMPmCmW2/kGeQ7XYgmMrR48tAjpAJxNR1AaWFYWaK8kQjU/SAIsdBZvOj3MSre1
         mlJzhU9wi/9pxexszo0+Q0TZwQlGBUbP3YV/mLPJI/wbt1C6gykwrm92Pbphe9S7wpoX
         kwMo8t5PO3Wyu81J1mIZapt41FaJSSBcqiQVvxDYsHO6hg7iK79R3pGmTB+sTXSijVMw
         u5dat/wyfiJqpDw8g4m9aReWG7nDG+FyGOq3S727wFcAD5wInrrjX+tPG1vGxwkjkCGh
         0qAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+wRPba2aTllGZx8PDlw0zzH9iPchxnyCl6J19SZ7Ki18HoG/J7GtuDdExDT4sp+5cXimpgnuVglZqYdA=@vger.kernel.org, AJvYcCXQfVMKfQfA0whY9LftNYtdFhOOF8fyQ4qwBr0NwSfxxJwaymt8ZvCH7k6607mi2zessMpxYI1CxJKWTVcu+cgO@vger.kernel.org
X-Gm-Message-State: AOJu0YxadGxSxHzrluHtxiYW8LkzjW+dDpWjw+e+kRWycNH22fP9HpjE
	u93mpQ1ASJXF7rrfoLjKPbN2ZV9mLQHzpij0z+HyKy35Ce6cDHTb
X-Gm-Gg: ASbGncuYIQC455Lh8dFtjK787hKzKnTp5GvDlgc3QlidyrSYoruzyXlEOE7GnuyVRNZ
	vS3137BMjpEOjksHWtB/voS0YACV7f1tFR2VeS9JcQ+aBoFgm7LgTV0yPgomOc0VAvtVXlwCjtL
	n9mATkaRHWGJ1AzITSyDZB4eb/Zaz9o7Qt3Lf3iwVRCYt8jLXAAHj4FWwgrcfrnrKMyg7x3/oH9
	qy8hFHEfwLW0T9Iv9u+SWmSV620TZwbABnY8sD2Ju0D2i8S5dAuP5xaMfktEGexXt0sPo1oZYtP
	OQk7YUQ3pSRlZtT5dDyV2OE=
X-Google-Smtp-Source: AGHT+IH3EYjDKPoQ/e0zJiaGtwJhz0k1Ov8NHAPdHjRC/le5ACQyzWR3UwrkNbfa/a8/mVoIaYX0Wg==
X-Received: by 2002:ac8:7d4b:0:b0:472:636:f60e with SMTP id d75a77b69052e-47222945029mr114554481cf.34.1740250827709;
        Sat, 22 Feb 2025 11:00:27 -0800 (PST)
Received: from localhost ([142.198.73.227])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471fdf8ac21sm60434901cf.19.2025.02.22.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:00:27 -0800 (PST)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
Date: Sat, 22 Feb 2025 14:01:13 -0500
To: ritvikfoss@gmail.com
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests/mount: Close 'fd' when write fails
Message-ID: <zshes4xtyir7zrrybeqj2amrxyctwqnuvx2tqyktv4vsfstxqi@pvdq2rb5m47j>
References: <20250222114709.50011-1-ritvikfoss@gmail.com>
 <20250222121249.50588-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222121249.50588-1-ritvikfoss@gmail.com>

On 25/02/22 05:42PM, ritvikfoss@gmail.com wrote:
> From: Ritvik Gupta <ritvikfoss@gmail.com>
> 
> 1. Close the file descriptor when write fails.
> 2. Introduce 'close_or_die' helper function to
> reduce repetition.
> 
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
> ---
> Changes in v2:
>     - Fixed formatting
> 
>  .../selftests/mount/unprivileged-remount-test.c    | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> index d2917054fe3a..41d7547c781d 100644
> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> @@ -54,6 +54,14 @@ static void die(char *fmt, ...)
>  	exit(EXIT_FAILURE);
>  }
>  
> +static void close_or_die(char *filename, int fd)
> +{
> +	if (close(fd) != 0) {
> +		die("close of %s failed: %s\n",
> +		filename, strerror(errno));
> +	}
> +}
> +
>  static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
>  {
>  	char buf[4096];
> @@ -79,6 +87,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
>  	}
>  	written = write(fd, buf, buf_len);
>  	if (written != buf_len) {
> +		close_or_die(filename, fd);
>  		if (written >= 0) {
>  			die("short write to %s\n", filename);
>  		} else {
> @@ -86,10 +95,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
>  				filename, strerror(errno));
>  		}
>  	}
> -	if (close(fd) != 0) {
> -		die("close of %s failed: %s\n",
> -			filename, strerror(errno));
> -	}
> +	close_or_die(filename, fd);
>  }
>  
>  static void maybe_write_file(char *filename, char *fmt, ...)
> -- 
> 2.48.1
> 
> 

Closing a file right before a process exits is redundant,
since the kernel will clean it up automatically anyway.
That said, whether doing this as a best practice is arguable.

Cheers,
Seyediman

