Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23858B3F29
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfIPQoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfIPQoQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:44:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DED4214D9;
        Mon, 16 Sep 2019 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568652255;
        bh=/vl4XZg36JrNwZ/5nnvRHDpnQMM8DhYL3wkGfsRhiYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z1iPweTk2tyNn3UJWaQveE4CYMrl5iWTSI5+RDXQ4uSDADz2njmZhF4Zl1v+uvBFt
         LrDvlicis7rQjjvOd1qBc5a7JC1mIaYNK23y/QlhrsMgIiDB1i1V+zJZOSCgcYX0lW
         tOy1/jPlE5bbffBFdBg8QtMwP4BU1v/TOQ1NaVJ4=
Subject: Re: [PATCH 5/6] selftests/clone3: enable clone3 self-tests on all
 architectures
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <d1a101897be9ee31b11f13ec61384f004dafd40c.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5d140570-765d-2bab-4f46-d45e9cfc0944@kernel.org>
Date:   Mon, 16 Sep 2019 10:44:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d1a101897be9ee31b11f13ec61384f004dafd40c.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> clone3() is available on most architectures, so there's no reason to
> restrict the respective self-tests to x86_64.
> 

Is it missing on any? Please key off of the return value and exit with
skip if unsupported.

> * tools/testing/selftests/clone3/Makefile (TEST_GEN_PROGS): Set always,
> not only ifeq ($(ARCH),x86_64).
> 

Please - no file names in commit log.

> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/Makefile | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index 4efcf45..faa069c 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -4,8 +4,6 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
>   
>   CFLAGS += -I../../../../usr/include/
>   
> -ifeq ($(ARCH),x86_64)
> -	TEST_GEN_PROGS := clone3 clone3_set_tid
> -endif
> +TEST_GEN_PROGS := clone3 clone3_set_tid
>   
>   include ../lib.mk
> 

This is fine. Where is the code to handle unsupported case?

thanks,
-- Shuah
