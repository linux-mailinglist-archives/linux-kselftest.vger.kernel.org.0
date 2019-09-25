Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE2BE5BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392349AbfIYTgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 15:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392336AbfIYTgT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 15:36:19 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EB021D7A;
        Wed, 25 Sep 2019 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569440179;
        bh=8Grs7LRppFCyZ3JutL0fp5q5ZY3bi7rRdE0tG+CC9ko=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C4OXA8IRly1/koag00wpkKy6fxTogThu9rb3n13g1NEADdTUd19KiCTuoHIE3HHjN
         oLOf5gW5VWSi9Oql4blr4ujIa5+ftneZAvst1GLAlFMIWZXSHnh5kz5pqlWXoKR+IF
         6AV5uqoEXC46Usyn7BMfvSvk0MN3uhDR21Ahc/fc=
Subject: Re: [PATCH 1/2] kselftest: add capability to skip chosen TARGETS
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dave.martin@arm.com, shuah <shuah@kernel.org>
References: <20190925132421.23572-1-cristian.marussi@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e8848069-124d-a236-30c9-b8915471db16@kernel.org>
Date:   Wed, 25 Sep 2019 13:36:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925132421.23572-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/19 7:24 AM, Cristian Marussi wrote:
> Let the user specify an optional TARGETS skiplist through the new optional
> SKIP_TARGETS Makefile variable.
> 
> It is easier to skip at will a reduced and well defined list of possibly
> problematic targets with SKIP_TARGETS then to provide a partially stripped
> down list of good targets using the usual TARGETS variable.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 25b43a8c2b15..103936faa46d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -132,6 +132,10 @@ else
>   		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   endif
>   
> +# User can optionally provide a TARGETS skiplist.
> +SKIP_TARGETS ?=
> +TARGETS := $(filter-out $(SKIP_TARGETS), $(TARGETS))
> +
>   all: khdr
>   	@for TARGET in $(TARGETS); do		\
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> 

Thanks for doing this. This looks good to me. Would you like to
update the documentation file?

thanks,
-- Shuah
