Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789BE6D39E8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDBStr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjDBStq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:49:46 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DF4661BF;
        Sun,  2 Apr 2023 11:49:45 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332InfX8020945;
        Sun, 2 Apr 2023 20:49:41 +0200
Date:   Sun, 2 Apr 2023 20:49:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCnORVI3xecYmraf@1wt.eu>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 02, 2023 at 06:04:33PM +0000, Thomas Weißschuh wrote:
> vfprintf() is complex and so far did not have proper tests.
> 
> This series is based on the "dev" branch of the RCU tree.

So just to confirm, it's all good, thank you very much. I've passed it
to Paul.

Have a nice end of week-end ;-)
Willy
