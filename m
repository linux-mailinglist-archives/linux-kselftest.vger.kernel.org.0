Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B0743B70
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjF3MFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjF3MF2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 08:05:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1444AA;
        Fri, 30 Jun 2023 05:04:43 -0700 (PDT)
X-QQ-mid: bizesmtp72t1688126672t652b9nc
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 20:04:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: vLOCICHxEeAb0GlQ301aqzxbxGSaxjPZA1q5/3l0Tcb41pLyqUjcKxPWfkW19
        E4I+TjreMVr4hI7doeKYjPAR7LpyM3asEdCjbHQCJweaPeHwqoVcT47+jo3yw4WMF1kwsnT
        R7/hb6EddEkpJRd5m9xC6aFvRr8D/SK98pn9x99sqE47336VeAMCgUFfeBeQYGtKaQZGsBH
        rON48fOrsdpg0xRDthyiTKrkCPaSwuloIzTRlu+SDg2oxVQZkLlioblskVAr9HT2vcvWmjf
        +/9q/8gJgOC2lDln8H0jNpkAvKEKBwC2pxRADLwDXEC69JWsVB+Rm3eRGVod+BtWCTOYQgR
        igWxuMSS6hmXxOYqYq+x23uQQCRj8k0LwfGv79UJswCeuliIxIXUJXUahlIiKKi0wByQm3R
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5300123220790220409
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 00/15] allow run with minimal kernel config
Date:   Fri, 30 Jun 2023 20:04:30 +0800
Message-Id: <20230630120430.220395-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9b941cd7-1fb7-404d-a329-b831d20ce3de@t-8ch.de>
References: <9b941cd7-1fb7-404d-a329-b831d20ce3de@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-06-30 07:22:39+0800, Zhangjin Wu wrote:
> > Willy, Thomas
> > 
> > This is v2 to allow run with minimal kernel config, see v1 [1].
> > 
> > It mainly applied the suggestions from Thomas. It is based on our
> > previous v5 sysret helper series [2] and Thomas' chmod_net removal
> > patchset [3].
> > 
> > Now, a test report on arm/vexpress-a9 without procfs, shmem, tmpfs, net
> > and memfd_create looks like:
> > 
> >     LOG: testing report for arm/vexpress-a9:
> > 
> >     14 chmod_net                                                    [SKIPPED]
> 
> Shouldn't this be gone?
>

Yes, if apply your chmod_net removal patches before this series:

    LOG: testing report for arm/vexpress-a9:

    14 chmod_self                                                   [SKIPPED]
    16 chown_self                                                   [SKIPPED]
    40 link_cross                                                   [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

    139 test(s) passed, 4 skipped, 0 failed.
    See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

    LOG: testing summary:

         arch/board | result
        ------------|------------
    arm/vexpress-a9 | 139 test(s) passed, 4 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

This test also applied the new proposed chroot_exe and chmod_tmpfile
from https://lore.kernel.org/lkml/20230630111433.211130-1-falcon@tinylab.org/

> >     15 chmod_self                                                   [SKIPPED]
> >     17 chown_self                                                   [SKIPPED]
> >     41 link_cross                                                   [SKIPPED]
> >     0 -fstackprotector not supported                                [SKIPPED]
> > 
> >     139 test(s) passed, 5 skipped, 0 failed.
> >     See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
> > 
> >     LOG: testing summary:
> > 
> >          arch/board | result
> >         ------------|------------
> >     arm/vexpress-a9 | 139 test(s) passed, 5 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
> 
> > [..]
> 
> >  tools/include/nolibc/sys.h                   |  22 ++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 102 +++++++++++++++----
> >  2 files changed, 106 insertions(+), 18 deletions(-)
> 
> A few nitpicks left, mentioned on the patches themselves.
> 
> In general: for the full series.
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> 

Thanks Thomas, will send v3 later.

Best regards,
Zhangjin
