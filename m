Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD376DBF5C
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Apr 2023 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDIJ3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Apr 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIJ3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Apr 2023 05:29:03 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76BC3526F;
        Sun,  9 Apr 2023 02:29:01 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3399SkC6023420;
        Sun, 9 Apr 2023 11:28:46 +0200
Date:   Sun, 9 Apr 2023 11:28:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/11] tools/nolibc: -std=c89 compatibility
Message-ID: <ZDKFTvhzgVGBjr0M@1wt.eu>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Thu, Apr 06, 2023 at 09:54:46PM +0000, Thomas Weißschuh wrote:
> This series replaces the C99 compatibility patch. (See v1 link below).
> After the discussion about support C99 and/or GNU89 I came to the
> conclusion supporting straight C89 is not very hard.
> 
> Instead of validating both C99 and GNU89 in some awkward way only for
> somebody requesting true C89 support let's just do it this way.
> 
> Feel free to squash all the comment syntax patches together if you
> prefer.

I gave it some thought, at first considering that going lower than GNU89
was possibly not very useful, but given that the changes are very small
in the end (mostly comments formating), I think that you're right. The
cost of reaching this level of portability is basically zero once the
patch is applied so I think it's worth doing it now. However I think I
will indeed squash all the comments patch together as you suggest.

Thank you!
Willy
