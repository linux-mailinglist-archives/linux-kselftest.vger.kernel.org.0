Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D47BC6D6
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbjJGKgt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJGKgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:36:48 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB779E;
        Sat,  7 Oct 2023 03:36:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 397AaKv9023928;
        Sat, 7 Oct 2023 12:36:20 +0200
Date:   Sat, 7 Oct 2023 12:36:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: drop test for getauxval(AT_PAGESZ)
Message-ID: <20231007103620.GB23812@1wt.eu>
References: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 07, 2023 at 12:18:55PM +0200, Thomas Weiﬂschuh wrote:
> The test will not work for systems with pagesize != 4096 like aarch64
> and some others.
> 
> Other testcases are already testing the same functionality:
> * auxv_AT_UID tests getauxval() in general.
> * test_getpagesize() tests pagesize() which directly calls
>   getauxval(AT_PAGESZ).
> 
> Fixes: 48967b73f8fe ("selftests/nolibc: add testcases for startup code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Note:
> 
> This should probably also make it into 6.6.

Agreed, you should just push it to the fixes branch.

Thanks!
Willy
