Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0A52FCEC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiEUNij (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbiEUNii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 09:38:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06C6EC65;
        Sat, 21 May 2022 06:38:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 54DC41F45EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653140314;
        bh=j9f2V5Zxh9yuwQmxlQWv50QaI2FGhN8Kn1Vpx9SxtRA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=MYYwBif3PEkSuh/MdFn1sRqZrgGIxJtsd8CYrNrZqpLbvt//UTuVpyzysbtYXB89I
         uQKcsdODyzM6PRM/EovYCnVF1BKQZBcUb1i5L/cj9PbpD2Ojk0D48UkZ3BPPadx7pG
         mjeZOlbNs9I5j5W0zoKMMbr6eOFlCYnRK3DUoZY1G8X584fxiF30EqZKaeYP5vjxOk
         2tjwVUrVwAndiv9itlXqKZEpT16slMJelVSgcWN65FSnjEFVDi47sLnehGtVAqBFtn
         xj/gWPFCmRH0/lryQzysLUc/2sNXD85+R3h4PK+DIj970WmEbPOFVG6qz/FunWUxbC
         cU2LNTI4aW/ng==
Message-ID: <1e2931e1-afc3-14bf-d72a-a267574c2b97@collabora.com>
Date:   Sat, 21 May 2022 18:38:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE
 test
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220519092343.2776414-1-javierm@redhat.com>
 <20220519092343.2776414-4-javierm@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220519092343.2776414-4-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/22 2:23 PM, Javier Martinez Canillas wrote:
> diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
> new file mode 100644
> index 000000000000..93ee73c16828
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fat/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS := run_fat_tests.sh
> +TEST_GEN_PROGS_EXTENDED := rename_exchange
Create a .gitignore file and add rename_exchange to a .gitignore like
other tests.

> +CFLAGS += -O2 -g -Wall -I../../../../usr/include/
> +
Include $(KHDR_INCLUDES) instead of "-I../../../../usr/include/" here.

> +include ../../lib.mk

-- 
Muhammad Usama Anjum
