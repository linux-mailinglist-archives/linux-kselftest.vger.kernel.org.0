Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D8B3F24
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfIPQlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731760AbfIPQlx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:41:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE4B214D9;
        Mon, 16 Sep 2019 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568652112;
        bh=hRc2ZawhqpenqWEWFAiPo4mHnpVz2rr2Hrb1dskcScA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r5Ht9MEcYkuoymxDe9HIbBT+7kV56lYKv1VHETcwMbHtV3od04FYy2t3QNwkNA3+N
         XYdgjRJxcmWHPV4XCTStAO5DoeIDpUrnh12ZWVpZ3DT9wkkHjeq0tytjdAqZeW2DRC
         JiJyYtLGIkvj/nZKtmvNlDAQld5JwcSytTpy8Sdc=
Subject: Re: [PATCH 4/6] selftests/clone3: fix up format strings
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <fc4ff67f28c6a6b83afecb6a6e22d632e23b82f2.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <144cc30f-cfd9-c367-188a-3cdcd4b120af@kernel.org>
Date:   Mon, 16 Sep 2019 10:41:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fc4ff67f28c6a6b83afecb6a6e22d632e23b82f2.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> * tools/testing/selftests/clone3/clone3.c (test_clone3): Change format
> qualifier for printing size field from %d to %zu; place colon right
> after the word "says".
> 

Please drop the file name. The rest looks good. I am assuming there is
a reason for doing this. Please include compile warns if applicable.


> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/clone3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 1746a9b..7b8d927 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -109,11 +109,11 @@ static int test_clone3(uint64_t flags, size_t size, int expected,
>   {
>   	int ret;
>   
> -	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %d)"
> +	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)"
>   			"\n",
>   			getpid(), flags, size);
>   	ret = call_clone3(flags, size, test_mode);
> -	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
> +	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
>   			getpid(), ret, expected);
>   	if (ret != expected)
>   		ksft_exit_fail_msg(
> 

thanks,
-- Shuah
