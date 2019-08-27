Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE69F59B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfH0VwK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 17:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33257 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfH0VwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 17:52:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so217954pgn.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+irtzyVRDDrZdpMz7JihRashs6tjpw1hAnPhyXixHfQ=;
        b=H8vyk3/hGsv4WW7to+VBsIoy/ie5y44IptvuovFBoFlS81qgLeHyMG6YQgBw/5NiNJ
         4OJbnrcOAqOdQIj7AyUVcV0NQCjrAJdZ1axoB+yMJ3BYN38u4jmdQCGEOEwkSrTpRMhe
         qO8BNNHqBeQ7OjCM6FRGwKKxkAUT6DfiP5VlwZGowJ17eLxv8jhB0or8+sYF37ERbtzM
         otWRjXgj2ld2gyoMIrYgsQi4iPLd6zR64a9P8MdgkI8YnzYQZULtWc0Q3QrHJOgA8B26
         PXEj/PSKdDzY6isF4T/zCx0ihKcSOl8bNbmAbPU0xCELf7iMVWfiH9fVuxD+OjxvTWlc
         pleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+irtzyVRDDrZdpMz7JihRashs6tjpw1hAnPhyXixHfQ=;
        b=sHNVAhEhhuPNA/i0IpigTdCbmzqv8LE+DN5sMBgBmyAic4Xpl0FrsbifsQ4j8IqTbD
         lSEaQRWKi/ySebZ8puyLHWm9OsfuKDWv5X1CXhBCLyzjW3aWTNmCCXygUl6U0++jQ3k2
         DJo7E3TS9T63Vxy6MEzAVT089qkRvhJYX8kvj4eUBLhxEOCazfvTWWgoKJlO16/iu3vX
         y7JWXCtrOn40CXP7ssuMk1ZpEpIZuXblYZ38Xq2r/pSNKEpsuS5fz0K5pjgPpnGTmLT2
         Ho/ehKtx4rXPXfYU8179xhihkFUok7OEVRCoQ7g9pw8oDzeKIFeZBJYnokMwBQvKmYHE
         fJUA==
X-Gm-Message-State: APjAAAWwRBHLnbk7gbxS5aeeoHqn2u/hCK6iK3+QipHKkuHpdV0a02Ol
        EhfS3AUYE8gT594dYkXh/Jk9wlIRWuYjsUaQqzgKwg==
X-Google-Smtp-Source: APXvYqxrNp5MqJ49VvEtHBx+6SXiy4HCQDDbPjQbTxaNkfrxJpIxNaW7wj73njCyaAs203y7ieJUT/8pgVpCFwemiTA=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr527994pgk.384.1566942728992;
 Tue, 27 Aug 2019 14:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com> <20190827214613.9B896206E0@mail.kernel.org>
In-Reply-To: <20190827214613.9B896206E0@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 14:51:53 -0700
Message-ID: <CAFd5g45NudtV4Q-ooXStGnEUDYCBbTx2JvkYQn1_mLZNYqnPjA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     shuah <shuah@kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 27, 2019 at 2:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-27 10:49:32)
> > Previously KUnit assumed that printk would always be present, which is
> > not a valid assumption to make. Fix that by ifdefing out functions which
> > directly depend on printk core functions similar to what dev_printk
> > does.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Does kunit itself have any meaning if printk doesn't work? Why not just
> depend on CONFIG_PRINTK for now?

I was thinking about that, but I figured it is probably easier in the
long run to make sure it always works without printk.

It also just seemed like the right thing to do, but I suppose that's
not a very good reason.

I am fine with any of the three options: depend on CONFIG_PRINTK - as
suggested by Stephen, just use printk - as suggested by Shuah, or
continue to use vprintk_emit as I have been doing. However, my
preference is the vprintk_emit option.

Anyone have any strong opinions on the matter?
