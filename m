Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3F727D25
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjFHKso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFHKsm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 06:48:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBCFE6C;
        Thu,  8 Jun 2023 03:48:40 -0700 (PDT)
X-QQ-mid: bizesmtp83t1686221314tkp66wzp
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Jun 2023 18:48:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: tzTosAI5sKG9/AD2qzkS+TcfGVzdBYGznP13Vz9P+A9CFhz3e0QgveSKV4BBa
        2SLQ4GODkDKdStbPXqTq0XjbEXJ5XfT97k6C/IGA7SLQE4KMoITriJh6SXcqzEXFsEmO3vP
        UYAo4dO1FqrdaZ5CRyYn+TPO7/Bbt1Z2LEGCZCdjBJ6X563sH89mRqqAcDepVpnRiMi/2q2
        +Twpqfh15uZrCJvzzzppu5t2HM0n/yxOEzVAFyGDpWD8WyExZxJL3rFcYt2LxvSW6XDTEiy
        88zqsPSb3T3X+jkGKeDC5uOVVTIr8yd9eg/hfB7xIONzB8Qf0Qqr/qv1T8A7He+8Y/Krh/R
        TwumgtnvrW91Ig5K0pUywLl3LqLLbfO8uQqjHeNtguqj9rWUfA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14232647922915751446
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: nolibc: KTAP output and test reports
Date:   Thu,  8 Jun 2023 18:48:28 +0800
Message-Id: <20230608104828.38797-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
References: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> Hi Willy, Zhangjin,
> 
> after your recent discussions about the test output and report I
> wondered if it would make sense to switch nolibc-test to KTAP output
> format [0].

Just read the doc, it looks really good.

> 
> With this it would be possible to have a wrapper script run each
> architecture test as its own test subcomponent.
> A (K)TAP parser/runner could then directly recognize and report failing
> testcases, making it easier to validate.
>

Yeah, this is what can we benefit from the standard format.

> Also maybe we can hook it up into the regular kselftests setup and have
> the bots run it as part of that.
>

I did take a look at the other kselftests cases, seems lots of cases use
qemu to run the tests, perhaps we can share some of them. Not sure if
there are some libraries work on qemu test support, therefore, we can
reuse them.

> The kernel even includes a header-only library to implement the format [1].
> It also should be fairly easy to emit the format without a library.
>

Perhaps we can learn and discuss on how to use them at first, I'm a newbie to
both of them, but I'm really interested in running nolibc in the kselftest
framework ;-)

Thanks,
Zhangjin

> Thomas
> 
> [0] Documentation/dev-tools/ktap.rst
> [1] Documentation/dev-tools/kselftest.rst (Test harness)
