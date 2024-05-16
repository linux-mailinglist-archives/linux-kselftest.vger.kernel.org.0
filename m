Return-Path: <linux-kselftest+bounces-10302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9558C7999
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F322833A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAA14D2BD;
	Thu, 16 May 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/2Q+N1d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVqCAeJ3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NzJEOyRg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCdB6xDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DA143895;
	Thu, 16 May 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873945; cv=none; b=nZ9jidPeh3lm69fkwfd0fboBNwn3qqiaeYlAFqm3e28QFoCma7YgShEf5kYzNwhmBu5QYffZdDCM8og0KgeDhwKcumxX4+bk6MY7PF+HHuU1ZeacReAkFMb9fp7lHf6qQaTfhwjetKwCD/FI1NmyYNmLIdr/JkysDIKIt46IyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873945; c=relaxed/simple;
	bh=q6iu/X+FK6YCqLN1gkCh8RoIXbQ80eATjNEPDEk5brM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndGq+uTN342Blpqrs0XirjTeHGfSpCnuehlvQnq/rjxs8GQFcBSWoHl6HTW+Yx4TEHSapAHaYfvW0sCFcbWlg6ssayDAQPejZCNTWgH6qOKkl82AhWVKRWYuWLjllXyA0TQKtH/flafyrDIr6/DAaCkdzK5Fla0K/AaQKSv0rBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/2Q+N1d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVqCAeJ3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NzJEOyRg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCdB6xDN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A39F34B83;
	Thu, 16 May 2024 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljb6iEdJgsES4YgAa+ABFGeaYU8BOkPNGhpZeJJA+Wo=;
	b=c/2Q+N1dkaved4rxJ9+tgDhlTJe03v3OzUeTIVVomtDlnsSoYvAzbI7t32WimCGbnSfY/8
	urAAUngq4LpGGb7E8W3hx/YicoFHfXgnGO7+9CUqABK4lhuetDIQq4SznZNZMwZmCt9SGG
	+dk30/JHXZeNo1+LX2HDZZFfKRG601U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljb6iEdJgsES4YgAa+ABFGeaYU8BOkPNGhpZeJJA+Wo=;
	b=FVqCAeJ3M7TxQyL1og5veAbgfTe9qn7V7nEGNgeQAtEyn2ZJgOVKS1KCIb48Sjcuwqp7wL
	SmLF2ajeoevQiHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljb6iEdJgsES4YgAa+ABFGeaYU8BOkPNGhpZeJJA+Wo=;
	b=NzJEOyRgsy22iK7fykjrnuqY4IgZwezv17pI46JJFLp2ynAgO5Zc8Ie+lz5yCDZniODdeq
	6jqCVqpXhEB+h0l5HA9vxMR3MpcB56X+SJQP2S+EsJLi/1qeu9qeb3RJI8iAL/gZkJTDXb
	ZfrRx/5dcbRw/BXyhmoCRcnbYmdTVAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljb6iEdJgsES4YgAa+ABFGeaYU8BOkPNGhpZeJJA+Wo=;
	b=UCdB6xDNIMRsO3HA5tu2S4282E0WZoxkVklicNH/IkQyFGX8APG1bimeH/j0Lp60gNYZXr
	rz7wl1dPx0I0u2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F6E13991;
	Thu, 16 May 2024 15:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id seAlDZQoRmZeCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:39:00 +0000
Date: Thu, 16 May 2024 17:38:54 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com>
Cc: christophe.leroy@csgroup.eu, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, shuah@kernel.org,
	syzkaller-bugs@googlegroups.com, ye.xingchen@zte.com.cn
Subject: Re: [syzbot] WARNING in btrfs_free_reserved_data_space_noquota
Message-ID: <20240516153854.GE4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000fac82605ee97fb72@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fac82605ee97fb72@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[adec8406ad17413d4c06];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[csgroup.eu,fb.com,suse.com,toxicpanda.com,vger.kernel.org,lists.ozlabs.org,ellerman.id.au,gmail.com,kernel.org,googlegroups.com,zte.com.cn];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Tue, Nov 29, 2022 at 12:43:38AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b7b275e60bcd Linux 6.1-rc7
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=158a7b73880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=adec8406ad17413d4c06
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169ccb75880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bf7153880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/5423c2d2ad62/mount_0.gz
> 
> The issue was bisected to:
> 
> commit c814bf958926ff45a9c1e899bd001006ab6cfbae
> Author: ye xingchen <ye.xingchen@zte.com.cn>
> Date:   Tue Aug 16 10:51:06 2022 +0000
> 
>     powerpc/selftests: Use timersub() for gettimeofday()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118c3d03880000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=138c3d03880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=158c3d03880000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com
> Fixes: c814bf958926 ("powerpc/selftests: Use timersub() for gettimeofday()")
> 
> RDX: 0000000000000001 RSI: 0000000020000280 RDI: 0000000000000005
> RBP: 00007ffd32e91c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffd32e91cb0 R14: 00007ffd32e91c90 R15: 0000000000000006
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3764 at fs/btrfs/space-info.h:122 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> WARNING: CPU: 1 PID: 3764 at fs/btrfs/space-info.h:122 btrfs_free_reserved_data_space_noquota+0x219/0x2b0 fs/btrfs/delalloc-space.c:179

Most likely fixed by 9e65bfca24cf1d ("btrfs: fix
qgroup_free_reserved_data int overflow"), it's an 32bit type overflow
that can cause various accounting errors, the function names match the
context.

#syz fix: btrfs: fix qgroup_free_reserved_data int overflow

