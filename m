Return-Path: <linux-kselftest+bounces-18492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506398888D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5695CB21A24
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39414F12F;
	Fri, 27 Sep 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZzhiuY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352D18B1A;
	Fri, 27 Sep 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452293; cv=none; b=Q+L9ch7vygOfQQ35j/iPVyGboDsyVow+bbhwW21mzSa6oYIrWHn346jaDXZeMRPywn5HzQLuz0qYnK1p8exKCtqmexUYmaeW291K3u7xqnZZNOmfo8xl4Jpf4QjHpKuIQ9HodiXDOLgYPghHmRmjSCnzFEWjzBPPtcEFN5+5dlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452293; c=relaxed/simple;
	bh=Be+ZGbp3IfAlLZpZF/dmewOvihf2CFmNlZ+Q66KjvMg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KcucUGrd0MWBvKtl413CCv8LgmGbjd1cA+yLGVojM6tLByVYnbH4I99mwuECZuyRlKkVmyk77i7Em8044hTKnMECe+R/T1bCY53GCUeygqLKosuDRvfFnFVjv9enetWYgUUEc78tT0v4UcvxdnJKK53g2gqImjXMJ/g88aG5mUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZzhiuY8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206aee40676so20053045ad.0;
        Fri, 27 Sep 2024 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727452290; x=1728057090; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=siq7XCFpoWz1j+ij/CuNUWO3s9GtQAEeoPcY53GflA8=;
        b=LZzhiuY8xSsYPUo4JFGcP+NDGY/4nggzmc9BuRVRJ2zE+87Y1oXLSXJ9EgQOuNBL76
         OfYGNF+FW+TJco0iokhaQotPzyhij0lIsicyi+S9c4m/ieXNHwQCM1Sx7yVxLglTvf8m
         25BWLlqTpkBQ5gipZCOdY7JGyNYJvBzR5vtZ+vDKLjG0sDaoDIf5qwIOqxrHYhyHu8d8
         YUlmvwzmHNkmDapr/lj5qGzqUcqJLoxQFgF/THaq73sodHs7gCEog1ALcGeowz1nyd3f
         EZ7o8btu9W1qh4ops9bFXC/gWGkxTAJzARjEV+b5gEI0waFwCBMgxhxmJ12mR9H5wVMS
         0bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452290; x=1728057090;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siq7XCFpoWz1j+ij/CuNUWO3s9GtQAEeoPcY53GflA8=;
        b=QoTgnFZNRlx9VJG/vBd4amghvJPxSAVgvRzIHhM+ue0uzo4AMmJTtNh4ZQg/YwKqlE
         MlhfiiYlwt7DtWngf0ahjDuueOCtugutE9+3LdKZTsZlKR/DhXlCyjM7fWICmxKKsAH4
         mobEtQsWWoAd1hLuDX5bmDja3lfHU34MKAMXfKVdRyCeeSrVWIOrqmrdSKB9Bdc3xR5f
         OFigGWKtYC76SO5vdkCdohPu5zGJScrdMGcrguOxpgDHR8Z4CUrW+4evQHODGH4eHx6q
         ZDgCH+oDiLw5U0wTdQrHOrQoBOvd9Jb2fAa3NA/uz66oxLo0HiO6JI7CiOpMwg3Yoj+O
         uDYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+TfDELExEbbitIOqGzMp57paU7y0QoA3C1CZ0r4L2uK2r9Gc8YkV7YIPqyGmO6HJ7Y6q4LPPi+cuyXdWEzjfa@vger.kernel.org, AJvYcCWZ+FIopcZARVctN5VaGfw/3FfHTIADGtjWmfMdbKpdgRrPA66ovywMhsvx+EszPBELYEVGRelRFEuAnhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAvm5HttozTt+k73ybKpEkLsw5QG0dq9kEGkudneqCz0W49yo
	5b9EMfZCBWJ+yQHYg28bGpdD7oPmoOR1TfKWoIIngtmviYo36Eh3Wg8wqw==
X-Google-Smtp-Source: AGHT+IHYen+9SCB9zAwc+2YM+I/YJeUCIgN9O5oINntyeB1ech4upS2dfT1q+IPsJIFbM8mIsRWLFg==
X-Received: by 2002:a17:903:11cd:b0:206:96ae:dc57 with SMTP id d9443c01a7336-20b37b912b5mr62267395ad.48.1727452290237;
        Fri, 27 Sep 2024 08:51:30 -0700 (PDT)
Received: from dw-tp ([171.76.86.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm15170095ad.102.2024.09.27.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:51:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH] selftests/powerpc: Rm the unnecessary remove function.
In-Reply-To: <20240927043125.8199-1-zhangjiao2@cmss.chinamobile.com>
Date: Fri, 27 Sep 2024 21:15:41 +0530
Message-ID: <87h6a1aymy.fsf@gmail.com>
References: <20240927043125.8199-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

zhangjiao2 <zhangjiao2@cmss.chinamobile.com> writes:

> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> Path is not initialized before use,
> remove the unnecessary remove function.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/powerpc/mm/tlbie_test.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> index 48344a74b212..fd1456d16a7d 100644
> --- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
> +++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> @@ -314,7 +314,6 @@ static inline void end_verification_log(unsigned int tid, unsigned nr_anamolies)
>  	fclose(f);
>  
>  	if (nr_anamolies == 0) {
> -		remove(path);
>  		return;
>  	}

Nice catch. Indeed the path is uninitialized here. 

However, I believe the above "if" block should come after initializing
the path. The idea is if there were no anamolies noted, then we can
simply remove the log file and return.

Something like below. Thoughts?

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index 48344a74b212..35f0098399cc 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -313,16 +313,16 @@ static inline void end_verification_log(unsigned int tid, unsigned nr_anamolies)

        fclose(f);

-       if (nr_anamolies == 0) {
-               remove(path);
-               return;
-       }
-
        sprintf(logfile, logfilename, tid);
        strcpy(path, logdir);
        strcat(path, separator);
        strcat(path, logfile);

+       if (nr_anamolies == 0) {
+               remove(path);
+               return;
+       }
+
        printf("Thread %02d chunk has %d corrupted words. For details check %s\n",
                tid, nr_anamolies, path);
 }


-ritesh

