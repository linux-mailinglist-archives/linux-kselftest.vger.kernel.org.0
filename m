Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1377CC6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjHOMSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjHOMRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 08:17:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08DF0171B;
        Tue, 15 Aug 2023 05:17:40 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37FCHHZL005336;
        Tue, 15 Aug 2023 14:17:17 +0200
Date:   Tue, 15 Aug 2023 14:17:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Message-ID: <ZNtszQeigYuItaKA@1wt.eu>
References: <20230813090037.GE8237@1wt.eu>
 <20230813133944.19604-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813133944.19604-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 09:39:44PM +0800, Zhangjin Wu wrote:
> > And we're done, you can then keep the simplified __sysret() macro for all
> > other call places.
> > 
> 
> Now, this issue is near to the end ;-)

I've now pushed the simplified fix (without changing the SET_ERRNO()
macro, enough last minute breaking changes for now) in branch
20230815-for-6.6-2.

The tests pass and riscv/loongarch are even very slightly smaller than
before (~8 bytes) but again that doesn't count as it depends on how the
compiler decides to arrange if/else branches.

I'll let Shuah know about these late fixes.

Regards,
Willy
