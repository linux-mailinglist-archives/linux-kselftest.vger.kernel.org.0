Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936237C67F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbjJLIHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347243AbjJLIHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 04:07:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FD90;
        Thu, 12 Oct 2023 01:06:57 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.217.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C80FB6607334;
        Thu, 12 Oct 2023 09:06:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697098016;
        bh=yTMOxirkSsfi40134zfm8Df7fb3tsgxzrLHw09uiTt0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Yg3t2OfWI6DpDHvhjd/0qpO/Nx+icjlIuiMDPHPGOlFE//iEJd6k75n2eucjGAJby
         VEUD21UE9nsOdG5/vr1+Cd/AMi/BdAaG3Kn4mn/HLuG3GLW7ZFLO7c6AOSJdPxXfsR
         CFdavNmyJp+PRonMc5rU4LfQc0DfMn8pgaW6Krzn9cGNC4dNXlrJgFoIERysZhRAlB
         TnMwXmDe0Kqg0mtzk9mrVCM+c7mvhDrAysrJyr11gJSEMr9Qt4ryNm6R/BwT3wIuNZ
         EOMIgRHTJ+NnvD1PPmO3zBZPWE01wRBMsvq8vTm/tpe9226k77ERYh0Y+V9xU3BUGv
         PmYtrBxUZyUEg==
Message-ID: <3be75492-36e7-4ffe-ab0e-ef583b801af1@collabora.com>
Date:   Thu, 12 Oct 2023 13:06:48 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/mm: include mman header to access
 MREMAP_DONTUNMAP identifier
Content-Language: en-US
To:     Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        akpm@linux-foundation.org, shuah@kernel.org
References: <20231012064048.433346-1-samasth.norway.ananda@oracle.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231012064048.433346-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/23 11:40 AM, Samasth Norway Ananda wrote:
> Definition for MREMAP_DONTUNMAP not present in the selftest for
> mremap_dontunmap thus throwing an undeclared error when running make
> on mm.
Thanks for sending the patch.

You have mentioned in other email that MREMAP_DONTUNMAP isn't present in
glibc older than 2.32. So including linux/mman.h solves the build error for
people having older glibc. Please add this to the description of the patch
to give the exact reason this patch should be accepted.

> 
> Fixes: 0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-mm/CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com/
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  tools/testing/selftests/mm/mremap_dontunmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
> index ca2359835e75..a06e73ec8568 100644
> --- a/tools/testing/selftests/mm/mremap_dontunmap.c
> +++ b/tools/testing/selftests/mm/mremap_dontunmap.c
> @@ -7,6 +7,7 @@
>   */
>  #define _GNU_SOURCE
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
BR,
Muhammad Usama Anjum
