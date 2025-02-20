Return-Path: <linux-kselftest+bounces-27114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949ACA3E63E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 22:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC82422819
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E51EC01C;
	Thu, 20 Feb 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhtZOW5X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856ED1EB1B9;
	Thu, 20 Feb 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085253; cv=none; b=TJST90FL3V3rfN7MHZ3WEB0h86YYq6prBTx0aeotVE+Y1tfVTJIPqaac10dmTOvSNCxpYff0YJDw6z3vOO99CF0eyKGj6QzYWXsP8Xerh+5xWjzRTubdJwZYGQkgoLs6IAVr+VOW4vNE/QiXYvroGg0hfa0ycI+5mxD5GMwuAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085253; c=relaxed/simple;
	bh=wyE+JSDxuV/hZTOQ0u1ZwPe//2YlrT8Ib5nCs1cadyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCQkAaR/yjYW5igwcKQ3/SPCBqBh5RzsJcybKmgs+WU+DMNz7vP+cnbyX3hISoHEuq8XnoX1Fhyd50Sewb+QFD+KMc9oFby5v1J44oF7OD848yTXro9T4u+s4xgjP5YAuq+5g6FYHLr7y/vxyl8KmaMIR2WE6d6Wur82hgsM+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhtZOW5X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c4159f87so19883005ad.0;
        Thu, 20 Feb 2025 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085251; x=1740690051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goRxPis4fiR0KiYF8m/mmzbs8TD+l7fkkxSQ1nIdOy8=;
        b=jhtZOW5Xhq9NqlUPQ87he2II85jzKuRBl0pjjRAvY2nwaVqcE/rYgGffLBewbJeOSD
         GLSOio5lg4PgWCHw6slhjQRoQzE/+JFFRsPc6s0lXevettFV9uGl2BZXLPVUEe9YYinx
         6zFWicYS1+OvdY7y7RUI/PuNL8zYOLf86zIzclGRYWEkG1xpUkmomMM5YXbvEXN56AjU
         zL+qwpU0San88ewCYhEiD2spNZZ0uZ1kFMnhl7RvIRq32Kjfsta2NLsZuYOxyfXoY4SN
         dAdpcvPXBfmwWCxN/mJAfQSwk2cObRsOzpCVukT2EhEg19tZw30nKa4qTTC2ucACc+/n
         ABfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085251; x=1740690051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goRxPis4fiR0KiYF8m/mmzbs8TD+l7fkkxSQ1nIdOy8=;
        b=LQwJNI57biNGXDIvcnDC4EnuJSQbPt4K6Gau1MtGbEYMjmtFL0f2GFVidElzhB6nJC
         se2I5+YJCg+kJIyjh0A+un6uibt+rylfgJ+it82xajuNQfX7nJRkQbUQPttE15lBFctD
         nSunJJCtk5T1hZcabn1KxdCyI1BMQGSJMOFSFam+BElCpIhQkcJMZMx3+1M1Nf7z3eLv
         /QX2kOKGaMEL57B1euLSrTjfaFPO6HjOb9TGC/lA0bTJb3LzfwlX9rP4UL3e91rSgPvx
         sh8fYdXaJyLbElgBxOU2eMKE4OgBq8tm/rQVCpvJvfjAEdVsU+bVkeLARrTDqmRvoDCw
         P79A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7SaBUpxfFXCWd/sU8rv+JLZ/oHjSeMSirE/61an6m+w/mwZTtSFRnB5WOgYicP/rNFW01VSCJQJ+@vger.kernel.org, AJvYcCVh12XsvYfGuH1gjETkTRHtgKuwWuHwTPVB0dfDo05XZH9RtMrGEFGVnFZe8ComKaBA0PAO+MJMGZ1wm9M+13h2@vger.kernel.org, AJvYcCVkWD6f9EN8R7p9a/FUwbDb9jYGErQCX9eyM2bcAI1ouihWoqshy1f34cBBy/JmBisG/Tw=@vger.kernel.org, AJvYcCXX/8F8g/rpd2xsBorPz1XIOlmxMn3QOasb9DzD1YZ7yG+CLX6oZ2OF/VyREo+KQNSmFwrh4BJkG9usFTKM@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoyuoNNpHT9XOQDKIWplUq5LecjGZ6Qz8yy2ZrQ7dCQ2ZVKx3
	v88oLN6UKBpabeVhN644Xy7dgVLTsxbns6xTNOhDMbcA48Rq9JQ=
X-Gm-Gg: ASbGncsVBYtvg9hZmyCQm0wbU3pHECjhH5cFcQnO7NUGE3wOq4btYFKfjs+vYMWTK6b
	uENV3UkMY0QeEOlIP62V7ofQfIZnKsqPC2hEcEZLZDAj9F7VEXtC1EbvExaTgBNIrIB+6oH/onp
	mh9br3ErIRfjElSaIYVb/OqhC62D9sbfIqOp4s1vJHwCLPY+nEa31yaaRImuxca8HMoa6by0VYp
	zTvKEg9wVc+HuqaUN2vrpSomVpYOkElFu6md+9L9nDLZh2dF4o/Q5q5DlcRZumwfg0lNKANoJ4m
	fnpw6eITCUxH8MQ=
X-Google-Smtp-Source: AGHT+IGslSk8vgGnidZWgpsWLCS9e9O5Moku2z8DGhJIxx0KDO4cfjuxSXj1umr7Y2mV/3IdPW96jw==
X-Received: by 2002:a17:902:d2c8:b0:216:5294:619b with SMTP id d9443c01a7336-2219ffbd671mr8961765ad.47.1740085250617;
        Thu, 20 Feb 2025 13:00:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d47ba84fsm126080825ad.0.2025.02.20.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:00:50 -0800 (PST)
Date: Thu, 20 Feb 2025 13:00:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 4/9] net: devmem: make dmabuf unbinding
 scheduled work
Message-ID: <Z7eYAXxPNx59OTcS@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-5-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> The TX path may release the dmabuf in a context where we cannot wait.
> This happens when the user unbinds a TX dmabuf while there are still
> references to its netmems in the TX path. In that case, the netmems will
> be put_netmem'd from a context where we can't unmap the dmabuf,
> resulting in a BUG like seen by Stan:
> 
> [    1.548495] BUG: sleeping function called from invalid context at drivers/dma-buf/dma-buf.c:1255
> [    1.548741] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 149, name: ncdevmem
> [    1.548926] preempt_count: 201, expected: 0
> [    1.549026] RCU nest depth: 0, expected: 0
> [    1.549197]
> [    1.549237] =============================
> [    1.549331] [ BUG: Invalid wait context ]
> [    1.549425] 6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15 Tainted: G        W
> [    1.549609] -----------------------------
> [    1.549704] ncdevmem/149 is trying to lock:
> [    1.549801] ffff8880066701c0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.550051] other info that might help us debug this:
> [    1.550167] context-{5:5}
> [    1.550229] 3 locks held by ncdevmem/149:
> [    1.550322]  #0: ffff888005730208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x40/0xf0
> [    1.550530]  #1: ffff88800b148f98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x19/0x80
> [    1.550731]  #2: ffff88800b148f18 (slock-AF_INET6){+.-.}-{3:3}, at: __tcp_close+0x185/0x4b0
> [    1.550921] stack backtrace:
> [    1.550990] CPU: 0 UID: 0 PID: 149 Comm: ncdevmem Tainted: G        W          6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15
> [    1.551233] Tainted: [W]=WARN
> [    1.551304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [    1.551518] Call Trace:
> [    1.551584]  <TASK>
> [    1.551636]  dump_stack_lvl+0x86/0xc0
> [    1.551723]  __lock_acquire+0xb0f/0xc30
> [    1.551814]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.551941]  lock_acquire+0xf1/0x2a0
> [    1.552026]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552152]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552281]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552408]  __ww_mutex_lock+0x121/0x1060
> [    1.552503]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552648]  ww_mutex_lock+0x3d/0xa0
> [    1.552733]  dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552857]  __net_devmem_dmabuf_binding_free+0x56/0xb0
> [    1.552979]  skb_release_data+0x120/0x1f0
> [    1.553074]  __kfree_skb+0x29/0xa0
> [    1.553156]  tcp_write_queue_purge+0x41/0x310
> [    1.553259]  tcp_v4_destroy_sock+0x127/0x320
> [    1.553363]  ? __tcp_close+0x169/0x4b0
> [    1.553452]  inet_csk_destroy_sock+0x53/0x130
> [    1.553560]  __tcp_close+0x421/0x4b0
> [    1.553646]  tcp_close+0x24/0x80
> [    1.553724]  inet_release+0x5d/0x90
> [    1.553806]  sock_close+0x4a/0xf0
> [    1.553886]  __fput+0x9c/0x2b0
> [    1.553960]  task_work_run+0x89/0xc0
> [    1.554046]  do_exit+0x27f/0x980
> [    1.554125]  do_group_exit+0xa4/0xb0
> [    1.554211]  __x64_sys_exit_group+0x17/0x20
> [    1.554309]  x64_sys_call+0x21a0/0x21a0
> [    1.554400]  do_syscall_64+0xec/0x1d0
> [    1.554487]  ? exc_page_fault+0x8a/0xf0
> [    1.554585]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    1.554703] RIP: 0033:0x7f2f8a27abcd
> 
> Resolve this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> 
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

