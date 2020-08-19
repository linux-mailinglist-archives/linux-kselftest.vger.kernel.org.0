Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522224A61C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHSSmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 14:42:10 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53452 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSSmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 14:42:08 -0400
Received: by mail-il1-f199.google.com with SMTP id o18so17405588ill.20
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 11:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/Bc9IGKthyb4/4Equ8PDcO5t+DRavD5Kty3CCCxkvw=;
        b=b9Jze22Qvm8kt3mw4o4mm75o8F/Uy5pwkITi7M1NV4zjvmrSXgnADW/FBWaCiKLnaQ
         0I6a3bfH1LbOBVjsGp8RqJqSqdk+E88nBXU/ebbgRWptBYWMJ2/JaiAhVA5gEZBLWtzg
         rsN9CJNhkk+P/wJLml9gxHip8yQkhQuN1klIMX8Xqw6m3AZxsxG4RZaipKceoYP/55Bx
         gMVstrTlyVd1wrMOvWGDXB+1rrBHh2SPrM3yfdKtIaR5GIqGIBPMH8TOd7cMhN5oNKOV
         d4CSD5wDXkEwtvh4s84DJFoPjcIF5DpxBlyUnDcAJLgn5OmuSuc5LoDOpOb5VxqKUP8O
         RvPw==
X-Gm-Message-State: AOAM530Zt+fgZD3XPqDtGlnBBJIX8JGiDytycjfH0BJtTVr5aJURYIrf
        51Qau0fl17vtOI02JCSIR+JSo68JEcqfeCu/BqINtEYkXCJP
X-Google-Smtp-Source: ABdhPJxBnOT/Zs8AQMPWL8g/vwMMvZSe9QJsKh8x44da5tnVZga3SiM38KDJZgB6PtqMxFubNhPzkTmpJxSO7cgDTe17jRpUgh+y
MIME-Version: 1.0
X-Received: by 2002:a02:682:: with SMTP id 124mr26096197jav.110.1597862527633;
 Wed, 19 Aug 2020 11:42:07 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:42:07 -0700
In-Reply-To: <000000000000a7e38a05a997edb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c13f505ad3f5c42@google.com>
Subject: Re: WARNING in __cfg80211_connect_result
From:   syzbot <syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, jason@zx2c4.com,
        johannes@sipsolutions.net, krzk@kernel.org, kuba@kernel.org,
        kvalo@codeaurora.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        shuah@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

syzbot has bisected this issue to:

commit e7096c131e5161fa3b8e52a650d7719d2857adfd
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Sun Dec 8 23:27:34 2019 +0000

    net: WireGuard secure network tunnel

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ad8b1900000
start commit:   e3ec1e8c net: eliminate meaningless memcpy to data in pskb..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dad8b1900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dad8b1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
dashboard link: https://syzkaller.appspot.com/bug?extid=cc4c0f394e2611edba66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d9de91900000

Reported-by: syzbot+cc4c0f394e2611edba66@syzkaller.appspotmail.com
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
