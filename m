Return-Path: <linux-kselftest+bounces-41278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F6B54304
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4058AAA029F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B5279DC4;
	Fri, 12 Sep 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NWW8IpDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4BD18859B;
	Fri, 12 Sep 2025 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658997; cv=none; b=gWgygRxt3p49Xb5/Ado0lcZD0rkCA7k5LUREYnaDi5hbptFV4kqMioRtKlLDaeX5tjGIleGRo/wazhY8JUY6cBAF0t+xLPbGbEvzLmXCRIgTbaX3n5pJ/kbsqomv0XnRAjJDrowSytVkS9Ha5bANbgwdiuWPsVCn9C/BdBw/z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658997; c=relaxed/simple;
	bh=KnbWWZ1vZ7cS+SnFrToVLk6/eP2S5BM8goClXA6cIBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnJKLBlOamLvfyWsSeZKZlUz5+TfhzGTb/O0Aly3do4ium1DSs962lNVMuBfRYiis9e4CQfoRKqqvoZNg0wNvB5PU2e6nwVWXaOxp8k2Cz7nI5Ovaf/jEYp6THGR6bgvDGc/c18o+EwFzLUHBwlX92mMWH9W1W/n1Rk0NszmxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NWW8IpDm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757658608;
	bh=KnbWWZ1vZ7cS+SnFrToVLk6/eP2S5BM8goClXA6cIBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWW8IpDmvTnK2lh7vg8icSbnes7lYwmiq1z2K9xdMjog0SFC7Nulxdk4NhgoLFL+N
	 5is3M5aEjcbpPkEYimcIjAdz6+MDL5d6IhrxJs+Ca2tjClKJw/ZgSGfipmF5RfkbcW
	 cl4yQSPmGAYVo1yFYkUMOEDmhttWGbRhKtoqMjG0=
Date: Fri, 12 Sep 2025 08:30:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error:
 use of undeclared identifier 'HWCAP_GCS'
Message-ID: <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>

Hi Naresh,

On 2025-09-12 00:48:47+0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed on arm64 defconfig
> with clang-20 and gcc-13 toolchains on the Linux next-20250909
> till next-20250911 tag while building selftests/arm64.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? yes
> 
> First seen on  next-20250909
>  Good: next-20250908
>  Bad: next-20250909 till next-20250911
> 
> Test regression: next-20250909:
> selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> identifier 'HWCAP_GCS'
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> identifier 'HWCAP_GCS'
>   390 |         if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
>       |                                     ^
> 1 error generated.
> 
> The suspected commit pointing to,
>   kselftest/arm64/gcs: Use nolibc's getauxval()
>   a985fe638344492727528e52416211dda1c391d5

That suspicion looks correct. I am wondering a bit how this works for
the other selftests which use this symbol.

Can you give this one a try:

diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
index c99a6b39ac14..816b497634d6 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-util.h
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -26,6 +26,10 @@ struct user_gcs {
 };
 #endif

+#ifndef HWCAP_GCS
+#define HWCAP_GCS (1UL << 32)
+#endif
+
 /* Shadow Stack/Guarded Control Stack interface */
 #define PR_GET_SHADOW_STACK_STATUS     74
 #define PR_SET_SHADOW_STACK_STATUS      75

