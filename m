Return-Path: <linux-kselftest+bounces-5957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87287290A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 22:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146031F28EE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03712C7EF;
	Tue,  5 Mar 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfACXXU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB312BF0B
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672464; cv=none; b=rIVsSy1Z7r8N1fOeY3z342HyQvt49sP2Kn6svu5bubfK0JnSgUtmKk0XBXwKNwcy2CQ6bc5ElZqTkii8i0Lh9ZrnEqyxvW4CQZWfS2sAbnGL3F1bJwMdlliVkAzX/QWCuUWse96BXPhAdTlT6GQ80pO1+6htRZ/xZ7Ul36oQ6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672464; c=relaxed/simple;
	bh=3mL3z/qxqBUyDlYaBkawRzU+GsgP5u+d/+lOsY1c0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNO/f1FY8F1cIuiXfmAN3M9i7fZ2WA+Vt9v17gcUCWI/Xr50HJ/Dl1DfbuECP6UCWz/UZlOIw7xRJLjmzoaKgZsGjdDvYSprzUQRehAHQeGGAmAibOA1cbaE1Rq1QajAXJYkeiddGCPP+Rk4+jBQnImqPqn5dPNGY+Q6RWQCu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JfACXXU1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6de3141f041so4220757b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709672461; x=1710277261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF432v09KlF629RNN3u5qcmSSQ2n+BPZ5TK5Cfww29c=;
        b=JfACXXU1Z/tJMbfQJ+OKdyimCcXq5lwZiledrnKJ2x0m5WUwbh/MoGI3Ckwdoy8fcR
         VLkIdTu66n93EWSyTzE2ojPS0QZMuT65MimK79Zw8A3wfT+I2u8+7P3/dd4nzD4mcrwk
         DfoyoNPkDVMMveNA7Dmj/oIuzkMfC1n26ApYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672461; x=1710277261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF432v09KlF629RNN3u5qcmSSQ2n+BPZ5TK5Cfww29c=;
        b=hd3R3Vc6jWtCc+wFLl7XNXgnbXWDsSB5d2YafTbyOsOzI0bPQyAe1EmJsTDu9WjnyR
         tdbuMZvsFEDcYUfWUrGwuVf5Jx1dEVHP1agWRJF260U+fiPFafa0OaNO5Oi/7yYvz96B
         6SuyBMD/CuE3ZVUE7i0CDMFom/HjaDPPd9RcIDVRaaGROs2MaRKA0cXZHVM2oxVfPrXT
         IMbORYsqnVk4MTWcmz4ZcCyC4vN4FGid8/lTU8MdXH7rmKez4SzQi/F5sv6SUsEuKt6j
         ww1lSanyNKtXz67/R4lEXgAv4ITRsBBWPFAXcvZbsmiG6qTkAZodvIp99nNei7iISd7Y
         vXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUA8JslcVFgbCxqLGMM+79xCx3ir8n5r20luzR6fAUvmZNiKsRbw7sVpyUo4vGIBvkWnidNorgrHlu2oXjd4yh/RuwjcXMV0F+FZ5LyWbAH
X-Gm-Message-State: AOJu0YzETc3ai0UAKpAMBNjOEpA+qU4hAraZ2rWh8+HzDdUVSosyFMTu
	KjdUAeoRG6C+thUFtO0lkIp7X9CUpQ/A37NhJqVve3SFb6dUbSj8tbnrOIpULv3z1NnCIvRLi9M
	=
X-Google-Smtp-Source: AGHT+IFgU6Ny/h5rqcqqC1Dq853UHL6pR3leCjAfvblgUgL0FZjcQ559bVzwVH8cdJcz3mW5XsbNzQ==
X-Received: by 2002:a05:6a00:3d10:b0:6e5:a009:9eb4 with SMTP id lo16-20020a056a003d1000b006e5a0099eb4mr15506921pfb.0.1709672459215;
        Tue, 05 Mar 2024 13:00:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm9416426pfl.123.2024.03.05.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:00:58 -0800 (PST)
Date: Tue, 5 Mar 2024 13:00:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Message-ID: <202403051256.7A50FE28E7@keescook>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>

On Tue, Mar 05, 2024 at 07:20:27PM +0500, Muhammad Usama Anjum wrote:
> Hello,
> 
> I've been running execveat (execveat.c) locally on v6.1 and next-20240228.
> It has flaky test case. There are some test cases which fail consistently.
> The comment (not very clear) on top of failing cases is as following:
> 
> /*
>  * Execute as a long pathname relative to "/".  If this is a script,
>  * the interpreter will launch but fail to open the script because its
>  * name ("/dev/fd/5/xxx....") is bigger than PATH_MAX.
>  *
>  * The failure code is usually 127 (POSIX: "If a command is not found,
>  * the exit status shall be 127."), but some systems give 126 (POSIX:
>  * "If the command name is found, but it is not an executable utility,
>  * the exit status shall be 126."), so allow either.
>  */
> The file name is just less than PATH_MAX (4096) and we are expecting the
> execveat() to fail with particular 99 or 127/128 error code. But kernel is
> returning 1 error code. Snippet from full output:
> 
> # child 3493092 exited with 1 not 99 nor 99
> # child 3493094 exited with 1 not 127 nor 126
> 
> I'm not sure if test is wrong or the kernel has changed the return error codes.

The error code is actually coming from the script interpreter (in this
case, "/bin/sh"). On my system, /bin/sh is /bin/dash, and I see the
failure. If I manually change "script" to use "#!/bin/bash", the test
passes for me.

Since lots of other selftests appears to depend on /bin/bash, I think
the right fix is simply:


diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index bf79d664c8e6..0546ca24f2b2 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -393,7 +393,7 @@ static int run_tests(void)
 static void prerequisites(void)
 {
 	int fd;
-	const char *script = "#!/bin/sh\nexit $*\n";
+	const char *script = "#!/bin/bash\nexit $*\n";
 
 	/* Create ephemeral copies of files */
 	exe_cp("execveat", "execveat.ephemeral");


Can you test this and let me know if this fixes it for you?

Thanks for the report!

-Kees

-- 
Kees Cook

