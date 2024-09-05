Return-Path: <linux-kselftest+bounces-17337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADD96E61F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 01:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DA91F22AE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D871A727D;
	Thu,  5 Sep 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdyp6tE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB6539A;
	Thu,  5 Sep 2024 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578220; cv=none; b=q3MRbdzvm/X389SyyIm4O4Dcnn7VDnVFsoJWbqz8wlYS6e0FUpvdg8GnvIVkr2U3fpLIMUr6TdN3qEpfd1rhi2w9VQ6Y7Z53HWuZfKI06Qt6/vzbAbXSyOkeAoc0APc3/Ai82jmRjPlPPlCy11kdzJYLRsPlSDPi+Q1jV9OGkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578220; c=relaxed/simple;
	bh=rQugc0RZNrnAOFUZoUEf4sJt7rouH3wxQ8yP+xWGT9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dz3q63+GpE7UesHklfpJom+g7+3cj1NZyy4QMlsyaCRw5umPn5dYMDwvgM0ZYOFg/esgUUBKQn7W9Y0apY8jr9xQ1HYTDuNkrvDIyiMdgz/TsJ3jfZA/7SNpCI5UddWaEiy+DiYDdeI2alDkCMKL6i4hxiW6j0zMZ+ovLgV3Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdyp6tE/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45680233930so8764831cf.3;
        Thu, 05 Sep 2024 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725578218; x=1726183018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qo8m8li/DItO+PeZ8FBAi9MIkkXQzptGTjicoh08/+4=;
        b=Sdyp6tE/mCOJ8Qiflqyvb4RKBlQDsB9Ey34fn5oHEokppIhOOwVIYD0h+t3/RP3CVj
         adxC5xFtGz8aBCp/Nz7DdsIvdsjTHbxlXLlUe+ecp+4QD/xWy+Kyo+0Gp856kPQuD4+Z
         Gyomyd1LIRrYTl9xCHVxkCGe4JjZJvWOiPIm8WKmTLPZgVQKVyEa0CoUZ013Ndn8EQxy
         AnZcD9N7rWCgFVAgb4v7BdrpeSaCnurPrrrDQ3YDQc/8dwlBVgyDwCxfRghYfOFO7/G0
         0Zg4ZrT8F8J7Y+pzIWhrkV/S+CM7sIYZFqtYnzQNNkV2dykTUt0Zg/opTTqR/QL5fzo5
         dlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725578218; x=1726183018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo8m8li/DItO+PeZ8FBAi9MIkkXQzptGTjicoh08/+4=;
        b=PmBkZ7Cvx7qkzMg/On8vywr/axv6u1qp4c2WtzFeV+2NvCtdlnqM5wbvR3XrpTnCc/
         LimFEmlY7jH08R+sswnWrLDhDikexJWsbxzX84WOGro/25Y6FFTxJ191s+bFqO9kNXry
         VPcFMpZLbFbm/3xqnoPrhqP6Fon/NufPGaluV9OzP3UFdb7LuSOcezUc9OwDJ0Qe8r5t
         07B1CkoMud3nUUVn4+6j7BlqXO5LYquup4/MkIaxGi3HMaF9LQhjpSq6eRC7V7QGPgRH
         iOuo2ISV691DUkKCH1sL44187MhDyls16Urm210R/XHl/RptfZ2GZ1NU7pNUEYHSSMfp
         GyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWANSUg08+HGKdZ2pLQ0mIIAOqQKlrg9QWQOWVjvrOHcfR/wBXFIh2Yhunc4m9lqakW1zPNfPIEYXGtNW1+kzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3n2K0adaiG82b6uSLGo382dIOUscCknXWwhvQOlzlb4jQzqd
	3sz0tJIldpHBLHI5sfQhVNI3VH2mGwhZlv0eRBk369ZRYYfi78nkcTO4xg==
X-Google-Smtp-Source: AGHT+IEZ6jhwkxjx5Rsp4WThikw4c0EQeiU4vYMhG2IsO3ALq0fGBmcdwu9tf65alnXXhE7OHrJNPA==
X-Received: by 2002:a05:6214:5d0c:b0:6c3:5b3e:d8a4 with SMTP id 6a1803df08f44-6c35b3ed903mr212230926d6.5.1725578217563;
        Thu, 05 Sep 2024 16:16:57 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52041877esm11909666d6.123.2024.09.05.16.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 16:16:56 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/2] selftests/net: add packetdrill
Date: Thu,  5 Sep 2024 19:15:50 -0400
Message-ID: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Lay the groundwork to import into kselftests the over 150 packetdrill
TCP/IP conformance tests on github.com/google/packetdrill.

1/2: add kselftest infra for TEST_PROGS that need an interpreter

2/2: add the specific packetdrill tests

Both can go through net-next, I imagine. But let me know if the
core infra should go through linux-kselftest.

Willem de Bruijn (2):
  selftests: support interpreted scripts with ksft_runner.sh
  selftests/net: integrate packetdrill with ksft

 tools/testing/selftests/Makefile              |  5 +-
 tools/testing/selftests/kselftest/runner.sh   |  7 ++-
 .../selftests/net/packetdrill/Makefile        |  9 +++
 .../testing/selftests/net/packetdrill/config  |  5 ++
 .../selftests/net/packetdrill/defaults.sh     | 63 +++++++++++++++++++
 .../selftests/net/packetdrill/ksft_runner.sh  | 41 ++++++++++++
 .../net/packetdrill/tcp_inq_client.pkt        | 51 +++++++++++++++
 .../net/packetdrill/tcp_inq_server.pkt        | 51 +++++++++++++++
 .../tcp_md5_md5-only-on-client-ack.pkt        | 28 +++++++++
 9 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
 create mode 100644 tools/testing/selftests/net/packetdrill/config
 create mode 100755 tools/testing/selftests/net/packetdrill/defaults.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/ksft_runner.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt

-- 
2.46.0.469.g59c65b2a67-goog


