Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B000702CC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbjEOMcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjEOMcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 08:32:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E38CE44;
        Mon, 15 May 2023 05:32:27 -0700 (PDT)
Received: from [IPV6:2a0c:5a83:9203:ad00:2382:dff5:d060:ac62] (unknown [IPv6:2a0c:5a83:9203:ad00:2382:dff5:d060:ac62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E05166031DA;
        Mon, 15 May 2023 13:32:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684153946;
        bh=8UJkKw6fGhISejBa/aG9A4bSXYVrTYUy3Vsdf1Iq5rs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hTHvzpVbPOz1xFZalZetFz981HIplYGOgbxRyKqF4AiUwVeCYaEddJ8IdMQPXPmIW
         NEvuo39IlSlBPn/nnV4/UH/MBTHiuUIYLcETERWpVrFI7emgotYZsP5BxjJEoUdfLu
         +2aaLEAG9DK5nfSWPtRRbz45D52t8IoNlOv2m9SCQCnvHru279C4jtAG7ZA1Oua1jB
         6+m1n+ZaOyWv+5VgS2vUhreR/M4n7dIE3whYwTwWxzm7phsxBFAm2nUAf51CQhVQd3
         LOUveiWlJaK6kzyMKR6XLnt//0PKmcEfaLdttlXdVg7uKKJ57Iu+Y8nbIKMImuIY/K
         9o0y6BrYey0Bw==
Message-ID: <aab36e10-ce86-9374-ea67-be6d1a0f4adf@collabora.com>
Date:   Mon, 15 May 2023 14:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: selftests: mincore: mincore_selftest fails only on qemu-armv7
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com>
 <a9e9a1a7-346a-475e-961c-ec8568613b45@kili.mountain>
Content-Language: en-US
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <a9e9a1a7-346a-475e-961c-ec8568613b45@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

On 15/5/23 13:51, Dan Carpenter wrote:
> The test is wrong.  It doesn't accept -EINVAL as a valid failure.
> 
> tools/testing/selftests/mincore/mincore_selftest.c
>     139  TEST(check_huge_pages)
>     140  {
>     141          unsigned char vec[1];
>     142          char *addr;
>     143          int retval;
>     144          int page_size;
>     145
>     146          page_size = sysconf(_SC_PAGESIZE);
>     147
>     148          errno = 0;
>     149          addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>     150                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>     151                  -1, 0);
>     152          if (addr == MAP_FAILED) {
>     153                  if (errno == ENOMEM)
> 
> On Armv7 is a 32bit machine so HUGETLB isn't enabled and the errno can
> be -EINVAL.  It's has returned this for 10 years.
> 
>     154                          SKIP(return, "No huge pages available.");
>     155                  else
>     156                          TH_LOG("mmap error: %s", strerror(errno));
>     157          }
>     158          retval = mincore(addr, page_size, vec);
>     159          ASSERT_EQ(0, retval);
> 
> mm/mmap.c
>    1405                  }
>    1406          } else if (flags & MAP_HUGETLB) {
>    1407                  struct hstate *hs;
>    1408
>    1409                  hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
>    1410                  if (!hs)
>    1411                          return -EINVAL;
>                                  ^^^^^^^^^^^^^^^
> hstate_sizelog() return NULL when CONFIG_HUGETLB_PAGE is disabled.
> 
>    1412
>    1413                  len = ALIGN(len, huge_page_size(hs));
> 
> regards,
> dan carpenter
> 

Thanks for the tip, Dan. I'll send a patch for it asap.

Cheers,
Ricardo
