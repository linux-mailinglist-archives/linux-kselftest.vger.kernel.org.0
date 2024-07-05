Return-Path: <linux-kselftest+bounces-13245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E601928C88
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD49B221EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8393D16D30D;
	Fri,  5 Jul 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NROOo9Kp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015642B9B9
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198502; cv=none; b=s+hkpDNbQuqsiIb+F3Mgj22QdwnFALTL63NUvEPztbWB1UojnIO0CvPvX+K2Tb6PI1aKSqVavcRyxpx7IgxTMBq0HQX6g5NgyvE6iUQUXw5MXWeGNmJ83GFEP9GB+zHJfO8Odpr807OBoWAp9LGZH6x/LVwU/sXGGuRshe2vRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198502; c=relaxed/simple;
	bh=JbpMAAp767cJMVvvsfmlKOVKEDBe1tv8WSltj4UH6v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8sar6MAm/PxNOfS6nrKFxx5rC3dJW2EHYRmgoTqp+JlqTiP0weolq3xHdZwZtQgtgIhh3qTZJ1iqLOoI9USSe4R1dkKTqlpSW6fmoj8T5MlNFe84dhDIaBI3l9GWXCGLvTqpYtP0aCBy22e8C9C3ZYcnaDCuA8af6tUwo25HBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NROOo9Kp; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eeecebb313so7841639f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720198500; x=1720803300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+6p2HoNrUHHa/yVChF/+f6ARUdHwWa9m3WGICPV8zw=;
        b=NROOo9KpWSPZfPUGqznxS507ekb+9dNphmCi46NCzAbVkDaYaca8H8Pfkgq52smB1H
         ccJE27E49j1KUMmx/kzc9MrLrzm87a58Kd1gNtjNPAOmLNwjxD0PQySmxqNbcsJqoV2S
         wtM2BWQ+WpeF1AmKE+R7FTfdlyf6BSwDe6bWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198500; x=1720803300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+6p2HoNrUHHa/yVChF/+f6ARUdHwWa9m3WGICPV8zw=;
        b=HbpbWFYyzIsJsjEuuDpiugN6O52TXLezICgq0umoEI+hkUKbO4B5v8iyfGYy3quzNc
         DcbKCZ5fQ6EZDCNVrDlhIOQnvzYJ+BPRkRm5wHDYMAMRq9eNrJnFQY+zuvs4/zdy0tsQ
         +lPoxn9+XwRA/acDBsAipbr7NOoFEee91fPbND1X41JSN5ooiiOAtlluvjiulhkiv++o
         Fc+5sSZZOBV+b4Xg6i/OB6JN97wOfWZHicOGGTWQUkacbTYZxOIQm4bfU2tQG1I+iqsj
         tU632Fvbo0olUajnzEK0tW+NNTU5o0TJMJcp5UbwHdWo2IutJAtEZb01K8hXdSleB+v/
         u3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX1hRJRT2JGVOM4kjz2aYgPtbFK/ObMMP/SJj1BHKLDuTDWu6S2DCodjpN4BRz62hw6ZBp7QqETVDGNdFF0JGbivMlFr72+osNszvYf5FV6
X-Gm-Message-State: AOJu0YydDR6nNDT8gjxUGXFOPP66Q6Hulhdnq4/4IZLJUXwNpu7TgM6G
	Cqqh++LHzW6CGKQSr2CG/jnRl5EAFvSKqP++nyReJCjjAcaBDm+P9adnF1MaKts=
X-Google-Smtp-Source: AGHT+IHY3in/e9Yxt3K+EtGGW2Ojce03GKiDSgxyEYqs6zBH6DryDUXwKCb6gpUav66FAfp/eAhNgg==
X-Received: by 2002:a05:6602:6211:b0:7f6:5178:8607 with SMTP id ca18e2360f4ac-7f66df05100mr601855839f.2.1720198500122;
        Fri, 05 Jul 2024 09:55:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f910fdsm4521403173.91.2024.07.05.09.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 09:54:59 -0700 (PDT)
Message-ID: <9262c7ff-41e6-4df2-a335-e81897381ed0@linuxfoundation.org>
Date: Fri, 5 Jul 2024 10:54:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] selftests/vDSO: fix clang build errors, and
 Makefile cleanup
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240704023324.83564-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 20:33, John Hubbard wrote:
> Hi,
> 
> This is basically a resend, with a rebase onto today's latest Linux
> main, in order to show that the patches are still relevant and correct.
> 
> Changes since v3:
> 
> 1. Rebased onto Linux 6.10-rc6+.
> 
> Cover letter for v3:
> 
> Jason A. Donenfeld, I've added you because I ended up looking through
> your latest "implement getrandom() in vDSO" series [1], which also
> touches this Makefile, so just a heads up about upcoming (minor) merge
> conflicts.
> 
> Changes since v2:
> 
> 1. Added two patches, both of which apply solely to the Makefile.
> These provide a smaller, cleaner, and more accurate Makefile.
> 
> 2. Added Reviewed-by and Tested-by tags for the original patch, which
> fixes all of the clang errors and warnings for this selftest.
> 
> 3. Removed an obsolete blurb from the commit description of the original
> patch, now that Valentin Obst LLVM build fix has been merged.
> 
> John Hubbard (3):
>    selftests/vDSO: fix clang build errors and warnings
>    selftests/mm: remove partially duplicated "all:" target in Makefile
>    selftests/vDSO: remove duplicate compiler invocations from Makefile
> 
>   tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
>   tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
>   .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
>   3 files changed, 39 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52

Applied all 3 patches to linux_kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah


