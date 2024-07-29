Return-Path: <linux-kselftest+bounces-14373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6D93F0F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A2284283
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7613E41D;
	Mon, 29 Jul 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb9NNUyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB5139568;
	Mon, 29 Jul 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245095; cv=none; b=jF515a9wXtWHbo/V8WUQiZ9SvfO6NDLcu8xHUZjI1cn4IlRn4WeCUsXMqoqr91nqcadj45SJa8kRyvpa20AeIzY8mNUytXF1vz6aper6HwP2/JdPdKktp0HTAvIgCJ1N1OVmdD6Hy1Nxf4l/LxlQ8UXOpwLCdmNkYbDaADq2Izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245095; c=relaxed/simple;
	bh=GgpBzyfhRSLYC+TLXnY4y4ChT4cl4MHuMO36o+bpnTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f44vp6Qi7pcbUiZ2h9QcfUKMfjxyZMYA3QS3z6f+mxeN3O0G3THlmKoYFBATt8yzFh8vYAFaoRa1eQ5d380iZTxJ90rJsa+jEav/thShHlP9yq8u15opNAHqQOvh2c6M/NGAQ6t5vLhmZTuRxsLfltndsGUQy79pfRZNvuvvE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb9NNUyb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd66cddd07so17021445ad.2;
        Mon, 29 Jul 2024 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245092; x=1722849892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KCgWkgZpj/xjXSot0+cYlFbdfSHY/0HVZ5q0fJohp8=;
        b=kb9NNUybzOSZig45zqDc0/4vDCbKcsm5fxPPlYjHYQsqNIMagh+BCF7F9iJoQVZJMU
         6bOtd4qXIIayjNmG3l3dxPfdCkoMQa33Iwq/F0AjZuxestJ5r9ntSeIe3u3dpCEhGrsp
         E0SmnLJPrKJwSGWV5ETf2UireEJrS+YOAsVhvXi3Coz+NaJoWgUtfkPObR+lMvwQxnsJ
         3rPPtzjtgzrwi7OnytttfZ+kJtaI/X4P+9Tz8dGV2toX/mdJZjlHaPu/dM9OA6Daxqjy
         qluw9aGgHAbEBe+RibquBvC1PlDMS0/XiwHi7pY2PwlAtkVbyQEv5RfFtP1RVoQH5GIr
         a5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245092; x=1722849892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KCgWkgZpj/xjXSot0+cYlFbdfSHY/0HVZ5q0fJohp8=;
        b=G/z7CJrrU02/JD9wFBT865yl/nz85kIjvrWEpKX3Kf7NW5ho543Lxcs2jwW4cI3Uf1
         aTG4R8U6pNpBCM4TZKMO31h/BusOUXPJA4wZlSZkt0VwJ1alCuoIHUg0zQuRN+E/c/6r
         Rtzr1oWD4dmShqvGeVj7QsmEP5cPTpsuGCY4NRcGsZUFmcAypwsDexkaKEMeH+wAjg/N
         NRuKDeJl7fZqGfNXjDLJWODl/bnzQWhsjRYUJiT+aYs/W9MFPtiVahb33qDCZHH8o4DQ
         p1dwEw0h4J5FPoeXgO+aUiOfTbpz9JB56gYU0nYFPWhpSf7aqU9+RfgmXLfEkBOs0VCT
         17Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU5k6VmlTNLDZjpOzm60TCeM2EAemBtzU2heKKXa8PWvP5kwDrFixZUzHdpsaH2pr/1EL/FamcDXeEPpM0tGTrqdNTu3Q05+rKjda1ZO9CvznavU44ramIdWbfDhq+rKQu6NI+v78Ag
X-Gm-Message-State: AOJu0YxQdFKYvcnA1gEfPYyxcglB7TXI2Tta8iUAx/3lmKIfHBH8QV1q
	Y8Tt0nuIw6BAIBgEA1rLKGgsfqrr3kVfQH/nxpWKp5TlBTwWpcqMm1DO34xw
X-Google-Smtp-Source: AGHT+IHSomnBFfcQ/Q1STjT0wbSvVrxsNvJahShlp3GqWRbvdrcQ9ZyRRWcqcR5do1ulTXeCQQSipg==
X-Received: by 2002:a17:902:c411:b0:1fd:6eec:1b4 with SMTP id d9443c01a7336-1ff0483805cmr41067875ad.19.1722245092514;
        Mon, 29 Jul 2024 02:24:52 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:24:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/8] selftests/bpf: Fix error compiling test_lru_map.c
Date: Mon, 29 Jul 2024 02:24:19 -0700
Message-Id: <22993dfb11ccf27925a626b32672fd3324cb76c4.1722244708.git.tony.ambardar@gmail.com>
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

Although the post-increment in macro 'CPU_SET(next++, &cpuset)' seems safe,
the sequencing can raise compile errors, so move the increment outside the
macro. This avoids an error seen using gcc 12.3.0 for mips64el/musl-libc:

  In file included from test_lru_map.c:11:
  test_lru_map.c: In function 'sched_next_online':
  test_lru_map.c:129:29: error: operation on 'next' may be undefined [-Werror=sequence-point]
    129 |                 CPU_SET(next++, &cpuset);
        |                             ^
  cc1: all warnings being treated as errors

Fixes: 3fbfadce6012 ("bpf: Fix test_lru_sanity5() in test_lru_map.c")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_lru_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4d0650cfb5cd..fda7589c5023 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -126,7 +126,8 @@ static int sched_next_online(int pid, int *next_to_try)
 
 	while (next < nr_cpus) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(next++, &cpuset);
+		CPU_SET(next, &cpuset);
+		next++;
 		if (!sched_setaffinity(pid, sizeof(cpuset), &cpuset)) {
 			ret = 0;
 			break;
-- 
2.34.1


