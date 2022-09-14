Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10E5B85A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiINJz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiINJzI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 05:55:08 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963077B281
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ehWrl3y+Wg0GBs71Zw1RTQVPegiwwGzXZB7B3+J31M4=; b=GoCZBoHDlBqjwKvlvWd3vM1L3A
        MY6KakRZZGOgIUc2Y5H9Qll9TMTR+4U77XWJ5pCYd0vNd5U2UVw5LvMVkv19/v2EwoUIJWSbT+Q0t
        aABfdhFSbz1il9WczLXUctN8SnUTYqvSGH56ul0rAt+NNv3Q9jggeQzq0/zEm28/r48LZe3kpUJD4
        Bxn1a60ybz7BFd0LmUOQ9Gu8cLG4W+vPNqHofH4AyD069vyE14SvwbCNelkaEjRsMEb7YEeRzZ8jQ
        Pma7K7Y3t+zDrG1QV/giQwDia6LHee/X4IYLaD13d/krsPWsZnnRFGJIutNVKMRmrafea1LTEO5Rf
        0JjTlWVQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtps 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oYP5N-000Bqj-UQ; Wed, 14 Sep 2022 11:53:37 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
        by mail.igalia.com with esmtp (Exim)
        id 1oYP5L-000QAS-7S; Wed, 14 Sep 2022 11:53:37 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
        by webmail.service.igalia.com with esmtp (Exim 4.94.2)
        (envelope-from <andrealmeid@igalia.com>)
        id 1oYP5K-0003Dj-BI; Wed, 14 Sep 2022 11:53:34 +0200
MIME-Version: 1.0
Date:   Wed, 14 Sep 2022 11:53:34 +0200
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-kselftest@vger.kernel.org, dvhart@infradead.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests/futex: fix build for clang
In-Reply-To: <20220909110709.1827374-1-ricardo.canuelo@collabora.com>
References: <20220909110709.1827374-1-ricardo.canuelo@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a5f6b1da7df0784536c7d7b70a0bc44e@igalia.com>
X-Sender: andrealmeid@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ricardo :)

On 2022-09-09 13:07, Ricardo Cañuelo wrote:
> Don't use the test-specific header files as source files to force a
> target dependency, as clang will complain if more than one source file
> is used for a compile command with a single '-o' flag.
> 
> Use the proper Makefile variables instead as defined in
> tools/testing/selftests/lib.mk.

Could you share how I can test this patch?

> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---
>  tools/testing/selftests/futex/functional/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile
> b/tools/testing/selftests/futex/functional/Makefile
> index 732149011692..5a0e0df8de9b 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -3,11 +3,11 @@ INCLUDES := -I../include -I../../
> -I../../../../../usr/include/
>  CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
> $(KHDR_INCLUDES)
>  LDLIBS := -lpthread -lrt
>  
> -HEADERS := \
> +LOCAL_HDRS := \
>  	../include/futextest.h \
>  	../include/atomic.h \
>  	../include/logging.h
> -TEST_GEN_FILES := \
> +TEST_GEN_PROGS := \
>  	futex_wait_timeout \
>  	futex_wait_wouldblock \
>  	futex_requeue_pi \
> @@ -24,5 +24,3 @@ TEST_PROGS := run.sh
>  top_srcdir = ../../../../..
>  DEFAULT_INSTALL_HDR_PATH := 1
>  include ../../lib.mk
> -
> -$(TEST_GEN_FILES): $(HEADERS)
