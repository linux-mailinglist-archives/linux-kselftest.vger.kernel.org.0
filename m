Return-Path: <linux-kselftest+bounces-34114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9CAC9F56
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0907817448E
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D251C5A;
	Sun,  1 Jun 2025 16:21:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA161F5E6
	for <linux-kselftest@vger.kernel.org>; Sun,  1 Jun 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748794864; cv=none; b=cF2547fFkIeBRXTshF+5R6+vd5HJ59UYMXdFvntlsH4au4B7bdDT7dE90uh/8rJgyZZT55Lpq5mg914SvMv9oOxQmeFKnEQRGIPnGexS5ITRwcXBRDRZhgmICjqKvj3HXOvCnWydvBS6l5UqFNBrM8vSRKVNBQfxOynR/9K44hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748794864; c=relaxed/simple;
	bh=h6QoMpVGGZVy60Ef1tMLb7Ks9v3/ZkdGVQ1zpckE/E8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EcVo7w+XgHuuVtapSu57UVy76HO6zsY0vnlnADyGMRAflA8Q5Xdppbm1E2gI1CwYuL2HgiS2FyN/8oWB55pbant7kAFrSP38QEAyhLw5X+d0M970h5rlLPPzXsg7WMuoBxmxVffvUUvmTtP0IvmOb4Ds8UWBYIDYfmyskZawx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dd789f3b99so78293965ab.0
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Jun 2025 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748794862; x=1749399662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxRCzM24gglLIr7E2yldOZZAcHs1wVBwC6JZOlmfhD8=;
        b=o6NLCSMwFIz+Z+KIpw+a9fxaoh8w78skzgTsWG1s4LQFlAsHPX37eyfw2mGUtOvTwK
         Uc2KjfuJXI0fYGZxGyYkyMjp2XyD/h091uRrYlmVuz5o1WOr+VcZzUFzwS1qGoGEo0eS
         XatmlXpZZGa9O4CwzetoOsUJ4jYQ9gBLFw0pKeURUcsvTMcoam54sxJ7FzbUiTR60YdP
         2ecWvVCZlR8+qYH7fXZIXj+ff6wZ8Q3blFrLi1Rj5ki5gUlzecrWr28uolQizMuphuNb
         DNFiu/CvYxdj7YYiLZgHJ7CRw2RowyVn2GKKWMrCBwU4S7ZwOhXyMfkroS+k5M0FW9V0
         GlAg==
X-Forwarded-Encrypted: i=1; AJvYcCWk7FMgSNgmOtGio2cjW53EYmS5kTzsBs14iMY1ScsdNmlQFl4gorOaDhxJOaLa/4dzxSEsmEiof80QgPoh8UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmGONCWBCi3ieOsIR1mKsCu8G8cKD1dw3X2YZNPhYZaTYQnGA
	jOFt/eq7NShtUpeutE1l6tgJDxxR6RVfHtiRePJf0dx47Y9KekhK0Z+FFsZjduqertn6qewhRDO
	Yn8iLGsa90Z3i4ozEeO1WgG31V8VQkg5qB7u7SjouAG8CTL9oIcP+vX70/dY=
X-Google-Smtp-Source: AGHT+IE6dM+Sri1ig2zWdcwsj1cdNpnH6D5Ew7GCODMXRc5foiZExQDqXF9qiWibFIJGCE3VMwNQPSukaY5jbkheuww0vE49Df77
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3dd99c2898cmr107808385ab.14.1748794862401; Sun, 01 Jun 2025
 09:21:02 -0700 (PDT)
Date: Sun, 01 Jun 2025 09:21:02 -0700
In-Reply-To: <6751e769.050a0220.b4160.01df.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] general protection fault in __cgroup_rstat_lock
From: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, 
	haoluo@google.com, hawk@kernel.org, inwardvessel@gmail.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, muchun.song@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, roman.gushchin@linux.dev, sdf@fomichev.me, 
	shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a97915559f5c5ff1972d678b94fd460c72a3b5f2
Author: JP Kobryn <inwardvessel@gmail.com>
Date:   Fri Apr 4 01:10:48 2025 +0000

    cgroup: change rstat function signatures from cgroup-based to css-based

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ca4c82580000
start commit:   932fc2f19b74 Merge branch 'irq-save-restore'
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cdfc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dfc8df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cgroup: change rstat function signatures from cgroup-based to css-based

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

