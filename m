Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA475DC5A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGVMDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGVMDx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:03:53 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2AC49B;
        Sat, 22 Jul 2023 05:03:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MC3k1d017321;
        Sat, 22 Jul 2023 14:03:46 +0200
Date:   Sat, 22 Jul 2023 14:03:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/8] selftests/nolibc: add XARCH and ARCH mapping
 support
Message-ID: <20230722120345.GB17311@1wt.eu>
References: <cover.1689713175.git.falcon@tinylab.org>
 <90c1d88dabf73e100dc840965fbdfe3ad5dc550f.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c1d88dabf73e100dc840965fbdfe3ad5dc550f.1689713175.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 05:15:13AM +0800, Zhangjin Wu wrote:
> -	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
> +	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"

Most users will neither care about nor need XARCH and will wonder what to
put there. Since there's a fallback on ARCH, better indicate something
like:

    (uses $XARCH or $ARCH, and $TEST)

Willy
