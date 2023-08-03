Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579AE76DDDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHCCKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCKS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:10:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 545D81A7;
        Wed,  2 Aug 2023 19:10:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3732A61Y023764;
        Thu, 3 Aug 2023 04:10:06 +0200
Date:   Thu, 3 Aug 2023 04:10:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 00/10] tools/nolibc: enable compiler warnings
Message-ID: <20230803021006.GB23704@1wt.eu>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230802202243.GA23256@1wt.eu>
 <40bfb455-80c4-4ab1-b36e-ba5cbd723198@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40bfb455-80c4-4ab1-b36e-ba5cbd723198@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 11:10:17PM +0200, Thomas Weißschuh wrote:
> On 2023-08-02 22:22:43+0200, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > On Tue, Aug 01, 2023 at 07:30:07AM +0200, Thomas Weißschuh wrote:
> > > To help the developers to avoid mistakes and keep the code smaller let's
> > > enable compiler warnings.
> > (...)
> > 
> > OK, that's overall OK to me, and I noted thta you'll likely update
> > 6 and 9. Just let me know how you prefer to proceed, I hope to send
> > the PR to Shuah this week-end so I want to be sure we avoid a last
> > minute rush and the risks of breakage that comes with it.
> 
> I'm not yet sure when I can rework those patches.

No problem.

> Could you already pick up those you are fine with?
> (And also leave out the final one to not have spurious warnings)

OK, I'll stick to this for now, thank you!
Willy
