Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5B52FA98
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiEUKPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiEUKPO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 06:15:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7033492D11;
        Sat, 21 May 2022 03:15:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 77A5C1F465E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653128111;
        bh=U5YYJMFVDj3+ZXv5ZAFidJafbwiSoIY5HnfXpGh6rAQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=oMoyK3w1YJ2PVNfPvw+RD6t1fHMeeqpJmiDcE8SpeQ/4muCzkrsfGVkHgvqJ9C6Hn
         N88TlBup/hKQ3eFIWH9s0JoZvlDU8HHTOh6SWzS5BSSymMx96ikENa15ZWXHKAAaID
         PHVtndYhUdryLb8NM7id4YsBl1GrJ9G0SyFwd7ckZBB4o0yWbX26QprnBdiNu1Dgng
         BHgEzene+7JSCWDzDkdfHhTRnlb/4V/KG1eoK5AYJEiB1qLWyE1STxBG96D2/5DVch
         eDRa7e7UEBzQV8bq6hqPJLRjjl8/Uhh9w3mEZW1GJPiltOKPxE8Kjb/jC52lITXsAh
         d83BYBjPrh67A==
Message-ID: <0d63c264-520c-687d-7ac6-26cb3f119f0b@collabora.com>
Date:   Sat, 21 May 2022 15:15:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, daniel@ffwll.ch, tj@kernel.org,
        hridya@google.com, christian.koenig@amd.com, jstultz@google.com,
        tkjos@android.com, cmllamas@google.com, surenb@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 6/6] selftests: Add binder cgroup gpu memory transfer
 tests
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220510235653.933868-1-tjmercier@google.com>
 <20220510235653.933868-7-tjmercier@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220510235653.933868-7-tjmercier@google.com>
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

On 5/11/22 4:56 AM, T.J. Mercier wrote:
>  .../selftests/drivers/android/binder/Makefile |   8 +
>  .../drivers/android/binder/binder_util.c      | 250 +++++++++
>  .../drivers/android/binder/binder_util.h      |  32 ++
>  .../selftests/drivers/android/binder/config   |   4 +
>  .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++++++
>  5 files changed, 820 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/android/binder/Makefile
>  create mode 100644 tools/testing/selftests/drivers/android/binder/binder_util.c
>  create mode 100644 tools/testing/selftests/drivers/android/binder/binder_util.h
>  create mode 100644 tools/testing/selftests/drivers/android/binder/config
>  create mode 100644 tools/testing/selftests/drivers/android/binder/test_dmabuf_cgroup_transfer.c
> 
> diff --git a/tools/testing/selftests/drivers/android/binder/Makefile b/tools/testing/selftests/drivers/android/binder/Makefile
> new file mode 100644
> index 000000000000..726439d10675
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/android/binder/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall
Please add $(KHDR_INCLUDES) here to include the uapi header files from
the source tree.

> +
> +TEST_GEN_PROGS = test_dmabuf_cgroup_transfer
Please create a .gitignore file and add test_dmabuf_cgroup_transfer to it.

> +
> +include ../../../lib.mk
> +
> +$(OUTPUT)/test_dmabuf_cgroup_transfer: ../../../cgroup/cgroup_util.c binder_util.c

-- 
Muhammad Usama Anjum
