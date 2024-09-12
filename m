Return-Path: <linux-kselftest+bounces-17773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC48975E2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 02:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44EBDB22FC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 00:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D511799B;
	Thu, 12 Sep 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idTZAkjF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D5A20;
	Thu, 12 Sep 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102404; cv=none; b=tmsT4azSCtKPoA+HVv7lsA8xPqY4T0HdbhkMYrIdUOysBcZpRQQf+4BiwERBa//aHtTfSOFsL+s1HrUCmn4BFQTBWbIjSVWI5wAYFCV+W+2a3Cdm0W86UkYoaOzblwtd/vna4pGLn2Gq4Y+HKZZo6rt0ZCJbt34h3mZZq0j4gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102404; c=relaxed/simple;
	bh=5TQj2D6X4dBqp73nrTyPvLJP8elGj8jF1eeihOwkmUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLjkVLJtZND3a5qGPtryyxT9khhdECykIA/Pg8skAiU7ZAgEUAevxvBIxL5rQe/Y2lmvN31bNLbPjMTAVBuQWZKi9EheL8vB9HXXiltySp6mr1c+/hAQFX5eXxTNngK3IV42GLUY6MhbWVIXVEtz1isrLo/vRrrxA+QRBJZPE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idTZAkjF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c56eec7fccso3087106d6.3;
        Wed, 11 Sep 2024 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102402; x=1726707202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBTeIaNFqArQXn3ZOLoqrN5tCZM/LRA/XzkQflYYCcU=;
        b=idTZAkjFbc9Iy97fg70hlXN3jG/y2dUh2XrQM2dRwWmuIChDByksAGT5PhQBFT2SyG
         WdtVyVMs+/A0PSHicDETmpu+MMPmV3lNfxZJMNonYdWG5Gw/Efq/ypcpGI36wedNzOhH
         U95QpCJGB+CWm59IN1HTh3tpOVyNy9J6cRUmn9RVW6Y00H6fBvsd49mWffR1tJZABoJW
         K8z1MjN6pA/6rSJBU/VvpvBKeLYeZgnf8PcQ8FPgZ0UTS8Lh05TN5fRqgozGHfSrHgAZ
         fgE6eJ5Gcb8fyDUZrWmnYodWUkVxIpqCdL2PS9B/2MVhTg0Y87QojAstafGScYWzc872
         28VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102402; x=1726707202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBTeIaNFqArQXn3ZOLoqrN5tCZM/LRA/XzkQflYYCcU=;
        b=oNZ/vCXhK+y4s3bRb1oepsIDMc3dZNIx3XfmdPSgKZv8SPfr5dRz9w/5+XCdWSRKIS
         yvTvPIH2rO6C6iUiCVqf5CmjqEP+dL6hs7c5UgzPvX1rAj85fKH3OsAiZg3CZPGZ3x7Y
         Lh79I/+/fjizRkugmFn0GcdRLSd5NgXme5cqzlR3q2Dw34X/UBCJNVqDvZAAz2LG3jAQ
         NtcCQOIwLpSlcL1QQdO3ndbYXD9sff4nTmIMydYQrK52jCAIX9iG86/epjFwHS+6Rjs/
         kwOYDo1Bu9PJ9xuZ3uPSqrpFj0j8UopBrUAm5johJiTt8r1PVayrTtc+U8e0iphpln9m
         KG6g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Z8Fanc7UIid1HRvwaGMOwrVtrO2QpNoXODiruIlA+eiTv1GRLedrvZJ28mLvez0fslYUadJ9GoOo4Um1r/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxX7Flu7mpTj5UoIjDuYf3msmqIhUp0oMnY0rTUkr/Y14mBuK9
	Jl6Z8Qlk5Z1/1Ylqt843eZ3UnBRb+606+xCHYm6lpgXXF1UFYS8WsMhIDw==
X-Google-Smtp-Source: AGHT+IEHVJrAE84dzNhEYeXw11LhWhH7O8vG2uofwhRyXli5853NZy8xoTwY/qPxeoUZKiM/5I7Ghw==
X-Received: by 2002:a05:6214:2f12:b0:6c3:64b6:3e29 with SMTP id 6a1803df08f44-6c57352aeecmr20738706d6.30.1726102401840;
        Wed, 11 Sep 2024 17:53:21 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433b69dsm47947656d6.53.2024.09.11.17.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:53:21 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/3] selftests/net: packetdrill: netns and two imports
Date: Wed, 11 Sep 2024 20:52:39 -0400
Message-ID: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

1/3: run in nets, as discussed, and add missing CONFIGs
2/3: import tcp/zerocopy
3/3: import tcp/slow_start

Willem de Bruijn (3):
  selftests/net: packetdrill: run in netns and expand config
  selftests/net: packetdrill: import tcp/zerocopy
  selftests/net: packetdrill: import tcp/slow_start

 .../selftests/net/packetdrill/Makefile        |   1 +
 .../testing/selftests/net/packetdrill/config  |   6 +
 .../selftests/net/packetdrill/ksft_runner.sh  |   4 +-
 .../selftests/net/packetdrill/set_sysctls.py  |  38 ++++++
 ...tcp_slow_start_slow-start-ack-per-1pkt.pkt |  56 +++++++++
 ...tart_slow-start-ack-per-2pkt-send-5pkt.pkt |  33 +++++
 ...tart_slow-start-ack-per-2pkt-send-6pkt.pkt |  34 +++++
 ...tcp_slow_start_slow-start-ack-per-2pkt.pkt |  42 +++++++
 ...tcp_slow_start_slow-start-ack-per-4pkt.pkt |  35 ++++++
 .../tcp_slow_start_slow-start-after-idle.pkt  |  39 ++++++
 ...slow_start_slow-start-after-win-update.pkt |  50 ++++++++
 ...t_slow-start-app-limited-9-packets-out.pkt |  38 ++++++
 .../tcp_slow_start_slow-start-app-limited.pkt |  36 ++++++
 ..._slow_start_slow-start-fq-ack-per-2pkt.pkt |  63 ++++++++++
 .../net/packetdrill/tcp_zerocopy_basic.pkt    |  55 ++++++++
 .../net/packetdrill/tcp_zerocopy_batch.pkt    |  41 ++++++
 .../net/packetdrill/tcp_zerocopy_client.pkt   |  30 +++++
 .../net/packetdrill/tcp_zerocopy_closed.pkt   |  44 +++++++
 .../packetdrill/tcp_zerocopy_epoll_edge.pkt   |  61 +++++++++
 .../tcp_zerocopy_epoll_exclusive.pkt          |  63 ++++++++++
 .../tcp_zerocopy_epoll_oneshot.pkt            |  66 ++++++++++
 .../tcp_zerocopy_fastopen-client.pkt          |  56 +++++++++
 .../tcp_zerocopy_fastopen-server.pkt          |  44 +++++++
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt | 118 ++++++++++++++++++
 .../net/packetdrill/tcp_zerocopy_small.pkt    |  57 +++++++++
 25 files changed, 1108 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/packetdrill/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt

-- 
2.46.0.598.g6f2099f65c-goog


