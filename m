Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6858B723A9F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjFFHyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjFFHx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:53:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8910DE;
        Tue,  6 Jun 2023 00:49:57 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9FA46602242;
        Tue,  6 Jun 2023 08:49:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037796;
        bh=usPMufmDzuBOCEzo23gPEz247KJx0Gj7Q/7CWBmyGBg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=AfuYw65rewPWEzEcE2cn1a8WpAnJngEFkPjO/j2Z2N19zqvHa5LXIyBhg+ORY3Mfr
         P3OXJuPYtlpS7QSs0+l6Gyw6ndruGDu2bfwLwm27JatkLAacYx1J0dQCuDvX1lE1pZ
         VU5Tkq4GFhoOiMAk/5/hwuAjPxEwXdIiaqF1IPEiqymjLzLlOFfYucky1MxklhJdiN
         b6XHGNnOEtCWkjvV9esaPWT9eldKyo2DA/YzjJhGOfrCPco5OVluLHDS7osFvNUF7q
         6fQpaSynIgl6BKsMoGPPEbTxpN35wDxvXi2Vh5lM0Nnjxng9O/r3Sm4tcHR7xiW9tY
         ND61zjbCfQ9qw==
Message-ID: <08bf8e05-3c64-1f1b-d6d7-f542a7026c6f@collabora.com>
Date:   Tue, 6 Jun 2023 12:49:49 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] selftests/mm: fix "warning: expression which
 evaluates to zero..." in mlock2-tests.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-4-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-4-jhubbard@nvidia.com>
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
> The stop variable is a char*, and the code was assigning a char value to
> it. This was generating a warning when compiling with clang.
> 
> However, as both David and Peter pointed out, stop is not even used
> after the problematic assignment to a char type. So just delete that
> line entirely.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/mlock2-tests.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 11b2301f3aa3..80cddc0de206 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -50,7 +50,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>  			printf("cannot parse /proc/self/maps\n");
>  			goto out;
>  		}
> -		stop = '\0';
>  
>  		sscanf(line, "%lx", &start);
>  		sscanf(end_addr, "%lx", &end);

-- 
BR,
Muhammad Usama Anjum
