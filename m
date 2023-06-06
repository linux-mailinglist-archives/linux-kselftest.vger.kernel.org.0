Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68966723602
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjFFEFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 00:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFFEFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 00:05:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E4187;
        Mon,  5 Jun 2023 21:04:57 -0700 (PDT)
X-QQ-mid: bizesmtp90t1686024291togh83dg
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 12:04:50 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: BycE0arnt6Q+DiGmOoSjcqC6z29sE59MRf7cHm6kMbAvZqUe1qyvJ3e45WXlj
        4yYXcpXQWfFuthg9ilKta6hbzXqhvHEPFAA8dW+tNBRbZdY7y2g/sWo6j8StjMP5pNr47Wc
        0JrnssV0uWtql1ohfnWDQ6FgHT6OeKFLfJdpVI5E9zMfbZhMMavkU9fUr1vQsXgEVVNh753
        7f8Sn2ALmSu05e7H6+ENvQ/9eUcCNp4Ka36Zsj7OxLI18N6d1Ygp7hqWLm8aoSkrBaPrblS
        nkFPdhZcgBndjhG+L9v3dBEO6hf1bFtGObDUoTIuzojp3p0rPCJ+fSlVTuju4h6mfnWujez
        L7IPplN+Tt/SE1/064NwW51Hvj72g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13643759654165346408
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 0/4] selftests/nolibc: add user-space 'efault' handler
Date:   Tue,  6 Jun 2023 12:04:50 +0800
Message-Id: <20230606040450.353900-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c6129c15-7e95-4f6c-b4db-c6b5daa6d3cc@t-8ch.de>
References: <c6129c15-7e95-4f6c-b4db-c6b5daa6d3cc@t-8ch.de>
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

> On 2023-06-04 13:05:18+0200, Willy Tarreau wrote:
> > Hi Zhangjin,
> > 
> > On Tue, May 30, 2023 at 06:47:38PM +0800, Zhangjin Wu wrote:
> > > Hi, Willy, Thomas
> > > 
> > 
> > Just let us know if you think that's something you could be interested
> > in exploring. There might be differences between architectures, I have
> > not checked.
> 
> If the goal is to handle hard errors like segfaults more gracefully,
> would it not be easier to run each testcase in a subprocess?
> 
> Then we can just check if the child exited successfully.
>

Yeah, it is easier, it may be possible to simply pass the test case to
something like test_fork() and let the child to run it there.

I will take a try, thanks very much.

> It should also be completely architecture agnostic.

It is for we can reuse the test_fork() stuff.

Best regards,
Zhangjin

> 
> Thomas
