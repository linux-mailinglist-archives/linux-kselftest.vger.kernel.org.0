Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A26E320F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDOPPd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDOPPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 11:15:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA51540EC;
        Sat, 15 Apr 2023 08:15:29 -0700 (PDT)
Date:   Sat, 15 Apr 2023 17:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681571728;
        bh=PHGt+W7NxEPDtQSyORfCnDMsqkljH8VZv53sZGUyqI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9Igvkz9VpsW/V72zgvqKQcAeVJWNCDfO2XZVnNhkpQG9aEitCLDNS+7snMEYxABZ
         JA6ouk4ZB+c6yOisadjNJcU8wZ56mp6OnIgEDNJTEsF3HVdokcOyj+Xn6l1CyujGTY
         JtK3TsCz5ud9ksS+6BYjEj1RGwL9AMXChbaYFvUk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/11] tools/nolibc: -std=c89 compatibility
Message-ID: <e93c1260-ae29-4fa4-9097-a81784ac7ef8@t-8ch.de>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
 <ZDKFTvhzgVGBjr0M@1wt.eu>
 <ZDq455RD5yJ8Nwk0@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDq455RD5yJ8Nwk0@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-15 16:47:03+0200, Willy Tarreau wrote:
> On Sun, Apr 09, 2023 at 11:28:46AM +0200, Willy Tarreau wrote:
> > On Thu, Apr 06, 2023 at 09:54:46PM +0000, Thomas Weißschuh wrote:
> > > This series replaces the C99 compatibility patch. (See v1 link below).
> > > After the discussion about support C99 and/or GNU89 I came to the
> > > conclusion supporting straight C89 is not very hard.
> > > 
> > > Instead of validating both C99 and GNU89 in some awkward way only for
> > > somebody requesting true C89 support let's just do it this way.
> > > 
> > > Feel free to squash all the comment syntax patches together if you
> > > prefer.
> > 
> > I gave it some thought, at first considering that going lower than GNU89
> > was possibly not very useful, but given that the changes are very small
> > in the end (mostly comments formating), I think that you're right. The
> > cost of reaching this level of portability is basically zero once the
> > patch is applied so I think it's worth doing it now. However I think I
> > will indeed squash all the comments patch together as you suggest.
> 
> I've now squashed the ones about comments together, fixed the declaration
> inside the for statement in nolibc-test and tested with gcc 4.7 & 4.8 and
> confirmed it works as expected. I've queued it there for now:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20230415-nolibc-updates-4a

Thanks!

I noticed today that I did not adapt the comments in arch-s390.h;
because the start() comments were already correct.

But the last line of arch-s390.h still contains a C99 comment.

Do you want me to send a patch or could you just push one?
(Or fold it into my patch)

Thanks,
Thomas
