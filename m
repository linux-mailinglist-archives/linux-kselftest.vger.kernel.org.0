Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDF767D25
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjG2Ibh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjG2Ibg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:31:36 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E36E448C;
        Sat, 29 Jul 2023 01:31:35 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T8VSM9004422;
        Sat, 29 Jul 2023 10:31:28 +0200
Date:   Sat, 29 Jul 2023 10:31:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 12/12] selftests/nolibc: speed up some targets with
 multiple jobs
Message-ID: <20230729083128.GM956@1wt.eu>
References: <cover.1690489039.git.falcon@tinylab.org>
 <ca03989b38085a74bde33b7dc5040b33a76f3c4b.1690489039.git.falcon@tinylab.org>
 <ce2f10ad-bbdf-4948-b784-b497e8973e6e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce2f10ad-bbdf-4948-b784-b497e8973e6e@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 08:44:32AM +0200, Thomas Weißschuh wrote:
> On 2023-07-28 04:35:01+0800, Zhangjin Wu wrote:
> > The sysroot install and kernel build targets are time cost, let's use
> > -j<N> to parallelize them with multiple jobs.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index ad2538ec5eb0..1b45c22f9a94 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -171,7 +171,7 @@ PHONY = sysroot/$(ARCH)/include
> >  sysroot/$(ARCH)/include:
> >  	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
> >  	$(QUIET_MKDIR)mkdir -p sysroot
> > -	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> > +	$(Q)$(MAKE) -j$$(nproc) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> 
> This should already work when the users specify -j on the make command
> line themselves.
> I'm not a fan of force-enabling it here.

Indeed, we must not do that, because some users might for instance
prefer to build multiple archs in parallel and benefit from a better
parallelism and now they'd end up with too many processes.

Willy
