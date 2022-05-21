Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34552F956
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 08:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiEUGom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiEUGol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 02:44:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D815EA4C;
        Fri, 20 May 2022 23:44:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 341E41F469C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653115479;
        bh=vZubmbERibb5UaHu4PMlVt8DMsGhoRyewNkbdIiKYd0=;
        h=Date:Cc:From:Subject:To:From;
        b=gNXRFxou8H8JO0cVZ302YdprJ1+fZ5ZMjEoEOX1307xylbiC+nise/Jr16E//xkID
         Ct82n3t5g3WVn1G9SSxhICp1yIFcwzy1xCZ+2FSPIQo5Bi+hhBbG7jmm/lCTa+lqyU
         r//BWJIoUNYnyMLV24AXOZ8HTpqpSpk1xC9J5Z8wvVuEE083Q0DZ0yPwJB9a3FOCVi
         OOAevZ02WZxPKyiQmVJwGte6yyqju6v9tGcfGky4H/1iGBoboYLeRgKex0ZK7wNK1X
         SXzFbjNJvrTLRViz3tDbbBJn2tjk1hYUL2VrkZsmbn17lwGPJMeI/2Z8q/uRoZF8RL
         T1i53NT0TlDnQ==
Message-ID: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
Date:   Sat, 21 May 2022 11:44:32 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

kselftest can be built using the kernel's top most Makefile without
using kselftest's Makefile directly. But there is bug in the top most
Makefile. The build fails if the specified output directory is first
level sub-directory. Here is a example to reproduce this bug:

make kselftest-all O=build

"The Make is working in a wrong directory, that is why the relative path
does not work." Masahiro Yamada. Feel free to fix it if someone pin the bug.

It should be noted that the build works in some other combinations:
make kselftest-all (works)
make kselftest-all O=/tmp (works)
make kselftest-all O=build/build2 (works)

My unsuccessful attempt to fix this bug can be found here:
https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/

Thanks,
Muhammad Usama Anjum
