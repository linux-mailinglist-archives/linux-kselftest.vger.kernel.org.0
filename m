Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0D3D8DDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhG1Mbx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:31:53 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34530 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234683AbhG1Mbw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:31:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UhFo.B1_1627475508;
Received: from 30.21.164.90(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhFo.B1_1627475508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Jul 2021 20:31:48 +0800
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
Date:   Wed, 28 Jul 2021 20:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> When running the openat2 test suite on ARM64 platform, we got below failure,
> since the definition of the O_LARGEFILE is different on ARM64. So we can
> set the correct O_LARGEFILE definition on ARM64 to fix this issue.

Sorry, I forgot to copy the failure log:

# openat2 unexpectedly returned # 
3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] 
with 208000 (!= 208000)
not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails 
with -22 (Invalid argument)

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   tools/testing/selftests/openat2/openat2_test.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index d7ec1e7..1bddbe9 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -22,7 +22,11 @@
>    * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
>    */
>   #undef	O_LARGEFILE
> +#ifdef __aarch64__
> +#define	O_LARGEFILE 0x20000
> +#else
>   #define	O_LARGEFILE 0x8000
> +#endif
>   
>   struct open_how_ext {
>   	struct open_how inner;
> 
