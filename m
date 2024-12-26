Return-Path: <linux-kselftest+bounces-23756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C979FCD3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E2316254E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E208146A72;
	Thu, 26 Dec 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO6NRMU0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997F76025;
	Thu, 26 Dec 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735240025; cv=none; b=ABCQHIiNQpqFzmpakgjkw+QKh/EN8ZgUWf2lVfmHI61+M0tPEOULt/Gl9z7YBfbRb7gikgKFIqs8Lw6q92qsxb+dYNGWwRvrOSccSwNgpvRnSwgOub1wFJKJ75af/ea5/nhd1SSOVjvp06ZpUlbpTpI9/3p3GY0awdAOXmwxafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735240025; c=relaxed/simple;
	bh=S+/XUS+TG5bfYwQTMhsq25YjHJfE8A7xX2vTwCqum1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvTP1FiNQmqXU/onpAm7PX3LHkKzX6ubINyvUMiye+vYdmJz9gLWEgdnVEZod13xVYmn0e86Saow6NJkILe9f2YgVNVnD6rO06l0L3FYZf4i7v1zxCd3tDJa1MswjerKEbWhn6CprYRSKUuprxttnYwrZbJGZYuA4zMi3QndZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO6NRMU0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso76775775ad.0;
        Thu, 26 Dec 2024 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735240023; x=1735844823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXwZX7qcL5Q5uwBETXlrSBU6vMbcDPrfWJcs6udk4dY=;
        b=CO6NRMU0Cvo1LEHUAW/Z/yhKrSfSp/YzyZveAfJ+fi7RIP2p0g5q/c6wb+wP7h/bui
         7xjAk3XHLSU5JpKbrRmNzqF1DOEpaUKu3zAFFJPiZH7jgF7IBVr9QG76k4qbJh3Lo82L
         Nk7xqr1MfVbAdrP03YEXO7rBbuHlWdWtwQI63+BX8hJF6aOoV7eH6BJe9zbZHf7ryF04
         6H0a3IG2ooUiUQAC3PbbAgkJjUD8tIhVHei3zPDv01aOY4UOLpEXPjV+YV/+nCwXiEiO
         2mb2eQUOw0EX3Ckrfvitq9Xr3irqpbEdkzjdPiFnbzx1/W6wxOF7z0gpwhfAgOc0bICl
         tO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735240023; x=1735844823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXwZX7qcL5Q5uwBETXlrSBU6vMbcDPrfWJcs6udk4dY=;
        b=P6G4xN2tWSDxQGBAMeJOhQH95KkyduRg9RNzkgh8a5q34ErmaLTfsUcyLGxHthnSWl
         u2OIT+EC2/B5NKCUmBwRqm0nOOMTnSO+XH6CrR7XJj5u8ib7ARA2AD2NL150gKa3dzrs
         O3Yyd/CtcBV2M04D/8NxCtRYPeuvxOWjd4nKDUEdLjsOgBzhP8zaEuycS497N+mZN35K
         r3SGTgxclMLRmRfC8K8c0C4cT21Hla/V10LY02LC0XVAjX6SFxzoanOhmSKWlB3CrwJV
         QQyZErL447lAM6a/mBrS6zisHdASAi+Ul4xPIYZxmDwx/muOAHX15YeInwE6hS1J7arq
         p8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVzzXa5tsvzJOQbcz4GlxzWgX5560jqmIkyiqzKlt8W3AURI5Yd31iHEetH8GNbRjgpGwRBsTWxx0Vm9/PEIPaE@vger.kernel.org, AJvYcCWLMwxBjBo+lRAwMMtspVgMkEQ7+ehCTmR7qKpWNDOfLFrdNB98+ujmkMPsgavdpQcy64Y=@vger.kernel.org, AJvYcCWRAScoVPNCRIrsSboQtLDPix4ZPKc43HwkE9xNg4fzsqkDlTHTX9HtlQh8LngwSUln5Bhv183omRya@vger.kernel.org, AJvYcCWUKvW/mkmuN2m0aqxKHPNs99Jnj2OwgenNpv74TaC0PnUX+dH7dadTdog+elbeZggkNJyzMBonteu4ljrz@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEkv+W/+yjh7YHtnP8/DXceTPZ7VX80Tf2MFltc6+in/wnZRY
	JNaFMHOOzmvQSYKDdeckoE0YyDqFBaKZ1I7mx/G9eswVlrMcwUEwBwMofAE=
X-Gm-Gg: ASbGncs9UuggvntW4Zrglpr+ANRxYWSOrQO1ZWisHdy8qsR6URgoLjXeIOqa/3BnPiF
	SX2s7nBSN6Hg3QgdYukaSAwqLSiFbTyAeLIvhGNWPvOFxlpmf+zJtkAKjOFyH+EPcCzV2u7sUxt
	I1qUqT4QMUuUfMD77F6Gn48ba9EWQAuyWNB5RR/cGIJqhhutxHx9p+/8SPX26S4uwv4eGzpvtvC
	TfDQEI1WDiV3aZntMfqJdM2lwpukJYjj8Mq11l61GCQs/A3WByFB4NU
X-Google-Smtp-Source: AGHT+IH5GP3RIujBooCTnClTTqGZb/t3uapPT5RPrSrXb6fO3KCQ7bbTApm3PlB/Cz/PoLoUCnFgZw==
X-Received: by 2002:a05:6a20:6f06:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e5e080c77fmr38547687637.29.1735240022805;
        Thu, 26 Dec 2024 11:07:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc605001sm12146311a12.54.2024.12.26.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 11:07:02 -0800 (PST)
Date: Thu, 26 Dec 2024 11:07:01 -0800
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
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 3/5] net: add get_netmem/put_netmem
 support
Message-ID: <Z22pVRcr-B624UcG@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-4-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.
> 
> This is fine for the RX path as net_iovs are used exclusively with the
> pp and only pp refcounting is needed there. The TX path however does not
> use pp ref counts, thus, support for get_page/put_page equivalent is
> needed for netmem.
> 
> Support get_netmem/put_netmem. Check the type of the netmem before
> passing it to page or net_iov specific code to obtain a page ref
> equivalent.
> 
> For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> ensures the entire binding doesn't disappear until all the net_iovs have
> been put_netmem'ed. We do not need to track the refcount of individual
> dmabuf net_iovs as we don't allocate/free them from a pool similar to
> what the buddy allocator does for pages.
> 
> This code is written to be extensible by other net_iov implementers.
> get_netmem/put_netmem will check the type of the netmem and route it to
> the correct helper:
> 
> pages -> [get|put]_page()
> dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> new net_iovs ->	new helpers
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/linux/skbuff_ref.h |  4 ++--
>  include/net/netmem.h       |  3 +++
>  net/core/devmem.c          | 10 ++++++++++
>  net/core/devmem.h          | 11 +++++++++++
>  net/core/skbuff.c          | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> index 0f3c58007488..9e49372ef1a0 100644
> --- a/include/linux/skbuff_ref.h
> +++ b/include/linux/skbuff_ref.h
> @@ -17,7 +17,7 @@
>   */
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -	get_page(skb_frag_page(frag));
> +	get_netmem(skb_frag_netmem(frag));
>  }
>  
>  /**
> @@ -40,7 +40,7 @@ static inline void skb_page_unref(netmem_ref netmem, bool recycle)
>  	if (recycle && napi_pp_put_page(netmem))
>  		return;
>  #endif

[..]

> -	put_page(netmem_to_page(netmem));
> +	put_netmem(netmem);

I moved the release operation onto a workqueue in my series [1] to avoid
calling dmabuf detach (which can sleep) from the socket close path
(which is called with bh disabled). You should probably do something similar,
see the trace attached below.

1: https://github.com/fomichev/linux/commit/3b3ad4f36771a376c204727e5a167c4993d4c65a#diff-3c58b866674b2f9beb5ac7349f81566e4df595c25c647710203549589d450f2dR436

(the condition to trigger that is to have an skb in the write queue
and call close from the userspace)

[    1.548495] BUG: sleeping function called from invalid context at drivers/dma-buf/dma-buf.c:1255
[    1.548741] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 149, name: ncdevmem
[    1.548926] preempt_count: 201, expected: 0
[    1.549026] RCU nest depth: 0, expected: 0
[    1.549197]
[    1.549237] =============================
[    1.549331] [ BUG: Invalid wait context ]
[    1.549425] 6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15 Tainted: G        W
[    1.549609] -----------------------------
[    1.549704] ncdevmem/149 is trying to lock:
[    1.549801] ffff8880066701c0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.550051] other info that might help us debug this:
[    1.550167] context-{5:5}
[    1.550229] 3 locks held by ncdevmem/149:
[    1.550322]  #0: ffff888005730208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x40/0xf0
[    1.550530]  #1: ffff88800b148f98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x19/0x80
[    1.550731]  #2: ffff88800b148f18 (slock-AF_INET6){+.-.}-{3:3}, at: __tcp_close+0x185/0x4b0
[    1.550921] stack backtrace:
[    1.550990] CPU: 0 UID: 0 PID: 149 Comm: ncdevmem Tainted: G        W          6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15
[    1.551233] Tainted: [W]=WARN
[    1.551304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.551518] Call Trace:
[    1.551584]  <TASK>
[    1.551636]  dump_stack_lvl+0x86/0xc0
[    1.551723]  __lock_acquire+0xb0f/0xc30
[    1.551814]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.551941]  lock_acquire+0xf1/0x2a0
[    1.552026]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552152]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552281]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552408]  __ww_mutex_lock+0x121/0x1060
[    1.552503]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552648]  ww_mutex_lock+0x3d/0xa0
[    1.552733]  dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552857]  __net_devmem_dmabuf_binding_free+0x56/0xb0
[    1.552979]  skb_release_data+0x120/0x1f0
[    1.553074]  __kfree_skb+0x29/0xa0
[    1.553156]  tcp_write_queue_purge+0x41/0x310
[    1.553259]  tcp_v4_destroy_sock+0x127/0x320
[    1.553363]  ? __tcp_close+0x169/0x4b0
[    1.553452]  inet_csk_destroy_sock+0x53/0x130
[    1.553560]  __tcp_close+0x421/0x4b0
[    1.553646]  tcp_close+0x24/0x80
[    1.553724]  inet_release+0x5d/0x90
[    1.553806]  sock_close+0x4a/0xf0
[    1.553886]  __fput+0x9c/0x2b0
[    1.553960]  task_work_run+0x89/0xc0
[    1.554046]  do_exit+0x27f/0x980
[    1.554125]  do_group_exit+0xa4/0xb0
[    1.554211]  __x64_sys_exit_group+0x17/0x20
[    1.554309]  x64_sys_call+0x21a0/0x21a0
[    1.554400]  do_syscall_64+0xec/0x1d0
[    1.554487]  ? exc_page_fault+0x8a/0xf0
[    1.554585]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.554703] RIP: 0033:0x7f2f8a27abcd


