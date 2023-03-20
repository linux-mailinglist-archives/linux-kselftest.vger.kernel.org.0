Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAD6C2437
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 23:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCTWGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 18:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCTWGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 18:06:45 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79B5925BB5;
        Mon, 20 Mar 2023 15:06:38 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32KM6OrA018186;
        Mon, 20 Mar 2023 23:06:24 +0100
Date:   Mon, 20 Mar 2023 23:06:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/8] tools/nolibc: add support for stack protector
Message-ID: <ZBjY4FuLLbMeJM4t@1wt.eu>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Mon, Mar 20, 2023 at 03:41:00PM +0000, Thomas Weißschuh wrote:
> This is useful when using nolibc for security-critical tools.
> Using nolibc has the advantage that the code is easily auditable and
> sandboxable with seccomp as no unexpected syscalls are used.
> Using compiler-assistent stack protection provides another security
> mechanism.
(...)

Thanks for this. I had a quick look over the patches and at first glance
it looks OK. I'll give it a try before this week-end on all supported
archs to rule out any potential side effect, and will queue it.

cheers,
Willy
