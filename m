Return-Path: <linux-kselftest+bounces-40876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A16B46CF3
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7B91B240E0
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35FD29D267;
	Sat,  6 Sep 2025 12:41:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26051235044
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Sep 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162465; cv=none; b=WMyahnKJNEu0Pa9WTv0IB9KQqBPEVTolqjNBfIi86lFeHX1eppEUpiL7r1FeBtHToBWB871kEII9xtZQ+S7vCcUDVu65a2iSILt8h6GXBgrkK//6U2zw+lQ6gY9mMdbdiT8RDg/YcRAMpfMszulZ7ypx52Z51eYkt4UQjdGON6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162465; c=relaxed/simple;
	bh=U7G7G+aVkZB2v3V/zUCuzgGGvDKqhdtnY8WhOjRRook=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tAbCyjU++whlohI4/2GdLVXqSiU/fwlgVXK/HIVznl45JGfY5IUx6QTxvVjN6nJPjDx3g7AUw7qPZSK5uqPKeoFnQmz2RGcHNCCPIyCunqAwK6CRLPFoDVowMQQ1XyCYrtpsWEOBT1amT6s5nBqCmpNgeFKx9A4ilX+7YioRAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so76941845ab.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Sep 2025 05:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757162463; x=1757767263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEKjptd+e9tTMEG8g0kTtT0/no/OlP4s8sHfIK6Y4+Y=;
        b=v1VLFOX6Y5guYXWV+0vgavczhlWxYybXYFb6FHYL63qTTkXWZ1sMTqEUczhKwwtB4Y
         riis7W+HIov1gHC5ALQRJsJRI4ja6YULXF3JeIb8V+joZjct25yGN4ztWhoE/v/OLvia
         Oq2S+Yi0X5c2VHHCp/jDF8rOAJDCXAsT4wodzPF5wXE+5ydMtqT94z8RVLf+hkDCc9dB
         tJjP2VypdqNG0XpOZ1XFrDc/KK1Q6JZUaR+HFU7xTztPKj31OHqDI+5SUSeooSqkz3Tz
         CUg+cvMUfol5x7r6jsNc6vuypgtZaDn3A7ZcMv+gQlJXg0l4TCOV94FUZVHu/Fn6H51e
         CFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDZaav50yfNAvQ/KgGSEb+dpT9n8SEl46fPdi2GugoCc6pSSjuxkvmXukKvk+IXcGxQvuF9ZT0I4RgFB5qq1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXpeX4Cq9W2G9u0C2LatFNlEzhaFVl5Hfib/YyFYIEkNEv2OJ
	8tFFJiaT6HUiofdP24Vg6h0oq1NysjY+9Jug0eLcZJ+UxpKGMO7YtoYK+DkQ1qbN2I1YhTFw2LC
	hen5eH3nKvca4mr+Mwl/1IVwOszBUKSFi4RYT8d7qmfSsr3dEq65h2Ctpiyg=
X-Google-Smtp-Source: AGHT+IHxNVzyRSZvKDEdGlmnC8rBo6tj0A527j9A7QqwnVmZRh2c1L2jvTp4bM80v+o6jg5YbDExuc8bKDS+cnBSnKi+t5QY9sHX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:451a:b0:3fe:f1f4:77b2 with SMTP id
 e9e14a558f8ab-3fef1f4788emr15491265ab.5.1757162463379; Sat, 06 Sep 2025
 05:41:03 -0700 (PDT)
Date: Sat, 06 Sep 2025 05:41:03 -0700
In-Reply-To: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc2bdf.050a0220.192772.01ac.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
From: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	ecree.xilinx@gmail.com, edumazet@google.com, gal@nvidia.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f792709e0baad67224180d73d51c2f090003adde
Author: Stanislav Fomichev <stfomichev@gmail.com>
Date:   Fri May 16 23:22:05 2025 +0000

    selftests: net: validate team flags propagation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a3ba42580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a3ba42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a3ba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12942962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16942962580000

Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Fixes: f792709e0baa ("selftests: net: validate team flags propagation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

