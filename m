Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76307618A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjGYMqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGYMqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 08:46:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F7FB;
        Tue, 25 Jul 2023 05:46:36 -0700 (PDT)
X-QQ-mid: bizesmtp75t1690289187tcpgjqxu
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 20:46:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: rZJGTgY0+YMD4rlm4GPuIeeH+yD3SbEuafkNjy7XI5sQSONJEJXlftsw0ZKC3
        BXRLz2n3NNgMdXI2tEXLiUdFo87wtGdWwwLCO/H70L/W5m7zgpDtJhN88SX3p/25/DZUc4+
        3jsP+/zrhvMZN+ql7/9iCmrLizi8TGKUVDcBqJQsuKzAyZGwY6RkhGUWbYnAAand2LhARqQ
        i2+7JbrO5DcYNW/bSu0B+cwq4bTPsztQk533dQhrm3fYhVGOaO5dp8+bq1AqbCzI6lSbM/a
        fPDJOKlo1BKPtaC3NPMYzXaLw22WGg3ZBhJ7KsvlTxedrkiTuOTimyT8Ke6StLoihG9aDo5
        wRx0jhUXMIm/x78UT4mUEcjn/iPj7Wcl7vO0UqW9w6HhdLrQKuAIDTzAst4Ww==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15751746732556440129
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 03/14] selftests/nolibc: print running log to screen
Date:   Tue, 25 Jul 2023 20:46:26 +0800
Message-Id: <20230725124626.35745-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722122926.GF17311@1wt.eu>
References: <20230722122926.GF17311@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Wed, Jul 19, 2023 at 09:20:17PM +0800, Zhangjin Wu wrote:
> > When poweroff fails, qemu-system will hang there without any output.
> > 
> > It is very hard to debug in such case, let's print the running log to
> > the screen to allow users to learn what is happening at the first
> > glance, without editing the Makefile manually every time.
> > 
> > To get a clean output, the 'grep status' command can be used.
> 
> The problem with doing this is that it rolls back to the initial
> version that breaks with qemu. When its stdout is sent to a pipe, we've
> found that the output got randomly mangled and/or missing contents.
> It's only when sent to a file that it's OK. I suspect it has something
> to do with non-blocking writes being used to avoid blocking the
> emulation but I could be totally wrong. That's the reason why we had
> to switch to a file.
>

ok, thanks for sharing the history, it is important.

> And I'd rather avoid starting it in the background as well. Maybe
> you'd want to run the qemu command under the "timeout" one ? That
> could be better than nothing.

Yeah, with the timeout logic, this may be not really required, so, let's
drop this patch and the LOG_OUT from the previous one.

with our timeout logic, we are able to quit qemu and then print the
running log to screen to tell users what happens background, let's
discuss timeout logic in its own patch.

Thanks,
Zhangjin

> 
> Willy
