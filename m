Return-Path: <linux-kselftest+bounces-11684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A207F903FD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB7282D99
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5D18E1E;
	Tue, 11 Jun 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgLvUuAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79922331;
	Tue, 11 Jun 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119040; cv=none; b=gfD/+1C1sYnRPe++K9MgGLVMtclTsJHK+cHPXPIgpbz9ZMiKP3Et8lfZws7zZZCgIGAc/r3/+WvhlhL38X7o7BULUsrJnoyPqtFiXhLni6UtikFUSGMUpwW48CuyM+o7NYYtue/zM/vpOa4l7lGYcFjatH8RK1idDFmCq174H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119040; c=relaxed/simple;
	bh=hBDZsMo7XS37/WDuKhGZamh2Y8ndhFFxERQL6K36UXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ha87SV/ZfCqiWtypmJH7HzFKt7hKUVqhUbmCLZXO1UzeO1qHjHBI3qXEHbx28jTrpMOB+gRQ6m6Eqgu86f1canxrnQXixbXLsyj3W4JFc8zo0lzMZT/2arhcjolEA4KVvfjH/LYvIl+OM7X+u1jhmn57D5jsX3zrBnnhlb8nt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgLvUuAW; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-375932c94f0so5991305ab.0;
        Tue, 11 Jun 2024 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718119038; x=1718723838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm8XxZQUI/HGBg0dmgtwj323sJEbBxn99UO8Ys/CJ9E=;
        b=VgLvUuAW3hoQynsupjdqD9j89X5YIcLvcrikcLl80qOqooqgXbgTzy7CSga3IyBtkC
         Y79USyklvNidMOO9BFmQiWdwkHA8pfIwcqQWVSkYykLQSwIMo9KcLlLk1HEQNmzTWNOg
         1pySgk+L6LXcBTURG4tTB4O3UVpqzYlwnPavahwcgbD0VgcX4hS5bBV1TWfGAPoC5qLU
         KinXhly2Da9cudCl4gAtKMDH3wTKZaGkKgIfB/QFf7uR1knJsYqk5JQd+DQYZ7HpxrDU
         73Ak8ouahfVb4aU0bIBncED/8mUylAGCcqJJ5blnCJ7Kf/3GBN/YD7GTXg2dxL/oQDgm
         wlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119038; x=1718723838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm8XxZQUI/HGBg0dmgtwj323sJEbBxn99UO8Ys/CJ9E=;
        b=jqxcJARRl/+2dEPCTBDscAsQfzqZBv+qHMqB5DYEF2rvy5kRmvMMgsRJzDCSGe1ol8
         SNBO69zPakYnsSOfBFnkRoVXOuY58HDn4qkfWdcgndyRk8A8mM4+kLZu+O8+mUvdSLTs
         DyUrtgJsZgRUaNce/7Z3V21da7iNfxeMCEWMgbj5cK5BIlrZ7D3UG1g5sWt8VT9KR/8x
         uZyBWmtMmaownRQZEBe5tUTyykyD4DFf+sPfwRpLYYBMHTjKqWsFtvC+qEYmwdspOHNB
         uBfjz4rlmkoRi1S5eB4fh1SS37DgbZVOuBClK9yhQoLXQbe7B67iaTfX66FCUB79nMcC
         mnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuc4YAnpap3saxLecuCxYoyMm49Kj9QigNRjqfyXFA/dhcgamQPo3pdU49k70XMUl6clbObryT70L8lKfX4Nv+Dqdk8bZSSGTxUWl+FjyvmVBqyYppt2Hj49MSjRqoxBSOm9jIndD1UUbGqyK
X-Gm-Message-State: AOJu0YyQKL5HIwlGboqclLaHDfgnyHiDnsz7xkAACZh+RxzhKiiAMVEI
	tx5Hoviol075duR6VSGb1HiWcZoaLmKGQZfqDLtFbcvKKR2F4HHj
X-Google-Smtp-Source: AGHT+IExm5GtDuYDkONfdjBbLVN8LHjWknlg7VwmafjrbNWIyXPsbRtYVK9WGAtqfWsQ86KMykmh4w==
X-Received: by 2002:a05:6e02:2169:b0:375:a535:f7c7 with SMTP id e9e14a558f8ab-375a535fbdemr67209805ab.0.1718119037631;
        Tue, 11 Jun 2024 08:17:17 -0700 (PDT)
Received: from xps-15.. ([91.90.123.30])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4b7cbacb0d1sm2001416173.4.2024.06.11.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:17:17 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Amer Al Shanawany <amer.shanawany@gmail.com>
Subject: [PATCH v3] selftests: seccomp: fix format-zero-length warnings
Date: Tue, 11 Jun 2024 17:16:08 +0200
Message-ID: <20240611151638.5767-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <43e24489-a3af-4e53-afc6-ff1dd9462ee2@linuxfoundation.org>
References: <43e24489-a3af-4e53-afc6-ff1dd9462ee2@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix the following errors by using string format specifier and an empty
parameter:

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
Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
v1 -> v2: removed empty print statements
v2 -> v3: used Kees's suggestion
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..94886c82ae60 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -194,14 +194,14 @@ int main(int argc, char *argv[])
 	ksft_set_plan(7);
 
 	ksft_print_msg("Running on:\n");
-	ksft_print_msg("");
+	ksft_print_msg("%s", "");
 	system("uname -a");
 
 	ksft_print_msg("Current BPF sysctl settings:\n");
 	/* Avoid using "sysctl" which may not be installed. */
-	ksft_print_msg("");
+	ksft_print_msg("%s", "");
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
-	ksft_print_msg("");
+	ksft_print_msg("%s", "");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
 	affinity();
-- 
2.43.0


