Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FBC13FA44
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgAPUNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 15:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbgAPUNL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 15:13:11 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3CB20663;
        Thu, 16 Jan 2020 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579205590;
        bh=fPP11jfjDsjW6JkTbSPKOQE44w8JcAdCqd6Zok8K0Rk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MjYBJTb4mO0VQE47tEHcptW+/xfnm8QuiiE8Z1Ru88f4hTrfdiYh7WnjYvvbx1mrD
         03v48LZXueLLw5+ZWjTSx0oX9S0Mswd+RSAynxTUcewAeCLgOEO6SeNkGMsUrEr/Qb
         vAKYYdmQ4EF+NCi+ruEEaqhu6rLxIZKSah6Laa1U=
Subject: Re: [PATCH][next] selftests: fix spelling mistake "chainged" ->
 "chained"
To:     Colin King <colin.king@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20191210112455.171482-1-colin.king@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2a02d10f-2ae1-acfc-d5c3-fe49dee9cba3@kernel.org>
Date:   Thu, 16 Jan 2020 13:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210112455.171482-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/10/19 4:24 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/openat2/resolve_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
> index 7a94b1da8e7b..bbafad440893 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -230,7 +230,7 @@ void test_openat2_opath_tests(void)
>   		{ .name = "[in_root] garbage link to /root",
>   		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_IN_ROOT,
>   		  .out.path = "root",		.pass = true },
> -		{ .name = "[in_root] chainged garbage links to /root",
> +		{ .name = "[in_root] chained garbage links to /root",
>   		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_IN_ROOT,
>   		  .out.path = "root",		.pass = true },
>   		{ .name = "[in_root] relative path to 'root'",
> 

It didn't apply to linux-kselftest next

If this is going through opennat2 tree then,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If not I can this for 5.6-rc2

thanks,
-- Shuah
