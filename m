Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88377A52BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 21:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjIRTKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjIRTKA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 15:10:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B4109;
        Mon, 18 Sep 2023 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1695064190;
        bh=gc/WMgSdjYxe2NiZy+i680FnIrB6GCa5tYJPeqSm6OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e08bKLe+haQBydEioK8s+5TdOsl1X4PQSy0OheurwbYpWzlHBBMwto7DIMtfqEAL6
         D+sS5LoYv6kEw7OW9eniiosRJ2gXWwYxb5LCO7LypnThjHqQs4suqMpzvnd2I1/9P1
         AHV2ZFS+sw5Cvc5Zj5hE/JSNv6qDBOGhp5vRS8Hk=
Date:   Mon, 18 Sep 2023 21:09:50 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <7da10f44-f18a-420c-a906-69ba43478aa0@t-8ch.de>
References: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
 <20230917-nolibc-syscall-nr-v2-2-03863d509b9a@weissschuh.net>
 <ZQh4gwcxvqgn/9Nh@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQh4gwcxvqgn/9Nh@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-18 18:19:15+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Sun, Sep 17, 2023 at 05:36:17PM +0200, Thomas Weißschuh wrote:
> > The ENOSYS fallback code does not use its functions parameters.
> > This can lead to compiler warnings about unused parameters.
> > 
> > Explicitly avoid these warnings.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

> [..]

> It's much cleaner like this.
> 
> Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Feel free to push the whole series to the next branch.

I pushed all three recent series' to the next branch.

Thomas
