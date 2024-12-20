Return-Path: <linux-kselftest+bounces-23695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F59F97BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92B3189A974
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E44226182;
	Fri, 20 Dec 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfAsRtHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D89226168;
	Fri, 20 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714733; cv=none; b=IvSy33nRG84Or472BrImv1nuFc9Ekvy1aHPitBPlHGBpeyFqQgGx+tTYvW/FUM3nfu+OiXqL9VGsfa3IB+i6ABkZvO5URLPNuHmKMSJpo0junVrllToELfM4ypS2UG/mnAbv2gWWKbblGAXwz0iWTz7DGck61a3RAQORgA8M6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714733; c=relaxed/simple;
	bh=fd2wUCiuzCI8wsBoeeeGZA+1NoG499gkqCRaEiPEbb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkPBFyihI7/Gr+UAdDgCL+OZPM0SfUR6tbWZyZ5cTcnRxqZ0S4Id+gsZhxQppK0ZnxeaYmn7zI1HYwM6iI6V3BuFyEt0yVH6CNMtlz6XVi3mc8IVjGYcmp+P0Bvpsx6TZGtyrDYUJPBha7Wo1m4V3qfhdRGLKgMZJvR5gYeAkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfAsRtHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4267CC4CECD;
	Fri, 20 Dec 2024 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714732;
	bh=fd2wUCiuzCI8wsBoeeeGZA+1NoG499gkqCRaEiPEbb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JfAsRtHTA03j9+TXI2gSrqGN18hg18oTydMhF4G1jj2pwQUZM4aY7ik0sGn786DVF
	 SbRKK1UWZABrlnEogPtiI9UWj6G9DMkHAQP2dNsH2qYTVkpPxx699TFDQLr082DSiC
	 3y0MS3atmVSmqsLy2QDh1GcEicMns5LKhU9ZEzXW7QtLYkP7y5+Zx3eJCfBkIQOOh7
	 4ggIrAevX7Bjf9xuR2c+8c/RcesGYFd6xUxB1ROXEuEZs98bi5YSTU0l8nhlDHssCv
	 67paIKl5VF5om+EXID63SLhOj+VySIW53Z4FeJqIy/zSaoXlkjiYTPE8C0AQIDAelH
	 XtyN7mMMx2djQ==
Message-ID: <23208797-44fa-47a0-8459-80f2949ebc8e@kernel.org>
Date: Fri, 20 Dec 2024 10:12:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/run_kselftest.sh: Fix help string for
 --per-test-log
To: Brendan Jackman <jackmanb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220-per-test-log-v1-1-de5afe69fdf4@google.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241220-per-test-log-v1-1-de5afe69fdf4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/24 09:12, Brendan Jackman wrote:
> This is documented as --per_test_log but the argument is actually
> --per-test-log.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/run_kselftest.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index a28c1416cb89b96ba5f8b287e68b324b51d95673..50e03eefe7ac70d1b21ec1da4d245182dda7b8ad 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -21,7 +21,7 @@ usage()
>   	cat <<EOF
>   Usage: $0 [OPTIONS]
>     -s | --summary		Print summary with detailed log in output.log (conflict with -p)
> -  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
> +  -p | --per-test-log		Print test log in /tmp with each test name (conflict with -s)
>     -t | --test COLLECTION:TEST	Run TEST from COLLECTION
>     -c | --collection COLLECTION	Run all tests from COLLECTION
>     -l | --list			List the available collection:test entries
> 
> ---
> base-commit: eabcdba3ad4098460a376538df2ae36500223c1e
> change-id: 20241220-per-test-log-33ecf9d49406
> 
> Best regards,

Thank you for the patch. Applied to linux-kselftest next for Linux 6.14-rc1

thanks,
-- Shuah

