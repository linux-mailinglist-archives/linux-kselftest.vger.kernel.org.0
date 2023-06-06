Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9957723AD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFFIAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbjFFIAB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:00:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AA1701;
        Tue,  6 Jun 2023 00:57:22 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB02B6602242;
        Tue,  6 Jun 2023 08:57:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038240;
        bh=dJtVN800iAdfG6CXzYYZqT/neQHYc3IrMQgEit0f8wc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=T1C3aAq66y3wj7+W1Khrrvy7RTIpSiw+Uvnx1xeap31IJZZgxRZR4REQONavel+nV
         oLUM+7W7k1QSlZq9I0cBA1et5P0hB0MxkEK53PciylO6OTZjyNsY8ceZH6d8hqQsEw
         31Ry3hLxKP7/+ASkqt2j4JxXY4DPxEYFZNYeg20tGiKw3LxGe71ndDbaWNHR60xAyK
         yF+ZT6SQrRoip7IAK5gdHCOlyGVO3ZHCHUFITZD5BekIm0wmd/qiiHZnufCErZLoC+
         oF2wNbl3bXX3cqO6om+gI9S9+g+QhVcsf8XF3JkBaqEVYu0gYwc3WAnbiw7ukxuXM5
         9dftH1605Gwcw==
Message-ID: <c10cac6f-7170-0865-bca9-52310196df56@collabora.com>
Date:   Tue, 6 Jun 2023 12:57:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 10/11] Documentation: kselftest: "make headers" is a
 prerequisite
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-11-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-11-jhubbard@nvidia.com>
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
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>     make headers && make -C tools/testing/selftests/mm
> 
> However, that's not yet documented anywhere. So add it to
> Documentation/dev-tools/kselftest.rst .
> 
> [1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  Documentation/dev-tools/kselftest.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 12b575b76b20..6e35d042199c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -36,6 +36,7 @@ Running the selftests (hotplug tests are run in limited mode)
>  
>  To build the tests::
>  
> +  $ make headers
>    $ make -C tools/testing/selftests
>  
>  To run the tests::

-- 
BR,
Muhammad Usama Anjum
