Return-Path: <linux-kselftest+bounces-466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7BD7F5616
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 02:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E5C281626
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 01:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEB1C05;
	Thu, 23 Nov 2023 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6R7+z+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F634197
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 17:54:26 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbda959062so420347b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 17:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700704466; x=1701309266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5dzblVhwCJC6kOnlVa4igAEP9DZu5FsofVvttpT0BI=;
        b=g6R7+z+048+P5SGoqFdBnksuZWiZyjcspwtOURphutXWUN/zbVsvwRn7SrwGWX6/6r
         KbvOf9GDmHk5JVtjfewV6BC5x54XS+gg1yktF6bxkOOkGfvft92zWvOO9mNUo+1+AKKw
         vzt9eZh/7qAaA7vzpe/UCbLWmUcUsFaFo1p4vmHcpU6usdzjy7j+GODb1igIkp2WMXL+
         wEWdcN7Zosy5ePeOYyIShp2Xhb1HAXBiNs/bobEYyceKPNpkLeua8JfvMFLggbAeNAGu
         hEFrRQkJKLmeC3ZMHSWYucpoBq+DVVYHoK9XUJe2C0CV0CSJuFqYhMqu0zYE6QnOXGQo
         pSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700704466; x=1701309266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5dzblVhwCJC6kOnlVa4igAEP9DZu5FsofVvttpT0BI=;
        b=XFMo+dxPAW6fCysGQZ/0T56SBKctRvWNQJyFx4LyRcEX2GnsdmnarIcxSSiivvAqKi
         qQEwSp+2pHo76YFL+VBGVKQkylarMgAK645ey2vlFBsza4VB9t+2paKKhYB/56nkeQlC
         OI9kVYASUBqTfizRgNP0KXqLnLCIXgpSj5bZ2cBKE5V8oTVOvIt2zGhXq4oHac3aD1dd
         MeeHBwrPIo9LaqvDVPE1y5NuHSEpBojcxQxjhpalgu6HGYeqcckzHPeMk01j/A7+lVf6
         nf8c0PLgBH6hCQUu6l0NBd3c/bRMc13rr+U3ClA0ySx1TwfEQBXUiQoGoo2T9CjiIaXG
         WqLQ==
X-Gm-Message-State: AOJu0Yw7ckSoHljOBozkzml8seMSwuCwdzvULaE0iGraipjBMjywiCCk
	b9V/eCCZlddTuylhUSC5vpjQyKfo6bsj1g==
X-Google-Smtp-Source: AGHT+IFCXPdsWbv7ZWgUyFqgNtUZTy1lFDsIG+RGssIRMnVMueGuaOEYaY3hcHJ/WVafnEdbuCU+6g==
X-Received: by 2002:a05:6a20:8f03:b0:188:e61:f324 with SMTP id b3-20020a056a208f0300b001880e61f324mr4935769pzk.57.1700704466253;
        Wed, 22 Nov 2023 17:54:26 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a000100b002855bfa23e3sm449008pja.53.2023.11.22.17.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:54:25 -0800 (PST)
Date: Thu, 23 Nov 2023 09:54:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kselftests: add per_test_log support
Message-ID: <ZV6wziKnIs2jZfa2@Laptop-X1>
References: <20231102075017.4060991-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102075017.4060991-1-liuhangbin@gmail.com>

Hi Shuah,

Any comments for this?

Thanks
Hangbin
On Thu, Nov 02, 2023 at 03:50:17PM +0800, Hangbin Liu wrote:
> By default, all the test output will be printed to stdout or output.log if
> -s supplied. The kselftest/runner.sh also supports per test log if the
> variable per_test_logging is set. So add new option -p to set this
> veriable. Note the -p option is conflict with -s option.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/run_kselftest.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index 92743980e553..965220a314ce 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -20,7 +20,8 @@ usage()
>  {
>  	cat <<EOF
>  Usage: $0 [OPTIONS]
> -  -s | --summary		Print summary with detailed log in output.log
> +  -s | --summary		Print summary with detailed log in output.log (conflict with -p)
> +  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
>    -t | --test COLLECTION:TEST	Run TEST from COLLECTION
>    -c | --collection COLLECTION	Run all tests from COLLECTION
>    -l | --list			List the available collection:test entries
> @@ -41,6 +42,9 @@ while true; do
>  			logfile="$BASE_DIR"/output.log
>  			cat /dev/null > $logfile
>  			shift ;;
> +		-p | --per_test_log)
> +			per_test_logging=1
> +			shift ;;
>  		-t | --test)
>  			TESTS="$TESTS $2"
>  			shift 2 ;;
> -- 
> 2.41.0
> 

