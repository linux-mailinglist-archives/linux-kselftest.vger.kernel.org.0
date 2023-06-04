Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77672162F
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFDKrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFDKrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 06:47:31 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A20E7B4;
        Sun,  4 Jun 2023 03:47:29 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 354AlLOV001713;
        Sun, 4 Jun 2023 12:47:21 +0200
Date:   Sun, 4 Jun 2023 12:47:21 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: test_fork: fix up duplicated print
Message-ID: <ZHxrueqyt0g+zvMx@1wt.eu>
References: <61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org>
 <20230602024157.11151-1-falcon@tinylab.org>
 <a72cac9d-609f-4c4f-a7f8-7c6b89837e0a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a72cac9d-609f-4c4f-a7f8-7c6b89837e0a@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 12:20:34PM +0200, Thomas Weiﬂschuh wrote:
> On 2023-06-02 10:41:57+0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > What about this one for 2023xxxx-nolibc-rv32+stkp6?
> > 
> > @Thomas, welcome your Reviewed-by If it is ok for you ;-)
> 
> Indeed, good catch!
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

And queued, thanks to you both!
Willy
