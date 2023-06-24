Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC773C9C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFXIyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFXIyS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 04:54:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0818B;
        Sat, 24 Jun 2023 01:54:15 -0700 (PDT)
X-QQ-mid: bizesmtp89t1687596845tar8umko
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 24 Jun 2023 16:54:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: QityeSR92A3DMBxJR9qE2xYZ5ave9QLjBojiQa4mwxhBHO55ur6tAsScc5GCz
        /sYlo5cbbA2bvcRE2x29yNFvwxcojlQVdPsJUh7v9Ix+RFnoHHhKswfSw4X1w6aODESy98Q
        E/FoWAyJxhDiOH4lD5Ths6g5UZ03+bsfa0IYebrpD+dLn9vkkA5ZX9GjKLJ18bkweKzyRj+
        xuE8/IkVspvx94u0CLXPjPGUW13O7vbyEVjjveob6Djl8aARQXuU1EgAtQuVHpMD/s/rfZq
        Bim1WGGvW9RTNlieqOGfojgH9vAZGZxHtyHAv2dPbUDSENwn2O/sDwRSpdekFg17+GNF/uP
        Sjs6vzEURCGQTc/Opz+89wMrg3reyPiLXxaIjJOBSS1jO3QHbo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2644677313220337364
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel config
Date:   Sat, 24 Jun 2023 16:54:03 +0800
Message-Id: <20230624085403.603469-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622184559.1188894-1-falcon@tinylab.org>
References: <20230622184559.1188894-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> > Hi Zhangjin,
> > 
> > some general comments for the whole series.
> > 
> > On 2023-06-21 20:52:30+0800, Zhangjin Wu wrote:
> > > Hi, Willy
> > > 
> > > This patchset mainly allows speed up the nolibc test with a minimal
> > > kernel config.
> > > 
> (snip)
> > > 
> > > * selftests/nolibc: fix up kernel parameters support
> > > 
> > >   kernel cmdline allows pass two types of parameters, one is without
> > >   '=', another is with '=', the first one is passed as init arguments,
> > >   the sencond one is passed as init environment variables.
> > > 
> > >   Our nolibc-test prefer arguments to environment variables, this not
> > >   work when users add such parameters in the kernel cmdline:
> > > 
> > >     noapic NOLIBC_TEST=syscall
> > > 
> > >   So, this patch will verify the setting from arguments at first, if it
> > >   is no valid, will try the environment variables instead.
> > 
> > This would be much simpler as:
> > 
> > test = getenv("NOLIBC_TEST");
> > if (!test)
> >         test = argv[1];
> >
> > It changes the semantics a bit, but it doesn't seem to be an issue.
> > (Maybe gated behind getpid() == 1).
> 
> Cool suggestion, it looks really better:
> 
> 	if (getpid() == 1) {
> 		prepare();
> 		
> 		/* kernel cmdline may pass: "noapic NOLIBC_TEST=syscall",
>                  * to init program:
> 		 *
> 		 *   "noapic" as arguments,
> 		 *   "NOLIBC_TEST=syscall" as environment variables,
>                  *
> 		 * to avoid getting null test in this case, parsing
> 		 * environment variables at first.
> 		 */
> 		test = getenv("NOLIBC_TEST");
> 		if (!test)
> 			test = argv[1];
> 	} else {
> 		/* for normal nolibc-test program, prefer arguments */
> 		test = argv[1];
> 		if (!test)
> 			test = getenv("NOLIBC_TEST");
> 	}
> 

Test shows, when no NOLIBC_TEST environment variable passed to kernel cmdline,
it will still branch to this code:

    test = argv[1]; /* nopaic ... */

And therefore report the whole test is ignored and no test will be run:

    Ignoring unknown test name 'noapic'

So, we may still need to verify it like my originally proposed method, but
let's further verify the one from NOLIBC_TEST=, we should tune the code a
litle.

Thanks,
Zhangjin
