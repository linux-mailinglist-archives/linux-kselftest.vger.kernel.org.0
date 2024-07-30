Return-Path: <linux-kselftest+bounces-14485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FE941FDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648CB2857D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFBC1AA3DE;
	Tue, 30 Jul 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hqt5oVgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C91AA3DA
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364908; cv=none; b=YH4RlG8UIe1evstavLwdA3BeiA+s9+u30EWe+7QHubknMbgpV4WQFk724jihnG4xyzNQ7gRj+waJglPHTZPtjXwP4JTZgoZnBEu4Zez1YRDhhIrvtW+AE8EH372yp+NyXolH94p5ACsGIQ9/MqIX+aNnqd3TF5H1DtRcOaRVDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364908; c=relaxed/simple;
	bh=cQu6W4UI8ZhYAkUGkdwfn6ra/TVUApW7l9/Nhh1ufIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ckyfi+0Sh8YLmYspR7+8NaYXH6XHYDD0+jckqT3FDtXMm0SZFwoGbrpDR0VOlQC7Dn2rayF5KvRWPgNcg2vTvQGvl67hjECaRq0OGnAT+fzI7LirfbD6ZSsIFEAyYmJ6wnCo/e94vb4M5shtU/6h8Ku38J9DAniXBnmyZKmvmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hqt5oVgZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b79c27dd01so27690026d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722364905; x=1722969705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMSUZZptWgXq4XhSFPCYKksGJubsTg0zmMWwFlEEsGQ=;
        b=hqt5oVgZQnnHbE06wGXWeJS8wM6HFns3kvimEE3wnKXeu9/OJCT/pI1awKdxWitTVG
         50QJt3MF8dWJ9bKqsyby7DuUWZps8elty4FjCCU8coS9h1bal5jF9kMEzeLFmyUzyYVG
         3WqAN0PvliWLxTDW1Mrt34ZFUzqH5GfhES0Flo7AHU/QvjiPZ+EJcM6ujVpAPkP4EDEF
         V6pDALV+xN0ah4rmndjg/MdVvdWImgRrMVfIvfe3flckR36W4lRuGUxFwge6joGuQK9z
         CuMtk2fp45zLn5F2Yaooy7Oxg1DEzi6a0g23pi28a0uqLJ71Oy5MVyba6elAP29iWSGd
         v//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364905; x=1722969705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMSUZZptWgXq4XhSFPCYKksGJubsTg0zmMWwFlEEsGQ=;
        b=nijWrT8X2J1VZEn7sDlL2wnBRhg7KdUWhThXA6mdN3Cf1Tl5FWB6qdT5fKj7+vZ8Cf
         6dcJpwy67lN37/2y6h7qWRfYR2E3ZI857S0Co/UryFPZBAHnhIJ1e0E4ip83WczsUJlx
         KEL8OcaYxCaNTBzeDTjsgaEtWA6Xh0n5CWe+s0DV3HHmWZqb5Tn6WOTPim4WjvIAQk3z
         71YzBAmt1ywzcZDsMhIohWZuNknjN4QZ/nnxdj+h0tKzMkGZ/OLB7xpqkV3JbSbPqqFi
         5X85rG5T5S/str3GKKOYIlpsq6yrFd+6tvOZ0CCw7pDQBqhpuKtx368rpFlanFq0RAID
         he1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxULr6W1WB9PZb9MU7iEFMxV+QtRftL9b8Y/czf4m5aB6wz+uX+X453Sf92UpQO+l65Gj6Grp9Z/mt4PScq2Lu5+qYcGYvWFIb6ahK32VH
X-Gm-Message-State: AOJu0YzKwEDwjctMQ1zkXLKebN04RvQG14f5cOd5WdOp7fu7IqA180IP
	6ZnYr2YXSFQfGu230BenUkOYoT4Ts5U3U99v5Rxs947q3ED5dnZBw9k+Pf4BVLs=
X-Google-Smtp-Source: AGHT+IHu3QxO7K9JwS90h8vXZWn3FRmiyKLJ+Z/nFLdlnRlTlnwHODIKkZCGjGrSpVBvjE40338Udw==
X-Received: by 2002:a05:6214:415:b0:6b5:7e0b:eafb with SMTP id 6a1803df08f44-6bb55a113f6mr161858606d6.24.1722364904780;
        Tue, 30 Jul 2024 11:41:44 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb07bf7sm66132716d6.137.2024.07.30.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:41:43 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	almasrymina@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	axboe@kernel.dk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v8 0/3] net: A lightweight zero-copy notification mechanism for MSG_ZEROCOPY
Date: Tue, 30 Jul 2024 18:41:17 +0000
Message-Id: <20240730184120.4089835-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Original notification mechanism needs poll + recvmmsg which is not
easy for applcations to accommodate. And, it also incurs unignorable
overhead including extra system calls.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces a new zerocopy socket notification mechanism.
Users of sendmsg pass a control message as a placeholder for the incoming
notifications. Upon returning, kernel embeds notifications directly into
user arguments passed in. By doing so, we can reduce the complexity and
the overhead for managing notifications.

We also have the logic related to copying cmsg to the userspace in sendmsg
generic for any possible uses cases in the future. However, it introduces
ABI change of sendmsg.

Changelog:
  v1 -> v2:
    - Reuse errormsg queue in the new notification mechanism,
      users can actually use these two mechanisms in hybrid way
      if they want to do so.
    - Update case SCM_ZC_NOTIFICATION in __sock_cmsg_send
      1. Regardless of 32-bit, 64-bit program, we will always handle
      u64 type user address.
      2. The size of data to copy_to_user is precisely calculated
      in case of kernel stack leak.
    - fix (kbuild-bot)
      1. Add SCM_ZC_NOTIFICATION to arch-specific header files.
      2. header file types.h in include/uapi/linux/socket.h

  v2 -> v3:
    - 1. Users can now pass in the address of the zc_info_elem directly
      with appropriate cmsg_len instead of the ugly user interface. Plus,
      the handler is now compatible with MSG_CMSG_COMPAT and 32-bit
      pointer.
    - 2. Suggested by Willem, another strategy of getting zc info is
      briefly taking the lock of sk_error_queue and move to a private
      list, like net_rx_action. I thought sk_error_queue is protected by
      sock_lock, so that it's impossible for the handling of zc info and
      users recvmsg from the sk_error_queue at the same time.
      However, sk_error_queue is protected by its own lock. I am afraid
      that during the time it is handling the private list, users may
      fail to get other error messages in the queue via recvmsg. Thus,
      I don't implement the splice logic in this version. Any comments?

  v3 -> v4:
    - 1. Change SOCK_ZC_INFO_MAX to 64 to avoid large stack frame size.
    - 2. Fix minor typos.
    - 3. Change cfg_zerocopy from int to enum in msg_zerocopy.c

  Initially, we expect users to pass the user address of the user array
  as a data in cmsg, so that the kernel can copy_to_user to this address
  directly.

  As Willem commented,

  > The main design issue with this series is this indirection, rather
  > than passing the array of notifications as cmsg.

  > This trick circumvents having to deal with compat issues and having to
  > figure out copy_to_user in ____sys_sendmsg (as msg_control is an
  > in-kernel copy).

  > This is quite hacky, from an API design PoV.

  > As is passing a pointer, but expecting msg_controllen to hold the
  > length not of the pointer, but of the pointed to user buffer.

  > I had also hoped for more significant savings. Especially with the
  > higher syscall overhead due to meltdown and spectre mitigations vs
  > when MSG_ZEROCOPY was introduced and I last tried this optimization.

  We solve it by supporting put_cmsg to userspace in sendmsg path starting
  from v5.

  v4 -> v5:
    - 1. Passing user address directly to kernel raises concerns about
    ABI. In this version, we support put_cmsg to userspace in TX path
    to solve this problem.

  v5 -> v6:
    - 1. Cleanly copy cmsg to user upon returning of ___sys_sendmsg

  v6 -> v7:
    - 1. Remove flag MSG_CMSG_COPY_TO_USER, use a member in msghdr instead
    - 2. Pass msg to __sock_cmsg_send.
    - 3. sendmsg_copy_cmsg_to_user should be put at the end of
    ____sys_sendmsg to make sure msg_sys->msg_control is a valid pointer.
    - 4. Add struct zc_info to contain the array of zc_info_elem, so that
    the kernel can update the zc_info->size. Another possible solution is
    updating the cmsg_len directly, but it will break for_each_cmsghdr.
    - 5. Update selftest to make cfg_notification_limit have the same
    semantics in both methods for better comparison.

  v7 -> v8:
    - 1. Add a static_branch in ____sys_sendmsg to avoid overhead in the
    hot path.
    - 2. Add ZC_NOTIFICATION_MAX to limit the max size of zc_info->arr.
    - 3. Minimize the code in SCM_ZC_NOTIFICATION handler by adding a local
    sk_buff_head.

* Performance

We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,
cfg_notification_limit has the same semantics for both methods. Test
results are as follows, we update skb_orphan_frags_rx to the same as
skb_orphan_frags to support zerocopy in the localhost test.

cfg_notification_limit = 1, both method get notifications after 1 calling
of sendmsg. In this case, the new method has around 17% cpu savings in TCP
and 23% cpu savings in UDP.
+----------------------+---------+---------+---------+---------+
| Test Type / Protocol | TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+----------------------+---------+---------+---------+---------+
| ZCopy (MB)           | 7523    | 7706    | 7489    | 7304    |
+----------------------+---------+---------+---------+---------+
| New ZCopy (MB)       | 8834    | 8993    | 9053    | 9228    |
+----------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy    | 117.42% | 116.70% | 120.88% | 126.34% |
+----------------------+---------+---------+---------+---------+

cfg_notification_limit = 32, both get notifications after 32 calling of
sendmsg, which means more chances to coalesce notifications, and less
overhead of poll + recvmsg for the original method. In this case, the new
method has around 7% cpu savings in TCP and slightly better cpu usage in
UDP. In the env of selftest, notifications of TCP are more likely to be
out of order than UDP, it's easier to coalesce more notifications in UDP.
The original method can get one notification with range of 32 in a recvmsg
most of the time. In TCP, most notifications' range is around 2, so the
original method needs around 16 recvmsgs to get notified in one round.
That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
+----------------------+---------+---------+---------+---------+
| Test Type / Protocol | TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+----------------------+---------+---------+---------+---------+
| ZCopy (MB)           | 8842    | 8735    | 10072   | 9380    |
+----------------------+---------+---------+---------+---------+
| New ZCopy (MB)       | 9366    | 9477    | 10108   | 9385    |
+----------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy    | 106.00% | 108.28% | 100.31% | 100.01% |
+----------------------+---------+---------+---------+---------+

In conclusion, when notification interval is small or notifications are
hard to be coalesced, the new mechanism is highly recommended. Otherwise,
the performance gain from the new mechanism is very limited.

Zijian Zhang (3):
  sock: support copying cmsgs to the user space in sendmsg
  sock: add MSG_ZEROCOPY notification mechanism based on msg_control
  selftests: add MSG_ZEROCOPY msg_control notification test

 arch/alpha/include/uapi/asm/socket.h        |   2 +
 arch/mips/include/uapi/asm/socket.h         |   2 +
 arch/parisc/include/uapi/asm/socket.h       |   2 +
 arch/sparc/include/uapi/asm/socket.h        |   2 +
 include/linux/socket.h                      |   8 ++
 include/net/sock.h                          |   2 +-
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  23 +++++
 net/core/sock.c                             |  72 +++++++++++++-
 net/ipv4/ip_sockglue.c                      |   2 +-
 net/ipv6/datagram.c                         |   2 +-
 net/socket.c                                |  63 +++++++++++-
 tools/testing/selftests/net/msg_zerocopy.c  | 101 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 14 files changed, 265 insertions(+), 19 deletions(-)

-- 
2.20.1


