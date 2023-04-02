Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D119D6D39D4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDBShU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBShT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:37:19 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDCE2B45E;
        Sun,  2 Apr 2023 11:37:18 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332IbD8o020831;
        Sun, 2 Apr 2023 20:37:13 +0200
Date:   Sun, 2 Apr 2023 20:37:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tools/nolibc: add libc-test binary
Message-ID: <ZCnLWQ2BCisgmP+a@1wt.eu>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
 <20230328-nolibc-printf-test-v3-1-ddc79f92efd5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v3-1-ddc79f92efd5@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 02, 2023 at 06:04:34PM +0000, Thomas Weiﬂschuh wrote:
> This can be used to easily compare the behavior of nolibc to the system
> libc.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> ---
> 
> Feel free to drop this if it does not fit in.

On the opposite! I wanted to do it, you beat me to it. I'm just going to
add an entry for it in the help message.

Thank you!
Willy
