Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7778E558
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 06:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbjHaEMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 00:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjHaEMX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 00:12:23 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEEDE42;
        Wed, 30 Aug 2023 21:12:11 -0700 (PDT)
X-QQ-mid: bizesmtp69t1693455124t62lzhoe
Received: from linux-lab-host.localdomain ( [116.30.129.10])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 31 Aug 2023 12:12:03 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2951270669692478245
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        shuah@kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v2 0/2] nolibc: remove reliance on system headers
Date:   Thu, 31 Aug 2023 12:12:02 +0800
Message-Id: <20230831041202.5896-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZO+rJv/ZNokkyWpL@1wt.eu>
References: <ZO+rJv/ZNokkyWpL@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Wed, Aug 30, 2023 at 05:07:11PM +0200, Thomas Weißschuh wrote:
> > This was prompted by the discussion about output directory support with
> > O=.
> > It seems sometimes we were pulling in system headers making testing
> > annoying and unreliable.
> > 
> > Willy:
> > 
> > I did not implement the '#ifdef va_start` guard that we discussed
> > before. In my understanding the latest agreement does not need it
> > anymore. Please let me know if this is incorrect.
> 
> No that's fine given your goal of including just "nolibc.h" and no
> other regular include file, I agree. I've just merged it and pushed
> it to the -next branch.
>
> Thank you Thomas!
> Willy
> 
> Subject: [PATCH v2 1/2] tools/nolibc: add stdarg.h header
> 
> This allows nolic to work with `-nostdinc` avoiding any reliance on
> system headers.
>

A little typo in above commit message: nolic -> nolibc.

Thanks,
Zhangjin

> The implementation has been lifted from musl libc 1.2.4.
> There is already an implementation of stdarg.h in include/linux/stdarg.h
> but that is GPL licensed and therefore not suitable for nolibc.
> 
> The used compiler builtins have been validated to be at least available
> since GCC 4.1.2 and clang 3.0.0.
