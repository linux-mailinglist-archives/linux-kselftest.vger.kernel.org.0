Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B338C74C7DF
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGIToW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGIToW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 15:44:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFDE8;
        Sun,  9 Jul 2023 12:44:19 -0700 (PDT)
X-QQ-mid: bizesmtp68t1688931848tema44dq
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 03:44:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: lO87fmWkX3H2QuidU/Qifug9t33Re8cxsSsqd3qJgn/fthj7GaPFRV0CDQrMt
        DzcdOdM0gzFuuhCLfa/hDEp9Brv5n/FVzLLUk7/LOns3sgPnVhki16JPjAoWB2TcbO9H+18
        /5L+rCMfhY6L6+KEByj2lhvjf7hESBDTrhT3WTE7i453na0FHgtE7Tj1LepYwtfJ8SDe+1p
        cbZHrYWggUHCD3yNNkeP9s0vauYpUIGwd9jQ2s/DQ7vWSkxp+gAruVs8lMw4HBk15AnEqu0
        F28CAG29yBrjtACbsyRtqMSBMhY8x3EMOeCWGPKD5KaUCouNf3RiYwfWEkNfSUVKf+XFzdX
        LIyzKCsfb/HWDqAK7UV6Mo7aYOsgw/lUvSlX9q9xItRhZUh01wNvMbZfAPcfg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10054229700685415936
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 0/5] selftests/nolibc: report: print test status
Date:   Mon, 10 Jul 2023 03:44:07 +0800
Message-Id: <20230709194407.97791-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709085829.GC9321@1wt.eu>
References: <20230709085829.GC9321@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Thu, Jul 06, 2023 at 05:02:26PM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > As you suggested, the 'status: [success|warning|failure]' info is added
> > to the summary line, with additional newlines around this line to
> > extrude the status info. at the same time, the total tests is printed,
> > the passed, skipped and failed values are aligned with '%03d'.
> 
> So as I mentioned with some commits, I *do* find it important to
> preserve the convenience of grepping for a single word to from 20
> test reports at once and visually check all statuses (and in this
> sense I like your preference for aligning the words to make them
> more readable). But having to guess some grep context and see the
> output garbled clearly does the opposite of what we were looking
> for in my opinion.

Sorry for confusing you, hope my just reply [1] explained the 'newlines'
patch, as you pointed out in another reply, perhaps I need to write more
about the deeper 'background' idea of the patch, but sometimes, I'm also
worried about writing too much, for example, some info may be 'obvious'
but I spent too much statements, I will improve as possible as I can,
thanks.

[1]: https://lore.kernel.org/lkml/20230709192652.97668-1-falcon@tinylab.org/

> Also, I think there's no need for having 5
> separate patches to add/remove a line feed. Better discuss an
> output format that matches everyone's needs and change it at once,
> this will make the patch more reviewable than having individual
> changes like this.

That's right, the patches are split here is just for the last three are
new to our previous discuss, perhaps need more discuss, in the future, I
will propose the ideas before send the patches, just as we did for some
other patches.

Thanks,
Zhangjin

> 
> thanks,
> willy
