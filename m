Return-Path: <linux-kselftest+bounces-29625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D8A6D461
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 07:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC5D188FA7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914D18E351;
	Mon, 24 Mar 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILbbtFAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E62E338E;
	Mon, 24 Mar 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742798584; cv=none; b=s0jogGx6Y9DBspNoCAKJQ0Os3a+2Odd/3AsJhrFXZeY5xb6PUTqmB45KsE4VhZ/hHOWMJZzIPGZWTfLzarARCmpf+us8KcpY15mZXs7gSydUaSCzcxe2CZ0DoRMKtRNq2wLmqXR1jTi2pwL2ilFdtMgH7j1mJRG+Pe3wsvhqChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742798584; c=relaxed/simple;
	bh=3GDPaf9kAVH6vi9UQz0EbD6wzACAE/x3IWZpE9t2MlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPXfV06mcjC/bIE7lOg5rppr8/X8UTcuyesrLocJcoQeXOM/aIuBS2PgbtiEfo3REQbASI4t6MYnF5hVAHoWy4fEylZnVa4rDnHv3LufFUyDXAFqApnu3VBw2s8w4GmmjwuneKSEw9q6ukiWUoV+5pg9iNVS50U3knU64qnaecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILbbtFAw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so70741585ad.1;
        Sun, 23 Mar 2025 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742798582; x=1743403382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avYKSEMp5uulDA5FmpuH+JjdUIqqwn+PXiLercSA2Oo=;
        b=ILbbtFAwyiHjK8Jdp45GFcPJYJT9lmE2jYvHLikPFECiGEonnBkNb3iCmjvppZoA9N
         DMlyGA3O+9/8yXarUOiOghEH/uzEeSnIuhxEWosugb7RWoSziLYYqQklfePhDdOyrQyH
         qGlyOXopJvSlh6ZRCswfTtIykoIWVci0zhP42UrEDife+Ae4FrYoICOzfrsmioDz9N+Y
         EzqiqN4EqSxzNIo0RzHfAu+OKIpw34Jeh6xxVYUvepRHQCSfBvwcXs13QgULdwRd8lTQ
         MojTUJi7kUvS6Gn1CGvoFBL+lHnpuZcVpE5+8BM9mlAqj9c6T3Ds0vXQmPZJFUybzd/t
         Sg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742798582; x=1743403382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avYKSEMp5uulDA5FmpuH+JjdUIqqwn+PXiLercSA2Oo=;
        b=XaOUUfWjnCI/EpIqkrtHarUWO4DMeWw9jrY3R1IbXWJnX3lFv/M9x0TbncRNt2aso6
         ZBaxGgOxN/QezWwx728w1pdahKsWVJe4Tt+DoPI98VrZ6qRHFjNcvYSuk8FVLouJZeYN
         55F/4HND9/tHJtDJqG0rBySu8o6Jl7VjuKnogF7fPf7TuPpOfHbBd47do0Bpwaa6r6He
         8gkmTvanvX4D8Tf1FUbqKsOF0099SjND1RFezbvxVBo/Oj2n/cjSCbjMaM/StA0OY65c
         c5RrAFp4hDQlHwIFuD5IS/dcJWMnn2Jx3dLSTwD3086NGKStq8FkQolaNg/n7/u4ZDK/
         eGsA==
X-Forwarded-Encrypted: i=1; AJvYcCUul8xn7Msgw0K0sQgqa+XIT4a86+XROZJ0XAVrF2RGEmjyMsCN0pbGroOZOPL6GQuTkLhrlZGYrN/Lcihw0QH9@vger.kernel.org, AJvYcCV74SMBLzoD/rPY5384JCqIvNgdcKy8M1agzpro3iD/lzvQDy6SnN3XKUO20wqShDROlh0=@vger.kernel.org, AJvYcCXLmfMbZcbNvOS3InK6IiK2yDIVCZrV2E2Vb9eRm6f8BTget26BE+VFze+4yj5mJgiiFiLka8+Wg6NkGnmr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf5i2oiXpoMB8zItXI3casRiD2ZNyKlwpLRE5ZNorMCGITb3S
	ot+YHpTAt9YBr8OvmX/IitqjZLjtcsoyS/u3byE+wgmAGZGdaqnq
X-Gm-Gg: ASbGncuoDduq9Z4Mq9YoAo8NYXlMvIghTiv0qK1hvjfzqyEvMjfSp2iL0Z3wOMV6uQE
	2CgFXIajoCjdnaaESYQsoXAJQEX3HCDqPuWtN2vwOuH1i7N/YlObXNvEt8NMJHJpQdPYW/p1TXS
	DnjFgjE2RGFzz5i4FrdWd10Beng8Jrpu4V8MC9p15uhxiv/DcHROhnKuiXXMrInmeP/0l4nF48b
	Q2TYg7RcHSsIPNL4U9USPio1qYOHJpy8z8oPJZUHN5eobRNnvGN5UHRAwG1Pve8WvyCAXjB+Da6
	rWACHH2F+2RWTSJe/HtwvxTzetNb/ouPG/zeQzdbL+2Crflb9Ifb4xgQqDPg+Fb2dQRdnd9XNC0
	Yp4Y1ZJq1uB+cVxpQ
X-Google-Smtp-Source: AGHT+IF8+4TJLgp83Qv06VrPfp1uuCsQfmW4YhBkKQOtqN0lGp4bA4yreyx8j4WAUkjKsDzxKe89uw==
X-Received: by 2002:a17:902:ec87:b0:223:52fc:a15a with SMTP id d9443c01a7336-22780e09691mr157125175ad.33.1742798582038;
        Sun, 23 Mar 2025 23:43:02 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f459aasm62693845ad.76.2025.03.23.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 23:43:01 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: malayarout91@gmail.com
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Geliang Tang <geliang@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Mon, 24 Mar 2025 12:12:14 +0530
Message-ID: <20250324064234.853591-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <malayarout91@gmail.com>
References: <malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static Analyis for bench_htab_mem.c with cppcheck:error
tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
error: Resource leak: fd [resourceLeak]
tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
error: Resource leak: tc [resourceLeak]

fix the issue  by closing the file descriptor (fd & tc) when
read & fgets operation fails.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
 tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 926ee822143e..59746fd2c23a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	got = read(fd, buf, sizeof(buf) - 1);
 	if (got <= 0) {
 		*value = 0;
+		close(fd);
 		return;
 	}
 	buf[got] = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..10a0ab954b8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		pclose(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


