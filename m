Return-Path: <linux-kselftest+bounces-10771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E08D1AC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0F6B22724
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9716D33E;
	Tue, 28 May 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYzt21HN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DE16D335;
	Tue, 28 May 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898309; cv=none; b=sGs8niuezLv5GrOluR9tHWnriObYhj4zCZpzUbvJ8wOjrzvZKEDCMJ2aul+EGvvyRfNkHZvy6xwBVj4d4OL+Ld6MHUb31K5TCqarPeyaN/DyPoyx9LP7278tGZskSHacuk4udDHy680f2lz7AaTFxpcg9/an5UVTuwvVlqGuMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898309; c=relaxed/simple;
	bh=qqDnq+8DCihtvxh2tA4h1Nwr54ScpfDmHOuPXfX8yLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ei9Chhtasw7CifKBmq/8A1E/2R7RLNxGMdT1MbyVBuTLHmtfXxNbmbF18MqKp33tU/PLfkVwpn/D4m+QWf+059E+2m8KyWiSFZJygG8PUohjjN+bgKBKCQVvUzjFtdeZSMA35I8MecOOdVWhhltWv2xsfxE9lJOHthW9lZeNO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYzt21HN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so5558075e9.2;
        Tue, 28 May 2024 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898305; x=1717503105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+ePbf6YYVyuLoatenDzEi9t+2512ijImy79nCfIO9g=;
        b=fYzt21HNVrye5aWn8MxFHPmY+aPY9U6ImJb04XYSJ879jUdFrdpnRTvPPB05q7SIaC
         MJXPPGkTvd6RY6SBLPdbSAlqqrQGINytr+6lhapaFFH+roRcihOxwMDnicDTUlyB9PXi
         /38VRh5rfijq5mKVPXfb/8Mt3LN5ep5o07Gh6rO7k7/zvTv1L6cf/djSLcJBf3v6Ispa
         41QrIYuI9q3yi6ODYkQZHHejdjikceZV6ztulaXfDE5kKevAcvFs431Nw5+Ue7fbG7Tg
         iw9ylbVYHOUfZ/bqTqboOIDoI3Et/Qo57ca6utj8xMly1kVBd18w6UukiI4EOE+4FDNk
         StCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898305; x=1717503105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+ePbf6YYVyuLoatenDzEi9t+2512ijImy79nCfIO9g=;
        b=e7Rwfb9Rnkz/xCn6UAeSu+E488GhBbDNCi4RJjtBiwly4KehCLI0wFn9Jux0IkKDpx
         wp5Zw2ruJAzcq76wRLQ4bKwbzvTSC4vYzn61apDJj8SzW+/MV7U8cHBNhJGbtj6XKU8j
         eJZnLmXrFiYI5bg4bleecoEYEAX/8ooZd1K9Hh21UJOIYElhgvFEx3Y48I2HS9xgz4wS
         U5tqMrT2vqQEBJFo9nIBD8ZPOpX49tg4YHF220sX1BcqOQhcgdgpS6d9GuSTylWnKyN9
         PMZ5I8Bp6TYmmq+TAOKIv0WMknG72NhVbtg11Z3eIlZ4DWe1SYor+SDk+PO5qYGAnruG
         0puw==
X-Forwarded-Encrypted: i=1; AJvYcCXZXq6h6aUKDE0aT7iydkz/3u8+UE0fiJz18nhiMsqZG/odEE3oAOp0659j53tid9dunstK7ySB1jZMwd5OaG933v8CbjTx4MjjcmE6I6pF93SzQPkK4kUlwzJCQA3dHoyRA0Qm+aoJW/aII9Vl
X-Gm-Message-State: AOJu0YyfSBCFH3K0cRZEjyHMv2LGtSd6n7yfkfgFGo7MB35h+7T3HlXI
	C9u2IM3n1Lh/Umh7v6uhfMZ22eNUX+GRjX5CW/nrgTELDTEfYxbvz6jx4g==
X-Google-Smtp-Source: AGHT+IFDlJcvMVj+yiLB8KL1ut3q/gSiu/kNbiPa+Dqq5iB1EJsvgQsI/x10RVemjSr0FOHmQP64DQ==
X-Received: by 2002:a05:600c:1c83:b0:420:110b:4211 with SMTP id 5b1f17b1804b1-42108a150a1mr83145125e9.39.1716898304649;
        Tue, 28 May 2024 05:11:44 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-94-218-116.cust.vodafonedsl.it. [5.94.218.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f69850sm168281625e9.26.2024.05.28.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:11:44 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/2] net: visibility of memory limits in netns
Date: Tue, 28 May 2024 14:11:37 +0200
Message-ID: <20240528121139.38035-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some programs need to know the size of the network buffers to operate
correctly, export the following sysctls read-only in network namespaces:

- net.core.rmem_default
- net.core.rmem_max
- net.core.wmem_default
- net.core.wmem_max

Matteo Croce (2):
  net: make net.core.{r,w}mem_{default,max} namespaced
  selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a
    netns

 net/core/sysctl_net_core.c                  | 75 ++++++++++++---------
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-sysctl.sh | 15 +++++
 3 files changed, 58 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns-sysctl.sh

-- 
2.45.1


