Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3B7138FE
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1KR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1KR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 06:17:29 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2AE9BB;
        Sun, 28 May 2023 03:17:23 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34SAH2PX002019;
        Sun, 28 May 2023 12:17:02 +0200
Date:   Sun, 28 May 2023 12:17:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Message-ID: <20230528101702.GG1956@1wt.eu>
References: <cover.1684949267.git.falcon@tinylab.org>
 <20230528075955.GE1956@1wt.eu>
 <210e5ed9-be89-4e48-9c1e-3eb5b0dd288a@t-8ch.de>
 <30bf1742-64ff-4f92-beab-332108d0201f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30bf1742-64ff-4f92-beab-332108d0201f@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 28, 2023 at 11:41:53AM +0200, Thomas Weißschuh wrote:
> > If you are fine with pushing more stuff to this branch, picking up 
> > the fix for the duplicated test gettimeofday_bad2 (7) would be nice, too.
> 
> And the ppoll() argument cleanup (10) for that matter.

OK now both done, thank you.

> IMO it would be more convenient to move generic cleanup patches to the
> beginning of the series.
> When the reviewers are focussing on the real changes they won't be
> interrupted by the cleanups. Also the maintainer can more easily pick
> them up independently, so they are dealt with and nobody has to worry
> about them anymore.

Agreed!

Thanks!
Willy
