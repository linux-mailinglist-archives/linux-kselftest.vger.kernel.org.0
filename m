Return-Path: <linux-kselftest+bounces-44725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25BC325F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 18:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5C78348572
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F633B6EA;
	Tue,  4 Nov 2025 17:37:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516233B970
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277837; cv=none; b=Yc8JPerUUy6uCOlCchV6bD1wT85xyNzoPek5i1uf02ho0xh02MBm3aOsglcbKvvhpsJzWJq7vuJzYlPS7My6/YPjtWqGEb80Yk4/l9eOWWI3MhGpkzOQW64fqiVIIUtVx3BN+P64b9Opk0yDunZ8ftXMsDuSfsDEFFrPCFHY16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277837; c=relaxed/simple;
	bh=UlY1KhZtrDOuDHrLgI0Oei5J42LFvFBO4Qi6hX0Z3x8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=of+wfvgvZchuvIpi/kFn+aR/gzq5rRmlnQRYC3wEyFmn6a829pFQ49C34xzgGUS2A3olUS1sFeN6ZQsOsZFI7YL0bg8Ehk5zyoRm9ivlZYO1XO4XnqymPzzeGnWZjD9CwxzYXFapsktvjBjVIfBH2yIAkqx6CfqlWP0d/C5gHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so2526491a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 09:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277833; x=1762882633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6eTNxxLcNy7wO3MDtB0SYsnP0RhlnRRYoZuaanYAto=;
        b=HwkAdOJs/bUHLyTGQnu/N+t1kzQIf7lY3McFqAPTnwds8xiP6IUF4QrXePcPRCmHto
         0WcUrf5YdMneQ45ZuLI7MthM0gdGMAqUOyNLL73U2mRMvApiZl7y7K05h7X3uzFepx2j
         LuMGIt1qBDDOPE3Nd668VXsd3EQSixyRbiIYaEZuJ3j9rjr3vlBxl/tSsJP0W0MX117P
         ADc4p+O5qcux2yLMmFrZkjbyHlXQaPuavrBPqIuDL4qYnUZ4neaGwXTkGZg4KAvmgT/Z
         nxFwbvd6a/RuL/UxMEM0V+6T0b4DybKrlIX4yZIOpwi5x+Diw1J8A+UR38N1iIBns0OV
         +BmA==
X-Forwarded-Encrypted: i=1; AJvYcCU/cENFBUSWqnsknnP76KqfynzFFROtFbC9AzJkQc4gfnUa32VOjxWZrpuipUShihE594nm7C/vED0Qsb/oEDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHzFFdm5Jk9VG5aoDrfbph/MDB6qb9wBMYi2VPtqPww4aQL6T
	npDztymNENz5WInYXXvnJCiL8lOay7RwN3+NgP2IxoUBv5tPE7xdaKN/
X-Gm-Gg: ASbGncv11hmAVdkd50pSXVa+agfm2kfdom3JDWgeg2apjfeX5X4u2b7irz7JYlfdEgZ
	nVG0FLYrNlYlKQYNkUOD7o5//aMFlTMRq/Hg/bh3pHehzy3M7O9wpiWPnOt8So/3F68opkV5cVF
	ykdSOfYtg+99OBS2C2lQq4+zvOOUW8bPGpl9may+tItssBo3bx0OEO30q2aciv2alY2RRIboHsI
	YtbEP+yJ+bzdrZeXnx5LxSJTa7FOdonHeyF0u+gV1K3raOPN6k9TQFwahzSrrCEWHbH+xWmPWmS
	8iOe/vFUt4kJMgZZcoIpUWcFEf1CKWWBINy+et4JiSHXfEHBVnh6W2EfqQ1K8dqEPZRGk9jMgxr
	3MCB5RBeghOsSOv6gm3qrup3SIofkhyUQR3EazdXrhjrCanrrdiPqO8inugkjTMymf5Y=
X-Google-Smtp-Source: AGHT+IHWSXVh6r30EyaybF/0e+aAYqu1Y9TDDbQ35hp7jqzz7Df4/+jTMzfaV7yDvOLad/iZEhrkXQ==
X-Received: by 2002:a17:906:c110:b0:b72:52c2:b8e0 with SMTP id a640c23a62f3a-b7252c2bab8mr319087766b.37.1762277832949;
        Tue, 04 Nov 2025 09:37:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4c::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fb05a02sm263381666b.58.2025.11.04.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v8 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Tue, 04 Nov 2025 09:37:00 -0800
Message-Id: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALw5CmkC/33RzUrFMBAF4FcpWd+RSdL8deV7iEiSTu4NSCJpL
 cql7y52IZVW1wPfOZy5s4lapokN3Z01WvKUa2FDZy8dizdfrgR5ZEPHBAqFDgUUmmMtU32ll7m
 2+b0R2BSFTOijd45dOvbWKOWPDX1ihWb2fOnYLU9zbZ9b0MK303/mwoEDyqhRa+UsuceRQvblo
 bbr5i1ib/SnhgAEZYyiUY1Ran0w5N5Qp4YEBGtUNInCKPnR6HcGN6dGDwjoVZDBJssjHQy1N+y
 poQDBGBKK0PcUjj30j8Hxj0319x69DEmJpEN/NMzekKeGAQTvnUgxkhb+91/Wdf0C7LI7ZFICA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=leitao@debian.org;
 h=from:subject:message-id; bh=UlY1KhZtrDOuDHrLgI0Oei5J42LFvFBO4Qi6hX0Z3x8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHohoqvWbz8kYRzn7u0s4LvlcnsfvBLouic
 OGTvhTZzn6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bTpJD/sHUcthl6rQSEzswJz0c/Tug+XnrZg0tQVOD+ixxkKTb0iopJqsqmkPnjYc39A6GUPDmTV
 j8DAAlxS4ZIWQho7FCZ/A60mp53x6EQRJnDUv61QVaLB+z3xlbBoCzKzA/FCKxaJesfW99rUJoH
 LgyUAej8ylj5IAbg+Wo0fQQ4GP+qcxBUQb7hPnlwzeurilGb+SKt13c40dq1Dd1zcFQrpSDUBYP
 1OhTlSY8hpoWP5JNPxjTvp1qP5A9hCxcOn5QL0/9OnTJqqelisk9QHg4Ppi6c3JIg6m++2Ak/wu
 umCvolphBYxVv4PkSvtMpwxAFH54ppFbFkM1U5p3MoVa3Ik7D1HtyGhqblRGfqWAmbq+NBPB0Mt
 x8usOipwky+54NO5CIGtl14BWHZu//k5Uf9K5bRrQe+jT+/kTSZfJPLYau2fiW2LmG3VRSoapSK
 hYSjoVU/wJfV9Y1S82WX3c58hOw4NxES7fYmPylnebtpLJjBmZRK4bCk3hy1OUk87pO/8t2zEfT
 /BkTVMOuHxJN4M3ToZ4txs8oSIEMyruc/hojdWRJPVtIC6XJv2dOKP/q7Aizda1pBYjGck1CunK
 Lm8xMvUxfjBIx6J9kIC0FS6c6ON2vCHqZjzpGgLJe2VlaGp2x2n/PhGgX9rtPZZgt0EFAXvPIPY
 BA/c6KkGYIvfh2A==
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
base-commit: e120f46768d98151ece8756ebd688b0e43dc8b29
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


