Return-Path: <linux-kselftest+bounces-9046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD38B5E22
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21FB281D35
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC5E8288A;
	Mon, 29 Apr 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6RmxZrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F482881
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405959; cv=none; b=eLobgECAfJpQSm3Qas9STTKpLn7hei8vxeZDwI+doi0k+WwBzGmys6PnjJKxijnYbaIeEUVuEgKQ4N5DLco8qQIiW6tD/SPicQLtrA2wbmNH2dcSIBY6c49oK+F4uUqXSaj95SgPjlUbPXo2D2PM1PWqKYKqeYBtwLVjYY9NjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405959; c=relaxed/simple;
	bh=ZGroGLVCIbK/w2kt3vda3NvOtFQm8DNYiuqe1a85j7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLSZ8hVr2MZUEkuICPgyrRY/dLFz4Z51BMvUsE1EMA0BaH+rdd0HYRy5V2h4y3/a1CUMEezGgsA4pbEqhS3lTksEevmNiDLxf2kUCm0xQJEq2cj22M/G7/Wg/7apc8+nu+LnpkefIHiUaEjZ3lMBjTASnpWKmlrnHvnChPz56BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V6RmxZrh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee12766586so3474477b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714405957; x=1715010757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gima1jfCICeyQJgLxFU9qZsAD6bEvLHMP34ZgzB6Ps0=;
        b=V6RmxZrhZWKzVig5HYsP2yF9HZMG45HYF7j3aS1InQHCmcJUL34YQcHolJIS/ddpmn
         FUMOlIRq81A8Pi4fnjNglddQRmZi0GdYVLQ6QQqis3bOGEyBQvGc8hzDEsQu+qkuVHjn
         3n0AEFHhLLzMkQT3kzRQHa9qx08kD3VFy5Svk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405957; x=1715010757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gima1jfCICeyQJgLxFU9qZsAD6bEvLHMP34ZgzB6Ps0=;
        b=rn4QYX657BaC8YIOLzQBwJuWoE23ZC6A/cAx0fxuvnLDZ3FxhCufl/suN6WTOiCCek
         VNBQHvHUCGB0wdUmhtuBSjUseQHv3HRTC13D6PFPEd4x2euE8c8SdExUzLXMRaUmIbul
         oUEmHJBKKpmgRCjwJxbL8uZRdT1k6HADWun/HDb/m79MbXIUdb9WV+PEHGVKIZOfrt3R
         kU8lPwCDxovif5GX9v4BakLspJ6QQK1FPHrqWTgcQXMtNdbFXvfxG4Zw4KNoJI7JxUOC
         /5p3bYidaD+B5WZCUUzmoERjxBGeKpc/9u1Ed8KFGR8rvzSiQJudgCDaGXGsCqxivPoq
         TRIw==
X-Forwarded-Encrypted: i=1; AJvYcCWMN6Z2/qHGDn6neIEXBJ0RKRH1URBWiWDXO7fH3357zwcIEH8+QsgB2EL9ha1A+ub0AweWC1QWxG6r7PGwLybD89X75grDtcwtLX6g4PWI
X-Gm-Message-State: AOJu0Yw92QnHuCs2qUfc4wyA0NhW+iB459yDiCvk2lWYDaZcv/Jj2pw6
	SBsSQUZLfpXS8ExkQMtYLVt8eAe5TgtUS64rPhY7KW42YD+mOecYJQK7UpiRsA==
X-Google-Smtp-Source: AGHT+IGz0OVF8FOBG5ad2HJpYX+iCqoilEeanBPBnxJEQfuJZQ8o1+SlNlPpuioodO7c78+X5jYWEQ==
X-Received: by 2002:a05:6a00:4b10:b0:6ed:21d5:fbdb with SMTP id kq16-20020a056a004b1000b006ed21d5fbdbmr63495pfb.8.1714405957544;
        Mon, 29 Apr 2024 08:52:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006eceaccaec9sm19364854pfb.131.2024.04.29.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:52:36 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:52:36 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <202404290852.C327596A@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-5-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:26PM +0200, Mickaël Salaün wrote:
> Fix a race condition when running several FIXTURE_TEARDOWN() managing
> the same resource.  This fixes a race condition in the Landlock file
> system tests when creating or unmounting the same directory.
> 
> Using clone3() with CLONE_VFORK guarantees that the child and grandchild
> test processes are sequentially scheduled.  This is implemented with a
> new clone3_vfork() helper replacing the fork() call.
> 
> This avoids triggering this error in __wait_for_test():
>   Test ended in some other way [127]
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240429130931.2394118-5-mic@digikod.net
> ---
>  tools/testing/selftests/kselftest_harness.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 55699a762c45..9f04638707ae 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -66,6 +66,8 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>  #include <setjmp.h>
> +#include <syscall.h>
> +#include <linux/sched.h>
>  
>  #include "kselftest.h"
>  
> @@ -80,6 +82,17 @@
>  #  define TH_LOG_ENABLED 1
>  #endif
>  
> +/* Wait for the child process to end but without sharing memory mapping. */
> +static pid_t __attribute__((__unused__)) clone3_vfork(void)

Why "unused"?

> +{
> +	struct clone_args args = {
> +		.flags = CLONE_VFORK,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	return syscall(__NR_clone3, &args, sizeof(args));
> +}
> +
>  /**
>   * TH_LOG()
>   *
> @@ -1183,7 +1196,7 @@ void __run_test(struct __fixture_metadata *f,
>  	fflush(stdout);
>  	fflush(stderr);
>  
> -	t->pid = fork();
> +	t->pid = clone3_vfork();
>  	if (t->pid < 0) {
>  		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
>  		t->exit_code = KSFT_FAIL;

Regardless, yup, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

