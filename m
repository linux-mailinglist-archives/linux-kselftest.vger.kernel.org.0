Return-Path: <linux-kselftest+bounces-31699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE5A9DA28
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285FE7B4CAF
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CA1B85CC;
	Sat, 26 Apr 2025 10:45:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95E146D6A;
	Sat, 26 Apr 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664327; cv=none; b=VPFmqgoR+39VBNOMSzYswp6FIl/SZ+q4A8mzvP1uV5x+PwM/MORosLm/R3+eM+15wYuxh9Y7mF0LowMSliiAPSVhAeYhP2LpgMkyOAkuf/D3aIwHOqwBG1OoRGNEnESKElW8yURoSCzLcxjFfsstQS8Z3DdbqFxNxWejy0YD/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664327; c=relaxed/simple;
	bh=Bz6uE7rW/OpOzkwI3teOsgR1ZLH6jKH/PVsSxn1zW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr9kXv7T6gIUFsCYSGeHZI2z5mGjpznYWc4kz7TVe3gJeIW3hFiu9uFBCEwSeFpPiaUHCoBxxFPE+B8KtIvBIHFwHmJhplsgN0SKcQuBFHEhherxz/9x8mVkPrhiaBWTjKT7Cw8zFjVG05wDfj50zTyBxsng98fBF1bH3JnM7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QAjKTC018738;
	Sat, 26 Apr 2025 12:45:20 +0200
Date: Sat, 26 Apr 2025 12:45:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/15] tools/nolibc: add difftime()
Message-ID: <20250426104520.GD17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-11-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-11-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 23, 2025 at 05:01:41PM +0200, Thomas Weiﬂschuh wrote:
> This is used in various selftests and will be handy when integrating
> those with nolibc.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/include/nolibc/time.h                  | 7 +++++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
> index 28a1549adb14e2087fa8fbdb7e9c35e1c3f22c2a..760133c574ece97165e3bba5616a387deaf07aff 100644
> --- a/tools/include/nolibc/time.h
> +++ b/tools/include/nolibc/time.h
> @@ -105,6 +105,13 @@ int clock_settime(clockid_t clockid, struct timespec *tp)
>  }
>  
>  
> +static __inline__
> +double difftime(time_t time1, time_t time2)
> +{
> +	return time1 - time2;
> +}

Thanks for making me discover difftime(). I've never heard about it, and
seeing it return a double looks totally weird, but that's how it is indeed.

In case time_t would be unsigned, this would return a large unsigned
value. I think it could be more robust to explicitly cast the two
inputs to long:

	return (long)time1 - (long)time2;

> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index aed71de4b4f3dd1f183c7fc25e5a5cee466600ed..fd8bab42e75157967658690005bc9142360fc135 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1423,6 +1423,7 @@ int run_stdlib(int min, int max)
>  		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
>  		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
>  		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
> +		CASE_TEST(difftime);                EXPECT_EQ(1, difftime(200., 100.), 100.); break;

Then here maybe test it in reverse to make sure the types don't cause trouble:

		CASE_TEST(difftime);                EXPECT_EQ(1, difftime(100., 200.), -100.); break;

Willy

