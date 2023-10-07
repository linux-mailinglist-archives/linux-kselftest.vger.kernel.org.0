Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A97BC6E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjJGKpf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjJGKpe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:45:34 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDF92;
        Sat,  7 Oct 2023 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696675531;
        bh=maMScBc4Mt8jkDu4ndjP5a/QW0aFcACPqJA18uWVSKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lea5HSwSqGy0m5HSNvD78SXW9MpzZpXym/Hxb6DDAibCtwnn1nXfZY0oM5o3n79cL
         uokuMuBEHoaNNz3qe4w8UuNiM+43IWK/vsWThNiUmJ6ehvc7deixRB6l70YAMXRVSh
         40j2Ky0fEIZDApmCvuCR/H8DghOJ3UeqlIMRN8Cw=
Date:   Sat, 7 Oct 2023 12:45:30 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: drop test for getauxval(AT_PAGESZ)
Message-ID: <6721ed01-8438-4325-8645-d307f82e30ec@t-8ch.de>
References: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
 <20231007103620.GB23812@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007103620.GB23812@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-07 12:36:20+0200, Willy Tarreau wrote:
> On Sat, Oct 07, 2023 at 12:18:55PM +0200, Thomas Weißschuh wrote:
> > The test will not work for systems with pagesize != 4096 like aarch64
> > and some others.
> > 
> > Other testcases are already testing the same functionality:
> > * auxv_AT_UID tests getauxval() in general.
> > * test_getpagesize() tests pagesize() which directly calls
> >   getauxval(AT_PAGESZ).
> > 
> > Fixes: 48967b73f8fe ("selftests/nolibc: add testcases for startup code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Note:
> > 
> > This should probably also make it into 6.6.
> 
> Agreed, you should just push it to the fixes branch.

Good point.

'fixes' now contains Ammar's alignment fix, the tree location update and
this patch.

Thomas
