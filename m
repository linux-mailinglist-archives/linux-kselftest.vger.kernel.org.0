Return-Path: <linux-kselftest+bounces-26280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583BA2FF44
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9593A659C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96271531E3;
	Tue, 11 Feb 2025 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gz1qOIJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EE1805E
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234454; cv=none; b=ktsmm24UGWYW/kh60EYx6SDdmSsup/lm8VFbFjPHmf4BKSJ+cd09ojePyUY5YwE1QqLFJOAClj18DSwV3HuaiYelUnk+Elm9pup23bR/b8Pg5ld7TGob9zdmSq7Q6xVl8m/kMMIDOWYyW0JICgky7jnFJ7h1Kxs4jyvmIr9MXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234454; c=relaxed/simple;
	bh=6pw2TQ0SjoDnu4BaWDqt5hNE/+yUbJqKYSfq/PbVHsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YfhoCn8KdbFFggCi6sYOw2OwPXQThWe7ahl6xD7UJN/R5jBtk45OEvgnxLwcegpIc6EmywDrxQmpZSR3MCKbDWeFto6WWOKienlZPnYSRKyp3Jpid+/gpCA2CtLkDcOpfrXn4W8OBBdplT7DF6RHDs72Esp+YoJSsllxsDfZ0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gz1qOIJS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso33255315e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234449; x=1739839249; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVd2mKTgpGboJauYAZVv+V8TB7b+iiGTljWobdbpSsI=;
        b=gz1qOIJSIlS3MLfXE8FrPWsZV8JySK98NbBumpts83Y5Gg9JHO8HUfIyDCQ90j3qiW
         7flwH61Xxoo2vAKqGWlp53KLa9OBfwpPChYXjpJIMEfDxKuAdD9bN5HL93L31R0/Z5Lg
         MKdCN1Kw+vdBnV75sx6C7fvwduBuOs3Hp0xvIus9GCBmKvAl/Llo0Oa5BjXI+o2V9Ans
         AGffFyxEO7vzrb8q0J8g8mIrntyjmWwZANDucFR3wf67zpmT0uxqUyfGjdlsiDcZrnl/
         AzxdV/CmvdtvWd1ZxKUwxzWdvfGMUykT2+HYxAp3iryPnNYD/z2mJUWvxKT6q4JSsne2
         g4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234449; x=1739839249;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVd2mKTgpGboJauYAZVv+V8TB7b+iiGTljWobdbpSsI=;
        b=fbqqMOmbLJTQqelKr+BjepzWF6BKlEXhgL8xnwzGQa2z6J6gKfCr0axxwYkAyugb0S
         CuzaCoUzjmUsv7ZHAMy0YRcPECvKN/K9mMAvCrI1KSMHWshxauRHflHdmT6xJfwOb6rE
         Tf6g8F5fTzi4YzDFCQXBk0RIrbCGOOyfJyiSWkFRTEyQgJjX7jw2rVgsF0lLgWqiiC6d
         5bOs/+YRnbi7xAJxSvvrykFPCwmv3BL3ekO0mm6Pqz3rLFPtZVy0m6zjbRIS402/ZsuG
         sa6gJg7p1DUV/ZbB6WDg1OyainSTAWFFBxEQHczpEJ2NUl04BdY0lZf+crBUxlx0D2gZ
         Qvgw==
X-Forwarded-Encrypted: i=1; AJvYcCUawRQ63rLWgnrmcHJrGXmm8xmSxHpwF9djhUenHCcZlSsTr3GA3ZuSRUPl7taFsnBBJyjm/dBOunJb5OtVXqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dCrAg9D3znkibQUxeSMylfQVNAeM2yhapGVv2toA0NyBe6SG
	nasuqsSk60dSRQ2gMYYWENYLW69YyOpbZNaoV3JN8cBzovqdZxL0qUKCv4057nc=
X-Gm-Gg: ASbGncuow8mq2Tryexrj1RVeTSNw8F33QmxSeb/pIQMbkY7DpEM0GRcVudpI1g5l1jz
	8v9Oadtsxp+a8QRA8UNsK6uj/DdVngImXQ6pszz4DWmLxoyC5nH7np0lidCitU6dYbpS33sDs3H
	oGrPfvoTTjKoAeKdzKw46t+Z6kk1OV7WFKydFUgH6xUfav3OIi8N3GhHO2JmxbYMyDUteQbfsK/
	5F3DwQl42yy+93QYUz1+BhOBmaLhMYmGwCGkm46GJUs2F2rwFGW+pKYgphQtu4VChEewBsTwjWg
	wjSYqpNbJW2rMic+S2LETbo8UGA=
X-Google-Smtp-Source: AGHT+IEyhXgYjEqazXHEpDwin/gMg4aCXFrL1D2P3CL35MWUh7QP5RLjFYtd3+i15P4bIzCnNdge8g==
X-Received: by 2002:a05:600c:5110:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-4392497dad8mr128785745e9.6.1739234449085;
        Mon, 10 Feb 2025 16:40:49 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:40:48 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
Date: Tue, 11 Feb 2025 01:39:53 +0100
Message-Id: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmcqmcC/23QzW7DIAwH8FepOI8N23yEnfYe0w6QOGsOI1VSR
 Z2qvvvcTl2ZBDcwP/8NZ7XyMvGqXndntfA2rdNcZAPxaaf6fSqfrKdBDhQatGAM6mz1vB2KZln
 keh9tQiW3DwuP0+nW6l0VPurCp6P6kEpOK+u8pNLvr53utZevNJWr3E/rcV6+bzNs8eZ/08D/p
 W1RG51S5jggujS4t/nARSrP0u6WsoGpKLoHBSM2d8GRCSFkDg0LtY2VBbEDWx+7PlDCVi4+LFY
 fJAWxSHEcA1EeYyuXals9F0isD2O2mb33jA1ra1vPbMVyQkv9CN5CK9dVVt74sE4sgWXs02A8d
 A3ra1vn+qtlMgbAke+oYcPdOrlkKhvE2pCRQmDnoWW72lJlO7EwGjPk2GMe/H97uVx+AEz2t7D
 nAgAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15965; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=6pw2TQ0SjoDnu4BaWDqt5hNE/+yUbJqKYSfq/PbVHsY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyEySuHxzUPhjIWgI17RL/34I8uqTxCApFJP
 ltc/ZooxVKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qchAAKCRALcOU6oDjV
 hzv3B/4taTR7BzIk0ht/5gktM3T1fXmvYw/eZvBLwdrmBlABWoraezV4azR3g02YqXrJwS/kfG1
 WGSnO14bkPQwplUc9nG3tKZnMuMOUbE6A2URUoOlX7ifa0YlySX+2te4wLTfzEPlcwHyVtz6Fci
 ZPhaxQlG9LB+hQ4W9DWMyF7A3l+ZH95++t2gktCyITK7vooMqHzLSthDO75UVhQbrjUb6IR218z
 BXkPB7tFSYOEgAgSsNsfhTWzS5fRdzdPETGR9lfH+Rgalozmkto8u48wxh6m9IcqkCA/e17flyg
 OOEqsV4aZO0fMWI/ruP7oFKrgqvGtUHmBKP832P3w3M1U25q
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

All minor and major reported problems have been finally addressed.
Big thanks to Sabrina, who took the time to guide me through
converting the peer socket to an RCU pointer.

This patchset comes with an extra patch for .mailmap to remove
my @openvpn.net address from the file, otherwise git won't allow
me to send patches from this address.

Notable changes since v18:
* ovpnstruct.h renamed to ovpnpriv.h to reflect new struct name
* removed peers release upon NETDEV_DOWN
* moved netdev_put() to after call_rcu() in ovpn_peer_release()
* removed DEBUG_NET_WARN_ON_ONCE in case of mismatching peer in
  peer_del_p2p()
* turned peer->sock into RCU pointer to be able to guarantee
  its validity in every context (thanks Sabrina for this!)
** the point above forced various socket handling functions to
   change into using a properly dereferenced RCU pointer instead
   of accessing peer->sock directly
* ensured peer->sock is NULLified upon release so that other contexts
  have a way to check if the member carries a valid pointer or not
* fixed ovpn_opcode_from_skb()'s comment about accessing 4 bytes (not 1)
* improved ovpn_udp_encap_recv()'s comment wrt various packet types
* ensured that 'iv' in ovpn_aead_crypt/decrypt() is malloc'd and
  carried in the skb's cb for async crypto usage
* added missing ovpn_crypto_key_slot_put() in ovpn_encrypt_one() error
  path
* TCP TX work item moved from ovpn_peer to ovpn_socket to ensure it
  stays alive along with the socket (peer may disappear earlier during
  release)
* pulled 4 bytes (instead of 1) before calling ovpn_opcode_from_skb()
  in ovpn_tcp_rcv()
* added missing kfree_skb() in ovpn_tcp_socket_detach()
* moved call to ovpn_mp_alloc() to ndo_init() to ensure it could always
  be rolled back in case of register_netdevice() failure
* splitted by_vpn_addr hashtables into by_vpn_addr4 and by_vpn_addr6 so
  that peers assigned a v4 or a v6 can be hashed separately. This
  avoids hash_entry offset mix ups during entries iterations
* changed ovpn_nl_attr_sockaddr_remote() into returning just bool
* added a few more consistency checks in peer_new/peer_set
* added completion member to peer to signal when socket detachment has
  finished and thus allow peer_del call to happily terminate (thanks
  Sabrina again!)
* extended selftest script with "peer removal during traffic exchange"

Please note that some patches were already reviewed/tested by a few
people. These patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

NOTE: TCP tests are still showing the following warning while running
iperf.
I have analysed the report several times, but it definitely looks like
a false positive to me, so nothing to worry about.

Basically the lockdep engine gets confused thinking that we are
acquiring the lock twice on the same sock, but actually:
1) the kernel is first locking the 'iperf' (user) TCP socket;
2) ovpn is later locking the underlying TCP trasport socket.

So there is NO risk of deadlock (and indeed nothing hangs), but I
couldn't find a way to make the warning go away.

Here it is:

[ 1056.319348] ============================================
[ 1056.319740] WARNING: possible recursive locking detected
[ 1056.319740] 6.14.0-rc1-00217-g30aa34e21028-dirty #111 Tainted: G           O
[ 1056.319740] --------------------------------------------
[ 1056.319740] iperf3/1438 is trying to acquire lock:
[ 1056.319740] ffff88811ea10218 (slock-AF_INET){+.-.}-{3:3}, at: ovpn_tcp_send_skb+0xef/0x490 [ovpn]
[ 1056.319740]
               but task is already holding lock:
[ 1056.319740] ffff8881112b1c98 (slock-AF_INET){+.-.}-{3:3}, at: tcp_delack_timer+0xaa/0x2e0
[ 1056.319740]
               other info that might help us debug this:
[ 1056.319740]  Possible unsafe locking scenario:

[ 1056.319740]        CPU0
[ 1056.319740]        ----
[ 1056.319740]   lock(slock-AF_INET);
[ 1056.319740]   lock(slock-AF_INET);
[ 1056.319740]
                *** DEADLOCK ***

[ 1056.319740]  May be due to missing lock nesting notation

[ 1056.319740] 6 locks held by iperf3/1438:
[ 1056.319740]  #0: ffffc90000400c28 ((&icsk->icsk_delack_timer)){+.-.}-{0:0}, at: call_timer_fn+0x102/0x230
[ 1056.319740]  #1: ffff8881112b1c98 (slock-AF_INET){+.-.}-{3:3}, at: tcp_delack_timer+0xaa/0x2e0
[ 1056.319740]  #2: ffffffff85ef2b20 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x68/0x1190
[ 1056.319740]  #3: ffffffff85ef2b20 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x2d4/0x1bb0
[ 1056.319740]  #4: ffffffff85ef2ac0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x1fc/0xee0
[ 1056.319740]  #5: ffffffff85ef2b20 (rcu_read_lock){....}-{1:3}, at: ovpn_encrypt_post+0x168/0x5d0 [ovpn]
[ 1056.319740]
               stack backtrace:
[ 1056.319740] CPU: 4 UID: 0 PID: 1438 Comm: iperf3 Tainted: G           O       6.14.0-rc1-00217-g30aa34e21028-dirty #111
[ 1056.319740] Tainted: [O]=OOT_MODULE
[ 1056.319740] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
[ 1056.319740] Call Trace:
[ 1056.319740]  <IRQ>
[ 1056.319740]  dump_stack_lvl+0x75/0xb0
[ 1056.319740]  dump_stack+0x14/0x16
[ 1056.319740]  print_deadlock_bug.cold+0xbd/0xc7
[ 1056.319740]  validate_chain+0x6db/0xe00
[ 1056.319740]  ? kfree_sensitive+0x63/0x70
[ 1056.319740]  ? check_prev_add+0xa60/0xa60
[ 1056.319740]  ? mark_lock+0x34/0x2d0
[ 1056.319740]  ? check_wait_context.isra.0+0x245/0x6a0
[ 1056.319740]  __lock_acquire+0x6ed/0x1000
[ 1056.319740]  lock_acquire+0x182/0x3c0
[ 1056.319740]  ? ovpn_tcp_send_skb+0xef/0x490 [ovpn]
[ 1056.319740]  ? __lock_acquire+0x1000/0x1000
[ 1056.319740]  ? ovpn_encrypt_post+0x168/0x5d0 [ovpn]
[ 1056.319740]  ? __lock_acquire+0x1000/0x1000
[ 1056.319740]  ? __kasan_slab_free+0x47/0x50
[ 1056.319740]  _raw_spin_lock+0x36/0x50
[ 1056.319740]  ? ovpn_tcp_send_skb+0xef/0x490 [ovpn]
[ 1056.319740]  ovpn_tcp_send_skb+0xef/0x490 [ovpn]
[ 1056.319740]  ovpn_encrypt_post+0x388/0x5d0 [ovpn]
[ 1056.319740]  ovpn_send+0x2a9/0x720 [ovpn]
[ 1056.319740]  ? ovpn_encrypt_post+0x5d0/0x5d0 [ovpn]
[ 1056.319740]  ovpn_net_xmit+0x5e1/0xa40 [ovpn]
[ 1056.319740]  ? ovpn_send+0x720/0x720 [ovpn]
[ 1056.319740]  dev_hard_start_xmit+0x1c4/0x350
[ 1056.319740]  __dev_queue_xmit+0x477/0xee0
[ 1056.319740]  ? netdev_core_pick_tx+0x2b0/0x2b0
[ 1056.319740]  ? selinux_ip_postroute_compat+0x460/0x460
[ 1056.319740]  neigh_direct_output+0x17/0x20
[ 1056.319740]  ip_finish_output2+0x6fd/0x1bb0
[ 1056.319740]  ? ip_fragment.constprop.0+0x220/0x220
[ 1056.319740]  ? ip_frag_next+0xcf0/0xcf0
[ 1056.319740]  __ip_finish_output+0x2f4/0x530
[ 1056.319740]  ip_output+0x166/0x560
[ 1056.319740]  ? __ip_local_out+0x44d/0x800
[ 1056.319740]  ? ip_finish_output+0x20/0x20
[ 1056.319740]  ? __ip_finish_output+0x530/0x530
[ 1056.319740]  ? __kasan_check_write+0x18/0x20
[ 1056.319740]  __ip_queue_xmit+0x6ec/0x1190
[ 1056.319740]  ip_queue_xmit+0x4e/0x70
[ 1056.319740]  __tcp_transmit_skb+0x17ce/0x3480
[ 1056.319740]  ? __tcp_select_window+0x1700/0x1700
[ 1056.319740]  ? __build_skb_around+0x23d/0x350
[ 1056.319740]  __tcp_send_ack+0x393/0x700
[ 1056.319740]  tcp_send_ack+0x43/0x50
[ 1056.319740]  tcp_delack_timer_handler+0x2b2/0x440
[ 1056.319740]  ? tcp_clamp_probe0_to_user_timeout+0x110/0x110
[ 1056.319740]  tcp_delack_timer+0x1c9/0x2e0
[ 1056.319740]  ? call_timer_fn+0x102/0x230
[ 1056.319740]  ? tcp_delack_timer_handler+0x440/0x440
[ 1056.319740]  call_timer_fn+0x151/0x230
[ 1056.319740]  ? call_timer_fn+0x102/0x230
[ 1056.319740]  ? trace_timer_expire_entry+0x1e0/0x1e0
[ 1056.319740]  __run_timers+0x62f/0x950
[ 1056.319740]  ? tcp_delack_timer_handler+0x440/0x440
[ 1056.319740]  ? call_timer_fn+0x230/0x230
[ 1056.319740]  ? __kasan_check_write+0x18/0x20
[ 1056.319740]  ? trace_irq_disable+0x160/0x1e0
[ 1056.319740]  run_timer_softirq+0x156/0x260
[ 1056.319740]  ? __run_timers+0x950/0x950
[ 1056.319740]  handle_softirqs+0x208/0x5d0
[ 1056.319740]  ? trace_softirq_exit+0x1d0/0x1d0
[ 1056.319740]  ? trace_preempt_on+0x21/0x30
[ 1056.319740]  __irq_exit_rcu+0xc5/0x100
[ 1056.319740]  irq_exit_rcu+0x12/0x20
[ 1056.319740]  sysvec_apic_timer_interrupt+0x84/0xb0
[ 1056.319740]  </IRQ>
[ 1056.319740]  <TASK>
[ 1056.319740]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 1056.319740] RIP: 0010:acpi_pm_read+0x14/0x20
[ 1056.319740] Code: dd 7a 04 31 f6 48 89 e5 ff d0 5d c3 c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 55 8b 15 10 cc 2c 03 48 89 e5 ed <25> ff ff ff 00 5d c3 0f 1f 44 00 00 f3 0f 1e fa 0f 1f 44 00 00 8b
[ 1056.319740] RSP: 0018:ffffc90002277bf8 EFLAGS: 00000246
[ 1056.319740] RAX: 000000000097dc75 RBX: dffffc0000000000 RCX: ffffffff817c4b93
[ 1056.319740] RDX: 0000000000000608 RSI: 0000000000000000 RDI: ffffffff868a5960
[ 1056.319740] RBP: ffffc90002277bf8 R08: 0000000000000001 R09: 0000000000000000
[ 1056.319740] R10: 0000000000000001 R11: 0000000000000000 R12: fffff5200044ef8e
[ 1056.319740] R13: ffffc90002277c70 R14: 0000000000034608 R15: ffffffff868a5960
[ 1056.319740]  ? __x64_sys_gettimeofday+0xc3/0x1a0
[ 1056.319740]  ktime_get_real_ts64+0xcd/0x2d0
[ 1056.319740]  __x64_sys_gettimeofday+0xc3/0x1a0
[ 1056.319740]  ? put_itimerspec64+0x190/0x190
[ 1056.319740]  x64_sys_call+0x1741/0x17d0
[ 1056.319740]  do_syscall_64+0xd9/0x1b0
[ 1056.319740]  ? syscall_exit_to_user_mode+0xd4/0x1e0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  ? syscall_exit_to_user_mode+0xd4/0x1e0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  ? __might_fault+0xb9/0x120
[ 1056.319740]  ? __might_fault+0xee/0x120
[ 1056.319740]  ? syscall_exit_to_user_mode+0xd4/0x1e0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  ? syscall_exit_to_user_mode+0xd4/0x1e0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  ? do_syscall_64+0xe6/0x1b0
[ 1056.319740]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1056.319740] RIP: 0033:0x7fa5fb82dabb
[ 1056.319740] Code: e8 26 89 c0 48 89 47 08 48 85 f6 75 1e 31 c0 c3 81 3d 59 b5 ff ff ff ff ff 7f 74 76 f3 90 e9 3c ff ff ff b8 60 00 00 00 0f 05 <c3> 81 3d 3e b5 ff ff ff ff ff 7f 48 8d 15 33 b5 ff ff 48 8d 05 2c
[ 1056.319740] RSP: 002b:00007ffd9d3763b8 EFLAGS: 00000297 ORIG_RAX: 0000000000000060
[ 1056.319740] RAX: ffffffffffffffda RBX: 000055a374dfb260 RCX: 00007fa5fb82dabb
[ 1056.319740] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd9d3763c0
[ 1056.319740] RBP: 00007ffd9d3763d0 R08: 0000000000000000 R09: 0000000000034608
[ 1056.319740] R10: 00007fa5fb829000 R11: 0000000000000297 R12: 00007ffd9d376450
[ 1056.319740] R13: 00007ffd9d3763c0 R14: 0000000000000001 R15: 0000000000000001
[ 1056.319740]  </TASK>

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (26):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ipv6: export inet6_stream_ops via EXPORT_SYMBOL_GPL
      ovpn: implement TCP transport
      skb: implement skb_send_sock_locked_with_flags()
      ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local UDP endpoint
      ovpn: add support for peer floating
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module
      mailmap: remove unwanted entry for Antonio Quartulli

 .mailmap                                           |    1 -
 Documentation/netlink/specs/ovpn.yaml              |  372 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  408 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  346 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1248 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1273 +++++++++++
 drivers/net/ovpn/peer.h                            |  164 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  223 ++
 drivers/net/ovpn/socket.h                          |   51 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  557 +++++
 drivers/net/ovpn/tcp.h                             |   34 +
 drivers/net/ovpn/udp.c                             |  421 ++++
 drivers/net/ovpn/udp.h                             |   24 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  111 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2377 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  192 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 54 files changed, 9817 insertions(+), 6 deletions(-)
---
base-commit: 39f54262ba499d862420a97719d2f0eea0cbd394
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


