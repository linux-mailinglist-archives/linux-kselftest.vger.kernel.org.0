Return-Path: <linux-kselftest+bounces-14301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341D93DE0F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202B5282FB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777743AD5;
	Sat, 27 Jul 2024 09:16:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363120B33
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Jul 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071765; cv=none; b=kV7INBMuv7VoYQ27LRMA59hB5RZcZI6Jp/ZRza79CyBZdYTQcJsk5ns1SpMUughdJ6NwfKPqKlz7+h6a0tq4WwkQX1LW4kI+l5jthn1i3/iC7fjkX/OKugI+dVxiQYUXh+yOr+IOExI+SAqjBZSLCR8b5eKiUzcTeqW85MjiJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071765; c=relaxed/simple;
	bh=dtvUBiAawgrbk/2NPnFXCKh/rwYKsAYierU6VX78Dls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qqElQnla6Nqh7WI13wAo8barjqyWCOU3yreHIzKmugbvAHzOqusZTg1dKUGMivnAPtsdxUb6fmZA3oF65CdNeqgfPo84icQOKTsFL9RkaX7+5H02iIq2sfSe/BX/yGEJAddIl4Fwqjklu8h8jpqQvOmaCV5xwkbPjjhI12lxHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso239646539f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Jul 2024 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722071763; x=1722676563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtgwoy9Z2Qa1FGZaJIoMnbuyZFsJQYJvV6j3oH+HdZo=;
        b=S+KQL9Ze+iPOBRqIqSY/+iN7pVVT6cx2qpyAkxN9UTiFUZLyM0MDFFH8TsuLGPd8IF
         oqmXpPdhd3mjVTRZwZMVfA0RgXwqapEdrat7GkITz2IDwgw7WkH2dnnWHUAwZxGEsUMV
         R5ffVQf1aMhntToFpCModlfi/vNTutE23NNE1Kj30e42ITrAbgOrQIc90fnP+PUP1fVC
         07tnWfroH7sGx1k6lpdm4h34rEJXCgQJEM9xkzChfKaNDCYedLhBiRaMmvmn7CuXgTYq
         kADZICXNZqvIdCyOuKqxVkHJd7BI7J5+fau5y/BCrnBn89SdQl4pRwi3vte6LF09tlqu
         6+SA==
X-Forwarded-Encrypted: i=1; AJvYcCVIgxfiNB8Sec9Z79Jk5q7RxAmOZAdbLxAxz5aQEJJOu2WlN9QcvYeRwXn+6A+t8nZl/WpDziXGVGTauqUrjiN6hNx8lYTa8Ei3T1Tn+wG8
X-Gm-Message-State: AOJu0YyTGkx31A3pDOxIWIdXhByFhjnKQNE/yICvdl9t7NZS7aTQ993g
	Vh6rFW5NTGOeqA40znKRz0m+3o4YEVz3Gjx62wmv0GJblK7538AbKnCrBGfGqEpk66BC3MaT8Gf
	K6kFTpVJypcq8tPxDhPBG7srmQahD2yeo6teh7QuXCf8WNfj7e0sg+rQ=
X-Google-Smtp-Source: AGHT+IErWPbCOrtbq/dbUnqctTf2rtdkbh1lbkPC+maSPidZr2xjge9XRYxMaBhgfp08AMHsfmVRold/vyjY2spnOGlOdDgWTLkS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8c:0:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-39aebd77810mr1691265ab.3.1722071763015; Sat, 27 Jul 2024
 02:16:03 -0700 (PDT)
Date: Sat, 27 Jul 2024 02:16:02 -0700
In-Reply-To: <0000000000004fe821060e0a68d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b66dc7061e371339@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in ipv6_rcv (4)
From: syzbot <syzbot+d9b3e95a78490389cfb7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dcaratti@redhat.com, dsahern@kernel.org, 
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	shuah@kernel.org, syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb66df20a7201e60f2b13d7f95d031b31a8831d3
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:55 2024 +0000

    net/sched: taprio: extend minimum interval restriction to entire cycle too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179b2623980000
start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d9b3e95a78490389cfb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1487fc06e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e5b4d6e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

