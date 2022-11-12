Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E709E626710
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Nov 2022 06:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiKLFCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Nov 2022 00:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiKLFCb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Nov 2022 00:02:31 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E421EEDD;
        Fri, 11 Nov 2022 21:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668229346;
        bh=UKrCkq3xKMj8sSLZqZpNU4Q0Lx+VN8Ps1Ny3URH+YVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QmE6AoM+jI44+Oi9YGeGF/G31TjtOxWtVxOKz3GCaCfSZg+40W10fxg+rqDj8CJLb
         z8NQHFOqwcGKR9AaybqOHkPClgoyKSgiGw9z7pMq2qF0os55MLgZMaRfGia9a1q4Y0
         C3tolvT9EAgL33Hg2y5Ejh5fcPA32Gd/7jggYlj4=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 450F4C4; Sat, 12 Nov 2022 13:01:05 +0800
X-QQ-mid: xmsmtpt1668229265t93w5drhr
Message-ID: <tencent_5695C257F3D13F4417034BA1FBAC95CB3B07@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnrr4E/kVfuAaOl1xdaPmH2g5MNcAlnARbTJTbpo2cOTjBhWNPR5
         uGpsVe1XUsORP3gpZQmITaJAeWOU6WToXQr8yE9Eojcu1DpdAdsk4lE9iwL04PEGNPaxPVol36N5
         W0zrLApB5zjHdUMxGZ/+0skjluPgfcViwQtw+YRsmmUNnkjOJi2UAMPx7U+l2OmDha5M+BcjDqbn
         GqJsdbk0WDCIZpdggcJZboR4Rgp9CqT0qa0hFmPz7JxN8U1fpM6Vre5Hd37W16JgIjInFjEbcF+4
         ru6MbpqBnGDcM47iWxssziI3GKPo+Lr3hLFt815RGapVRRYXCOWnWXWzJDZXBZrb2LQElxGaqaPq
         MTh/2hCcjZT1QCZNDUHTAzh+aNE6HaSZmVZVPDmLlgh3JKQpdxtTb6pS5SYJDGzRlEy09oU/peAx
         ZLMQggZFLf6NZo5srGxkIttroOSR0eBnoQLFQtGXhkrDdtWKacevNdRN0MO6shMziVNjXTxYDiMQ
         BD45EE5UaAxxv4gSr0bT8jY9UYwNUWDRqTYms5YnBsy04IU3kFZffsrCZM1BrX0czsfNLE1JYQYY
         k/Me8aVOjGwKsIeGD1f/YsauWxhGEKH6ooD69baH8cg3gCe/qNewUYKCpopvZPevBYXfEa+eZOCH
         uBlho+DLL7EeNRpf7WHrnngiVahhp6VQ2GS861E3gT+YQaEQOkPCRz/oplB33uvJBUYKiqMTigpz
         CgSvKsXYYHGamRV5UIFlZEAGQMD6FKDSYGUv6YVOQIv7vRtKQXW7w93+FNR6DC4iaLWe/XAZGbaE
         0iqWMYfpvMtpPqJbygyqkMHkjQwooiTEhx39CgQrXK7p+HD9w34duXzRuka3IrEbEdeHrUyYZ2zo
         SH0G3NidKkhxaCFcGXEKYLn4mb4AgHUErt4nHzr6FwkYoDd+bJ84E2ktHfjiANIMPa2JWd3N+6oV
         +J7Ljiap2SQNvqbFfIPAOqYdOg2bxXQMpISlFq5pFZ2lrlZj405A==
From:   Rong Tao <rtoax@foxmail.com>
To:     sj@kernel.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        rongtao@cestc.cn, rtoax@foxmail.com, shuah@kernel.org,
        yuanchu@google.com
Subject: Re: Re: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date:   Sat, 12 Nov 2022 13:01:04 +0800
X-OQ-MSGID: <20221112050104.22783-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221111173855.108360-1-sj@kernel.org>
References: <20221111173855.108360-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Park, I just search on GCC source code, found GCC support
"-Wstringop-overread" at least gcc-11.1.0, commit d14c547abd48("Add
-Wstringop-overread for reading past the end by string functions.").

AND found a testsuite gcc/gcc/testsuite/gcc.dg/pragma-diag-10.c

 10 #pragma GCC diagnostic push
 11 #pragma GCC diagnostic ignored "-Wstringop-overflow"
 12 #pragma GCC diagnostic ignored "-Wstringop-overread"
 13   if (c != 0)
 14     return __builtin_memchr (s, c, (unsigned long)-1);
 15 #pragma GCC diagnostic pop

it's totally same as this PATCH.

I think the motivation for this patch is to eliminate the compilation
warning, maybe one day we will compile the kernel with "-Werror -Wall",
at which point this compilation warning will turn into a compilation
error, and in case we already know it, we should fix this error in
advance.

For old gcc, we can add this?

 #pragma GCC diagnostic push
+#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
 /* Ignore read(2) overflow and write(2) overread compile warnings */
 #pragma GCC diagnostic ignored "-Wstringop-overread"
 #pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif

What do you think?

Good day!
Rong Tao
