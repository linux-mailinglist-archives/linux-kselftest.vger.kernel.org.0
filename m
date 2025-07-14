Return-Path: <linux-kselftest+bounces-37228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2FB03B79
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B661D3ADD3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F0242D96;
	Mon, 14 Jul 2025 09:57:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C675237186;
	Mon, 14 Jul 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487041; cv=none; b=aISu03g/NzMmJspqkgjJn1E2zRjrO6b+EWy0PwUTEzzVAg8WQwMPAOf/OoTbD2IrB5O1tCKVWO9USugYcj/aYndQCezWqd4mB2Uu2dGBUoQN8EE/bls2Kcwr/DU9S6IbDgNP2fUIvt1q7jyfqTVXuKngvGWf95rNqCUilCSMg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487041; c=relaxed/simple;
	bh=rDdMwXCVOVcXiGnXgADyQnVpZDxohMtiCAVH/Weukcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6Q2Oe+RorwZq+IupHXT0iZ68cktm8Ze4iqnG1QYeFT71OzZmHCLjdfFB6mBpKVc057mn/kXL81j88evt+CdDzvABCJfkTicxIDMsZe2yiZRJgWHDbS5+kHDPapAt2mQAlh+IOrcn4nOa9L+kY2JMHMFX8pJVs6lpkU4jNbkA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so7260918a12.3;
        Mon, 14 Jul 2025 02:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487036; x=1753091836;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qghsVPdUTDP1J7nJZp+VaQ7jNdOEP8atiZxLyLT5Gbg=;
        b=b4jdH4OE8WaqyE0m64xsiuXlx0FGw//YUMKoOBgypFoLKP6yhYpfh+3FYfPcLmTWYO
         jUUGQvTJFUd0W3qb0NIw3TpSKG4VHoIE3LfRdTAsiSUbwSevVamrcpnVjcXPQaq4ubwM
         KXTHO2P0yvWklZluat6SAYcq/9xd68oTYvJCatjn4wdtPS2Lt5F2ENJYwekKIhN/uRnn
         chPSmre1rUiWJ0ODsJj4HGvWuhbpkATRIVmZ9v1fRv7mDPHCeFXYS+594+FqOFb9ezlx
         z/4XVLgzq/G87kp0bY3jgkpGxAcFsGGLfcFkkuZOtVeGmwqGePNaM2sGVhIhFf2+zsO6
         eCNg==
X-Forwarded-Encrypted: i=1; AJvYcCUgEq012uAzBDiRsWGx4SjvDcTK2TmkUVwhOqAw7NG/7Wk6QjIXEvBFMg+UqmlFqXGP00JRdprp@vger.kernel.org, AJvYcCUp3OtcAJBHFhuvrTAAWPk4rKTcfTkIzcVo+s2WNJD2VqfedGPcKR8efHs61ZSgRosIxQRVqrwbuZlXWGbaN7Ol@vger.kernel.org, AJvYcCWarhMecFgApwSKkDwfrEtILQCRCTOiW/h4coOg4HdFEgkPRhQR/ytTQB/2Q+3HeuxsVgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfMavC+xCf118flzIQjRccB/dP8YQe+CKQC1KKdI52SjJh6Z9
	Ms4s0QvurOjZn64vHvl+SQgUC+xADQkoGMUln2vyK9RFvtusto9dQCx3mGKrdQ==
X-Gm-Gg: ASbGncu0bpQybtPYHQIFqr7FghnNjdddZPn9pC19wFff45MXB0jyDh2vTb1311tX/4X
	9HKqdpDt6QvAfDXCOvhoGDAAcrLvW0gMp2HWWConFWSvodWE6EsO3hPzQ29WIgxATwNfxq6qPJz
	CUVTV9AYN3fagHmB9KQZU9ovV+quSSpoxtCcCSw0UsRXpBe/ataEbQj88fWCw7mVjNLYcV92Kro
	+KfwlAEquFo8cx4SPTeO702wVTu4W6yLPg1RITf3wPORxliRhTdFnidwAD+i45GvoMEiRj+sbEQ
	FiwS5HlfmV5n3qGWSoH7sj7jybmlo3QTvcyevNG7dBTDLKbHPp1i48p1cwygueo8UIDxmF1Fqz5
	/FczOscU0879a+A==
X-Google-Smtp-Source: AGHT+IEp8fMurnpc9kzKbsyoGmEK3gBIdl87QdOHxlvJt/EC74zQne1sN8HKOVb1tAM+Z7/lDgFmkA==
X-Received: by 2002:a05:6402:26c6:b0:60c:3d54:4d2a with SMTP id 4fb4d7f45d1cf-611e848c485mr11567138a12.22.1752487035976;
        Mon, 14 Jul 2025 02:57:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f6f3be91sm4194387a12.26.2025.07.14.02.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:57:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v7 0/3] selftest: net: Add selftest for netpoll
Date: Mon, 14 Jul 2025 02:56:47 -0700
Message-Id: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF/UdGgC/23P3WrDMAyG4VsJPq6GLFuW06PdxxgjP3JrKElJQ
 ugovffR7GBZ0mPxfC+6m1GHrKM5Fncz6JzH3HfmWMihMM256k4KuTXHwhASY7AEnU7X/nL5mnS
 coLKOfEvI0kRzKMx10JRvy9yH6XSCTm+T+TwU5pzHqR++l85sl/vrydmCBS/iU1ty6Vx6b7XOV
 ffWD6dn4lcRvlCMIUZHSSg1a/Xsz7RqEm80AYKXlkSEiWiv3VrLRjtAYOG6JcQmVuVO+z8tuP3
 XA0KjDZFo5OD2mte63GgGhNqJk1hylZLudFhpazc6AIJ16AMniqGK//Tj8fgB8kCXbB8CAAA=
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3863; i=leitao@debian.org;
 h=from:subject:message-id; bh=rDdMwXCVOVcXiGnXgADyQnVpZDxohMtiCAVH/Weukcs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodNR6D6UbjMO3qJIp81gYYCS3VzUTvOC9O9WEN
 yVI91pkv82JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHTUegAKCRA1o5Of/Hh3
 bR9RD/9yb971U6OD3FEoBY+CCPRSBAyBEuWTldZd8ETRKioFTWETDi+DL7vi0AgU0GRY5knjvqU
 z7+DE+Zw13jZNX3wFEp+lWYW/C2WMalTK19fuTKQasEwV5j5mgf69lY1d9gWZq0ekX13MXth06z
 YYr0UMkSuxALheeaHczdGfyr/ThMcXVP/iLMz6obgdDT2fxUEx15IDxM3P507m6etK30kc3k8F1
 suGmqLhA6qCPcn44hZnqgcQKNqqDbHlxXqdcV8+KgTsoupkHi4ofWrxPzk0s/5CoGGzXEbjwtqz
 ts3i+SKikS8++Vi68WKOKYvOSbP4h4oUbMYYZYxyd8kLoLwVyzNTGcvnm8wdf5xGXoEFs/q6HeD
 qeVX1i70Gw1reSOLnmixdNpAqkoPt4friVowcUFbuBLmBz3MQWSaRdnRkJ399VNzG2t7RRb8r8d
 2/0dBJPbDFjSBY39N1DnZDDtFoskG/pU1tYwjPccpm+AcO3iKa1h9A9rZvRdErQSAU8MAgoZFLK
 UCbq2ULazBrvhaD9ELBYouATnmriQRriSlZJ3E/BOq2Z6g31qWuqhtV7ZWi+lAQK6sPN2ZXoYmn
 mYpv/1Vepv/p8ULwC58DhUQUi37SYpyzad33ljxaNDswbBXvAt6Q0p79ag1Ga+eVsv1XuuySueJ
 vAI6ooXAZOL3dRA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I am submitting a new selftest for the netpoll subsystem specifically
targeting the case where the RX is polling in the TX path, which is
a case that we don't have any test in the tree today. This is done when
netpoll_poll_dev() called, and this test creates a scenario when that is
probably.

The test does the following:

 1) Configuring a single RX/TX queue to increase contention on the
    interface.
 2) Generating background traffic to saturate the network, mimicking
    real-world congestion.
 3) Sending netconsole messages to trigger netpoll polling and monitor
    its behavior.
 4) Using dynamic netconsole targets via configfs, with the ability to
    delete and recreate targets during the test.
 5) Running bpftrace in parallel to verify that netpoll_poll_dev() is
    called when expected. If it is called, then the test passes,
    otherwise the test is marked as skipped.

In order to achieve it, I stole Jakub's bpftrace helper from [1], and
did some small changes that I found useful to use the helper.

So, this patchset basically contains:

 1) The code stolen from Jakub
 2) Improvements on bpftrace() helper
 3) The selftest itself

Link: https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/ [1]

---
Changes in v7:
- Rebased on top of net-next
- Using `ethtool -l` json option instead of parsing it manually.
- Link to v6: https://lore.kernel.org/r/20250711-netpoll_test-v6-0-130465f286a8@debian.org

Changes in v6:
- Remove the network toggled (Jakub)
- Set ringsize and queue size (Jakub)
- Some other general improvements (Jakub)
- Link to v5: https://lore.kernel.org/r/20250709-netpoll_test-v5-0-b3737895affe@debian.org

Changes in v5:
- Rebased on top of net-next.
- Calling bpftrace_stop using the defer helper. (Willem)
- Link to v4: https://lore.kernel.org/r/20250702-netpoll_test-v4-0-cec227e85639@debian.org

Changes in v4:
- Make the test XFail if it doesn't hit the function we are looking for
- Toggle the interface while the traffic is flowing.
- Bumped the number of messages from 10 to 40 per iterations.
   * This is hitting ~15 times per run on my vng test.
- Decreased the time from 15 seconds to 10 seconds, given that if
  it didn't hit the function in 10 seconds, 5 seconds extra will not
  help.
- Link to v3: https://lore.kernel.org/r/20250627-netpoll_test-v3-0-575bd200c8a9@debian.org

Changes in v3:
- Make pylint happy (Simon)
- Remove the unnecessary patch in bpftrace to raise an exception when it
  fails. (Jakub)
- Improved the bpftrace code (Willem)
- Stop sending messages if bpftrace is not alive anymore.
- Link to v2: https://lore.kernel.org/r/20250625-netpoll_test-v2-0-47d27775222c@debian.org

Changes in v2:
- Stole Jakub's helper to run bpftrace
- Removed the DEBUG option and moved logs to logging
- Change the code to have a higher chance of calling netpoll_poll_dev().
  In my current configuration, it is hitting multiple times during the
  test.
- Save and restore TX/RX queue size (Jakub)
- Link to v1: https://lore.kernel.org/r/20250620-netpoll_test-v1-1-5068832f72fc@debian.org

---
Breno Leitao (2):
      selftests: drv-net: Strip '@' prefix from bpftrace map keys
      selftests: net: add netpoll basic functionality test

Jakub Kicinski (1):
      selftests: drv-net: add helper/wrapper for bpftrace

 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/py/__init__.py       |   4 +-
 .../testing/selftests/drivers/net/netpoll_basic.py | 396 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  35 ++
 4 files changed, 434 insertions(+), 2 deletions(-)
---
base-commit: b06c4311711c57c5e558bd29824b08f0a6e2a155
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


