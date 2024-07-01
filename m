Return-Path: <linux-kselftest+bounces-12989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4091DA12
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FDFB23BA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9983CC1;
	Mon,  1 Jul 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gjG9psb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5183A17;
	Mon,  1 Jul 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822905; cv=none; b=EEF55Q2DfPGtoUB+ZPaTsb1jJdwQQppOYl7tRhBYWIR57iMdbbFByLn4NIllLZdKeOP0mrYXirfH+Gnmx/+m8nZJYvAfN6PnaI9LbbxK3qiNmS59Ft43YMuCYWnuV54wpVY8aacH47xt9lE1IlELwkRI0abfAFO1Ut1DRsp+kE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822905; c=relaxed/simple;
	bh=5iaTglpGcfem28OxlHlgrBIPodZhUHH2T3eeccn4ksA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p/HQlSOzp92JFe7YvYymuKa6qwoHthqbkI78usf+vFsFPCrf6uCg2Y/pHZCAZz3KPtIm5BNYFScwO3ntiTHrHBVvhldh6bXT/1twzRkFtEvPFZIZELoRzP0NjegKMLHnQQbHVkZdb4VXA9n9ZTEpu36SZ235vajVdE0yRPXU4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gjG9psb4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719822902;
	bh=5iaTglpGcfem28OxlHlgrBIPodZhUHH2T3eeccn4ksA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gjG9psb4HvhuMLsEwd/Xzb5XiPYwLdFE7KdM2OUgb+Tj1NT1ueA3TY6RuH9FCp5CG
	 HEUBjjr0AzrNaQoDZkDzZe7WgvtDAFXGB5+p2t+gP73WQxnPguX4CkzEuAB7l3aNDZ
	 7DpoaAXLfu+G3SqjJwzGzX3COgfipxJGUdG3DmJ+EX2KiJ9D64nTjo9OXB3A5xzYRT
	 pbB9AOEJp1QLTUN9rRjwrvJVP4BC3IKfE9mtS+k/j3wt81fjHbKiDIZHHze/XctqVT
	 ZGbCK/DZElFRukjh18RmqR5Cc1ScfN3Y/LgIhSuaw5LYkiAPqF7CZG8xVehVEyOBlc
	 Swd1uX/OJGseg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 39CCE3782109;
	Mon,  1 Jul 2024 08:34:58 +0000 (UTC)
Message-ID: <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
Date: Mon, 1 Jul 2024 13:34:53 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests and
 then skip
To: Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240522214647.3568788-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding more people for review

On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
> Don't print that 88 sub-tests are going to be executed. But then skip.
> The error is printed that executed test was only 1 while 88 should have
> run:
> 
> Old output:
>   TAP version 13
>   1..88
>   ok 2 # SKIP all tests require euid == 0
>   # Planned tests != run tests (88 != 1)
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> New and correct output:
>   TAP version 13
>   1..0 # SKIP all tests require euid == 0
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/openat2/resolve_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
> index bbafad440893c..5472ec478d227 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> -	ksft_set_plan(NUM_TESTS);
>  
>  	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
> -	if (geteuid() != 0)
> +	if (geteuid())
>  		ksft_exit_skip("all tests require euid == 0\n");
>  
> +	ksft_set_plan(NUM_TESTS);
> +
>  	test_openat2_opath_tests();
>  
>  	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)

-- 
BR,
Muhammad Usama Anjum

