Return-Path: <linux-kselftest+bounces-31962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41BAA3BBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF394A85E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30EC29E048;
	Tue, 29 Apr 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QJ17l7+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEA2750FD;
	Tue, 29 Apr 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967007; cv=none; b=Pu0DbSViR0nWB2xDczh8eVXEzjdmK5t2hJr/D4EJ93NTk51yJSyFowXnqz7GR/kKhOPXftju2rwclilkHbNemG+OpBrME5sZ2aScMwonxfHwe7iHy7ebrLbahD7mzsDrHCUwFivOP8tY2sHMPvojow+WFB48b2LdGFzIOoUA1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967007; c=relaxed/simple;
	bh=12FpjxI1vHDZ9XAvULM/y/zG2aDe5mmphDUUNP/SSYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZE4D+FxmpT9L8OwuyDf/Vuk6Ovu5uVd3Vucs27/agAoI32XD4mp3+JSmA8jsEXXoeM70a20s6E2ZUUlsDtGNDrGMYkT/j1ILXhSqRDcoTjkqWAKm41emP0wM/3iM0+apD7/PmaS+3ZkaFaTwIJpFoaG5v/ioyEn/j/oQ/5bmvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QJ17l7+y; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 151324040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1745966999; bh=f/1keQGvuVDmtVa5ntSFTTf2hNXSSFSwNLhCT8dvpEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QJ17l7+yOWELeBFPGR0nuT+ercDASavHWP1Eh57InondtNP8tSqbArNEYkQ5DpmON
	 AzCypqgVolSF83KCb5G333RyMUeq7AlDkgfiGYdQkUDtl3t1lOrhdRtHilTuXEOXOD
	 QDF/98uwmV19UR3m1b5Hd8uJ2nGGkMHi13PmSN76qHefT8EjoFW9W57q3a1LdEIbYp
	 1YevsfJJinupUu+JC5588/2NjUzba/gyIIsWORAat0VY03YSFep0znc5kup4vde2Eq
	 7SYsNoqKFVzh7I3n8EM+6Xpk8pUxleXtbIPHUKIHHzY+LBUyTjPekj7iZ6j5bH0B3n
	 BpFnYagDWNUqg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 151324040B;
	Tue, 29 Apr 2025 22:49:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
In-Reply-To: <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
Date: Tue, 29 Apr 2025 16:49:57 -0600
Message-ID: <87selqlh0q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuah Khan <skhan@linuxfoundation.org> writes:

> Add tips to clean source tree to build help message. When user run
> kunit.py after building another kernel for ARCH=foo, it is necessary
> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
> during the build. In such cases, kunit build could fail.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/kunit/kunit.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 7f9ae55fd6d5..db86a396ed33 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -583,7 +583,7 @@ def main(argv: Sequence[str]) -> None:
>  						'the options in .kunitconfig')
>  	add_common_opts(config_parser)
>  
> -	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
> +	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests. Successful build depends on a clean source tree. Run mrproper to clean generated artifcats for prior ARCH=foo kernel build. Run 'make ARCH=foo mrproper')
>  	add_common_opts(build_parser)

Nit: could perhaps that line be broken in a bit more readable way?

  	build_parser = subparser.add_parser('build',
        	help='Builds a kernel with KUnit tests. '
                  'Successful build depends on a clean source tree. '
                  'Run mrproper to clean generated artifacts for prior '
                  'ARCH=foo kernel build. '
                  'Run "make ARCH=foo mrproper"')

(fixed "artifacts" while I was in the neighborhood :)

jon

