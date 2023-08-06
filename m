Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3208E771459
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHFKMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 06:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHFKMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 06:12:50 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94F4119AF;
        Sun,  6 Aug 2023 03:12:47 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 376ACf46012379;
        Sun, 6 Aug 2023 12:12:41 +0200
Date:   Sun, 6 Aug 2023 12:12:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 4/4] selftests/nolibc: add some notes about qemu tools
Message-ID: <20230806101241.GD10627@1wt.eu>
References: <cover.1691263493.git.falcon@tinylab.org>
 <6de680acbc2d87e13a680d4453ef022568bf489b.1691263493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de680acbc2d87e13a680d4453ef022568bf489b.1691263493.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 03:51:24AM +0800, Zhangjin Wu wrote:
> Almost all distributions provide qemu-system-$(XARCH), their firmwares
> and qemu-$(XARCH), but for the new riscv and loongarch, users may still
> need to download external firmwares or compile qemu from scratch, let's
> add some notes about them.

That's indeed useful information but I think that we should really move
all the download instructions to a separate file. I wanted to write one
anyway, but didn't have the time with all the build tests to run :-(

I may propose one to be merged late, possibly.

Willy
