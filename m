Return-Path: <linux-kselftest+bounces-26584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB2A34E90
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C163AB268
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3124A077;
	Thu, 13 Feb 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ayffIehT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C4245AFB
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475658; cv=none; b=BErGTszbSkndVSK2XRzXwFSztIRKiZcVUitsEjCvm1v6uewIOm9N41qYJzYfxxqxpBr46hhmN8P0E6wKZFczgZktRJWap4fccmHLPqzxOcMauR6ZODd4jKB/dzRv7Z3oBMsKvS5siX/V3FMB38ZVMOHFPd87li1DcOJYMJKR2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475658; c=relaxed/simple;
	bh=ChdL9DAZt34v3GZl8S1TxgXWVeOpXC8lj6ygvioHH6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeAH1GDYmyJNxAAXtLCFDoRKnNHnb4bYgKWJjzUXm7jHnhZAUvaMOM5i1cAKmlk8KhDd/JNg4l+sNDcYXmZ+LhTUhjyjw/uCanoXTsnYElyCrcwNvjS2RnmoinC+KuGr4snjEV1nuKqhSfxkzEZgbKwNK3O8/gs2/FMRSTvm5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ayffIehT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so13861675e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739475653; x=1740080453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PnR7vXNcgrX4SDPtoMoOJMFx4K93Rm8Jlor9x6UL02E=;
        b=ayffIehT1Ro6KOrTqrOj4KumZSbhgnsK3Nhc3xe7WrulegcMZXRNPJ3RmxSzxDrOlq
         rcEIg3Mw2ienN8M9M86eAhgyAnCr9pRGQmk5xzjR2oxJQApf2ZUC9DmO/z3KrcbCcWag
         75htdZG2CHMM64LY4F/DDv8D6PuVL82JhqstsuqRIoZp6i9wTMyS7S7OpgjUeIqio2a8
         sb9qGEjaNim7YZOfZdhwVRrQQzHbzmdeTY38cbXpyocpRJGP28bbzZ/FRS2llZLi22f7
         MUtOcNvQn+KX5YvZhExLAyxUWcwMwy9diyH5uay/e9rV145Pwe9QkjQzdT3/2/bHO+92
         iLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739475653; x=1740080453;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnR7vXNcgrX4SDPtoMoOJMFx4K93Rm8Jlor9x6UL02E=;
        b=R3GwS0pDWz87e3k4DTCxiHsKmn5rKp0UqkissUBpcA6N5gQ4ft2wXs9L7hG0IO+7iC
         X5ckUzIqDiLAPcroG/+HKtMy+j09NRGxVy/eo/nnA09oaFN51sQOs/IpqjHKG+W+qZib
         Bo2FXmOqa22Aa22bvFjV2/22Wm9COZSIbbNpX/tmBagDq578/J+pkn4cVVa3Z2Vb25Gj
         E5ThnSE0O1Wuv5KsHrrW8yVUKAv8TyDHgAa4HHf6wlcqfucol0GKdCeMGH8nxLcmQRqU
         LwQJ8sOaOgG1aDS6NwIRKdfp2tdD/ZxgyhV396uUc2vSUKBb2gAmkpkW/j/bHssX5O9P
         pF/g==
X-Forwarded-Encrypted: i=1; AJvYcCXGgCgdJsGmYxzQd16n6qmIn6ZRKo7/U/H8d/Lc5jHMxaAO3Y43hh6kZ4sfYy7AEkUX3IHBMJLajMtbZav8jxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JF7i4sgc6SpW8T2JNkRxHgGZlBvbEQxATvMsIeTz2HrU6mP9
	LV12nPPxHnYXCXmWrkSMZ0bkVI1r0MGexinZjLgg8UuwFIGP5KlkgPNo+0Gt26c=
X-Gm-Gg: ASbGncs3WxS4eIZAIir0M8vtOyl1upfNtr5gOgUMky/ev0TqPkMqgDwm8PwAWmqkHHZ
	Jg0wSw4gf/jqg6Pn3FbBDra85qByoYi0uCEHXslRDxIFEa1dq6FfC+nRrlIOVK7hvn+cYnBkxg0
	+v332VV5wIu1Nu1BlnakiUmyq0AgXtWwudt+NkLb9em2CbepUpDaQFkSmMbECrL6gu7j2gDICGi
	e9DSGi45G1b2vWw6J9ESUPFn3qttpgaaaxWjCBVuM1mxub9Pfwb8DEZ8PX0lNkMrG+MG9frHjbY
	Nrd2lS3euzdyZvemc+zovvuAZ6xnlDPm/u7i9IjbWsKXJhAJm/Rptg==
X-Google-Smtp-Source: AGHT+IGh456dRd6btQ9kPaLgOAC/tBgyfMlLY4h5D/IXVgm7hUoi4atn5IbNYgkAnW9x0T+f9dgelg==
X-Received: by 2002:a05:600c:41d5:b0:439:59cf:8dfe with SMTP id 5b1f17b1804b1-43959cf90bfmr100001125e9.0.1739475653440;
        Thu, 13 Feb 2025 11:40:53 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:8ed1:f279:ecc1:ee2e? ([2001:67c:2fbc:1:8ed1:f279:ecc1:ee2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm56483425e9.2.2025.02.13.11.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:40:52 -0800 (PST)
Message-ID: <0c0de58a-4dac-4b3b-9fc5-2a58a145d5ab@openvpn.net>
Date: Thu, 13 Feb 2025 20:40:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <Z60wIRjw5Id1VTal@hog> <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>
 <Z64Tw02PO433bob8@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z64Tw02PO433bob8@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2025 16:46, Sabrina Dubroca wrote:
> 2025-02-13, 12:46:34 +0100, Antonio Quartulli wrote:
>> On 13/02/2025 00:34, Sabrina Dubroca wrote:
>>> Hello,
>>>
>>> 2025-02-11, 01:39:53 +0100, Antonio Quartulli wrote:
>>>> All minor and major reported problems have been finally addressed.
>>>> Big thanks to Sabrina, who took the time to guide me through
>>>> converting the peer socket to an RCU pointer.
>>>
>>> Something is off (not sure if it's new to this version): if I use
>>> test-tcp.sh to setup a set of interfaces and peers (I stop the test
>>> just after setup to keep the environment alive), then remove all netns
>>> with "ip -all netns delete", I expect all devices to go away, but they
>>> don't. With debug messages enabled I'm seeing some activity from the
>>> module ("tun0: sending keepalive to peer 3" and so on), and
>>> ovpn_net_uninit/ovpn_priv_free never got called.
>>
>> I can reproduce it. If later I rmmod ovpn I then get all the "Deleting peer"
>> messages.
>> So instances are not being purged on netns exit.
>>
>> Will dive into it.
> 
> I think the socket holds a ref on the netns, so it's not getting
> destroyed, simply "removed" from iproute's point of view. And the
> socket isn't going away as long as it's used by a peer.

After a deep dive I was getting to the same conclusion:
cleanup_net() is never invoked because we lack an invocation of put_net().
sk_alloc() invokes get_net(), so this is the ref that is not being released.

> 
> If I delete the peer(s) for the ovpn device and then the netns it was
> in, the netns is fully removed, and the ovpn device is gone. Also no
> issue if I delete the ovpn device before its netns, then everything is
> destroyed as expected.
> 
> I'm not sure that can be solved, as least under the current refcount
> scheme.

I went back to v12 of the patchset (which is pre-refcount-restructuring) 
and indeed the problem there doesn't exist.

However, it's unclear to me how in v12 the socket release was happening 
upon netns delete. Who was triggering that? ovpn still needed to call 
sockfd_put() in order to let it go.

Will investigate some more and think about a solution.

> 
> But I don't think there's a way to re-attach to that netns afterwards
> if we wanted to clean up manually (something similar to "ip netns
> attach <name> <pid>", but that won't work if whatever created the
> socket is not running anymore -- as is the case with ovpn-cli).

Yeah, it just hangs in background until reboot.

> 
>>>
>>> [...]
>>>> So there is NO risk of deadlock (and indeed nothing hangs), but I
>>>> couldn't find a way to make the warning go away.
>>>
>>> I've spotted another splat on strparser cleanup that looked like an
>>> actual deadlock, but it's not very reproducible. Still looking into
>>> it, but I'm not convinced it's ok to call strp_done (as is done from
>>> ovpn_tcp_socket_detach) while under lock_sock, because AFAIU
>>> cancel_work_sync(&strp->work) may be waiting for a work that needs to
>>> lock the socket (cb.lock in do_strp_work). I guess tcp_tx_work would
>>> have the same problem.
>>
>> Will have a look here too.

Thanks for all the info below.
I will have a deeper look at this tomorrow.

Regards,


> 
> The only ways I've managed to reproduce it is by using some ugly
> kernel-side hacks to try to force that path being hit. Either forcing
> the strp work to be queued just as we detach the socket (in
> strp_stop), or this:
> 
>   - hack some code path to do a big sleep() under lock_sock(), to give
>     me the time to do the next steps
>   - ping over ovpn, or any other way to add packets on the receive
>     socket
>   - delete the peer for the sleeping socket (while it's still sleeping)
> 
> When that big sleep is over, strp_data_ready will kick off and queue
> its worker (because at this point the socket lock is still owned),
> then I think del_peer proceeds toward tcp_detach and I got the splat
> below. So that's maybe a bit hard to trigger in real life (I don't
> remember what I was doing the first time I got it, I think something
> messing with the RCU stuff we discussed earlier).
> 
> 
> [  922.681435][  T300] ======================================================
> [  922.686247][  T300] WARNING: possible circular locking dependency detected
> [  922.690971][  T300] 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279 Tainted: G                 N
> [  922.696584][  T300] ------------------------------------------------------
> [  922.699697][  T300] kworker/1:2/300 is trying to acquire lock:
> [  922.702105][  T300] ffff88800a662160 ((work_completion)(&strp->work)){+.+.}-{0:0}, at: start_flush_work+0x407/0xa50
> [  922.705716][  T300]
> [  922.705716][  T300] but task is already holding lock:
> [  922.707779][  T300] ffff8880113edd98 (sk_lock-AF_INET){+.+.}-{0:0}, at: ovpn_socket_release+0x8a/0x1a0
> [  922.710238][  T300]
> [  922.710238][  T300] which lock already depends on the new lock.
> [  922.710238][  T300]
> [  922.712628][  T300]
> [  922.712628][  T300] the existing dependency chain (in reverse order) is:
> [  922.714443][  T300]
> [  922.714443][  T300] -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
> [  922.716127][  T300]        __lock_acquire+0xc4d/0x1ee0
> [  922.717250][  T300]        lock_acquire+0x1a9/0x500
> [  922.718266][  T300]        lock_sock_nested+0x40/0xf0
> [  922.719325][  T300]        strp_work+0x95/0x1e0
> [  922.720240][  T300]        process_one_work+0xe28/0x1460
> [  922.721307][  T300]        worker_thread+0x674/0xee0
> [  922.722283][  T300]        kthread+0x3c3/0x760
> [  922.723101][  T300]        ret_from_fork+0x46/0x80
> [  922.723792][  T300]        ret_from_fork_asm+0x1a/0x30
> [  922.724532][  T300]
> [  922.724532][  T300] -> #0 ((work_completion)(&strp->work)){+.+.}-{0:0}:
> [  922.726038][  T300]        check_prev_add+0x1af/0x2400
> [  922.726927][  T300]        validate_chain+0xdcf/0x1a10
> [  922.727847][  T300]        __lock_acquire+0xc4d/0x1ee0
> [  922.728721][  T300]        lock_acquire+0x1a9/0x500
> [  922.729590][  T300]        start_flush_work+0x41a/0xa50
> [  922.730434][  T300]        __flush_work+0xee/0x210
> [  922.731213][  T300]        cancel_work_sync+0xb8/0xd0
> [  922.732022][  T300]        strp_done.cold+0x51/0xcf
> [  922.732830][  T300]        ovpn_tcp_socket_detach+0x28e/0x2de
> [  922.733752][  T300]        ovpn_socket_release_kref+0x1ef/0x350
> [  922.734713][  T300]        ovpn_socket_release+0xe7/0x1a0
> [  922.735577][  T300]        ovpn_peer_remove_work+0x2b/0x90
> [  922.736468][  T300]        process_one_work+0xe28/0x1460
> [  922.737357][  T300]        worker_thread+0x674/0xee0
> [  922.737985][  T300]        kthread+0x3c3/0x760
> [  922.738545][  T300]        ret_from_fork+0x46/0x80
> [  922.739177][  T300]        ret_from_fork_asm+0x1a/0x30
> [  922.739846][  T300]
> [  922.739846][  T300] other info that might help us debug this:
> [  922.739846][  T300]
> [  922.741159][  T300]  Possible unsafe locking scenario:
> [  922.741159][  T300]
> [  922.742165][  T300]        CPU0                    CPU1
> [  922.743055][  T300]        ----                    ----
> [  922.743943][  T300]   lock(sk_lock-AF_INET);
> [  922.744638][  T300]                                lock((work_completion)(&strp->work));
> [  922.745786][  T300]                                lock(sk_lock-AF_INET);
> [  922.746837][  T300]   lock((work_completion)(&strp->work));
> [  922.747788][  T300]
> [  922.747788][  T300]  *** DEADLOCK ***
> [  922.747788][  T300]
> [  922.748856][  T300] 4 locks held by kworker/1:2/300:
> [  922.749474][  T300]  #0: ffff888008499b48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xd80/0x1460
> [  922.750588][  T300]  #1: ffffc90002527d30 ((work_completion)(&peer->remove_work)){+.+.}-{0:0}, at: process_one_work+0xddf/0x1460
> [  922.751894][  T300]  #2: ffff8880113edd98 (sk_lock-AF_INET){+.+.}-{0:0}, at: ovpn_socket_release+0x8a/0x1a0
> [  922.752983][  T300]  #3: ffffffff854de980 (rcu_read_lock){....}-{1:3}, at: start_flush_work+0x39/0xa50
> [  922.754018][  T300]
> [  922.754018][  T300] stack backtrace:
> [  922.754734][  T300] CPU: 1 UID: 0 PID: 300 Comm: kworker/1:2 Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
> [  922.754748][  T300] Tainted: [N]=TEST
> [  922.754752][  T300] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [  922.754761][  T300] Workqueue: events ovpn_peer_remove_work
> [  922.754779][  T300] Call Trace:
> [  922.754785][  T300]  <TASK>
> [  922.754791][  T300]  dump_stack_lvl+0xa5/0x100
> [  922.754803][  T300]  print_circular_bug.cold+0x38/0x48
> [  922.754820][  T300]  check_noncircular+0x2f2/0x3d0
> [  922.754922][  T300]  check_prev_add+0x1af/0x2400
> [  922.754942][  T300]  validate_chain+0xdcf/0x1a10
> [  922.754991][  T300]  __lock_acquire+0xc4d/0x1ee0
> [  922.755023][  T300]  lock_acquire+0x1a9/0x500
> [  922.755104][  T300]  start_flush_work+0x41a/0xa50
> [  922.755128][  T300]  __flush_work+0xee/0x210
> [  922.755198][  T300]  cancel_work_sync+0xb8/0xd0
> [  922.755211][  T300]  strp_done.cold+0x51/0xcf
> [  922.755222][  T300]  ovpn_tcp_socket_detach+0x28e/0x2de
> [  922.755237][  T300]  ovpn_socket_release_kref+0x1ef/0x350
> [  922.755253][  T300]  ovpn_socket_release+0xe7/0x1a0
> [  922.755268][  T300]  ovpn_peer_remove_work+0x2b/0x90
> [  922.755282][  T300]  process_one_work+0xe28/0x1460
> [  922.755330][  T300]  worker_thread+0x674/0xee0
> [  922.755402][  T300]  kthread+0x3c3/0x760
> [  922.755472][  T300]  ret_from_fork+0x46/0x80
> [  922.755497][  T300]  ret_from_fork_asm+0x1a/0x30
> [  922.755521][  T300]  </TASK>
> 
> 
> And then come the hung task warnings:
>   - del_peer waiting on the completion
>   - strp waiting on lock_sock
>   - peer cleanup/socket detach waiting on cancel_work_sync/strp
> 
> [ 1106.347400][   T39] INFO: task kworker/u16:0:11 blocked for more than 122 seconds.
> [ 1106.348547][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
> [ 1106.349671][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1106.350748][   T39] task:kworker/u16:0   state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208160 flags:0x00004000
> [ 1106.352454][   T39] Workqueue: kstrp strp_work
> [ 1106.353133][   T39] Call Trace:
> [ 1106.353659][   T39]  <TASK>
> [ 1106.354143][   T39]  __schedule+0xace/0x2620
> [ 1106.360659][   T39]  schedule+0xd0/0x210
> [ 1106.361266][   T39]  __lock_sock+0x137/0x230
> [ 1106.365430][   T39]  lock_sock_nested+0xcb/0xf0
> [ 1106.366173][   T39]  strp_work+0x95/0x1e0
> [ 1106.366845][   T39]  process_one_work+0xe28/0x1460
> [ 1106.369231][   T39]  worker_thread+0x674/0xee0
> [ 1106.371594][   T39]  kthread+0x3c3/0x760
> [ 1106.375692][   T39]  ret_from_fork+0x46/0x80
> [ 1106.377040][   T39]  ret_from_fork_asm+0x1a/0x30
> [ 1106.377851][   T39]  </TASK>
> [ 1106.378355][   T39] INFO: task kworker/1:2:300 blocked for more than 122 seconds.
> [ 1106.379590][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
> [ 1106.381079][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1106.382372][   T39] task:kworker/1:2     state:D stack:0     pid:300   tgid:300   ppid:2      task_flags:0x4208060 flags:0x00004000
> [ 1106.384211][   T39] Workqueue: events ovpn_peer_remove_work
> [ 1106.385072][   T39] Call Trace:
> [ 1106.385648][   T39]  <TASK>
> [ 1106.386139][   T39]  __schedule+0xace/0x2620
> [ 1106.393518][   T39]  schedule+0xd0/0x210
> [ 1106.394195][   T39]  schedule_timeout+0x18c/0x240
> [ 1106.398840][   T39]  __wait_for_common+0x3e3/0x610
> [ 1106.403079][   T39]  __flush_work+0x14f/0x210
> [ 1106.406874][   T39]  cancel_work_sync+0xb8/0xd0
> [ 1106.407519][   T39]  strp_done.cold+0x51/0xcf
> [ 1106.408109][   T39]  ovpn_tcp_socket_detach+0x28e/0x2de
> [ 1106.408851][   T39]  ovpn_socket_release_kref+0x1ef/0x350
> [ 1106.409588][   T39]  ovpn_socket_release+0xe7/0x1a0
> [ 1106.410271][   T39]  ovpn_peer_remove_work+0x2b/0x90
> [ 1106.410973][   T39]  process_one_work+0xe28/0x1460
> [ 1106.413075][   T39]  worker_thread+0x674/0xee0
> [ 1106.416968][   T39]  kthread+0x3c3/0x760
> [ 1106.419983][   T39]  ret_from_fork+0x46/0x80
> [ 1106.421172][   T39]  ret_from_fork_asm+0x1a/0x30
> [ 1106.421829][   T39]  </TASK>
> [ 1106.422260][   T39] INFO: task ovpn-cli:1213 blocked for more than 122 seconds.
> [ 1106.423215][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
> [ 1106.424451][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1106.425643][   T39] task:ovpn-cli        state:D stack:0     pid:1213  tgid:1213  ppid:514    task_flags:0x400100 flags:0x00000002
> [ 1106.427145][   T39] Call Trace:
> [ 1106.427610][   T39]  <TASK>
> [ 1106.428005][   T39]  __schedule+0xace/0x2620
> [ 1106.431820][   T39]  schedule+0xd0/0x210
> [ 1106.432351][   T39]  schedule_timeout+0x18c/0x240
> [ 1106.435050][   T39]  __wait_for_common+0x3e3/0x610
> [ 1106.439809][   T39]  ovpn_nl_peer_del_doit+0x270/0x6e0
> [ 1106.442825][   T39]  genl_family_rcv_msg_doit+0x1ea/0x2e0
> [ 1106.445602][   T39]  genl_family_rcv_msg+0x3a7/0x5b0
> [ 1106.450559][   T39]  genl_rcv_msg+0xb1/0x160
> [ 1106.451154][   T39]  netlink_rcv_skb+0x13e/0x3d0
> [ 1106.455220][   T39]  genl_rcv+0x29/0x40
> [ 1106.455737][   T39]  netlink_unicast+0x491/0x730
> [ 1106.457107][   T39]  netlink_sendmsg+0x77d/0xc00
> [ 1106.458517][   T39]  ____sys_sendmsg+0x7c5/0xac0
> [ 1106.461329][   T39]  ___sys_sendmsg+0x163/0x1b0
> [ 1106.468146][   T39]  __sys_sendmsg+0x135/0x1d0
> [ 1106.471564][   T39]  do_syscall_64+0x64/0x140
> [ 1106.472173][   T39]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1106.472947][   T39] RIP: 0033:0x7faa76628e56
> [ 1106.473558][   T39] RSP: 002b:00007ffe757311e0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> [ 1106.474674][   T39] RAX: ffffffffffffffda RBX: 00007faa7654f740 RCX: 00007faa76628e56
> [ 1106.475715][   T39] RDX: 0000000000000000 RSI: 00007ffe75731270 RDI: 0000000000000003
> [ 1106.476847][   T39] RBP: 00007ffe757311f0 R08: 0000000000000000 R09: 0000000000000000
> [ 1106.477959][   T39] R10: 0000000000000000 R11: 0000000000000202 R12: 00005617490cf490
> [ 1106.479064][   T39] R13: 00005617490d04f0 R14: 00007ffe75731270 R15: 0000561733d62d78
> [ 1106.480175][   T39]  </TASK>
> [ 1106.480646][   T39] INFO: lockdep is turned off.
> 

-- 
Antonio Quartulli
OpenVPN Inc.


