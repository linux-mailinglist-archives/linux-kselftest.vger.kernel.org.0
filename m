Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36670ADDE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjEULsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEUKLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 06:11:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A82919B;
        Sun, 21 May 2023 03:08:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34LA8IGS029413;
        Sun, 21 May 2023 12:08:18 +0200
Date:   Sun, 21 May 2023 12:08:18 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/7] tools/nolibc: autodetect stackprotector availability
 from compiler
Message-ID: <20230521100818.GA29408@1wt.eu>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sun, May 21, 2023 at 11:36:28AM +0200, Thomas Weißschuh wrote:
> As suggested by Willy it is possible to detect the availability of
> stackprotector via preprocessor defines.
> Make use of that to simplify the code and interface of nolibc.

I have just had a quick glance over it and not tested it yet, but
overall I really like it, thank you! I'll try to give you some
feedback today (or simply merge it).

Willy
