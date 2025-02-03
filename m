Return-Path: <linux-kselftest+bounces-25595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513FA26325
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38073A4714
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A591C1AAA;
	Mon,  3 Feb 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UI4Lae/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733B26ACC
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609120; cv=none; b=S/5cUj3/NUSnb/aDqjfJ6s+qjcWCXX85S02jix5ZtBOdccBJKSMUxgsM2OMjan1FJVGXz3ZjVCLTpq3Mj67CEIRuFsx+fhxv1DyvQxxHqq2lAFecg25+SQZ5/d76wcd7gZQzGVpfQIjhQ+Gu/6+qhhLTQs6LjG3LPcRm9SKJUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609120; c=relaxed/simple;
	bh=9Vrs45JX2KrNPQ3Qz//5o6M6osrXwHlbAQIz7nxBx5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANJcfrbWcIhbHY/6dcoJ3s2drXVEOdGiIVW5UidBQfTJYW5tLbrjsxXg3lXqGl5vmOgG+bD9YKs0qmvm0q0s3hqIuRDVbYLcMfKTv/zlPIurPBM4TdZu9XsOBlY3MtHGgjocNVSxfzOd1kp/so12ZcfDiRr6XmPiZXN+2RVEZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UI4Lae/k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so112145055ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 10:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738609118; x=1739213918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Bm5p9Nue7nzWz6v6mDzeSS1FG2kP5ZwAJBr4lDHS8s=;
        b=UI4Lae/k6sYE5v933hwoNVzumEqQMqnBt6CeKeHztprS4Msarog0E3qm+w2/Chmidm
         5j/gOPaS64a/SABh6CEuBBSJmWS2fOrxq4T3z/xiVuFWL4ZBgFhFhcluS46rSBCjRoJU
         ufFyotkxGhkmVncnSd78qlWXC/31sYcdHAcy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609118; x=1739213918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Bm5p9Nue7nzWz6v6mDzeSS1FG2kP5ZwAJBr4lDHS8s=;
        b=RCrU64+s2q7yXANZKL3ZvlwkgEgrAomXXfrkXnug28ic8ci8BeTAkfTIpZReV0+BX4
         A9W1vv08X56Ve0ih+Ok1kYIniIB5eArWoNluRm48B9dvN+jU+mbwWDj3CcP6DBoZrEB/
         L2fJtxrHm1wXpHGvmORfdMQSP8xbqfBGxSukE8Qu/3lchDXvGpYvGTw9/YD7bwpBhc5R
         w79UILozDoEPG+gcArVzHbHJzBpmwzyu/iz9if8JULhunfZfl2q/z/OpbB745gwJ9EiK
         Vij1za8d/2hhH6wUpi7lxKn/8et4iLsb02NTIr1xRB2uCQhPO9jBRNcKbemRktW/QFP8
         kYOA==
X-Forwarded-Encrypted: i=1; AJvYcCWeacCtIkhCk4zys/a2yV5ZcNMhYnFgtaULvp5ThUN7Fv0sz2ToX6MUGgIK9vaKhUm8za+/YkhXZn/DaaomGMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyungdY8tP9qKsRJxZvczR+BN3uOnCo3qupqJCJHz5xqqZNPrV5
	e4XWsxjojqAEdu2lRWhGgGo/4ASTLZEEI9ZYrh1XAdknLppm5oN3exRS6ccuTxs=
X-Gm-Gg: ASbGncuD7s81ydDuhCgeTVVNzjbGf+vtFliD8cueNSbb1I8fo/7tYhevbHe0OU/NcYo
	+1jDCy/i3GBLpeVICXqTtLobRsM3xL04Ii8A5nienR3t660YqwG7PvBe1TMFJyD4fxjm6ajEQvO
	f5pWiy2k0A5QYlfjunBTcB8y8igR++TtPOiTdrfP0jVaRzAHAOSpgV+VinRxJN8B9PFIaAtyeEI
	kUsH+S+exbt0LR1d6ZFfSiDea/oo45cUypwMAFmJVamXYYicMrYh01YDgI/J4RVDvY3/l3w9yYo
	l4ulw3OyWTb+6eFBeR0l63g=
X-Google-Smtp-Source: AGHT+IGAZMvIDpReKNwR27kneLCRe81kWXQXBWPYyyPTFSzBuCyE90dag3gb7+FZFir2PKJPH8tmSw==
X-Received: by 2002:a05:6a00:1820:b0:725:df1a:27c with SMTP id d2e1a72fcca58-72fd0c1b91dmr30900086b3a.14.1738609118073;
        Mon, 03 Feb 2025 10:58:38 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm6899673a12.73.2025.02.03.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:58:37 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 0/2] netdevgenl: Add an xsk attribute to queues
Date: Mon,  3 Feb 2025 18:58:21 +0000
Message-Id: <20250203185828.19334-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v2:
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

Joe Damato (2):
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 11 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 90 +++++++++++++++++++
 8 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
-- 
2.25.1


