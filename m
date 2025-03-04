Return-Path: <linux-kselftest+bounces-28180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE5A4D4E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB1A16FF8C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1841F76BD;
	Tue,  4 Mar 2025 07:38:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F81F76B6;
	Tue,  4 Mar 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073894; cv=none; b=PxeszdGCkjLHd5CYF0Ctg4Mer7tAx9SUc/YUt96CYwIJOMxMWhjHsBgxowo85oQfqDnw5tUr5NWe4WZjfa30cHt5bttPW4rO+xfgr8iRdAmB298uDoolXk3wWTjdArnsF3h1OV3sCtvighCsI87AWd9NUtVe32brBWyx0YLWAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073894; c=relaxed/simple;
	bh=e8NJ67tUUsOsfHWzR+/5cECrTmxqDC7D8L9ajq9GP0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHaXwXN+/j+XyutlX7BToeHPZLUxJwLuGEMuNlFQsN/mxap5YeyNUK2sVu/lfpS5vI7Znz4ps56WJ9fwfWrOIEA9MR407SfGu83+9Vc0411NtarxjsTGLIGlyj3bmo3DG7cL7N9eQaUgxgbzVZ0DQvPHCwzBJa7ceEGjQiXlOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5247bgLh010071;
	Tue, 4 Mar 2025 08:37:42 +0100
Date: Tue, 4 Mar 2025 08:37:42 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 15/32] tools/nolibc: use intmax definitions from compiler
Message-ID: <20250304073742.GA9911@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-15-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-15-adca7cd231e2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Tue, Mar 04, 2025 at 08:10:45AM +0100, Thomas Weiﬂschuh wrote:
> The printf format checking in the compiler uses the intmax types from
> the compiler, not libc. This can lead to compiler errors.
> 
> Instead use the types already provided by the compiler.
> 
> Example issue with clang 19 for arm64:
> 
> nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned
> long') but the argument has type 'uintmax_t' (aka 'unsigned long long')
> [-Werror,-Wformat]
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/include/nolibc/stdint.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> index cd79ddd6170e05b19945e66151bcbcf840028d32..b052ad6303c38f09685b645268dad1fa8848370d 100644
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -39,8 +39,8 @@ typedef   size_t      uint_fast32_t;
>  typedef  int64_t       int_fast64_t;
>  typedef uint64_t      uint_fast64_t;
>  
> -typedef  int64_t           intmax_t;
> -typedef uint64_t          uintmax_t;
> +typedef __INTMAX_TYPE__    intmax_t;
> +typedef __UINTMAX_TYPE__  uintmax_t;

Just thinking loud. While I understand the rationale behind this
change, it somewhat contradicts the one on printf where we explicitly
use it as an "unsigned long long" that's expected to be 64 bits:

   CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;

Do we really have guarantees that a compiler will always declare
it as a 64-bit or unsigned long long ? E.g. we could see new
compilers decide that uintmax_t becomes 128-bit. Well, maybe in
that case it will simply be a matter of updating the test case
after all...

Willy

