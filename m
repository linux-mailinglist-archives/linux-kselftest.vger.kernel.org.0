Return-Path: <linux-kselftest+bounces-14673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD7945265
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302C9B22169
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE921B9B3A;
	Thu,  1 Aug 2024 17:57:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2A1B9B32
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535024; cv=none; b=nNlPFwpjj5AHVPPw4zwbOhBigH6wH4YyxCCkA9QKhC2GIA46VXBD9B+HJ9jKrUHPmGtPftoYcz874Dhp9kYqf3oqux5TrxcWMhhgsyFetTjnog3R9qHz9JNO++01a0ZcxsXN6v9haOdlV9uaOys5/oWmkVQPub3BH0qBl4Rw8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535024; c=relaxed/simple;
	bh=tJFIaBPD3I1wF4aHwSiNr+L20nlaburnRO2nkOdfKSU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f+eVk/ulLq9WEBw1nYS3i+UgGndVjxVriAwhXqtHzHonHaK6J0GVWrvoZD49dXIo2lImiAud6iER9xOwZfyl5gsyoQ23oSRP0LdIP5jA0Np2K3OxNw8eqOnpEQl8Y6Iya5UO9j2/etnlgXutXkIHlxgxPghEfVzB6YMt4SvBfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39aebcdfc3eso98158955ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722535022; x=1723139822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTvoqCovkIf0M2Cb6BMo+BCs3j2PCLmCnlJnFySAEuI=;
        b=eU2pZr1lQw57TBUT000MJXaHwl+d59s7+tykTZlkRtt9TNxCmwMjj5nRMUa5wt3Nr8
         fOyr+iWODsJybMLC7L6JauiAo15sgn3+leFS1zC/C8Lx1mG59aarJS7KGLHAmn6n5S/R
         oVbJ586/y4eioNmZlwYYENdYY6jUQb4ZMESZ3DvC4IDSGBi15zWYFYHfp/WZAloEKVX5
         EWGL5Cm9oMnJRBA5g6LFB1JGEStV017x3aOrmLMcZcOeKEM0Ev1LdccoUhLpIojtXlVm
         RIgmAeatmFsnx3z4xyTMcTimMthGHdfuiyvFjXT2Mcl8IS+UwmlM8mKNObZjAS6ZUqb9
         Hbzw==
X-Forwarded-Encrypted: i=1; AJvYcCWC9nTeJgveXJOxdjdRKfwC7eMIykPV3pqSI/ZVAdeY8Za+SxOtShUP3z+GspB/stXpl4fwJpQdUr7MtZsljVbV7ScpIejUHzosEJpMtxp7
X-Gm-Message-State: AOJu0Yxd8Kap3B5wpqa6KK/U/6qsZaNKB/N4wXA9RqFCGBfSmKti0D2y
	fZdLY4/kJZqE0UAciaRjUyYH4RHMUDmQYrk5ImI+6XWLMH0H1qnx2L7f5h/ys6iZ4T9J8YjWHDS
	nYrxDba8xzXMKcOeTAEtpCyBUtkDCglcQ++veNTwiwNP7ZYTEPIUVTAU=
X-Google-Smtp-Source: AGHT+IG4+l9yii4CrFynQQ2hbUHkXbJgIIR9UdDoQpQ0Rjl3tIPbc90HCRWBdObkYeE9g75Vy+bDJ7fX//eKFTd3xnOH+raYAhFr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c3:b0:39a:e8c5:ba1b with SMTP id
 e9e14a558f8ab-39b1fc6cfa8mr553325ab.6.1722535022414; Thu, 01 Aug 2024
 10:57:02 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:57:02 -0700
In-Reply-To: <0000000000006923bb06178ce04a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fdcda061ea2f073@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hpage_collapse_scan_pmd (2)
From: syzbot <syzbot+5ea2845f44caa77f5543@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, borntraeger@linux.ibm.com, 
	david@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	io-uring@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, 
	peterx@redhat.com, shuah@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ef5b6a542b1dbb718226a5f8208be09ef405983d
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Nov 8 09:40:35 2023 +0000

    selftests: kvm/s390x: use vm_create_barebones()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14071cd3980000
start commit:   e67572cd2204 Linux 6.9-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16071cd3980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12071cd3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=5ea2845f44caa77f5543
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10874a40980000

Reported-by: syzbot+5ea2845f44caa77f5543@syzkaller.appspotmail.com
Fixes: ef5b6a542b1d ("selftests: kvm/s390x: use vm_create_barebones()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

