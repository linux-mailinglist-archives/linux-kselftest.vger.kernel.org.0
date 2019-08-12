Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C38A0FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2019 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHLOZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Aug 2019 10:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHLOZt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Aug 2019 10:25:49 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E3620665;
        Mon, 12 Aug 2019 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565619948;
        bh=dnLPVpEUWOO5jDD79kMhEtPATXAMvxJya3SuCzucbT4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Gu7RkPlXykG7GIHnPPD7Pwx2t1jhIQ8Oxcdju5Yoj9uuNETYQLsJxkEMaY8jvi4Gu
         p/lev0jWc8wzWMXVbIrU1g7hHDKlb2A+MMR9xZsrBWep4y5fgj8+xxNyw8BDDmTvAs
         qI+4BJ6hz/zJbajZ2ofsnc4gX1cxiGOrVpAW6A+g=
Subject: Re: [PATCH 3/3] selftests: ir: fix ir_loopback test failure
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190810114458.8883-1-sean@mess.org>
 <20190810114458.8883-3-sean@mess.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7b612199-542e-a4e6-6544-3cd4936f72e4@kernel.org>
Date:   Mon, 12 Aug 2019 08:25:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810114458.8883-3-sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/19 5:44 AM, Sean Young wrote:
> The decoder is called rc-mm, not rcmm. This was renamed late in the cycle
> so this bug crept in.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   tools/testing/selftests/ir/ir_loopback.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
> index e700e09e3682..af7f9c7d59bc 100644
> --- a/tools/testing/selftests/ir/ir_loopback.c
> +++ b/tools/testing/selftests/ir/ir_loopback.c
> @@ -54,9 +54,9 @@ static const struct {
>   	{ RC_PROTO_RC6_MCE, "rc-6-mce", 0x00007fff, "rc-6" },
>   	{ RC_PROTO_SHARP, "sharp", 0x1fff, "sharp" },
>   	{ RC_PROTO_IMON, "imon", 0x7fffffff, "imon" },
> -	{ RC_PROTO_RCMM12, "rcmm-12", 0x00000fff, "rcmm" },
> -	{ RC_PROTO_RCMM24, "rcmm-24", 0x00ffffff, "rcmm" },
> -	{ RC_PROTO_RCMM32, "rcmm-32", 0xffffffff, "rcmm" },
> +	{ RC_PROTO_RCMM12, "rcmm-12", 0x00000fff, "rc-mm" },
> +	{ RC_PROTO_RCMM24, "rcmm-24", 0x00ffffff, "rc-mm" },
> +	{ RC_PROTO_RCMM32, "rcmm-32", 0xffffffff, "rc-mm" },
>   };
>   
>   int lirc_open(const char *rc)
> 

Thanks Sean! Please cc - linux-keseltest makling list on these patches.

I can take this through my tree or here is my Ack for it go through
media tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
