Return-Path: <linux-kselftest+bounces-37130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E2B02125
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCC0583C94
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5422EE99F;
	Fri, 11 Jul 2025 16:05:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC332192B84;
	Fri, 11 Jul 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249923; cv=none; b=Ctcxidfro6BsncoekhSOM5zo6BeAfHdDCQBYk6x/6vgS4lx3+zP8iys7JVTbQSLN/No8LdS9pOiDXWJGSITSfzi0d/43unJgqCDD67w2UAYTVkkPlRxYZUWOCJlMrOQrEQaEzFaSzZ1xlF6irtKaKs8dtbX72WEmeEDtRYZeIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249923; c=relaxed/simple;
	bh=DyaRLSL3wtVvoPto8BZy228KqqNCIVs9JEwqJCCslNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tf1mN/hs/O7TVdGG7sBwmJxiecKAISeJ4roSCWQr4sZuZTo9E/nrsrbsJP4CTxP+IbuSPyzjHEV6GpBperuFqnHHtfx6+SMNYCUUbVK6PcOfeWbM0orX9V91xbLqJdLjb6BrMBzP/oxLXNa/bLsSrYqyQrSQOrjwTjsX0B/fWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so3337323a12.1;
        Fri, 11 Jul 2025 09:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249920; x=1752854720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0u1Nuau/v8sKJveSzb4nBKV8QzKO2475CmCFuNsGS4=;
        b=QAuWOidSDXXptU1G4d1mt7dkLNuKzCX57JY9CIIhulDu9OREKvQtAOw5tt8nh1VxHw
         fiH4ilsNIeRbL84qS6zDnD92P58l1lbH8NrtXgvfBCE7qiWZYT3HmUMSdBb6qRsnGs7b
         YMgFTdZIrF/H6hdxtzDHCBs9D4/u4AVCmxU8xHfclR85CZg+ueti3sh3GO6LQVBF69If
         WFgybnz2vnKG+xqoZn3b1kxzUa00NtLcrdD1dtY2PeDVGObMOdpbIWpK/L1v1qW/kIpW
         VYhmYpUvxFxfN6ZBzA1/6F9sg2Yvv71AcW20eplodg2DjtAKjNW0ppAGvYP/hVmuQQvm
         9eSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDcsVpNwWWZ+yTBDkCvjEDqXm/KhnMfMzhkFf9cTSRj+sKLCGfJOHMrC1yguFbIol5P/k=@vger.kernel.org, AJvYcCV723Tuo74oPFfY+G1VToyhj9ASKAVXGLGnlibB5xRSG17MiQquTheHoBFn+R7p+FBe0/JHibaa@vger.kernel.org, AJvYcCWaPH5ccST7qI+TzIIDc1JA/LhTzEhsQlhbkAG6ejFMMmkVgPZvlSgmyE6uhmD9FKcpyiSEvyAZTiGNMZcfGfQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpCLVu/fg+QwTiCxmH4muk22uVCCv26soaudTwecMHgO+UDP6
	ZdatICA+pY75SrKtLLAvWgVM5TLnVrat9BYOHfaVslfJvKCqGnDNCLu3
X-Gm-Gg: ASbGncvBrIcUI+ZyL8jvr/6Da1GeBPXQE8E/FkCcTku5N1lZq/TxFjDsqqzGL0rcsw0
	0XhQ4Z6j831sqakcKfTMOT1lJxh+MFkMAu8z0WNZrSyHYja/yL+FawnQVZTSZ15PPRSLscr6J2j
	ElkkzXuZ40aQgpnvLnlCW+MONGoS7K9ifQAH40zfTJTRKzLATg1StRYqFVxlS4VQQhms7FSt5OD
	cU1VfCsnFjOeK+mkPwicZzc3z0F6amLb+vDcuMP1VDiNdqrPjrLHPLxd98yvZBpgZ07xtAl+C/0
	yPgutktLk3ghQZx9/FfmfqZKnyDdD3sXH0BEGj9T8SZVYCvq8EJfWEZG7pYqkuWitNfmCqi/B63
	HS4GI7QW2NXlZlOb6vAbcaZA=
X-Google-Smtp-Source: AGHT+IF3c63figOWHH1WEdXqwA9w1zoB2cRRSFJTk5OVa14dE+nd2jEbCqEkC5EatMORgvQAZq7LuA==
X-Received: by 2002:a05:6402:5111:b0:607:6b8d:1a7c with SMTP id 4fb4d7f45d1cf-611e76386e4mr3422522a12.12.1752249919512;
        Fri, 11 Jul 2025 09:05:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f2c0fsm2360708a12.15.2025.07.11.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:05:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v6 0/3] selftest: net: Add selftest for netpoll
Date: Fri, 11 Jul 2025 09:05:08 -0700
Message-Id: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQ2cWgC/23PQWrDMBCF4asIrTNFHkke2aveo5RiS6NEEORgC
 5MSfPcSd1HXznr43s885MRj4km24iFHntOUhixbUZ+E9JcunxlSkK2QqNCqukLIXG7D9fpVeCr
 QVRpNQGXJO3kS8jZyTPd17kNmLpD5XuTnSchLmsowfq+duVrvryfnCiowRCaGxjZax/fAfery2
 zCen4lfheqFsqp2TmMkjH6rnv0ZN020O42gwFBAIrKIeNR6q2mnNSiwZPuASnnXNQdt/jSp/b8
 GFHj2iMTO1vqo7VY3O21BQa9Jk2tsFyP/08uy/AB6Gzry4QEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=leitao@debian.org;
 h=from:subject:message-id; bh=DyaRLSL3wtVvoPto8BZy228KqqNCIVs9JEwqJCCslNQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBocTY9MN+02dnHtqn3oOqeRY9TTwYlHSteb/Y8L
 JYYndtZYfmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHE2PQAKCRA1o5Of/Hh3
 bQ9pD/9oUCHb42npIk1WwG1orwcx6v36uLneQX2goD8eJnxYVcHXU8Z+/xFJ6IYu/5DMrWoeJ22
 Ca6UEjOCOw53ewoguFUMR1IiqKzOvb/ZCsUkXeRra52W63fMGG0NTYmEctd/+dxJfhZ/YiQCv61
 eJMhl6wWetAG98lzM5EV2glJyj5s7faoG/QCrTtbONuem5JN0UzGv7MsomZFBHeRnK4VJFBdb9v
 nKmMDR4w4jfn0VYZIFgNvnwyOSG511hGv7xmwaigQ8MvCrZ61IIvxLtATG2hMTjcaAnm3t1rDnY
 Q9rld6Kenb4k9yd74yQT1MBcQvoNSZQMkH7N3NFy8v07lcWKDtsrmyN2wgP0FbVxZmxT/EoxnNO
 tgjmsSepaFg07zWWyVWpB7cOm/KAcQNlp4OrtiAW8Ovzx99H+buQzklp0wJ9scFjEj+g174K5a/
 YPlZ5jzSpBLQMSib8RX83kyDNIsjzGrPoDDPexkxavZkR0neDX6gAz+QVYScGY/s80d9NUozfJ8
 xj2YKfDYK3fl7l1Pgou11jq/VlSv3FeUoBrFJVY7GbkW5cE74mhWo/vMeTv7WZfJsb5u+v/jg4K
 eiOHMjePUxHQ7AAN54QmffVG2uykQRL0Fwf69wfriq8mpoBW71k7fkPpEGas6vZ7rtOtrBDx7iK
 PKS7sDtPRdKfjqg==
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
 .../selftests/drivers/net/lib/py/__init__.py       |   3 +-
 .../testing/selftests/drivers/net/netpoll_basic.py | 411 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  35 ++
 4 files changed, 449 insertions(+), 1 deletion(-)
---
base-commit: 0f26870a989bf69957ed69d10c7ffc57ca5a7f52
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


