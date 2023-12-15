Return-Path: <linux-kselftest+bounces-1980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B742813FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076891C21D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF418F;
	Fri, 15 Dec 2023 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EnUQUHLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF5EBB
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so2228875e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607841; x=1703212641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYz2YDovoffYMSa4/zt2c6fJDejkIPeUObMVDQAFjYg=;
        b=EnUQUHLso2bJoZzpVpsdG4ctct12GXL3By9n82TGmsW2NIrDsDZTXBooFmNqLj/25g
         dY9q2tsQD36GKwqj/tTawg8Hlm9ujzPmrc5n1P8i6dQU/7lD73irHbr3KAx8ceJJOj3+
         RpU3m4b7y5yzzgcm+d2Jcijecx2VRIseKm0kRrNU5cNA/37n6etEnuFQqOKTMa0tmBMO
         fbsu56nK1I5mnmFzy5/2l8a34EYY/lXsJbyw2iNC5f0Zx5y9TpAYIZYCWaRG2HIsxRVA
         B3B6yaAklgpRvTT/XcJy74KkerY8JAJQFkmG1807TxYEqrkJrpOnoFLCT39NA4h9Ki1u
         2xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607841; x=1703212641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYz2YDovoffYMSa4/zt2c6fJDejkIPeUObMVDQAFjYg=;
        b=saIKYXuYpJCz+vJ05zBmdJDxAdVy1qAmJ0CqVkFEZ0/nje7FadZjBY+dEhDe06WItr
         aUnNSHVrYMw9q/QeRu6Xr1/Jq2jb5CxFPXvf0xAoYC0aQf3lWt2bMqKdkFoCcvJy/ndU
         l6nZgHx9DjVf1xhtkX0tJY2uIwBLk9ZiUJ2JN2R8I3JGzN3VX7SfwnalYn3CFQXNjoJ6
         I0Hws5mTo49ie9GGRIO4cYIVqNJ7YMKTVSbZHr+nMNSGVMHpaTQh/EPFoUrSO3ot/6Z6
         yDBA5pwLk/Him6XkCBy0dQA47mr70+9JNTXO26p4/BLXMBfA+mIqnP0FPsDnZoNdOWxS
         VJHg==
X-Gm-Message-State: AOJu0Yz9wD8UUUHse4u/oHSjhn/IwzJqnGU83ai5BdscoNqw+ndD9iRE
	xIAJ0qfJ5FAiHLgJxGm15j5T0Q==
X-Google-Smtp-Source: AGHT+IF86Mjo74VxERkyFN6vt9WC45W73e0nDA7ynhnMhCCC7OmOqa7UZVr24CynY0BJeTZO/2khnQ==
X-Received: by 2002:a05:600c:468d:b0:40b:5f03:b448 with SMTP id p13-20020a05600c468d00b0040b5f03b448mr2985045wmo.362.1702607840937;
        Thu, 14 Dec 2023 18:37:20 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:20 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 00/12] selftests/net: Add TCP-AO tests
Date: Fri, 15 Dec 2023 02:36:14 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=9521; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=W1hsIMO4LWnCVygW8noyKhfTOhAmhJbmRGN9bR0Kyic=; b=UYvU7yeQKvGEO6P+PhMVNO2YTTolMsXDTJQzjUR6ysys853p5jc6zcd9VFl6taZISs1rKfXSE pERiA1wgd7JAuT62ZDTtllhvCqkXkVzY/giYpbeTQ7DX0/8/u5Zfl+p
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Hi,

An essential part of any big kernel submissions is selftests.
At the beginning of TCP-AO project, I made patches to fcnal-test.sh
and nettest.c to have the benefits of easy refactoring, early noticing
breakages, putting a moat around the code, documenting
and designing uAPI.

While tests based on fcnal-test.sh/nettest.c provided initial testing*
and were very easy to add, the pile of TCP-AO quickly grew out of
one-binary + shell-script testing.

The design of the TCP-AO testing is a bit different than one-big
selftest binary as I did previously in net/ipsec.c. I found it
beneficial to avoid implementing a tests runner/scheduler and delegate
it to the user or Makefile. The approach is very influenced
by CRIU/ZDTM testing[1]: it provides a static library with helper
functions and selftest binaries that create specific scenarios.
I also tried to utilize kselftest.h.

test_init() function does all needed preparations. To not leave
any traces after a selftest exists, it creates a network namespace
and if the test wants to establish a TCP connection, a child netns.
The parent and child netns have veth pair with proper ip addresses
and routes set up. Both peers, the client and server are different
pthreads. The treading model was chosen over forking mostly by easiness
of cleanup on a failure: no need to search for children, handle SIGCHLD,
make sure not to wait for a dead peer to perform anything, etc.
Any thread that does exit() naturally kills the tests, sweet!
The selftests are compiled currently in two variants: ipv4 and ipv6.
Ipv4-mapped-ipv6 addresses might be a third variant to add, but it's not
there in this version. As pretty much all tests are shared between two
address families, most of the code can be shared, too. To differ in code
what kind of test is running, Makefile supplies -DIPV6_TEST to compiler
and ifdeffery in tests can do things that have to be different between
address families. This is similar to TARGETS_C_BOTHBITS in x86 selftests
and also to tests code sharing in CRIU/ZDTM.

The total number of tests is 832.
From them rst_ipv{4,6} has currently one flaky subtest, that may fail:
> not ok 9 client connection was not reset: 0
I'll investigate what happens there. Also, unsigned-md5_ipv{4,6}
are flaky because of netns counter checks: it doesn't expect that
there may be retransmitted TCP segments from a previous sub-selftest.
That will be fixed. Besides, key-management_ipv{4,6} has 3 sub-tests
passing with XFAIL:
> ok 15 # XFAIL listen() after current/rnext keys set: the socket has current/rnext keys: 100:200
> ok 16 # XFAIL listen socket, delete current key from before listen(): failed to delete the key 100:100 -16
> ok 17 # XFAIL listen socket, delete rnext key from before listen(): failed to delete the key 200:200 -16
...
> # Totals: pass:117 fail:0 xfail:3 xpass:0 skip:0 error:0
Those need some more kernel work to pass instead of xfail.

The overview of selftests (see the diffstat at the bottom):
├── lib
│   ├── aolib.h
│   │   The header for all selftests to include.
│   ├── kconfig.c
│   │   Kernel kconfig detector to SKIP tests that depend on something.
│   ├── netlink.c
│   │   Netlink helper to add/modify/delete VETH/IPs/routes/VRFs
│   │   I considered just using libmnl, but this is around 400 lines
│   │   and avoids selftests dependency on out-of-tree sources/packets.
│   ├── proc.c
│   │   SNMP/netstat procfs parser and the counters comparator.
│   ├── repair.c
│   │   Heavily influenced by libsoccr and reduced to minimum TCP
│   │   socket checkpoint/repair. Shouldn't be used out of selftests,
│   │   though.
│   ├── setup.c
│   │   All the needed netns/veth/ips/etc preparations for test init.
│   ├── sock.c
│   │   Socket helpers: {s,g}etsockopt()s/connect()/listen()/etc.
│   └── utils.c
│       Random stuff (a pun intended).
├── bench-lookups.c
│   The only benchmark in selftests currently: checks how well TCP-AO
│   setsockopt()s perform, depending on the amount of keys on a socket.
├── connect.c
│   Trivial sample, can be used as a boilerplate to write a new test.
├── connect-deny.c
│   More-or-less what could be expected for TCP-AO in fcnal-test.sh
├── icmps-accept.c -> icmps-discard.c
├── icmps-discard.c
│   Verifies RFC5925 (7.8) by checking that TCP-AO connection can be
│   broken if ICMPs are accepted and survives when ::accept_icmps = 0
├── key-management.c
│   Key manipulations, rotations between randomized hashing algorithms
│   and counter checks for those scenarios.
├── restore.c
│   TCP_AO_REPAIR: verifies that a socket can be re-created without
│   TCP-AO connection being interrupted.
├── rst.c
│   As RST segments are signed on a separate code-path in kernel,
│   verifies passive/active TCP send_reset().
├── self-connect.c
│   Verifies that TCP self-connect and also simultaneous open work.
├── seq-ext.c
│   Utilizes TCP_AO_REPAIR to check that on SEQ roll-over SNE
│   increment is performed and segments with different SNEs fail to
│   pass verification.
├── setsockopt-closed.c
│   Checks that {s,g}etsockopt()s are extendable syscalls and common
│   error-paths for them.
└── unsigned-md5.c
    Checks listen() socket for (non-)matching peers with: AO/MD5/none
    keys. As well as their interaction with VRFs and AO_REQUIRED flag.

There are certainly more test scenarios that can be added, but even so,
I'm pretty happy that this much of TCP-AO functionality and uAPIs got
covered. These selftests were iteratively developed by me during TCP-AO
kernel upstreaming and the resulting kernel patches would have been
worse without having these tests. They provided the user-side
perspective but also allowed safer refactoring with less possibility
of introducing a regression. Now it's time to use them to dig
a moat around the TCP-AO code!

There are also people from other network companies that work on TCP-AO
(+testing), so sharing these selftests will allow them to contribute
and may benefit from their efforts.

The following changes since commit c7402612e2e61b76177f22e6e7f705adcbecc6fe:

  Merge tag 'net-6.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-14 13:11:49 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-selftests-v1

for you to fetch changes up to 85dc9bc676985d81f9043fd9c3a506f30851597b:

  selftests/net: Add TCP-AO key-management test (2023-12-15 00:44:49 +0000)

----------------------------------------------------------------

* Planning to submit basic TCP-AO tests to fcnal-test.sh/nettest.c
  separately.

[1]: https://github.com/checkpoint-restore/criu/tree/criu-dev/test/zdtm/static

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (12):
      selftests/net: Add TCP-AO library
      selftests/net: Verify that TCP-AO complies with ignoring ICMPs
      selftests/net: Add TCP-AO ICMPs accept test
      selftests/net: Add a test for TCP-AO keys matching
      selftests/net: Add test for TCP-AO add setsockopt() command
      selftests/net: Add TCP-AO + TCP-MD5 + no sign listen socket tests
      selftests/net: Add test/benchmark for removing MKTs
      selftests/net: Add TCP_REPAIR TCP-AO tests
      selftests/net: Add SEQ number extension test
      selftests/net: Add TCP-AO RST test
      selftests/net: Add TCP-AO selfconnect/simultaneous connect test
      selftests/net: Add TCP-AO key-management test

 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/tcp_ao/.gitignore      |    2 +
 tools/testing/selftests/net/tcp_ao/Makefile        |   59 +
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |  358 ++++++
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  264 +++++
 tools/testing/selftests/net/tcp_ao/connect.c       |   90 ++
 tools/testing/selftests/net/tcp_ao/icmps-accept.c  |    1 +
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  449 ++++++++
 .../testing/selftests/net/tcp_ao/key-management.c  | 1180 ++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |  605 ++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |  148 +++
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  415 +++++++
 tools/testing/selftests/net/tcp_ao/lib/proc.c      |  273 +++++
 tools/testing/selftests/net/tcp_ao/lib/repair.c    |  254 +++++
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  342 ++++++
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  592 ++++++++++
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |   30 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  236 ++++
 tools/testing/selftests/net/tcp_ao/rst.c           |  415 +++++++
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  197 ++++
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  245 ++++
 .../selftests/net/tcp_ao/setsockopt-closed.c       |  835 ++++++++++++++
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  742 ++++++++++++
 23 files changed, 7733 insertions(+)
---
base-commit: c7402612e2e61b76177f22e6e7f705adcbecc6fe
change-id: 20231213-tcp-ao-selftests-d0f323006667

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


