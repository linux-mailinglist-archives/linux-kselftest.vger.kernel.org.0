Return-Path: <linux-kselftest+bounces-35164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6FDADC0A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B231891252
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23E21B91D;
	Tue, 17 Jun 2025 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad4LrThO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679931F192B;
	Tue, 17 Jun 2025 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134774; cv=none; b=gOepq11HG8WQeshfBwnE6daP9yz9Xiv5yUiAsAASvRIdgLsg9STvPhAjT8paK15Mo7zQNatfMoffFnSmcTlRZQ8KVaWb5yoxe43FGfkPNjdNYXtQc9OsE/1n2UOhvRlk5DfQD/xylYqrK9PDjR0gryn55z5+2EjY3XwgBEpAnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134774; c=relaxed/simple;
	bh=t+OjVad7eAvpDWlH56C4FprCkMtCNIHheW3QeGWnkVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ExMA46QQYyjKE5awFCEQXDgxkRXUkjm0GqYJp3yBXJCX98Ek67dRpEEMkWfYzqyr4Gj4Z/FyzFofeENiIANkDpZA93+Hh9BUXgoLe1IYXMY2Dsu3T79WPsCm+J80mxE169P8Udve+825KWl7WNKpYpWUSqtwry9fTxiTuVJ5EiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad4LrThO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5652824b3a.2;
        Mon, 16 Jun 2025 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134772; x=1750739572; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjGj1FKkr6lsKFldhLw4c9HweyQc+qlIKWu9cgdDyFY=;
        b=ad4LrThOyO20UTUgkduMxyYK2ik0Njc3TGVD+WEQpLoZZM+qiDdMB4ohWXVnMN2O6U
         wC54DbMZi06dGUdp47faQKdGvXG1Mabo1jJdctdhYLeAnYfHJrBpG/CUhncGpBY0iooN
         gKiFJBA/clhKNqkttg7DmhD+wv7EMeqAnyJp1jEWi+EEP0YvsqD3g44aNUvA1UmXgpDa
         tA33zEp7/Cvt3RQODQCNN1oMLx+48pBM3ZMEpd0wLCwYiv3GzPxfebE/cBSl+P7pd04T
         N3ygQ2E7l4ZVrpEZj6BYoaUSepN26k9381fsJxraFLxg0PsHZQ0pZrf00+KAv6SU+bpY
         YgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134772; x=1750739572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjGj1FKkr6lsKFldhLw4c9HweyQc+qlIKWu9cgdDyFY=;
        b=AiI5Zf5pgAI6Stev2v5ovNvKwvnS9DoxDfG536mWncQ9ELX+32ax8F6uTxOXIvujb7
         nhM0AXCnlq1pYBTchmqXdL1OBBAEHFZxt22G10IaKGyJhRVl3+To9iSEBIrLiTju+pgU
         77GQM4ZVkjnIk5/7eDJB/EaRkSth2azUiHIiiHqkv5fAr+b/8BqBhqksRIXmXiDjctFb
         eEXmSkkRDZN9PeZZizjpnevh6o5xEPcQvvsRCfEqsMUsaSPRC/zzYG5caZtNyjeb3Amo
         X99O+0AlBb1ytGcKxrXB4O0CmnDLf4FZgq5G+R5fG6MxpYOyfAlPBwf5kY7Nr7geI6B+
         re0A==
X-Forwarded-Encrypted: i=1; AJvYcCWfiW7CH8P2St6oXnu+3jH1hww4JPLDSXlrnpq6nW6nhessWdgnFGRDIgVs4WVlAp4gMgS/RtpaCGVVjclQFfke@vger.kernel.org, AJvYcCXi8C2Qa7rickASebqwg64TYE27l9oG2qNfgEkrUUx2ZGbMfUHnIuCfFLtpmd7QBnqQN23sDmUq@vger.kernel.org, AJvYcCXnRxYk8QhTqz95HlG1ht0A/ANXnthaljOpdgt+685JPHIqyM2fzRPTJcrIyEhdxAHIEd8S895B4iSfOpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdaokPQFFbTaybCMrPiuqyAJ8gGMPYffppM5XeQrZ5mwvpIXB
	iFPub/K827q41krKKuJGtdIa+6Tzo+vtDiW1qXA0a9aGpaH5/It7fsIWRJ7l5rdX
X-Gm-Gg: ASbGncvSXZzrhTb0E6GQ3Udhzu3yqv4zaKDMqwBxEs8SJtsrfMwv/vd+KDBDZn3WI7n
	sKDcbUSPXXxZpCNi97HB8F/d+CRokgYZfzrD0nOEKtNYhrtAzVjTNlfeVPa8gyN8lV7iaLUGiLI
	Mwu2bsm/xdhvK5OlMJVad/IlW+61kR8xdJ3YS4bVDtqlhNLFB+CoyCS6sjOVFlcZ/Y0DGHJt266
	HERiGqkH9S6nRR2z4slx65q+85G+2GvdaugHo29IHNSwyFBOpyiK+uJTG7Jth0P7oLT/vDX0MHl
	O147vb4j+8T9lUho9OsCSr+N8r2E94kXn0PDNMJrr6ejhZFhCHXZKZ1yIkk=
X-Google-Smtp-Source: AGHT+IEdxWDRf6+EpAFbQvucM60jiX8FSyavtrFoElTFBWd+TnkBTMCafEWAnKHFvrRXNLg8GBPgPw==
X-Received: by 2002:a05:6a00:2286:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-7489d1999famr17590954b3a.21.1750134771888;
        Mon, 16 Jun 2025 21:32:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488fff68b7sm7739920b3a.7.2025.06.16.21.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH RFC net-next v4 00/11] vsock: add namespace support to
 vhost-vsock
Date: Mon, 16 Jun 2025 21:32:49 -0700
Message-Id: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHvUGgC/13RwU7EIBAG4FfZcBbDzABtPZmY+ABejQdKp7tkb
 WtKQ9Zs+u4iFyvHn8z3TybcReQ1cBRPp7tYOYUYljkH/XAS/uLmM8sw5CxQoVGERqa4+KtM08Z
 xkz05hAFBoUeRydfKY7iVunfx9vry+zbzJme+beIjh0uI27J+l3UJylhp1qD+NyeQIEcyroXB9
 V3rn8+TC5+PfplKUcIjbiqMGVOnwGFDBNzWmA4Y2wpTxtCCGy1YGolrrP+wUfVmnbFldF2DFv1
 ga2wOGKjCJmPNjfHaaeO5r7E94uorks24cyN4rzDfro543/cfCn6TpOoBAAA=
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series adds namespace support to vhost-vsock. It does not add
namespaces to any of the guest transports (virtio-vsock, hyperv, or
vmci).

The current revision only supports two modes: local or global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

If it is deemed necessary to add mixed mode up front, it is doable but
at the cost of more complexity than local and global modes. Mixed will
require adding the notion of allocation to the socket lookup functions
(like vhost_vsock_get()) and also more logic will be necessary for
controlling or using lookups differently based on mixed-to-global or
global-to-mixed scenarios.

The current implementation takes into consideration the future need for mixed
mode and makes sure it is possible by making vsock_ns_mode per-namespace, as for
mixed mode we need at least one "global" namespace and one "mixed"
namespace for it to work. Is it feasible to support local and global
modes only initially?

I've demoted this series to RFC, as I haven't been able to re-run the
tests after rebasing onto the upstreamed vmtest.sh, some of the code is
still pretty messy, there are still some TODOs, stale comments, and
other work to do. I thought reviewers might want to see the current
state even though unfinished, since I'll be OoO until the second week of
July and that just feels like a long time of silence given we've already
all done work on this together.

Thanks again for everyone's help and reviews!

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
Changes in v3:
- add notion of "modes"
- add procfs /proc/net/vsock_ns_mode
- local and global modes only
- no /dev/vhost-vsock-netns
- vmtest.sh already merged, so new patch just adds new tests for NS
- Link to v2:
  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com

Changes in v2:
- only support vhost-vsock namespaces
- all g2h namespaces retain old behavior, only common API changes
  impacted by vhost-vsock changes
- add /dev/vhost-vsock-netns for "opt-in"
- leave /dev/vhost-vsock to old behavior
- removed netns module param
- Link to v1:
  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com

Changes in v1:
- added 'netns' module param to vsock.ko to enable the
  network namespace support (disabled by default)
- added 'vsock_net_eq()' to check the "net" assigned to a socket
  only when 'netns' support is enabled
- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/

---
Bobby Eshleman (11):
      selftests/vsock: add NS tests to vmtest.sh
      vsock: a per-net vsock NS mode state
      vsock: add vsock net ns helpers
      vsock: add net to vsock skb cb
      vsock: add common code for vsock NS support
      virtio-vsock: add netns to common code
      vhost/vsock: add netns support
      vsock/virtio: add netns hooks
      hv_sock: add netns hooks
      vsock/vmci: add netns hooks
      vsock/loopback: add netns support

 MAINTAINERS                             |   1 +
 drivers/vhost/vsock.c                   |  48 ++-
 include/linux/virtio_vsock.h            |  12 +
 include/net/af_vsock.h                  |  53 ++-
 include/net/net_namespace.h             |   4 +
 include/net/netns/vsock.h               |  19 ++
 net/vmw_vsock/af_vsock.c                | 203 +++++++++++-
 net/vmw_vsock/hyperv_transport.c        |   2 +-
 net/vmw_vsock/virtio_transport.c        |   5 +-
 net/vmw_vsock/virtio_transport_common.c |  14 +-
 net/vmw_vsock/vmci_transport.c          |   4 +-
 net/vmw_vsock/vsock_loopback.c          |   4 +-
 tools/testing/selftests/vsock/vmtest.sh | 555 +++++++++++++++++++++++++++++---
 13 files changed, 843 insertions(+), 81 deletions(-)
---
base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


