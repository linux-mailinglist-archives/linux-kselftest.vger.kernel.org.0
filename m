Return-Path: <linux-kselftest+bounces-40989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96026B49AC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 22:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0345188F86C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362692D8377;
	Mon,  8 Sep 2025 20:12:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122D2D7DE8
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362326; cv=none; b=ZDqTaTkLEzBoj8iqGRNlWV+oTgixQdWuH06ZwcvmLsAIVCqiLwZ0cMffHqF9dzrV/gl+QlJHahVNLMP0xa6RC4pldbNsKBVFSN+XRHg+9ScKpDYBs/114yEjk4fcSUIRJVixkgRhS6UYXdjM5Ll4h6qGFTqN5mz+4SYG8VjbjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362326; c=relaxed/simple;
	bh=WSIoRV+4dq+La932BdB3eUBY+0kr7L5QrWYY7oF+82w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D27eIKVmo8qF63ZBM2MB8JA7w6wOV8Ca/5oY4D6c2uwE9hovzny/Ijd28WtQlqTTzvid1K0i1P+xhZsrK5S9bbKS7lgBvYFJpoLdcjWapjnBvm1tdkTynFfvz4OI2jxDQ7WXhANBXYHdr858qvY5XJ0HxRZEA2VciJidZvj0nxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88c2ff21d59so397599339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362324; x=1757967124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUVU0Ff8fQ+u+hL7Q5pC0b/mSJVhOT9pIEPHC3xJKiA=;
        b=BCU2/ih2OyBIoFDVTeqxUoc64Cs6kkwk6Sv1O8MaDV44w0cURIkwBjctji83X73M8L
         GKyUz/pQFYnQKPSqZgmMGEE+qZlpIgWmNu5EHJxNYkyCkhRU06YhDwHJaLKFnCE6XQaU
         glZYQ1Uv+SbK+Il1cShGVzcqM8RGwB2ZvS3u3zWtluXErZMWAcdIxxSZjcZADYVJpPvK
         4qddQoLa3kldpFdhc+M/pkPmEgqJUPXWJYPJgVlJTtHJpk9km+q+dDZb5FOTIxK5G2+j
         pwFAigEZir29zWvfq2avAtTIMJ/KVoahDBQZzdGV7viZsE4m8+u/9eV8aQUS5ZGJdal1
         2Dfg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4t76mMZq5edCGwMZGsP3XbjndbDz5wNItRQbpHcw2ZcFgXfVIfOJ006l24qKzLB51QCrs7hR6WotW2sTb/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hJ1ImeHYx4pgOoHnbxuvA9PnsKas9Xf52wGklhnqn2ZiASgp
	ZDg0RSxK15+kloDVElUU9DYzPelAAdafjPISYRO49RyYSgR/6XBuvWtUs4pSldlzAf9JnuSEOam
	jWhaFoM2fP/H36CWwr7ovmzNi+650//RB98U8qSTlOOmxxwJ+KwZsxzsfocE=
X-Google-Smtp-Source: AGHT+IGVhC7g/XMpsLDsz/IZxR5D5A09ltN1f439U0eM0rM9IOQ0kdLoc8NU3w/85NGnunzKaEklMRswAVaqru7LxbNnoA0qcBEA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:3ec:248b:8760 with SMTP id
 e9e14a558f8ab-3fd94a13fc3mr140050635ab.18.1757362323770; Mon, 08 Sep 2025
 13:12:03 -0700 (PDT)
Date: Mon, 08 Sep 2025 13:12:03 -0700
In-Reply-To: <683428c8.a70a0220.29d4a0.0802.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf3893.050a0220.192772.0885.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in corrupted (3)
From: syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, charmitro@posteo.net, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, horms@kernel.org, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	yangfeng@kylinos.cn, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7f12c33850482521c961c5c15a50ebe9b9a88d1e
Author: Charalampos Mitrodimas <charmitro@posteo.net>
Date:   Wed Jun 11 17:20:43 2025 +0000

    net, bpf: Fix RCU usage in task_cls_state() for BPF programs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13745562580000
start commit:   079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
dashboard link: https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114915f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15566170580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

