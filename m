Return-Path: <linux-kselftest+bounces-13444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89592CC4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F3281243
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119287F49B;
	Wed, 10 Jul 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ozPoOvRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC984A21;
	Wed, 10 Jul 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598119; cv=none; b=MVzvl+0qU2Z8BV8v/p9t/CltEx8NXuXvYup1dtN0Ap8/QLomTlakoPDdfUeh+5TzuBLmfPyy7mdptaUpe1R+QhINJuxxxaJVhFJd0zlKpQ7esJvMFlfvELW5ss3/9tsHzoy8psKMC5spUEGlj9n0cvu1+PMcuVOlmWjO8Lpiqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598119; c=relaxed/simple;
	bh=AEuuguye4paXqrHJqwbhYfUH6lx8TebFSbjlaD3Jz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK2eVX1SDXp3ie7BWWbVnTY8hW3EheSm7bgdIPUxo3ShmqfoA4ptUk7T2SJBJ2wt/5eXd2jegSyAetxz6T5xUd5GGFBMFFIOkzc/WttUEWJLQ82kstEAqas1k+p3q0oTfGwSiSXttgwU7WX95R68q6i8u+wUDuY2kwY+QVyZ3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozPoOvRS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4309A20004;
	Wed, 10 Jul 2024 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720598114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8bOPsWE/D64uVpyJZt5keXGhkUWczcPlKgpEkNPXbw=;
	b=ozPoOvRST3NQfO5QHnWp8qHli9wbCvFhdX8aux1qDUhaZ+h2zs39bDpgWtGNME8CJv2W5B
	iC0fDa2FzrS2rFsW2YiUk7E7/ulrGNuCTCAIhuQEXYlh75KVCfMUPOx4kwSQdJ9svJZ5pq
	ahLH+PQ6BqvYHoqjymzPvrRhA/VQZyvkltUY4TFQ6fbEOBfdImQwLLHtgbk+0BlRuYJc0l
	bwFJlbEK0JqWFjNGy7MBTh8rDDcZZIwib9qlyOrmke2KFXSy3iGNp31u7pifyhZgKE8h2u
	MNxCVfHbo0TNuS9qjGMlonrgh2cnznemqI+Vt0AscwWI5MHhRxtXc5qYwJSEdw==
Date: Wed, 10 Jul 2024 09:55:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rtc@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2] selftests/rtc:Fix a resource leak
Message-ID: <20240710075513332c564f@mail.local>
References: <20240710071650f7265b40@mail.local>
 <20240710074309.6647-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710074309.6647-1-zhujun2@cmss.chinamobile.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 10/07/2024 00:43:09-0700, Zhu Jun wrote:
> The opened file should be closed before exit, otherwise resource leak
> will occur that this problem was discovered by code reading

The question is still why should it be closed before exit as it will be
closed on exit?

> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> From a good programming practice perspective, especially in more complex programs, 
> explicitly freeing allocated memory is a good habit!
> 
> 
>  tools/testing/selftests/rtc/setdate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/rtc/setdate.c b/tools/testing/selftests/rtc/setdate.c
> index b303890b3de2..17a00affb0ec 100644
> --- a/tools/testing/selftests/rtc/setdate.c
> +++ b/tools/testing/selftests/rtc/setdate.c
> @@ -65,6 +65,7 @@ int main(int argc, char **argv)
>  	retval = ioctl(fd, RTC_RD_TIME, &current);
>  	if (retval == -1) {
>  		perror("RTC_RD_TIME ioctl");
> +		close(fd);
>  		exit(errno);
>  	}
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

