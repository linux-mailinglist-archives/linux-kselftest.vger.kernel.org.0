Return-Path: <linux-kselftest+bounces-11106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A88D81B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365B5B2111B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29086AFE;
	Mon,  3 Jun 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIApz2ST"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C886AE9;
	Mon,  3 Jun 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415806; cv=none; b=A6cfqExfiKU3tRC4WVeceLV11A6edBdfjiCnRWiU0PzKEeHLeIPypCOkdeYcVtOEgxQBuiY8+bLnaxD4e6Umq5QDWOnPqQ4gq2Qz+28k4blUrQRrqv9gloOjU7SMngQ6bCZ15a8dwjguynPG1shH/bcxEonaVie21qDC3IDs1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415806; c=relaxed/simple;
	bh=QKTql34O8lDaqYmigvPLMWgqpx5wUV6YZyBk/TNIcmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+sPyG2rREkeJOOavSBhRuOe11LdFK8VqGqo75iyPa78Y+FVAPW66L7a5IXtuDpraGiXwNgUErURXJFcD7b53MIas0gD+uSA1KALMIjl+uiBqyPECi61XaPU3WtWzzqYPnqmJdethuvdh+rXhl4YWnNpnL6mfBtk+GdeDkxys84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIApz2ST; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaaa6so558099566b.2;
        Mon, 03 Jun 2024 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717415803; x=1718020603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HArPik3I7izu+6WonMf03QX2STUValM6DQn6IUu4hhc=;
        b=RIApz2STa+9paTWsNVbMjOckujyMuiSRv1NC34V4NYDUJ5JxjP3VhRzLdUbBkF6pTm
         lIxiQCa7cUUv5rhynexUCtWkiZVdAQ+95dnQABiJNNApP0X4iJ8XCX3lL5hh+pAJkr8R
         NhwBV7g70ETcj81MQdO/HrkVWyi183Pg+QlJqEF5kZC3Vp0WMGrVqPaQ3axftcx0kpGB
         LiMkaCNyyEN84T9f/FNqTC4WwWMBaZOKzJGCTlJo+OnD/Sk2NNQpMtdEt4kGYKy1V2j5
         7cSMfpgKxiI22m7D2knsjnCIsH3rMuIp/SaK6FxPvoSHIWY/uB/HYS6QQKxoj8P+RsGI
         GlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717415803; x=1718020603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HArPik3I7izu+6WonMf03QX2STUValM6DQn6IUu4hhc=;
        b=IxQB3SEenqQamvJSWywRBnKf2ZljA/BEhg9drqwlkQHeFUEQHqhklfX5bczzUG2BVA
         qx/wBYEt8WAxAqXR3cpptfksLHUpkGj60WxZ8A/eGI75tHBAFTXMIK8dAHlmNwD460EU
         GzN4sAs705mFQmLT/9m+cTmdJNxhVXJ1TQDNdOfha+gzULFTvWB+i+vfiiBwy+j8VLR0
         KTzgqeGX0ZXA9qXP13axoj9maj3LuIlfp/molMgUcgDUdObjMrfOjNfO51g+DtjjW2Rc
         lIx/WV3+wAGw6g7oi/SNxdaIuEqqEJQ0FRwO5H4P6IylQpP2wTCAa8luQSmQ3jMIlf+K
         IMBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0yODtfH6MjySmVL8ioRAIYtvTXNNeGOhj/QYP7EciLFPFQqG6i8Xn/Vl0ow7BpJ8tPkG18LTvW6xFmw19ge2BfeliqH8VNRy+IoVUfexNyaZRisBfdHA/i9UAHD/xAS0QWzbmInxzJI9uFZDk
X-Gm-Message-State: AOJu0YxdXMQVb+cMsmlxR2ZT+zTvv0S439Yn4hCzpZUo7QqcBNnKW18J
	I5jnBvVkS0uKMxClyUj/lYvVVxpP3099/me+5nGqtn65kueaa7Nb
X-Google-Smtp-Source: AGHT+IFk7AEDri/ImBDfMcpzA1gWV5IU3IKVTQAHuPklUwTdt3eUF3d+bPT7BRbEYly1JFmJtscrPA==
X-Received: by 2002:a17:906:1dcc:b0:a55:b272:ea02 with SMTP id a640c23a62f3a-a682244a89amr660656166b.75.1717415803420;
        Mon, 03 Jun 2024 04:56:43 -0700 (PDT)
Received: from xps-15.. ([91.90.123.30])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a68f39b9294sm229634166b.180.2024.06.03.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:56:42 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Amer Al Shanawany <amer.shanawany@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests: seccomp: fix format-zero-length warnings
Date: Mon,  3 Jun 2024 13:54:47 +0200
Message-ID: <20240603115447.30279-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
 string [-Wformat-zero-length]
  197 |         ksft_print_msg("");
      |                        ^~
seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
 string [-Wformat-zero-length]
  202 |         ksft_print_msg("");
      |                        ^~
seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
 string [-Wformat-zero-length]
  204 |         ksft_print_msg("");
      |                        ^~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..ed04b89de9c6 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -194,14 +194,14 @@ int main(int argc, char *argv[])
 	ksft_set_plan(7);
 
 	ksft_print_msg("Running on:\n");
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("uname -a");
 
 	ksft_print_msg("Current BPF sysctl settings:\n");
 	/* Avoid using "sysctl" which may not be installed. */
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
 	affinity();
-- 
2.43.0


