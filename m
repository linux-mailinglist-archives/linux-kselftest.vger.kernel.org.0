Return-Path: <linux-kselftest+bounces-1517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4F80C61E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990EB1C209A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF82230A;
	Mon, 11 Dec 2023 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZIeWV9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A1AB
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 02:12:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-286e03467a3so3130713a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 02:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289551; x=1702894351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GH7i95L+H2BeLVRjjioDAByqwcO/R3UaRcZe+O+j5uI=;
        b=fZIeWV9+r6sQ1D+IuzPWD7JmZPBOe4SHEGS4Cnk6elaTOHjmFS5M5h0f1F4h1PbenJ
         Qdja0Tx6GEW5t5jF7p29kq7plUEFdM5TABAl7Br72fSCWriPXde3gQf7Fg4bWWWygsTi
         8mjGJLMSbg4U4fHHkH+H1XaQgB1V2Os9oLjKe7nbWYoA32O+DGq0AoammfTUMTW/Oi25
         kHunCq+WTvplMTofWjYIPTkhFhNPpVAGoSFKWA9Rj0QaHbhjMmUQexFJ5zxZ1304Mb4x
         dcO+TjQaziLJz4b25YehMsO2m+qZ2gf6uHyJGcoxPak7CnvZEdj4M28iZ4wrryEQkqlR
         1V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289551; x=1702894351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH7i95L+H2BeLVRjjioDAByqwcO/R3UaRcZe+O+j5uI=;
        b=ZoCkIJN1Kig25+SLJ56Ck73q97nEklM+4EUXLKgpMzPkUBUrc5G3axd/c3+MdeAUr5
         QpocFzkzU0gjEx5jGlAUS/aAYbQQEB243DsUi4XfKrhLeUsOeK7Q0mioUmgr/k3Le5d7
         /71TaVAR0zBrLAmrsJDfH0xem3RcsmH6emHmio1O9Zl0RnRQMn59/KngChAdIdbl7NG6
         LWSSnTvQhuyVqtSzba6j/IX7VqiCp1WgrZsA7tZs96GzgLn7y4QVcpkai8ovkis+UG4U
         TblLUXGYUvkVKC0a8Er1hHXVLatWhD1hotj+fAMb5ReP7ucCFTy8c0oi3wGdtf34jECW
         ONJA==
X-Gm-Message-State: AOJu0YxGt0ulwCKy7rtVOERwD3DkUZF4VnjIZ98T4XI87JN2Krezzc85
	ryX1jHX/2dhij5tbnBzkrQI=
X-Google-Smtp-Source: AGHT+IHC2ioI999wIUV7sxMWb6JVtOG4phKI2l4wRw1oHKKvsGzWFGKM7vUrC0En+IK+9032COUz0w==
X-Received: by 2002:a17:90a:7c06:b0:286:6cc1:5fb3 with SMTP id v6-20020a17090a7c0600b002866cc15fb3mr1744888pjf.54.1702289551457;
        Mon, 11 Dec 2023 02:12:31 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001a98f844e60sm6077179plg.263.2023.12.11.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:12:30 -0800 (PST)
Date: Mon, 11 Dec 2023 18:12:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kselftests: add per_test_log support
Message-ID: <ZXbgiwZXt2PVN81e@Laptop-X1>
References: <20231102075017.4060991-1-liuhangbin@gmail.com>
 <ZV6wziKnIs2jZfa2@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV6wziKnIs2jZfa2@Laptop-X1>

Ping Shuah. Is there any update I need?

Thanks
Hangbin
On Thu, Nov 23, 2023 at 09:54:26AM +0800, Hangbin Liu wrote:
> Hi Shuah,
> 
> Any comments for this?
> 
> Thanks
> Hangbin
> On Thu, Nov 02, 2023 at 03:50:17PM +0800, Hangbin Liu wrote:
> > By default, all the test output will be printed to stdout or output.log if
> > -s supplied. The kselftest/runner.sh also supports per test log if the
> > variable per_test_logging is set. So add new option -p to set this
> > veriable. Note the -p option is conflict with -s option.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  tools/testing/selftests/run_kselftest.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> > index 92743980e553..965220a314ce 100755
> > --- a/tools/testing/selftests/run_kselftest.sh
> > +++ b/tools/testing/selftests/run_kselftest.sh
> > @@ -20,7 +20,8 @@ usage()
> >  {
> >  	cat <<EOF
> >  Usage: $0 [OPTIONS]
> > -  -s | --summary		Print summary with detailed log in output.log
> > +  -s | --summary		Print summary with detailed log in output.log (conflict with -p)
> > +  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
> >    -t | --test COLLECTION:TEST	Run TEST from COLLECTION
> >    -c | --collection COLLECTION	Run all tests from COLLECTION
> >    -l | --list			List the available collection:test entries
> > @@ -41,6 +42,9 @@ while true; do
> >  			logfile="$BASE_DIR"/output.log
> >  			cat /dev/null > $logfile
> >  			shift ;;
> > +		-p | --per_test_log)
> > +			per_test_logging=1
> > +			shift ;;
> >  		-t | --test)
> >  			TESTS="$TESTS $2"
> >  			shift 2 ;;
> > -- 
> > 2.41.0
> > 

