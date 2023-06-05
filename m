Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93F721D1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 06:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFEEXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFEEXU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 00:23:20 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C4F9F;
        Sun,  4 Jun 2023 21:23:18 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3554N89w005468;
        Mon, 5 Jun 2023 06:23:08 +0200
Date:   Mon, 5 Jun 2023 06:23:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 4/4] selftests/nolibc: fix up test-report for run target
Message-ID: <ZH1jLDX4tqf7Roo/@1wt.eu>
References: <cover.1685936428.git.falcon@tinylab.org>
 <48a994c40ac739a0e20ed7a34f290637e417bb0b.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a994c40ac739a0e20ed7a34f290637e417bb0b.1685936428.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 11:58:56AM +0800, Zhangjin Wu wrote:
> There is a '\r' at the end of every log line when run nolibc-test on
> qemu-system (make run), add support for this case, otherwise, the test
> result will like this:
> 
>     0 test(s) passed, 0 skipped, 0 failed.

Argh, sorry for this one! Note that as a general rule, this should have
been the first patch of the series (fixes first so that they can be
squashed into a pending series or backported when already merged).

I'll remerge it into the series for now.

Thank you!
Willy
