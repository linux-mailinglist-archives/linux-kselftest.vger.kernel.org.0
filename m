Return-Path: <linux-kselftest+bounces-42035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA178B8E7A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414D17CFAE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826B2459C9;
	Sun, 21 Sep 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVxYOyNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC2469D
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491779; cv=none; b=pMpL5kgCANKY/KcZL9VM/j2JUwAgiJoxA3qku6VTbP/KC15v1DW4v7cE4aFRUWyc7S85aEKgDogEVl0k/P2sorCzasY3vADm77LMUM1hIx86StHNixmi4mX05C52DB1diU12BKZvf/EvknGM23yHCh/Sa+orHVUZwgykQNNscIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491779; c=relaxed/simple;
	bh=HUv/KqDa+7owTqnRzPUIWK9staNfM29PaK/t0/ja1cs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YSbyZY+HPczs6a32qPXRF7z3dWwDrnQbXtEt2xwAfrhAZdKlQwMHK2xAQskKCUn/4bbCcsHkYmGX7i6zUJUxZ2uM1Qyoa9qHnWzDBkiqzuVYf3sfdw+QLf5ThcXj+QjBM3Mhv3KLo4k935uhWEsr/QhMT3Gl8QBb6yJGQWGC5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVxYOyNA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0308469a4so1179376f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491776; x=1759096576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3vFwP/UATWnOKN/9SU3bVti0yAkZLhmbmjOPQlF8WE=;
        b=jVxYOyNAGqRwObP4qio9VEpsn9Setxx6KmHjnWqQ4sGI0NLC3HZkpSj2eBRAAdhXXG
         2WQW7+TMQdD9OR9uCStTkz6fbwTt9HG9NbLwwG41hz3LSFXpKIRCiHonO4ejYPpZhm09
         HtqP4NJIKfZdfK4SLjAaNkAmbwLbNWp04ZRxB+KF64QolYHUVKYsw4lremxzeZBOYNAk
         r95Fz4igyQMMSG0JCBx17OJ5sv5uSA5NoXk6mmpgCUFB5wruGMcZ6/CnPxNuRGCrmZEk
         YBVHBH7y16qXUFZk9s5EDkrK+PJribhX8kypoABtxpampoToEuhEoqhqWanjQW1QsWBx
         +3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491776; x=1759096576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3vFwP/UATWnOKN/9SU3bVti0yAkZLhmbmjOPQlF8WE=;
        b=KlaO5VHy2nRpzw6+gAjUOVEOhef80A02BkGcyPlBBrd0GHGbMBf0jL6JA57FnfGA6m
         Y3Ewm0I9fq2H4cAyu/KOHLBndbM2SrNDPG6iPHWE/Fbd/mXdDaH7sNV48c5DDI+jQ1b6
         t58FAZ5zT8NaVkiXStHcpCfbYkisrXZxPTMkEj0reSvHPlIpYpruI7Y4OAjnAFu6hGpn
         Ac4OW/xuIV4vtboQ/5K+8AXhJlEtzstiOpd4v/h7R4cPsoUfK2U9r4EZUdVuZ0hLeEj2
         +Y7NtfVtd6Jn0jkO8kz1OOza2FL53KljVzQ5HTdggSRHOqFuA/OmAAw/SlgZh8troctw
         pNsA==
X-Forwarded-Encrypted: i=1; AJvYcCUw6B4wauh3rUTAy9lplwAa3FbWF+H4RkMkRVYZmFJxgQX/eFST+fq1oCYAwGTZMOyyziuXYDIdNcbOWhrDcWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+IfqnLuYqUwbSioyrshDCaVzRt83y4LRSE1rNjpO0JCKslcI
	SOfSUcOGuN0OB0u5lG7H2FaOu3GHN8QOpjVQHcH8XRiIIHy59cM3xlh8
X-Gm-Gg: ASbGncuKjFzG8hyOyB+dFaNLo7IoMQlXhYMHvd5xoB6vWG80Nb8D4bxcOV/RGbcSzER
	BIJiBmgRNUE2qZQwoDygrMvqFUB3U7heVIEaGv7OBEVkjwc4RpXjduE8Is/PR/cFWILWuF+7znt
	pZ485YWgDn1/6epyCkP+Eop09VRnxwl1o7X4xjaMnbdhOS0jzLnxIgDquhxe3o/gMhxpSSNrXk1
	maGJg9RWaJFORjtN7A6XngSd+3SPRkELIFZkwk/7srGB8KIgxYMG2Wi62BH3py6EuXIlouaKpBU
	isV1h4z/ScKdH74lOka9N7FCOz1Ht1yYQhhbB8af+CTYd+pYqPVVN4wG16iLX8oVGjGXe3kz6Fv
	0f+KLM5kzLKN6rf1368ktS8RWWyw=
X-Google-Smtp-Source: AGHT+IEucFUd0uppCrdOgZW3tAwX6G276I90VT+GnwFylm99xPnt54vCnTtXQgw7HvIviS8Gbud+rQ==
X-Received: by 2002:a05:600c:8a09:20b0:468:5d0c:fb49 with SMTP id 5b1f17b1804b1-4685d0d011cmr59027555e9.19.1758491776164;
        Sun, 21 Sep 2025 14:56:16 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:15 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v2 0/6] netconsole: support automatic target
 recovery
Date: Sun, 21 Sep 2025 22:55:40 +0100
Message-Id: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx00GgC/22NzQ7CIBCEX8XsWQzF/uHJ9zA9IC50EwtmIU1N0
 3eXcPY4mfm+2SEhEya4nXZgXClRDCWo8wnsbIJHQa+SQUnVybHpRcBsY0iCMTN5jyxM67p2eDo
 79gMU7sPoaKvOB5R5QbYMU2lmSjnyt56tTe2rV0v9x7s2QoqrQaNlq1Vv3d0vht4XGxeYjuP4A
 XAfxcK8AAAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2296;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=HUv/KqDa+7owTqnRzPUIWK9staNfM29PaK/t0/ja1cs=;
 b=TLKs/NnIrCUQcRsQEuPfRPWpA5Yx2ZGDUJpD1uaWibG1wTrHufzQoZ9jK3PGaouaLxrlmSVPC
 RSPEFasBcXcBL0a5R4BbOIbElucgG/M/4xNUzJGyvPpv6uj+ojs8ELC
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces going down). It then modifies netconsole to
handle NETDEV_UP events for such targets and setups netpoll.

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v2:
- Attempt to resume target in the same thread, instead of using
workqueue .
- Add wrapper around __netpoll_setup (patch 4).
- Renamed resume_target to maybe_resume_target and moved conditionals to
inside its implementation, keeping code more clear.
- Verify that device addr matches target mac address when target was
setup using mac.
- Update selftest to cover targets bound by mac and interface name.
- Fix typo in selftest comment and sort tests alphabetically in
  Makefile.
- Link to v1:
https://lore.kernel.org/r/20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com

---
Andre Carvalho (4):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netpoll: add wrapper around __netpoll_setup with dev reference
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target reactivation

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 102 +++++++++++++++------
 include/linux/netpoll.h                            |   1 +
 net/core/netpoll.c                                 |  20 ++++
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 +++++-
 .../selftests/drivers/net/netcons_resume.sh        |  92 +++++++++++++++++++
 6 files changed, 216 insertions(+), 30 deletions(-)
---
base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


