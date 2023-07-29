Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F8767CC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjG2H3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 03:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2H3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 03:29:45 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F7649D5;
        Sat, 29 Jul 2023 00:29:43 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T7TXZF004173;
        Sat, 29 Jul 2023 09:29:33 +0200
Date:   Sat, 29 Jul 2023 09:29:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: avoid buffer underrun in space printing
Message-ID: <20230729072933.GF956@1wt.eu>
References: <20230726-nolibc-result-width-v1-1-d1d2dc21844e@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726-nolibc-result-width-v1-1-d1d2dc21844e@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 08:08:13AM +0200, Thomas Weiﬂschuh wrote:
> If the test description is longer than the status alignment the
> parameter 'n' to putcharn() would lead to a signed underflow that then
> gets converted to a very large unsigned value.
> This in turn leads out-of-bound writes in memset() crashing the
> application.
> 
> The failure case of EXPECT_PTRER() used in "mmap_bad" exhibits this
> exact behavior.
> 
> Fixes: 8a27526f49f9 ("selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied, thank you Thomas!
Willy
