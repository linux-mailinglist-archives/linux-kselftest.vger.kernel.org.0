Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA7728532C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgJFUel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 16:34:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1832 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 16:34:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7cd4d20001>; Tue, 06 Oct 2020 13:34:26 -0700
Received: from [10.2.60.163] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 20:34:38 +0000
Subject: Re: [PATCH] selftests/vm: 10x speedup for hmm-tests
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20201003011721.44238-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6c07b012-4cfc-e89c-43f0-13266d71bf8c@nvidia.com>
Date:   Tue, 6 Oct 2020 13:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201003011721.44238-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602016466; bh=vC8aiUH6oYwpjzYwxS+gKtqylCBpiarACXAaIkYiZEM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=RJqfGKZik3ODyVLBzBTsrfS8Ull/oAJzjTHXWBol2ruz4L0FZz+Ogjy59v5S2krPl
         7De2UB+2JGx6/UakGY6TkoWvFeXLIWqmqP0RTdIcfMDqkGAX1sBjuaUDHgWJlZ3Afo
         ZK1YFB046OAsqA3bPfoK5u8wQACge6BR0Sa0nLPCS+4cCbAKuShr+2omayaZ8nqyov
         yck6z2dupJU6iLTBQUTa2UhDYPMP/YkNg4y+zPtUlBdHGrDnECQRe90KNtLj5OjaZf
         /5nceadIEVfO74PyAk7+BkcfcyGzrxyex91Q43Zf7vuQn4WybLM19EDGRbPeQO2xft
         3py58OHcDr3jg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/20 6:17 PM, John Hubbard wrote:
> This patch reduces the running time for hmm-tests from about 10+
> seconds, to just under 1.0 second, for an approximately 10x speedup.
> That brings it in line with most of the other tests in selftests/vm,
> which mostly run in < 1 sec.
> 
> This is done with a one-line change that simply reduces the number of
> iterations of several tests, from 256, to 10. Thanks to Ralph Campbell
> for suggesting changing NTIMES as a way to get the speedup.
> 
> Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Andrew, do you think we can get this one merged into mmotm? I think it's
pretty low risk.


thanks,
-- 
John Hubbard
NVIDIA

> 
> This is based on mmotm.
> 
>   tools/testing/selftests/vm/hmm-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 6b79723d7dc6..5d1ac691b9f4 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -49,7 +49,7 @@ struct hmm_buffer {
>   #define TWOMEG		(1 << 21)
>   #define HMM_BUFFER_SIZE (1024 << 12)
>   #define HMM_PATH_MAX    64
> -#define NTIMES		256
> +#define NTIMES		10
>   
>   #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>   
> 

