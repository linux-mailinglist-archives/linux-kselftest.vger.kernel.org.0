Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB774F846
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGKTNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGKTNC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 15:13:02 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12702EA;
        Tue, 11 Jul 2023 12:12:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36BJCX04006335;
        Tue, 11 Jul 2023 21:12:33 +0200
Date:   Tue, 11 Jul 2023 21:12:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: simplify status argument
Message-ID: <20230711191233.GB31402@1wt.eu>
References: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
 <20230711-nolibc-sizeof-long-gaps-v1-3-dc78c3b85fc3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711-nolibc-sizeof-long-gaps-v1-3-dc78c3b85fc3@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Tue, Jul 11, 2023 at 11:48:41AM +0200, Thomas Weißschuh wrote:
> I'm not sure if this is an improvement over the previous patch.
> If so it should be squashed into it.

Indeed, I find it less readable, because when you read:

        result(llen, ret ? FAIL : OK);

it makes it explicit what values of ret are expected with what meaning,
but this one:

        result(llen, ret);

makes it quite opaque. I'd rather keep the ternary operator and the 3
values that are likely more accessible to newcomers who will more quickly
figure how to do what they need.

Thus I dropped this one and applied the 3 other ones which are indeed
a nice cleanup.

Thanks,
Willy
