Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93247771359
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHFDTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFDTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 23:19:00 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB5D1FE1;
        Sat,  5 Aug 2023 20:18:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3763IdPN009225;
        Sun, 6 Aug 2023 05:18:39 +0200
Date:   Sun, 6 Aug 2023 05:18:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 8/8] selftests/nolibc: customize CROSS_COMPILE for
 32/64-bit powerpc
Message-ID: <20230806031839.GB9187@1wt.eu>
References: <20230805204845.GA7300@1wt.eu>
 <20230806031125.6800-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806031125.6800-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 11:11:25AM +0800, Zhangjin Wu wrote:
> > If someone wants to use their distro's cross toolchain, that's fine,
> > but I think that it will depend on distros anyway and some may not
> > even be provided (like loongarch) so I think it would make more sense
> > to adopt the canonical naming from Arnd's toolchains above.
> >
> 
> Agree very much, let's switch to Arnd's toolchains.

Fine!

> Ok, let's go this way, if the others are ok for you, could you please
> drop the last two CROSS_COMPILE patches from this v6 ppc series? Thanks.

Will do.

> I will send v2 CROSS_COMPILE series with them, with Arnd's toolchains, the
> whole CROSS_COMPILE series will be unified and become very simple, although
> they need to download the toolchains manually one by one, but it is possible to
> write a common script, but that is another requirement.

Or even wget -r or any such thing.

Cheers,
Willy
