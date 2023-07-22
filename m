Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95575DCBB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGVNRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGVNRi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 09:17:38 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13EA41A7;
        Sat, 22 Jul 2023 06:17:36 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MDHS8F017483;
        Sat, 22 Jul 2023 15:17:28 +0200
Date:   Sat, 22 Jul 2023 15:17:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 14/14] selftests/nolibc: tinyconfig: add support for
 32/64-bit powerpc
Message-ID: <20230722131728.GM17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <15b47c6901f79a22b985a53efeae71dc7b172a5f.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b47c6901f79a22b985a53efeae71dc7b172a5f.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:32:46PM +0800, Zhangjin Wu wrote:
> Firstly, add extra config files for powerpc, powerpc64le and powerpc64.
> 
> Second, QEMU_TIMEOUT is configured as 60 seconds for powerpc to allow
> quit qemu-system-ppc even if poweroff fails. In normal host machine, ~20
> seconds may be enough for boot+test+poweroff, but 60 seconds is used
> here to gurantee it at least finish even in a very slow host machine or
> the host machine is too busy. Both powerpc64le and powerpc64 can
> poweroff normally, no need to configure QEMU_TIMEOUT for them.

Hmmm call me annoying, but this started with tinyconfig "in order to
save build time" and now it's enforcing a 1-minute timeout on a single
test. When I run the tests, they hardly last more than a few seconds
and sometimes even just about one second. If some tests last too long
doing nothing, we should adjust their config (e.g. useless probe of a
driver). If they can't power off due to a config option we need to fix
that option. If it can't power off due to the architecture, we can also
try the reboot (qemu is started with --no-reboot to stop instead of
rebooting), and as a last resort we should rely on the timeout in case
everything else fails. But then this timeout should be quite short
because we'll then have guaranteed from the choice of config options
that it boots and executes fast by default.

Finally, if we need to implement a timeout enforcement for at least
one arch because we do not control every failure case, then there's no
reason for considering that certain archs are safe against this and
others not. This means that we can (should?) implement the timeout by
default for every arch, and make sure that the timeout is never hit by
default, unless there's really absolutely no way to fix the arch that
cannot power down nor reboot, in which case the timeout should remain
short enough.

What's your opinion ?

Willy
