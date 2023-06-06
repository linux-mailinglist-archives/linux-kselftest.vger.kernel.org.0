Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD28723678
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 06:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFFEtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 00:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjFFEtB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 00:49:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB64F109;
        Mon,  5 Jun 2023 21:49:00 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3564miI3017465;
        Tue, 6 Jun 2023 06:48:44 +0200
Date:   Tue, 6 Jun 2023 06:48:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <ZH66rI847lA1q3gq@1wt.eu>
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <1fc53bcf-f7ec-4d74-a984-da4ee38e938f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fc53bcf-f7ec-4d74-a984-da4ee38e938f@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 12:44:03PM +0200, Thomas Weißschuh wrote:
> (Talking about 20230605-nolibc-rv32+stkp7,
> but the same issue is in stkp6)
> 
> I noticed that the commit introducing prctl() comes *after* the one
> making use of it.
> 
> 8389cb4b55ae ("selftests/nolibc: prevent coredumps during test execution")
> 033c01b5a8f4 ("tools/nolibc: add support for prctl()")
> 
> This can lead to compiler errors and break bisectability.
> 
> They just need to be swapped.

just done in 20230606-nolibc-rv32+stkp7a, thank you!

Willy
