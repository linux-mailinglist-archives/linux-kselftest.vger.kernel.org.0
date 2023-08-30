Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4A78E244
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbjH3WVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjH3WVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0701310D9;
        Wed, 30 Aug 2023 15:21:10 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37UKmcVD000698;
        Wed, 30 Aug 2023 22:48:38 +0200
Date:   Wed, 30 Aug 2023 22:48:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nolibc: remove reliance on system headers
Message-ID: <ZO+rJv/ZNokkyWpL@1wt.eu>
References: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 30, 2023 at 05:07:11PM +0200, Thomas Weißschuh wrote:
> This was prompted by the discussion about output directory support with
> O=.
> It seems sometimes we were pulling in system headers making testing
> annoying and unreliable.
> 
> Willy:
> 
> I did not implement the '#ifdef va_start` guard that we discussed
> before. In my understanding the latest agreement does not need it
> anymore. Please let me know if this is incorrect.

No that's fine given your goal of including just "nolibc.h" and no
other regular include file, I agree. I've just merged it and pushed
it to the -next branch.

Thank you Thomas!
Willy
