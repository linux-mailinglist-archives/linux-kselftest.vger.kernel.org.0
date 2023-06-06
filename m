Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A09723AC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFFH6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjFFH6W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:58:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBCA1FC1;
        Tue,  6 Jun 2023 00:55:38 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B73D6600359;
        Tue,  6 Jun 2023 08:55:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038121;
        bh=fLoyE29jwAeZymQXtcLwzwFxwOHx58ue1ihixP2knDc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=H0Sfp4f89qEuDMkNJ8J/XXRTGjc69n7zYEiu4g3yPCu41jdMi1mWoJybEs9Zlf/A1
         kjuPQwGabfoTINNKRCBVzF4l68/qtBZCcwp89Ty7odG2oR63eiWFKHkf9eEQImh/Mx
         cSPJa4nnO5ojWa9jZp9wk/LqqfisW88lCSBX4/7/hkpi9NmWg1yDpZCPIh4pgmr7Mm
         VObjbe5iFx/KqGYDIpGwbBS3gk2BFs1LYCYcpmwcNdPUPkBAc7rV3R+725+7ePltF+
         ABa5rNyjy70Q6oFf4RGnXrsVKrMU376LPpxNTrAg5NwkIeN4dmb3aEpy3rOMRG2Fyj
         PLJ7J8Lv2/HNQ==
Message-ID: <1acf4b3a-71b7-3412-fe83-a9b730530583@collabora.com>
Date:   Tue, 6 Jun 2023 12:55:16 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] selftests/mm: fix a "possibly uninitialized"
 warning in pkey-x86.h
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-8-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-8-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 12:16 PM, John Hubbard wrote:
> This fixes a real bug, too, because xstate_size()  was assuming that
> the stack variable xstate_size was initialized to zero. That's not
> guaranteed nor even especially likely.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/pkey-x86.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
> index 72c14cd3ddc7..e32ae8a1cd99 100644
> --- a/tools/testing/selftests/mm/pkey-x86.h
> +++ b/tools/testing/selftests/mm/pkey-x86.h
> @@ -132,7 +132,7 @@ int pkey_reg_xstate_offset(void)
>  	unsigned int ecx;
>  	unsigned int edx;
>  	int xstate_offset;
> -	int xstate_size;
> +	int xstate_size = 0;
>  	unsigned long XSTATE_CPUID = 0xd;
>  	int leaf;
>  

-- 
BR,
Muhammad Usama Anjum
