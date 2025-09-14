Return-Path: <linux-kselftest+bounces-41449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4FFB56CFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 01:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B931817506B
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Sep 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F08261588;
	Sun, 14 Sep 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="NFc6/z88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5524E00F
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Sep 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757893051; cv=none; b=gtcvrKn4RHjghohIkktauK4cMIGYPV3ladKnQhPABjiAuV7L1AmHE8GvF1yMQTOc7+akQh8Q/r9t+Ilz9KBlHGAP0iTTnUEB+MjQS0o5Hu196beoM9cd+v5Hwi16LG8J/1d/UchTEkBcm8w6mzcTUfujArJAEZ0V9vfKgag12Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757893051; c=relaxed/simple;
	bh=odlrz20IXfc9MUnEwi5nRwEYXd3V+Xkv2SYseouBhLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYfVwm/UDAx6oXtZrQYL9kjhFjjWQ8LZ157v3QFcUhifHjTsQLfrV3vFxXYOunbBqX7yaL20xGcx2OLyLgwe0A7eIengxEWkXNp6MLMQxv4BqvwRL2C/EwgUBhbf/nUMyY9s+j+rO02rNWJcQQJXdmAMC+SESe09oKwzWmPDJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=NFc6/z88; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 36617240101
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 01:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757893041; bh=5xTBfcIgxXN2CX1CLHSz7aQ83atl75CzIOg3qYAIU7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=NFc6/z88ZyrxSxe1iPsQkkT3DK9pVl/ccf72vNiNCOfqRw9Luzza/fQzjeezsH89n
	 0elwQm4LSB9Y1lvYvaTEw4oBCu+cw3Jjj+c5CjDMGN+7U9itUtKtFGbKtURRHs7xcQ
	 0Bzizfz44ilnJLTGgaQsswnqa0WycxGbKZJA/vGfOK6U3oKLc5gAdyQBPt/rEijmiy
	 /Ye+d0SXaIaBCHJ5Dqr3e/UAnwICURhA/50aNrsCKkL48DEpktLfeIyqkgvHA1Sbfo
	 EnGL8Qk/QhF8IBdCS0foF/ScppWTyE0BfTJIHD/Ow/bh6i4dYQB5koYCwOdwc/Nlmf
	 6A6rmxUBn29wQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQ4MB58Twz6tn4;
	Mon, 15 Sep 2025 01:37:10 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com>
Cc: alexei.starovoitov@gmail.com,  andrii@kernel.org,  ast@kernel.org,
  bpf@vger.kernel.org,  daniel@iogearbox.net,  davem@davemloft.net,
  eddyz87@gmail.com,  edumazet@google.com,  haoluo@google.com,
  horms@kernel.org,  jiayuan.chen@linux.dev,  john.fastabend@gmail.com,
  jolsa@kernel.org,  kpsingh@kernel.org,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  martin.lau@linux.dev,  mykolal@fb.com,  netdev@vger.kernel.org,
  pabeni@redhat.com,  sdf@fomichev.me,  shuah@kernel.org,  song@kernel.org,
  syzkaller-bugs@googlegroups.com,  tj@kernel.org,  yangfeng@kylinos.cn,
  yonghong.song@linux.dev
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in corrupted (3)
In-Reply-To: <68bf3893.050a0220.192772.0885.GAE@google.com> (syzbot's message
	of "Mon, 08 Sep 2025 13:12:03 -0700")
References: <68bf3893.050a0220.192772.0885.GAE@google.com>
Date: Sun, 14 Sep 2025 23:37:15 +0000
Message-ID: <87h5x4obbt.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com> writes:

> syzbot suspects this issue was fixed by commit:
>
> commit 7f12c33850482521c961c5c15a50ebe9b9a88d1e
> Author: Charalampos Mitrodimas <charmitro@posteo.net>
> Date:   Wed Jun 11 17:20:43 2025 +0000
>
>     net, bpf: Fix RCU usage in task_cls_state() for BPF programs
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13745562580000
> start commit:   079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
> dashboard link: https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114915f4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15566170580000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

Correct, also did test-run to make sure.

#syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

C. Mitrodimas

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

