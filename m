Return-Path: <linux-kselftest+bounces-13558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5111792E5F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823621C22D15
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362981607B4;
	Thu, 11 Jul 2024 11:11:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135115A86E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696265; cv=none; b=YZEek+nLPBTUbEnvkQjl1IayMMsbbSr+wNn/rIP3+dZ58odfwipUcZVlLzp0/H68qTeosp9TXxFfnRtN904MaKn+U3g6C6mg36RkBo1OiqhEudAp7CiVej3fYHlMlAmGCVmFlm/ckfHnHuk8tsdcPh9CLdN95IpRwF3UaWvcn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696265; c=relaxed/simple;
	bh=0ZwX0N6cmTcPU6cUOhbMilU6Yelh76r3rbVgmSzYq0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h5zUySlR6wZVgrdepv/dDFxw61QjWAy984keNusBgKZVumYw4/BLb2kfryzV3S6ZyQ7GjdUhofzfGKA5rFjyw6C77AmbTJcvfUJFf04oU33NXBGInp/DnXUW/5IcwX4caq3pcIvX91kNwgZkEMaOHtzAwyN7uwWIGe8yW1oU728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so82598239f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 04:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696263; x=1721301063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxg3UJPkzx7M07gbZ9SOx2eod/ecUaN/p77xgE8W3KQ=;
        b=u9cO1F2c0HoIe04DXTVLluiqSbblWQyrrPEPVvSPRSKD5UCkveMB3d3cl7izNxk3FT
         NI2oQXw6zpftlv6S1uqgbTiSG2ciobreMly3YXYY6dTrXYNNs19CjPXrev5hdlHJuvEu
         Ii0fmn4XKas8HsjTi42pB9hVMb6fRYA5qUdmG4RFjDGeqJNyHLLx96ng4c5NTJj0jP6y
         a3a6j3daL/jjiGvjn8Y6X5VbunwwYWAz80+VPxvd5geN/dGkNEHZ1K/Dz+++RXSxVS7t
         CtuRdlMNZ4NrU3/PGEstCO033ZXkebZ50GxVIeBono7UzpfPxwGpLDaiuO51iZyt4DFN
         psDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpkqW/a4dsGHWbhYcGK4t27WbdExq/gKyZSiu67I7eOWUkHME979dP8owWZ4ztysBDN9eeo7pbvN7f6Sqm3vCrQa3nGBDjdcH9WG2RGIqe
X-Gm-Message-State: AOJu0YxKnSRRl8GN4dbm7HcEKMIkpEbsG6FUzjXL4ukskixPUNcx0uTG
	ti+Yt7BQzLTYfCvMOdYiAqT4gdfCSIL5bVsvQtVjhSVgNhi9EXrs3oLVw5hWURJBC+pl+VNsZTL
	boFtQAt3fLwLSVvaL4HSbgunnRSY4vbFmia2OrxbXL3JA369yweBo37w=
X-Google-Smtp-Source: AGHT+IGBjGi2u0vQwkoJ9T1yTRI18dBxcqWGmgtHOfjU9ZTmOOpU364A1mpSXTEejum4DWNhNasVTJ0VRDyOX29dVNI3xFSozQ7R
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8601:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4c0b24e9f62mr482571173.0.1720696262760; Thu, 11 Jul 2024
 04:11:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:11:02 -0700
In-Reply-To: <0000000000008ac77c0615d60760@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000822b8b061cf6d171@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, 
	broonie@kernel.org, davem@davemloft.net, dcaratti@redhat.com, 
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	lenb@kernel.org, lgirdwood@gmail.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, oder_chiou@realtek.com, 
	pabeni@redhat.com, pctammela@mojatatu.com, perex@perex.cz, rafael@kernel.org, 
	shuah@kernel.org, shumingf@realtek.com, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com, vinicius.gomes@intel.com, vladimir.oltean@nxp.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb66df20a7201e60f2b13d7f95d031b31a8831d3
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:55 2024 +0000

    net/sched: taprio: extend minimum interval restriction to entire cycle too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10593441980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

