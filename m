Return-Path: <linux-kselftest+bounces-13229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBA92836B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 10:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB951F25511
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DC13C693;
	Fri,  5 Jul 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k0R4d9k1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB47481AB;
	Fri,  5 Jul 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167115; cv=none; b=YX+yZq2ESTbUs8PKzyuIEmciVaZb3LwzEZUDGhYQ3oZyjO6MPpq9uZfRycersNjnqSqKiiBI8E9cvWwkKVHobqdfBJAc5neZ++jskXx0bPqtg8WTnpRY7nqvDUtbgq5asYDDG/K9z2NOg71OEtF1t77LHH0LgTy1mbNEdNF0f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167115; c=relaxed/simple;
	bh=Aj0m6t8GDqsHhAgXUzxgI6F12Xfm6vOntSjq+v8Fu+k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JdSn8LZ3gpJB4VbUOxEQ+p+JfoFlxNXBzhteAvn7OEtXkRQ65M2giNsBD55rBsWILKEt1zuu0T1SIulXVEiM5SODmvri5N5/lQjh3JBWEdilPzTUpAWrHIEicl5hAMdpRCRWYUNEmOksaL9HPnrGJHsy53sWc/NhUdNseD678wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k0R4d9k1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720167111;
	bh=Aj0m6t8GDqsHhAgXUzxgI6F12Xfm6vOntSjq+v8Fu+k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=k0R4d9k1T8mdsROZzkU9HtEXYxYzZe6bMlgmgkz+5WdFxt3rkdS2zx88DTZGS+Vap
	 j+V3KLRGy/SKofIaLWaRExYjrWTANIwdAjaYiBBFuZot3PP2YzLaGGMRxb5g0MHZqU
	 x6Ots4XX8Owe4bhA3i1AcbaLPlox5YJB3Pd6oURIwj8nQY0lNgkXPwdnmWc0jrGTG6
	 bJcwaMqrxM8yJwKJQsL87449QRIIwiC3GekKEHOp2iNIJ50GUKKaW0Ycw7dfhjF/lQ
	 z9r+fdyWOy/lS2dobpgpwSubfHkYUhMtKsqwdOx9mbBZo+Atz+WWv1RpYF4Mkocsit
	 TUjkTo7i17Nuw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 454AA37810FB;
	Fri,  5 Jul 2024 08:11:48 +0000 (UTC)
Message-ID: <b5c4d39c-a993-4929-af95-013e767fcdb1@collabora.com>
Date: Fri, 5 Jul 2024 13:11:45 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v3] selftests/timers: remove unused irqcount variable
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240704024202.84726-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240704024202.84726-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/24 7:42 AM, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about an unused irqcount variable. clang is correct: the
> variable is incremented and then ignored.
> 
> Fix this by deleting the irqcount variable.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> Changes since v2:
> 
> 1) Rebased onto Linux 6.10-rc6+
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 
> thanks,
> John Hubbard
> 
>  tools/testing/selftests/timers/rtcpie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
> index 4ef2184f1558..7c07edd0d450 100644
> --- a/tools/testing/selftests/timers/rtcpie.c
> +++ b/tools/testing/selftests/timers/rtcpie.c
> @@ -29,7 +29,7 @@ static const char default_rtc[] = "/dev/rtc0";
>  
>  int main(int argc, char **argv)
>  {
> -	int i, fd, retval, irqcount = 0;
> +	int i, fd, retval;
>  	unsigned long tmp, data, old_pie_rate;
>  	const char *rtc = default_rtc;
>  	struct timeval start, end, diff;
> @@ -120,7 +120,6 @@ int main(int argc, char **argv)
>  
>  			fprintf(stderr, " %d",i);
>  			fflush(stderr);
> -			irqcount++;
>  		}
>  
>  		/* Disable periodic interrupts */
> 
> base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52

-- 
BR,
Muhammad Usama Anjum

