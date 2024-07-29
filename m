Return-Path: <linux-kselftest+bounces-14375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FF93F0FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187BA2846DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FEB13E41D;
	Mon, 29 Jul 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX2ED9Tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A613E032;
	Mon, 29 Jul 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245116; cv=none; b=YRlJgHIiiObYrKjMBysewC8RiLuvArW+mG78gxad0QfM4WFdHjuf8YBxozj7bJt6FiXk/vIG/wKMqL07NEu/vJmgj4ww4W29KiY6KTlwteIdex6HCOZwcXBpzj1pCged4liJGoc3bI6uwg+NQ1h0reuZ6IZd6KMU2xRQEDcUnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245116; c=relaxed/simple;
	bh=U+72Zu68YsWKSCq/gROuLbLA0RkiJaRjm3nFdugE3VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZTf9DO2AzhFJJE8TTw65P4JPoFFzn7W2AcpA12vMKZkQCMUKPlALkD/cNpDiU7LWI5vM8P+rAhtgvzh9nVOZARlZGmq4Gd6ZNXojc+7w8vFHmBQP90F1w4d9grBVr3W5UlP4s3XbTityVnbiep0sN8TRViJTWzm+MNomJz3dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX2ED9Tx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd78c165eeso23989835ad.2;
        Mon, 29 Jul 2024 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245114; x=1722849914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NI7AuS3CWDWcwh3iYGbh1+P/lJIWDLh+u4INWitysM=;
        b=kX2ED9TxjNqyRIsp3RHYgnuSSejUSuYp6OVapkWWnoDT6p9+OcJjCOe3Knhp30nRIv
         GfR4IzxfhwhlCa1WANog0mSyDEJCbvtXDH866g5Dbf2TIRIM4DbQHsux1LlQQYg8WI90
         SxfYAEiy4JTn7CFYOxz8vryB6YemRHAleICaeEMHoSoD7WuKWE7McrDwRknQ1BLjsdAn
         tDe3EZMIsQ4Vo89BJ1xv1c7vxDP3R2isSgk9849REcBT7Mro0qPikpdAzHyb1wrEPnVN
         kIC2NQX3SGJPO5txhp8dn86EVLKN/qYqHmURqtNRi5JpGze2MozFefCHU7K7V+xNFCaX
         BZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245114; x=1722849914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NI7AuS3CWDWcwh3iYGbh1+P/lJIWDLh+u4INWitysM=;
        b=YSMYtsRfnw8U3xMxKh8p8Exf536XfBX2db9g5MeIMI6+o9FsT2rz9m71tArQMDZ9OM
         l/GJJkexdOnGxMMZFcNYHZ7GEJlSROk9D3Y0bDmVAmoYskx0KFUkgD8R3VgoBOtuBdlS
         MzReoSAcV00j7Gl5oqGaM5RnFC5Exp6oYl+CqG/bbgahkmvKZ66qzrvb7ft2zgw7aqyi
         Oz3HMo5vzEM3t7ijvrFyjFGjMxKky4xs503LbJ5/U5hdtEi8oNEABKH2O1kAZ9uy83RG
         I3D3q42BPBT5emg/173XIRSS8R2CnwAq9/qoeta2OoglS/OooIToxMOpa8Q1ZcjqzMTT
         IJkA==
X-Forwarded-Encrypted: i=1; AJvYcCXCi0dC/dB56Oeo9LGgFunyAkFv3CFsaVdG1DvlCdT9qSUhHDHcFle5ggLnB0Tc1cpMNprGqcF0Au49yWTSyALNVUhU58OP/XvYaKDJTQf3uj+Io/djGcXg4CrKiSJUS6w0VgVyBz8f
X-Gm-Message-State: AOJu0YwninBHb7iaR2+ZRdcXxi+L/Y7W4dSr0sxLWUOWGrad+lGe0aq6
	pRAHLcOAj9g+HkpabhyREjL3RNpF1pWknpCPBx0Nz+b17lfgUsy4bWHWxiJS
X-Google-Smtp-Source: AGHT+IGaaHe7YvfpkEUFCTmGQ1zmd0UBbH2J5zDAyfeOGm/x+Af4UIn2PMOsotW1EqUw0dNPaz/+kg==
X-Received: by 2002:a17:902:b090:b0:1fc:5879:1d08 with SMTP id d9443c01a7336-1ff0483bf36mr82870165ad.32.1722245113875;
        Mon, 29 Jul 2024 02:25:13 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:25:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 5/8] selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
Date: Mon, 29 Jul 2024 02:24:21 -0700
Message-Id: <bd2908aec0755ba8b75f5dc41848b00585f5c73e.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling lwt_reroute.c with GCC 12.3 for mips64el/musl-libc yields errors:

In file included from .../include/arpa/inet.h:9,
                 from ./test_progs.h:18,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:11,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
.../include/netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
   23 | struct in6_addr {
      |        ^~~~~~~~
In file included from .../include/linux/icmp.h:24,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:9:
.../include/linux/in6.h:33:8: note: originally defined here
   33 | struct in6_addr {
      |        ^~~~~~~~
.../include/netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
   34 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
.../include/linux/in6.h:50:8: note: originally defined here
   50 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
.../include/netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
   42 | struct ipv6_mreq {
      |        ^~~~~~~~~
.../include/linux/in6.h:60:8: note: originally defined here
   60 | struct ipv6_mreq {
      |        ^~~~~~~~~

These errors occur because <linux/in6.h> is included before <netinet/in.h>,
bypassing the Linux uapi/libc compat mechanism's partial musl support. As
described in [1] and [2], fix these errors by including <netinet/in.h> in
lwt_reroute.c before any uapi headers.

[1]: commit c0bace798436 ("uapi libc compat: add fallback for unsupported libcs")
[2]: https://git.musl-libc.org/cgit/musl/commit/?id=04983f227238

Fixes: 6c77997bc639 ("selftests/bpf: Add lwt_xmit tests for BPF_REROUTE")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
index 03825d2b45a8..6c50c0f63f43 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -49,6 +49,7 @@
  *  is not crashed, it is considered successful.
  */
 #define NETNS "ns_lwt_reroute"
+#include <netinet/in.h>
 #include "lwt_helpers.h"
 #include "network_helpers.h"
 #include <linux/net_tstamp.h>
-- 
2.34.1


