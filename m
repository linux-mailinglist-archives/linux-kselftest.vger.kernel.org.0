Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB37223E6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjFEKyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFEKyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 06:54:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E83DF2;
        Mon,  5 Jun 2023 03:53:53 -0700 (PDT)
X-QQ-mid: bizesmtp64t1685962422tk6mmkxh
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 18:53:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: k8Irs33ik7tnjsoDgjWjI3LC4qOfQWHYM30jJacF0M6fVfrVsLBbwbcZG0OQy
        imap5Tt6ar5OuT1r9rwsuHV/ixWQwcEQr2dHZeJLjinsSBuTz+oWl2n4sj1DY8FIVkjygVj
        t7+cjT3hCJftPzZP/lhhhgS4sVv3cv2299aF0ehg4zpC+0f5zT4pMryksZ9cWI0+/lVLUxs
        /o3cdgI2pnHCjHFGkRkvaBt1VOzWLhThw6lF3ChLPJptM0z/1QBTX5P+8hfCKR6eEI+9Cu8
        nJLi+FQYPwpyARrWBtJcmH7U5ZMQ7E2GY0X2Pm+kuewb6YBsM16rSys4880GZ8S4MezifVW
        +HnBmWGGSEk5Ajsjjj322+prpWJJPa7Qiuq6FjPt3ENXY/NWj0Zf1fA+KjzwQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7363967119739023590
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        paulmck@kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH 0/4] selftests/nolibc: fix up and improve test report
Date:   Mon,  5 Jun 2023 18:53:32 +0800
Message-Id: <20230605105332.245553-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZH2BhWcRzvmvjzn8@1wt.eu>
References: <ZH2BhWcRzvmvjzn8@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, Jun 05, 2023 at 11:47:41AM +0800, Zhangjin Wu wrote:
> > Thanks very much for your merge of the v3 generic part1 of rv32, just
> > tested your latest 20230604-nolibc-rv32+stkp6 branch, everything work
> > well except a trivial test report regression on the 'run' target.
> (...)
> 
> I've squashed your fix into the pending patch and pushed branch
> 20230605-nolibc-rv32+stkp7. I have only tested userland (I really
> need to leave now, no time for a kernel build).
>

Just did kernel build + nolibc test for arm, aarch64 and rv64, no regressions
found.

> Zhangjin and Thomas, now that your last two fixes are merged, I'm
> assuming that Paul can take the branch any time. If you're seeing a
> showstopper that needs to be fixed, please let him know, and I'll
> deal with it once I'm connected again, but please no more attempts
> to further improve that branch for now (i.e. consider it merged for
> any future work so that we can finally settle on something).

Ok, let's work on v6.6 ;-)

Best regards,
Zhangjin

> 
> Thanks!
> Willy
