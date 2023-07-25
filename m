Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC37609BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGYFup (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGYFuo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 01:50:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00330B6;
        Mon, 24 Jul 2023 22:50:41 -0700 (PDT)
X-QQ-mid: bizesmtp74t1690264232t6aj6ad7
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 13:50:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: UMQM+3VOEYuos1q43ad++BizDHi3jbZwiXqFFoFFyNjff1KQTQejM6Umaz2M8
        LRfu3W0i16rmSFpWanrWLLaSEi7tDkDDpxCIkG6N1db3KZYHcO+ZUfTM+8sWs/MnnvvQvC4
        ms5Z/qbbNTjJMRzsV2zvC1s+fKVeFrxvru1ljNZDHEWWnsZ+OkosacQnNNyACjuSfmwqCIy
        7b9/Raq4l+l8Vj/iR/X+YGbozW2WhJW33CEEc/w5TAGqIALgsXLOQPNObB4uXzGFr0z+OTp
        VCm55zMLjvlzo+WP2f/04t2nCcsgGwLMzs3s807szRb0sm3EKCMFoYABtjlcMhJ3QxPGJWy
        q5dSbhe6McIGKfDEWPGTdWJ+KiVtK/DRI8XNuVcBDRwNW5RvWQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4846309137526785037
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64
Date:   Tue, 25 Jul 2023 13:50:31 +0800
Message-Id: <20230725055031.15203-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722121019.GD17311@1wt.eu>
References: <20230722121019.GD17311@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> 
> On Wed, Jul 19, 2023 at 05:18:32AM +0800, Zhangjin Wu wrote:
> >  # ARCH is supported by kernel
> > +ARCH_powerpc64   = powerpc
> >  ARCH_powerpc64le = powerpc
> 
> And similarly let's simply call this one ppc64.
>

Well, I like these short ones too, what about also a ppc alias for
powerpc?

    ARCH_ppc     = powerpc
    ARCH_ppc64   = powerpc
    ARCH_ppc64le = powerpc
  

> Aside these few comments, the series looks nice, thanks!

Have applied all of your suggestions, thanks very much.

Best regards,
Zhangjin

> Willy
