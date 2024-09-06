Return-Path: <linux-kselftest+bounces-17382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7C96F0A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CAEB22462
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C471C8FAC;
	Fri,  6 Sep 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhsZJN1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7F158D81;
	Fri,  6 Sep 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616611; cv=none; b=cRMLs2KqYOsAfrK342FyKlBhbe0uaUF/xvmD1GHiH4ck1AogaBEA6Zr5zxcMUA6bdxgCa/L3kyAvWYPAXm04mwUbcg2wDn3zMdgcGwFkbTXosKzE5AvmRvpSNgbtq2SlHjuOWcLVFzTHx7lZ/GgV9/Ehg0cye5yqUjNjIJnQfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616611; c=relaxed/simple;
	bh=N2q7WPdX8pQ5BjKq2jHhPE9H//dF9Qujn9BuK4PUrNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qrYsfR2M2QRlYAGy1Mvhvg0Nxc+Ho11oknv4dm6Amd+2lg7M4ousfyGmSKQXTF6cHWLlCVJXsuMc5dQayJKg5sTtQ5WS86UNJm5/DO9qSszVXXJ+22F2TMqeb133J7TIzCsm6x4SXjp3VZUtKmwaT6P3zDPdZR+S34cisxx3wJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhsZJN1e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068acc8b98so16809005ad.3;
        Fri, 06 Sep 2024 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616609; x=1726221409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPfnhXw3E5N/TaNxdIPS8Z4PNN7kL/fcd+e+orfvG9U=;
        b=WhsZJN1e2+VwqY8LGuthauCj6FH+X8NRKxhDp2XYCSuIF4+wyx/dsReznx8OUv/B45
         ie+la0v309PtsswCgpjTvs2rMPb79iMl4VBNZ7sbxK6lBcJNw+u5h9pYDMYKISa6LrHd
         RocZNsSTop8LagMi/wEitYHfSCFhBP0nZPDuGW29YFEVSCuNte4u57SI/LNVcPfZm62f
         TEFv8jqGurQ41M06qEFX6EWRvvbg0Aqw8/3DNbEmjYkxLxBYSAyYv1Z1dX7AIJAy9UaS
         nJl5R6lHRHcJ7sOFIU4dh66QL1UGvGzzfGCO1HjLSYIduBpuv+UpdleMVXTrHePryU8l
         kBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616609; x=1726221409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPfnhXw3E5N/TaNxdIPS8Z4PNN7kL/fcd+e+orfvG9U=;
        b=RpSIED6ZOjPyBKVfKboLVFf4HBBxFmAMaHlSkebBTFgr4mtzN3W1k5MmHs6PShGIgS
         Qu5sv065mbfrf/gjuz6Zc/P7SZlcibpVuNrfCEztjBAWvUUjh9C7Ave9y/pXC8zzdnIp
         fSol+E94cl4Umz6/kPDf2tzEC1WcO9aUWEljSJf2e0B0DxEXrNvfQl0FoFn/k4C5OrW2
         YlFlXOF5rOZhj4n+2rU0g6SSw3CdS1y8Sr0O0/HTgdozQoLyL/h4bCteq/lO5fTY2T5Q
         /jG13GDOG5RF0QRxcjipCjrTqkNQjKom4cdAuBRgdFvhG0QgSZDDNS2AOK43N6citaAF
         UggQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQQ5rfuOVgPgkiw02iAuKZqjbNzQJ4s/CJ2kKiiLjxxHKXu3+VoRPC9c245BRnTU5RzSmWS8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhEH+IBD3SYj7yG/QtrORwwaqQ8sr+rpvsvjtaSReahdfSPXp
	xQ5aD1G7s7j9EO106mAyUUIl4ff7oM2D3dAjzfK2EDkdeatTr9Wp
X-Google-Smtp-Source: AGHT+IEqeGXWepsxYQ9O8AAHwVcIrms9vC0OggBpCF7lyXfOFQOQEZplvhjt9uC8KPKAHcR/GBWHrw==
X-Received: by 2002:a17:902:e80f:b0:206:9ab3:2eaf with SMTP id d9443c01a7336-2069ab335demr143500935ad.46.1725616609307;
        Fri, 06 Sep 2024 02:56:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5582csm39982595ad.221.2024.09.06.02.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:56:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 0/2] net-timestamp: introduce a flag to filter out rx software and hardware report
Date: Fri,  6 Sep 2024 17:56:38 +0800
Message-Id: <20240906095640.77533-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When one socket is set SOF_TIMESTAMPING_RX_SOFTWARE which means the
whole system turns on the netstamp_needed_key button, other sockets
that only have SOF_TIMESTAMPING_SOFTWARE will be affected and then
print the rx timestamp information even without setting
SOF_TIMESTAMPING_RX_SOFTWARE generation flag.

How to solve it without breaking users?
We introduce a new flag named SOF_TIMESTAMPING_OPT_RX_FILTER. Using
it together with SOF_TIMESTAMPING_SOFTWARE can stop reporting the
rx software timestamp.

Similarly, we also filter out the hardware case where one process
enables the rx hardware generation flag, then another process only
passing SOF_TIMESTAMPING_RAW_HARDWARE gets the timestamp. So we can set
both SOF_TIMESTAMPING_RAW_HARDWARE and SOF_TIMESTAMPING_OPT_RX_FILTER
to stop reporting rx hardware timestamp after this patch applied.

v5
Link: https://lore.kernel.org/all/20240905071738.3725-1-kerneljasonxing@gmail.com/
1. squash the hardware case patch into this one (Willem)
2. update corresponding commit message and doc (Willem)
3. remove the limitation in sock_set_timestamping() and restore the
simplification branches. (Willem)
4. add missing type and another test in selftests

v4
Link: https://lore.kernel.org/all/20240830153751.86895-1-kerneljasonxing@gmail.com/
1. revise the doc and commit message (Willem)
2. add patch [2/4] to make the doc right (Willem)
3. add patch [3/4] to cover the hardware use (Willem)
4. add testcase for hardware use.
Note: the reason why I split into 4 patches is try to make each commit
clean, atomic, easy to review.

v3
Link: https://lore.kernel.org/all/20240828160145.68805-1-kerneljasonxing@gmail.com/
1. introduce a new flag to avoid application breakage, suggested by
Willem.
2. add it into the selftests.

v2
Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxing@gmail.com/
Discussed with Willem
1. update the documentation accordingly
2. add more comments in each patch
3. remove the previous test statements in __sock_recv_timestamp()

Jason Xing (2):
  net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
  net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER

 Documentation/networking/timestamping.rst | 27 +++++++++++++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  9 ++++++--
 net/socket.c                              | 10 +++++++--
 tools/testing/selftests/net/rxtimestamp.c | 18 +++++++++++++++
 6 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.37.3


