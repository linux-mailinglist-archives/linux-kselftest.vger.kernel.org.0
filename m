Return-Path: <linux-kselftest+bounces-45003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8F0C3C365
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FA53BC454
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CDE3446CD;
	Thu,  6 Nov 2025 15:57:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF033C50D
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444620; cv=none; b=heIsrBMP06dt0gtuKji72NHFiRg/6ImUQD44hPsTRDVO84K6uT/BVrr65EF04ve9nFKKMfrl0jwm4x6IrRTafFYsPa9/XuV4P0pdiD4zjYXSgpl6hypCCUDL+4ZQTowOqlDZrOCcFsP5vc1KiPzydG3QX1mrFcOdCrHjE2hP4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444620; c=relaxed/simple;
	bh=rOrZ/4A04kwhL0ic9QR0izswFHe9Y3mAQqCArP6A188=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i88HGoogvnMP3mPzfTlFf+8V2kiuziU1dszr7+6JTXMG/tRv9/jQ47hiZO3VDuI1bRRD9ioyfa6CHXR3ItpjpqS4ICigTm+cjiJU1yCMxlUZTSpbC9+tEgubj7eJ1tOjxzrWdbyR+qemdCSjyvZhRZ1dy1GzdwSSrvYUDbd4M/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so1714863a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 07:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444616; x=1763049416;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PmoYhmQszxefHjhkpT3KQeYOeoKqB+UgwTp/bM0o7s=;
        b=Pj4E6p/MHg+DA3SOlVjdz+UsKAnoTUkqxwdygG/5uLxtMAiuDpIL4lnDjqCojkXaL6
         ae3w8IKs7izGWB3R4J9OFUVfbvoO3BMgtMbncEMM4/byW2LvNOdUQhj/oUJKVlr7CK8V
         fZoWKE7qAfIk8XUlIV+9Yd7O7u9Djvl8GR3ZKPI9RQSXDrNcCHsWQQorHj0IRV4WBrj2
         FF2Bdn6XBiXJb2yiGoPkDWq6g+cSbJ7zDkkJFV0RmBOZm1k13JZ8Q44q8mz+qXJVq477
         7PMumZF/t0Lvt0krYld/mU10W0vv7jhm1oSOoWmxkEkD8wbIVzVVRTxkz/BtLj8AMYxK
         0qYA==
X-Forwarded-Encrypted: i=1; AJvYcCXRXHDnrgn4gTI3Nt+VKzzPfRMFcg2D6Kt+MJUdDQKap3WZQorgMfAxFQ5YG+Ihjcj/cYi27urr1XovykY3vys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0e4BPWjgpWJq0p8i2X43lXGN3wBy5bHoc94VvUHbqmo8CNl0a
	CqUQ58z1j92hT+aAH9CbK/x7B0U7WUoB9TXfDWWId46cLUMBrE4YZp6A
X-Gm-Gg: ASbGncv113+kPIRX7ZnjeR1Qvyu40mWyCAp8JeeqPO2MveXB+BNeU7vcUbdZct+pvMm
	ZR/NTV0+PJxx8AjNNHr8nhAc6GlKoRovSK4XiisbZ3u4bUakCCF+wJ1ZIb7U5VWSfCfMUr1Cep0
	rOtmALbKvyd0IRvi3MI3V6Go0vq95BT6hkY92k2tSnIsqI6Jx+H04u+IE+W99DivnCmrfacee5P
	LKdgQEq/BFzq2GKxgJstjAb/vhfxQt5N+o9fTod5IDwgwgg/56xIU8f4YsKgpF5wsBYIuJ0rhgm
	QLbzncucur7uxeNSjvIzAScYEVuVsiuKUkr+Fq5jF0+S3G6I08uPmxDBlFWZN5A/4wKM4utKuID
	POkvYbWfawxMU/tXkt6PMPDUwwZmYFrpOCab3s0WrncZwks0buWRr5vQffm2NNfGqGyw=
X-Google-Smtp-Source: AGHT+IGtUCnY/0gL5xUXSuNGqI8E7ELQM5g8O42ZsyJXJ0jZ2YG8OSfxqQDMKV4oFHPUZ8QwMLmBOw==
X-Received: by 2002:a17:907:1c0a:b0:b28:b057:3958 with SMTP id a640c23a62f3a-b726554c3d8mr890156866b.48.1762444615548;
        Thu, 06 Nov 2025 07:56:55 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72a2824c2asm132004266b.34.2025.11.06.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v9 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Thu, 06 Nov 2025 07:56:46 -0800
Message-Id: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/FDGkC/33RTWrDMBAF4KsYrTNl9C951XuUUiR5lAiKHWTXt
 ATfvcSL1sVO1wPfPN67sZFqoZG1zY1VmstYhp61jT81LF1CfyYoHWsbJlBo9CigpykN/Ti809s
 01OmjErichMwYUvCenRp2rZTL54q+sJ4m9npq2KWM01C/1kczX0//mTMHDiiTQWO0d+SfO4ol9
 E9DPa/eLLaGOjQEIGhrNXW6S9KYnSG3hj40JCA4q5PNFDvJ94baGNweGgoQMOgoo8uOJ9oZemu
 4Q0MDgrUkNGFQFPc5zI/B8UGn5t6HkjFrkU1Ue8NuDXloWEAIwYucEhkR9ru4X4M/2MXdcwjnl
 EISOeAfY1mWb/1CxiSWAgAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=leitao@debian.org;
 h=from:subject:message-id; bh=rOrZ/4A04kwhL0ic9QR0izswFHe9Y3mAQqCArP6A188=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVFwKvvzkebqNy/kZS1nG85335bRbP4s/Pu5
 IU2Ck7/bKmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRQAKCRA1o5Of/Hh3
 bQSgEACQ1IzCyzKXtsX1G1SQIUxRdM5w4WuZXB37xspJkRXQoQTcPBeg+oSGeBu94hWm4DByKnB
 nb+1MdF3FXpbqlybrKyL6i28j2T3EhcB+G7rDdaAQ3uINsgGqElQRcPOA+Sn8ufuor2Qt899iBA
 MSsgTzJUzJ+OA3gIci+ub104ujlJCRszUiI9n3uQtZp2Me0hbVyXe+EOpFMOzLB0vwHRWiP/eqT
 JnZnyC9/3mIradwD7dLP7Its2eqC0s8siUnnjUItzeHJ3lFwJl2bp2cYTplZKA6GurnBzSujtOR
 At0z69SADJ5seIywWNs7bOsKKmSq9snvcl6HXsWICe7zIMFrG1FPzIMek3O4N48gayrk9ZTcOPJ
 jOOLgSsxA2sPvLKQaqiiSYOV7I2ethrpy9aap6zasMyGy7axv6wJfJ1TQRYWST1xbun1xv0fxlH
 tsfrzxoIMfRoLTfjla7pad1iy9US+u81V2N0QdMNTdfb0GX6uhlDdR4BNON/mzS7T8JWogV4ZwP
 56L6JB+ygDB3AzaIDOm6FTuH8opSklHolK5oIfvjPFd1MZ1GzkzF3VaJ+tN9aI884cl1yup9rVM
 pDry9PYPHFeRggKwwL5zgbOXTotyepzEznTjh6yGgIEuhrMpSeeRctXHtfyJ9wtQ5xP3RcZT17F
 GY8ZdsemENBPBJw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v9:
- Reordered the config entries in tools/testing/selftests/drivers/net/bonding/config (NIPA)
- Link to v8: https://lore.kernel.org/r/20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org

Changes in v8:
- Sending it again, now that commit 1a8fed52f7be1 ("netdevsim: set the
  carrier when the device goes up") has landed in net
- Created one namespace for TX and one for RX (Paolo)
- Used additional helpers to create and delete netdevsim (Paolo)
- Link to v7: https://lore.kernel.org/r/20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org

Changes in v7:
- Rebased on top of `net`
- Link to v6: https://lore.kernel.org/r/20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org

Changes in v6:
- Expand the tests even more and some small fixups
- Moved the test to bonding selftests
- Link to v5: https://lore.kernel.org/r/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org

Changes in v5:
- Set CONFIG_BONDING=m in selftests/drivers/net/config.
- Link to v4: https://lore.kernel.org/r/20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org

Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 361 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  82 ++++-
 .../selftests/drivers/net/netcons_torture.sh       | 130 ++++++++
 7 files changed, 569 insertions(+), 18 deletions(-)
---
base-commit: 7d1988a943850c584e8e2e4bcc7a3b5275024072
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


