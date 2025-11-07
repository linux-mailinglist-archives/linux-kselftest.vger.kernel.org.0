Return-Path: <linux-kselftest+bounces-45094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D3C403E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F41D3AD948
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6131D72C;
	Fri,  7 Nov 2025 14:04:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562F23E34C
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524248; cv=none; b=R83ESNChIfHgT5WADoQ+G83LLqfcIvhSFqlKkssmFysoWlsmMpy2GEpKk9z4mLvhFoRLaeb+fdpYQg7MXq10dVfTOSOzc79OqB3nrF48fsHBjoo8olRNYiYB1+MZilCp9LTJRNMwU7MkRnuocim+FvSvwQjg4Meb9kCPGGLTRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524248; c=relaxed/simple;
	bh=JECiORkdcpkewxWLEiioBSAJJFxfkUiJgv1GwsZQ3lw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P1HRUDhpDxreMZvdPx5VYj6nMOMnDd2NR/fW+eSwiV75jsno+vIwGRwhKdD+UNv0E6E6dO5PQDDOBCvc2ldjgPAKkCrISmfRii3P/DKKjqEWX00IzbaG0ooPy20Wh7nonRJ9B/IR/gfNwQr9r+9XsWcKE8MQKGyEGuXVfuumWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b713c7096f9so114755866b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524244; x=1763129044;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vBKMf5oaurBjhFxiKcMnzmBVlIaxyaSJ4JouDbHbIA=;
        b=gGVv/qSUipxYphgl6gDpLf35lzS0gq1Tc4hl8KFMitnpstvan7Kbil/Fu5xIT7Yre+
         e/k9IvghuBDg0swtKIlw7YX9hw/WAg2pKHiYS9j/K7hdGEJb4PYWKtqn5B9Sl5Fz+kSX
         B/q8OOrEe5GX8qNizChPWlTVCp76/oCeLB0gIHGRaGYY5S9tSJy0/1x4mn4/VtogaRYy
         Hq2/GC7PoiTFZacAgp5IIlqeZ9b8WrZ5rtb3KDNxmABhJRNj01XiAwN6pgmDudYaVHqW
         EpOsNL/CCk4oPWhWgwhav0c2nYYbQLRS1VTxmrurjp++Z+jn+p1ch6nEesj5eLQ6gcgj
         AjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2ZUXZcKANnK7MxoRzinY7xYGg1iu9BmnZsk4E3wZ/jiD2LF2LWHW1uPUarOpdvaugMcfg4MqDm2m6WSqTqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+dmj+drxeBazFICjxaMooCCIy7BQMfD8nhvOcUcedy++5oBN
	I24zBDa8y3dFGRKiAAay98iOcgPPRSuFqa4rBj4Om0tJYTkvKq/iG08x
X-Gm-Gg: ASbGnct8CCbieGpG0YrCQGFNqgrN+3UlCZ6TVGA7Byf56KsGRXIrhA11+MUJdAaEwwX
	R2ZcgbWpQ5WlDrJE88br6PBhVJCgg7TxJPBejJn14XhKl1N/JBWirLTqU944qT7CT8+wzS7RUfg
	21dwM5zLzSkZkEB4/xInua9m2/rpAJIIsMxRaGaTcIgF91dn6y1j5ivBAeeZ45f2p+9yAbmYcme
	gtSZkXVCSjs08G0DO7okLfL5as1DfJ9+6a5Tbv3KixF7WwOUN4LUIwO5Mdp0doPwo/KdwHedQNW
	MyLIGY2dnXA7aU3s6KruPZzwdSuSoWbFjCcREUMlh51utmjLyXyhTm5FyRyY9o6Uo/i+cEUU8ul
	etwIs469zoH6td8213Pdv+csmoTumywbPZ+ZWYrp6iFaz4h+PD8ea7yNC+m5oJtspqg==
X-Google-Smtp-Source: AGHT+IEilfeetvESNE+Ii2ZLx3CgVjOEN10OP2+ornEp/KkNTzAwKv6EVIrG8aSFNaGP9ZebkNMx+A==
X-Received: by 2002:a17:907:6ea5:b0:b6d:4fe5:ead8 with SMTP id a640c23a62f3a-b72c096d4fbmr358591766b.25.1762524243396;
        Fri, 07 Nov 2025 06:04:03 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d7996c4csm60253966b.5.2025.11.07.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v10 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Fri, 07 Nov 2025 06:03:36 -0800
Message-Id: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADj8DWkC/33RTWrDMBAF4KsYrTNl9C9l1XuUUiR5lAiKHWTXt
 ITcvcSL1kVO1wPfPN67solqoYkduyurtJSpjAM7dhwPHUvnMJwISs+OHRMoNHoUMNCcxmEa3+l
 tHuv8UQlcTkJmDCl4zw4du1TK5XNVX9hAM3s9dOxcpnmsX+unha+n/8yFAweUyaAx2jvyzz3FE
 oansZ5WbxFbQ+0aAhC0tZp63SdpTGPIraF3DQkIzupkM8Ve8tZQG4PbXUMBAgYdZXTZ8USNobe
 G2zU0IFhLQhMGRbHNYX4Mjg86Nfc+lIxZi2yiag27NeSuYQEhBC9ySmREaHdxvwZ/sIu75xDOK
 YUkcsDG8FvD7BoeELKVqefKJi7TH+N2u30DzzZaBNsCAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3548; i=leitao@debian.org;
 h=from:subject:message-id; bh=JECiORkdcpkewxWLEiioBSAJJFxfkUiJgv1GwsZQ3lw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxRCKuoWI+DWDMbqIWf+0GIEVxySrWtDWzPO
 Wp4tk+b1LSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UQAKCRA1o5Of/Hh3
 bWs3D/9iBeBX9U4wZvAwjbA3AWioue3lcQn6Q02PlTsC3s41PwDKMiFcvJNkJKlOHVlOErwKO9/
 2pJ7uuDx620xwT1t/4UUMX4qlDId5kj/0i5mcOgOcqjO5nXEOORoDG4RkvJMR1+RKaFu0TWgZim
 SR43wWBqL6UPJ+cfRS3WD49xKMwhI9Y7pf1Z0yLDkYg6hCM/Uk1KJwvb5K7llSI/18bxIQeoMY+
 af8GFk+6RaYSUgym1W38hF28ougDsPZf6Hv0TOGz55gOaU4uw7N6YeOR9o9iTigW/LNG3pTufdg
 pbvCka/7KFDE7vc1q1xScTyfURvWVxTmYcjdHM5KIFue7eE4d3VjtkPmO4HihNxDziprc5WP9mu
 XAXUuQ1GxiyAwVkHMBfL4sgZYJ/dQt1GtUCPD7hRoWMLMim2TjpSdHolB5tqa4pmuLQEA0sEoI6
 vK6JoqQZSBQcJ7DZd4Q1BB7parhwVe/oaA1g30OKS3fo5Y90yEPz0zddRRqI2C4Q8zlmNTma6l1
 vC4ssiDSI9L2z3MeGGwCwSOF4+iePkN2vOeJYd68vPKNre/1z4wm8nEJ+Lb5Q7Ro/OUggW2udAT
 OFsm8fo/+FITi9L8nIsxr06YuzQkaxO/x6AVfyCtQoXUegw7WSALxVt3Omd37zHhj5Tj1ZQv5f6
 JxPvoAWSmKPX6BA==
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
Changes in v10:
- Get rid of the create_and_enable_dynamic_target() (Simon)
- Link to v9: https://lore.kernel.org/r/20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org

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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  78 ++++-
 .../selftests/drivers/net/netcons_torture.sh       | 130 ++++++++
 7 files changed, 566 insertions(+), 17 deletions(-)
---
base-commit: 7d1988a943850c584e8e2e4bcc7a3b5275024072
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


