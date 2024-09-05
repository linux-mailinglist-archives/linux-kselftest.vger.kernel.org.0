Return-Path: <linux-kselftest+bounces-17204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE596D038
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222031C21B35
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A218A6CC;
	Thu,  5 Sep 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahUbvdJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54264C80;
	Thu,  5 Sep 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520675; cv=none; b=T5W2vcf0nGrJHRYDthV9DfPA6haLihD+BhozwNumCn/9HgHBZ3L625y6WTyWTeFUiWZ8eSO8hK3pjyLCT4Q4cOgdKE1Da/zQPMFJHe3dXrDXBI2pI8Ak91MVqq8nF6dIjkLJgX3l2poQU1iqmkvp+7pV5dwPtrqVj6/cXzUSsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520675; c=relaxed/simple;
	bh=exOXQY5cCVVtMCLtCJF6QcFkAJgM4RrKpujir2CeO+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MM0Z1Dd3ph/7TzdOG3yLxQ++Y8MS2hRLJDYOk3ctBNYkMafMHC9bCReU/e4JMcN+GyCBXYaYWE1uCMuZwZHrIsDdDJEtHHIsSybsFZrKGD9xbL0s9IzK3XGaUcuzH6NyD+CqvpfhPydsHs/7HHxwOsyP1/+pFBJs6qOFeC5GhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahUbvdJF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20551e2f1f8so4559435ad.2;
        Thu, 05 Sep 2024 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520673; x=1726125473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/fHW+vf/xwMj6TqyKbht/Nn75CPTpLR0jY+BqVTD44=;
        b=ahUbvdJFptgklXPlpfbZ9alnMnRsVjEivGChQ1KnXkg821UvnQsZqQCO7fPAu0SqeA
         kL0pFP28gkoUbbpddq66D3vTfYsXd4qdZaJndlzER9DRqSvEQl6AvaOVxGqdK9lOUIkW
         ONSiO7m7Y/yFQZL/UF0ALTpwTaR0n/nfQTro3vWrx0jwQnkNiJvQt8ofZS1IdOMUEUcq
         +7+RGic6RCBrv8OLyOwP2JBBhfkMm3uim4HRpZa5C4HG20WjC19+p7RdgGFHNNTTbrN3
         Ay4P4cYV4QbefdQX8Ddur9CmMVp/hrV1ulVnhFhGDhFC4gL92lbyUz9JxSA+LqIFX76T
         zavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520673; x=1726125473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/fHW+vf/xwMj6TqyKbht/Nn75CPTpLR0jY+BqVTD44=;
        b=QzHgBorm5by9mtMBAO7BF0idPr46U93reDnhEEMdrbMUkvDPVMXFnQC/D9Af5MQpel
         7IPoE3K6JOolPCQKajV4i7z2jtkJCeI519d/zqe0QWGzXESGFPbkghZPVlcL4WL9NKSl
         9vCgy8wngtm4mBo8pROZ55eQVMBQkFPKrwS63tw3dVs27NpgiK5xOykySJQw6gHt30Zq
         4/6R4uRtv5QuI4QCO2z7YV4eM4i/9kVQHb63fIPztPlC687Cu7gVG2objCLrBkrR3fn3
         CNmiG42a6Wxwjpa85QwIMRzXx0GY5B9kn6rbOrg17eFjGwAr/I+yNThbbaVDL/GSazCN
         i7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCURfMtJmpN0mQkX6/mURGoLXSzbMK232PjtzH26Dc0RWgtDbx+Cm/cLo5u6ZLG7MIb5Nedy9tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQYUvL5/vCeqMo0RaAKJ/D2LWXrylq5tSHYWw0YYQfjSP6OKZ
	T4FtgFmAH1qDB++QPe/Qyxx5IRTNEFDHDzD/zz+WLFHhnvK2DglO
X-Google-Smtp-Source: AGHT+IGfNnyZS7j+hZsQUigYI0BYXAaUTW17GJgmyWbxeh4zX9oRUay4Nx8OEB6Y/6Eoeqh+TU7zhw==
X-Received: by 2002:a17:902:ecc3:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-20584230d32mr131593395ad.56.1725520672986;
        Thu, 05 Sep 2024 00:17:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b19sm22929425ad.61.2024.09.05.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:17:52 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/4] net-timestamp: introduce a flag to filter out rx software and hardware report
Date: Thu,  5 Sep 2024 15:17:33 +0800
Message-Id: <20240905071738.3725-1-kerneljasonxing@gmail.com>
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

Jason Xing (4):
  net-timestamp: filter out report when setting
    SOF_TIMESTAMPING_SOFTWARE
  net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
  net-timestamp: extend SOF_TIMESTAMPING_OPT_RX_FILTER for hardware use
  rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_FILTER

 Documentation/networking/timestamping.rst | 18 +++++++++++++++++-
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/core/sock.c                           |  5 +++++
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  7 +++++--
 net/socket.c                              |  7 +++++--
 tools/testing/selftests/net/rxtimestamp.c | 11 +++++++++++
 7 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.37.3


