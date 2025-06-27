Return-Path: <linux-kselftest+bounces-35982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B7AEBE11
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486406A1D67
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8D2EAB7E;
	Fri, 27 Jun 2025 17:03:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A662EA727;
	Fri, 27 Jun 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043813; cv=none; b=e9CvjCA1kzprXC/qhAwDQMCv+wTaQgCbJFpKqOWXPCn1P9YXOcvOIZXZ5tv7CnJX3Xyn1/n/4BWlW1BPWRWxIXSL/dz5WC0KaGAJx730Arum1Tzb0SqSnFgHgFFG3NOabp0/gwsYQBc9ub1jhdKOa4bw4R+un4TnijuquGfA7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043813; c=relaxed/simple;
	bh=nXzyxfZtcRzaNJwnGz9ph4RHiCuOGSc2LfYD0Brd4rg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TWh1FOASNo1iiC+5spgEOSlUbjocEI4rAocla3jK15DB3b+H140B4IwzRKLPMdgTco78p+ddhOFNn5s1YLttk3QXRIJULOwDjaj9nXpNWFSPNpyIZ9C6jP1O5HujhYcj0tRM7Krzhn4Znq53kU73eywGggv7fzcZpo8lAEvYSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so340254566b.2;
        Fri, 27 Jun 2025 10:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043809; x=1751648609;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0xTwxPljoQU6BC5F6xmgbkQ4ioFx0ElNXIFan2NZgA=;
        b=h6YK49pcMwBBc5d8uC8U+EFnl1bJaIuR5DN0UlraYOlH0U3b5nbHds9JXxr/BDfUw/
         epeX3ee4KRmuxgAtFM3nTMzpng2QJZtEvAETzOqBRrBBBdv0bxO9Wt4zIRpG9fiX0KE+
         vCWF6M7ZpgK528FbOY/5QDMlJ2INfU+r3Yx9n1hZcdg8QaolQZg5+0a7S4QC+l8VfmZn
         +ZpC6MtknliwRWXVoxmEmRTRhLuh8RQSEL4ws35q1qeHaijDr/RU0fLycBArnhw751d4
         TEsbfolrh8FKhAP66qX6Vr8qcg6+sp61hSbH/oBlsW1ioPB2VfYS+kDmsWLk3lO5aTn0
         ZVlA==
X-Forwarded-Encrypted: i=1; AJvYcCUU+fisxb1BtZi4DeQNK0QUAaDMUr0bt06Tnd7cjD+r4kKlAFeIWZ/3ir2qWLQEyrFr00w=@vger.kernel.org, AJvYcCXm1AOOI5Hyden8F6XG0etDIpL1Pwd4z1kQU9rx3eCwRCKXjqonuzOuKt7HXQDCeiSI61so+tra@vger.kernel.org, AJvYcCXuwMxiB0t9B1/2GSAReSBNwjIXbqd3GI56/9CayinaDhrFk2yUsd0rcZGpXPi3cti8v3QWDiKpNnqxcadhQRG7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvap8+Y6x8YJfqLKFYIrzKqJ90vd+9W6XWXSWBepVivj8RcMn8
	cd4qoDZSeWrL8FfeuXZ+D5NTdyTNu/5YmWvt84m5fXddP2sylHOl+amr
X-Gm-Gg: ASbGncu7u9UC2mJZIux/3inoKEBEb34AOGqL5m9sWDW3f+2/4NYDUHozkPS5ED2m2sU
	HhQP9QHVq0mIs1CTlDY8WL+JzPNd1apq6t9MrpuQCs5grUCxB2TZtwp2mzDYp+T56sPTdzWB7hj
	sqOrGbdAp8HusxGpcYAGPErFDbeGCPQcqpSDwiqXyFpxawGhXs6v91yND6UHadKRVaQ0hcAekH9
	eJhLyNCQLY2U8AkGaS260KZCbsAN00epw/uXtZuY+IE2/YzWfEUvASwLfTVR6hr85Yh7SJSiUKA
	DA2vxm5pqwNXkPJAfWyVeRiLV/Pkjm6b737wlX3l0py0sdHu/QFx
X-Google-Smtp-Source: AGHT+IECu2XMDjD+UQNxbtS5PzxxaJTKOkwUAthdI095T2fsF1qFqZWS93/+q4MDtb0k5TiVnyfqLQ==
X-Received: by 2002:a17:907:72d2:b0:ae3:5887:4219 with SMTP id a640c23a62f3a-ae358874ce7mr306786766b.45.1751043809114;
        Fri, 27 Jun 2025 10:03:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b347sm157052766b.35.2025.06.27.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:03:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/3] selftest: net: Add selftest for netpoll
Date: Fri, 27 Jun 2025 10:03:08 -0700
Message-Id: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMzOXmgC/23N0QqCMBTG8VcZ59rFduaaedV7RIS5sxrElG2II
 b57aDcWXn/8vv8EiaKnBDWbINLgk+8C1EwVDNpnEx7EvYWaAQrU4iiRB8p993rdMqXMG6mwtCi
 0aSsoGPSRnB/XuwsEyjzQmOFaMHj6lLv4XjuDXPf9y0FyyUtjSmdP+qSUO1u6+yYcuvhYEl+FY
 kdpcawqhc6ga7dq6Q+4aaL+08gFL41FY4xGxF89z/MHdaPHjycBAAA=
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 ast@kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727; i=leitao@debian.org;
 h=from:subject:message-id; bh=nXzyxfZtcRzaNJwnGz9ph4RHiCuOGSc2LfYD0Brd4rg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXs7fH2qUQfHFS4Hmm/F6DYpNNfJr+5o3Fx6rN
 bJROCvhP/uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7O3wAKCRA1o5Of/Hh3
 bUfCD/0YeFypurws2zvN+N4jAUluSbnbS/0WUV6Z2W367spuyjzHF3pMOPupqlkvJatkjE7jcMX
 eaGOabBFPPAtjfBtwkx5BMFpEHFl7R7+YvR1rPzSlHsKO2r0+d5y1ywqmTgt0c7Mr1xJpbnU8av
 BkalY8hKQmTTdijrbEzieSlQJM/sCgzHxfD9Q3kqnfgP/siKTj++VIiAkrxMFKNEhQklaIDUF/J
 o+Uq8Tw1fQoII+iWl5XDS6p2TzfIeJb4QSuc7ZZjx3k+8BJrPAEnS7wXjxY3pTzOTQsUjhFFxHc
 3rJut313wkRX2AwCSfa4mJu5M9SKJA36ry2/nq9crh9nkT9O7x2aJ2lIx0EyJ8emm4WsmoPWNk+
 OI2pl50gkkcFAgb1jeFdX95/mVhmYLJfJv4bNwciB2YJXJ6NWzhzre16mn+QVOqw22udJRhwmUF
 fTjVBbdkvN/GS5dBlOYd5pgUagRKO4pD/nPr+BDtSxB9WS8KWXBjhNJzvhkDkfucP84e51Do977
 DyX1hAT+dVAEhGNF2mOuaRuthcwjVhTf9FvCBE9aGV/B3TuHcaC5Z53tu7To/JxM+MDMJ7L9Gur
 tzryVcOFlKFPcUA8tnsRC+5rajZC1+IuB9doWVGJgGms08DKP4uRCYqqrjnwii0WjzxCJGgP7Ag
 UFmJ5oyxhyF2s+A==
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
 .../selftests/drivers/net/lib/py/__init__.py       |   3 +-
 .../testing/selftests/drivers/net/netpoll_basic.py | 345 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  35 +++
 4 files changed, 383 insertions(+), 1 deletion(-)
---
base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


