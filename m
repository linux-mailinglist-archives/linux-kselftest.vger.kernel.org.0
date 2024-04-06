Return-Path: <linux-kselftest+bounces-7324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD4D89AA22
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 11:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59FFB233F3
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94E36B09;
	Sat,  6 Apr 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dOmJwRE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D421383B2
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395222; cv=none; b=TX/BJhxLDHOAEnjLHtkxF+4CIU+9ZBmCaQowCAYYozZR2oiKCpvACHfPVVJjE9NWer+Ldf/hPsgkRMWxG5hboZhqIWkjWlqRrZ5NOTintjBPaiNxcULk13OnwxV8D4CafSgxTlz7ma7125KORfIj1/Mcqiq5lnq31lhCZZGM7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395222; c=relaxed/simple;
	bh=yt9tmTIBJzVdCFZ4PnU57SVH6MzeinR1L4YoDUXNjsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gd4/YBWKOE0tn9KWR1+wqueKRDEfs5Wx5pKaYs3DofkDaYaHdgEmNKA40uMfAsn+LS1dZCJVaMBBCxJvRzIXJNkF/Ud1EdqHD7RjLv8vnITSN7T6mr0vScmnPFYwSSO4VAoZKyPSb3+R4TLfEKzPWzvjFQqFcde4YKmL61tgl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dOmJwRE8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61B2B42495
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395216;
	bh=G6LgQlJD57yHhfXydvKzs8A9bUpRZ0ooDJmyE1zvH0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=dOmJwRE8oTUeXFiopPdOZhTIHljrEg1oNa6fQNSMzZh6tAzjyoAozBGY9xAPb1ZVs
	 WdSHX3/8v9LKdS8sY05r+nyM4A4/cdYp4/30cmpsCgueAeY6vt5GKx8A/vplF3yxGs
	 KbTV/CNFegIF5LT9jhQgEyFOdElabj2P+LUJgIUrRC64AFuTmzgtrQDqqOhbxdb/XI
	 kTc5qrLPqjF38jkMXhWpv66GfIkwQc1/cAM5rWfPMGdOqYMfvygsu1Ocmg8UXQ1p22
	 hkrhRMW2Pl5IWtj0oCxxIvxexWuoTIv0WXUzFDVofbSX6qhB3W51RyfNFpn6uea0R4
	 QC8nFzUYu4MUA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c94d98afso26915171fa.3
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395214; x=1713000014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6LgQlJD57yHhfXydvKzs8A9bUpRZ0ooDJmyE1zvH0s=;
        b=dYpldi7AscDMrQBuMMob0Tql+LjvAkEh32FEr9yrLPCNYszgtcd1GG5aKl8wGwg0Hz
         dEohg5aA1nt1lQbiWqw0ly6SbM/wCBPG724XhzN4sqICArU+2InZwRxONTEiTGkSCuJA
         VF6okdLj1DW9pyLpP1QyUXCJ6RKjJfO2QhByf8DhQMLQOEgqKPx1ZPwc92UKEpTvXhTi
         puQ65haFCWzml2hGs1ZPxqwiCIlbGefbvHuargDVHVqYtwouK64HKsrXahw3pdyZrOxX
         PwoQKVE45X0EIFSRIG4O4z0DM5dSRlabXeXPQxZ/ycC24glZOLm2QumGbF9jXVuY8+rB
         L74A==
X-Forwarded-Encrypted: i=1; AJvYcCWMjgGxy/8VC23Q6YIMVL+PwkTt78cmUvzubcZmDwNItHNReE2nA1QvW6EgFjHRReDQkz13MqyVBwfN7J+k/hkq59t7D+u+Xp3xw2p2W1os
X-Gm-Message-State: AOJu0YwxpMVpqAQenYBPVkeymDbAxfHvJURhUKsBdV6eeLUkfOawXkAB
	Dt37go4prw8+Bx8Zdizl3o9aBLNKoF2klcN5RV9nmCWRDVyAKlBoZ/gJQu50mbY6XLSPY2HjcdC
	ckpdgSFLgiVbPGyqLdbNY3nXaTCEkBV/NIrFWYW6q9NlgQtpS6qyHAJD93OczIBnQPA/+QxHr2Y
	hTRTt7QQ==
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id s25-20020a2e98d9000000b002d6d35178aemr3079660ljj.29.1712395214347;
        Sat, 06 Apr 2024 02:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC5CR3YqSgu+J4/e2RoJd1lpNEBaMZEgCrY3TxjTsm1+4G8Z80bdHexcZXeNzlB0Tjro1Qiw==
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id s25-20020a2e98d9000000b002d6d35178aemr3079628ljj.29.1712395213639;
        Sat, 06 Apr 2024 02:20:13 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:13 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] libbpf: Start v1.5 development cycle
Date: Sat,  6 Apr 2024 11:15:41 +0200
Message-ID: <20240406092005.92399-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump libbpf.map to v1.5.0 to start a new libbpf version cycle.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..5dd81a7b96b5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,3 +416,6 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
+
+LIBBPF_1.5.0 {
+} LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index e783a47da815..d6e5eff967cb 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 4
+#define LIBBPF_MINOR_VERSION 5
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.43.0


