Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3A724B403
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgHTJzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Aug 2020 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgHTJz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DEC061384
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Aug 2020 02:55:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so772371qtp.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Aug 2020 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byj5e1NcGEKCZCoUKeCb/RN9/39259nsooaPeWr05l4=;
        b=mIYWqROvWD/RKdlCt/1BmnvTJH0idhKXzinoONCuobC26Ag8t2QIs/tRAQMvpAJ08U
         BzQnr6Nj3HJWweGGabib/1Ebtv6b9iTSVp37ZQ0WUFyGT/1Mwf9LHvU5nK4YjsOecvx0
         qeq35+syF+iWCEZEKoRYj8cJkQFXUe4PUx4IfwcRXiDj3YC7NyPY3pzIqRseHc7REiIh
         N/sY49jbKljaksEPUT/z8xb0zCJuW6D4i/ZcCidJbK5nRKJOJOPGEWLPa7qSCfoJtzPD
         ifR+I7dLcXN7mec2hk//+ojQ1if4Az7i7YBKVrbsiRurX/txFql1hnICOgzD9ep0YRYN
         Frng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byj5e1NcGEKCZCoUKeCb/RN9/39259nsooaPeWr05l4=;
        b=TTpZb1TvUxUGqKvSkzWWpNJROv/4li8IxG5Acuq+GUPeLzqlbLydoGV+t2n3qPOauu
         4YVUKigZVQ7s0pkDp0/XjS7/3zvenq5oXjDyKjbw8RZYkndN7kPWMYqykiZXHgahMFgd
         JJQA9ICSpWZ7qrnSxezahxiA7C0L+eXs+xdNODjYaWA0xfKeKH2QdhIqyYIP6cIs4YRf
         Bzx40ALH6DVs9AIHG3zOsjkWQYEp8FLuRzZatFnj43LI3yqehLWSRzPw5Wx+8/7x+EIq
         CXkgQp4LiTZ4TzSVSbCWmR52ngQ7x4xCryH0hyeR8zeAsPh5paQETbpb7XiD1RwkFQXh
         3vxw==
X-Gm-Message-State: AOAM5310Rbof62vp1OoaDl5IciWyQjkn6OukTrefOzj/JeTvPYC2X+4h
        YHlqU0c6mxAKGhmjkdbZZ0VzmG5gdaYumFgkk5httg==
X-Google-Smtp-Source: ABdhPJxN/Qcu0Avu7t5f0IsPNNgIlJfLFijf+/xkCrEm8gQAOrgnBi2Xab4nv3xb6LKbZ1GtGC+38K0MG7TuYx2ZwF0=
X-Received: by 2002:ac8:480c:: with SMTP id g12mr1838251qtq.257.1597917326809;
 Thu, 20 Aug 2020 02:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a7e38a05a997edb2@google.com> <0000000000005c13f505ad3f5c42@google.com>
 <CAHmME9rd+54EOO-b=wmVxtzbvckET2WSMm-3q8LJmfp38A9ceg@mail.gmail.com>
In-Reply-To: <CAHmME9rd+54EOO-b=wmVxtzbvckET2WSMm-3q8LJmfp38A9ceg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Aug 2020 11:55:15 +0200
Message-ID: <CACT4Y+b7eZNuCOBhwxpzXoEXqOAk9ZGBJBakr6nqYrnd54URpQ@mail.gmail.com>
Subject: Re: WARNING in __cfg80211_connect_result
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     syzbot <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 20, 2020 at 11:48 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Aug 19, 2020 at 8:42 PM syzbot
> <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit e7096c131e5161fa3b8e52a650d7719d2857adfd
> > Author: Jason A. Donenfeld <Jason@zx2c4.com>
> > Date:   Sun Dec 8 23:27:34 2019 +0000
> >
> >     net: WireGuard secure network tunnel
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000
> > start commit:   e3ec1e8c net: eliminate meaningless memcpy to data in pskb..
> > git tree:       net-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dad8b1900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10dad8b1900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cc4c0f394e2611edba66
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d9de91900000
> >
> > Reported-by: syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com
> > Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
>
> Having trouble linking this back to wireguard... Those oopses don't
> have anything to do with it either. Bisection error?

I don't see anything obviously wrong in the bisection log:
bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000

On the other hand, it looks super precise. It tracked "WARNING in
__cfg80211_connect_result" all the way down to the wireguard commit
with no flakes or anything.
