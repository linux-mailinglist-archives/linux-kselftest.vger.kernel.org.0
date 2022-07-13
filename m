Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F563572E4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiGMGiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 02:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGMGiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 02:38:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06904D5167;
        Tue, 12 Jul 2022 23:38:19 -0700 (PDT)
Received: from [192.168.0.24] (86.166.5.84.rev.sfr.net [84.5.166.86])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 254F166015B8;
        Wed, 13 Jul 2022 07:38:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657694298;
        bh=JeMidlcjsMt2NttqZPspM91gWwt1ujhVbq5qh8dmUQQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=gIWYNlnmQZZ3N4WcTGpDAgR7IM1S5P5eavZ4S1331HQNTJ2Txs6276tbW6uFJKlxa
         NE6oFGeYwMbjpr6oq4osxylO5EH0PxNsl5r+AWzxvx+JiqfY1sv8hT8x0d0Fh3ONyd
         OBYbeF6wYKXNEDwV43XWQGQLOfY1jycnRK/ujuh6NE2v6kwiEjTPo7w+Zi/31j7UcQ
         Sd1QDAu4tsludW1wjMaEdY7l/y6Z5hi44OsM7ij5xEfmsE2IKZCRs90x6sUIR/NsE6
         sbfCv5lOW679WMBHdUnSGNrSbz3Gyf8kKHHaf+MjMmLqOlBGg/HPIHSACN3qkRRvEt
         2qRlGNqkrrDdg==
Message-ID: <168ede35-12e0-c535-9d94-23b65a1beb28@collabora.com>
Date:   Wed, 13 Jul 2022 08:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] Makefile: add headers_install to kselftest targets
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
 <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
In-Reply-To: <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/07/2022 18:23, Guillaume Tucker wrote:
> 
>   $ make O=build headers_install
>   $ make O=build -C tools/testing/selftest all

Typo, it should be selftests:

    $ make O=build -C tools/testing/selftests all

Thanks,
Guillaume
