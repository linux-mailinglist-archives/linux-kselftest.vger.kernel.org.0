Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58362532CA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiEXOyU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiEXOyS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 10:54:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C96EC46;
        Tue, 24 May 2022 07:54:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 2319D1F43080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653404055;
        bh=k5OX95HbBLW6/3MZt89HO8rM2fIhljz076cqcrPbFY4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ffLtEKY/+PRMFgmAMbqx0/a2UvN/vMNfFgJXa+cEo/BPwpnHmDE2bIjCYczbxSzf/
         BgietX5cA+fGX47/j5O1cKWMd8KXNRu7Q+B+2biR8mLX2AyBJRnPjkQ9S/xY/iwT89
         BHCYna7nJVKjZD/lmHnM1/JXOWyJSg+OT3Q655fCshARxlN2ZBXn6BtXq0/Bdf7D1d
         +vNx+iRiqLCrAx6uV3HjZmQsjjiNqJY4L70BB4B+Fu+SMcvnyE9x1NgJVAvXQ+f4N/
         aIs9+zlh6mjG6QoUnivk783/1p2vSyQXyf+aC6pFfMXlDwiLmIq7VDtEshIz1P82Ep
         st3W6daIQ9zxw==
Message-ID: <170151f7-9d46-6b01-e281-0f675a3b523f@collabora.com>
Date:   Tue, 24 May 2022 19:54:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     usama.anjum@collabora.com,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE
 test
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220524073604.247790-1-javierm@redhat.com>
 <20220524073604.247790-4-javierm@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220524073604.247790-4-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/22 12:36 PM, Javier Martinez Canillas wrote:
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
Please create a .gitignore file and add rename_exchange to it.

> +CFLAGS += -O2 -g -Wall -I../../../../usr/include/
Build may fail if kernel on which this test is being build has old
headers. Always use $(KHDR_INCLUDES) instead of
"-I../../../../usr/include/" to use the kernel headers from the kernel
source instead of the natively installed headers.

-- 
Muhammad Usama Anjum
