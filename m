Return-Path: <linux-kselftest+bounces-11357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD69003FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F10728691E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38947194C7A;
	Fri,  7 Jun 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBXbP/8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C69194C79;
	Fri,  7 Jun 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764233; cv=none; b=GXQ02uhYaVCP7Uxj8AEquHg2pby396VbhJElUsrapNACc0vywoNWxENmTYQE/txxmYoCOg2IcVIldeEDWarBDoJo8NSDd8KBvkw5y1PGcFDtlcQvGcHf3ZiqnM8izeVMFw0BxQUWpA8soe/6LG7DadyqFz0IbvN+G9q4XZ8iUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764233; c=relaxed/simple;
	bh=j3w/ni9Jw+0Zb1i6F1YNKNqk564S+z3NvBQg0BntwpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxc0vt1RVg2wWa/zLvwQjyQUnl0VO1hPh598Z6zUjTcVRSpEiVRT0a0Z4iKDC8f2wmFOOXESBK0nw5I9iH+miXbJFlu6qmzLVzW1t+rhNtND1y8bTCegXf/7BdnJkInOTf/ESSf/Kn8hUzJj/7i4gx7QMd6AeTzMujIx/2H4LGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBXbP/8G; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68f1017170so267653166b.0;
        Fri, 07 Jun 2024 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717764230; x=1718369030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqr6wxYjthYbe8z3Y72AT67fpFXeoF21mZn5dlCDZuo=;
        b=QBXbP/8G6bSjD0Nftz5TpglMAiZtI2fLnmURGTC1EPa/LbBa/AB2eDsZ9EUR6+3C3h
         rwmeAnjuil3jWfptXM6tKHCwVNUqQ93v8VPaSdPgTlvUk016G44bOjG9vmXqlu+nOV5f
         bXWaLx5MhD5OkdlUYlwGHOqXzfFQQ+a0jIFOfRYJ/ept871jXp1OGyiEUpo69YBPj+8a
         h0JPPYOMhyvX3UeIbQhXnGOZOKhaWvHq1yel2vQH6G8maqta+I5xQUZM/JlNlLCWdHPP
         kYwi/ZvQTX+N20wdZPeiNY9JiicNUGe/3ZSMsaiJkFsotoisxRrcLd0Yc5AFvPX908/c
         tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717764230; x=1718369030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqr6wxYjthYbe8z3Y72AT67fpFXeoF21mZn5dlCDZuo=;
        b=BWGasY7LjqLjo82DS83WmyS8r3TZfhDBBNS4HasTWijfJS7qUX9HhsFCn9roDC8HZS
         TS8t3ieifSvoXFrdy/QZ8XmdKBwou4qHNE/zyRhK7c6fuq/YHthmtsy8HR8t4kWKqDU+
         f62cg/s2SAF41w7w+gbVRwnc3LIJXp44/90v4dVJUvaHAzWPgRWai3q0BRzKAWC/w1hF
         KlJv4MgdpM/sJccBHH2ckHwiNhZKAXYmI4VmbzyOpPPJE881rSMPZe9ju21+eOn9B6tc
         c3swvum1OsGaEEhnp9rPD6RwC44U+gxWQNv3Z1BFKmxih3MXqgUU0cgGEoXsqiC0hetr
         dS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXMrDZr/1uVN8RAhlSFxDeKcdavj8Lo5yufkddLCJIBNoiXPGbbwgzFZcRFSREbHUD3pnNi3Ejvt8qtscGvzpNC458ikenrzujwnqvEL+RppUy2t73jhXeUTQlbmgha1xegGGfmP7lYqqpv0JxD
X-Gm-Message-State: AOJu0YzlsCECu7qPfEioXwUn+SjS5ofbuTPnopTnrpJ2qEzRSztV5iEm
	YimSVN3R2EO9kwOk+Dvix8mj5ZzcvmaLyTD26HayxuoSwCPORi69
X-Google-Smtp-Source: AGHT+IGF1/x2yppR+jvEH+1/c1CLCVZQXSrcGQ0ukLkdI4oWviMDeiZ3fkmV/ttUCDqo6f3p8mc08A==
X-Received: by 2002:a17:907:bb89:b0:a6a:1429:eac6 with SMTP id a640c23a62f3a-a6cd665cc14mr138542166b.17.1717764229663;
        Fri, 07 Jun 2024 05:43:49 -0700 (PDT)
Received: from xps-15.. ([91.90.123.30])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6c805d1eaesm239457366b.89.2024.06.07.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:43:49 -0700 (PDT)
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
Subject: [PATCH v2] selftests: seccomp: fix format-zero-length warnings
Date: Fri,  7 Jun 2024 14:41:18 +0200
Message-ID: <20240607124117.66769-2-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
References: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix the following errors by removing empty print statements:
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
Changes v1 -> v2:
removed empty print statements
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..6fe34be6c693 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -194,14 +194,11 @@ int main(int argc, char *argv[])
 	ksft_set_plan(7);
 
 	ksft_print_msg("Running on:\n");
-	ksft_print_msg("");
 	system("uname -a");
 
 	ksft_print_msg("Current BPF sysctl settings:\n");
 	/* Avoid using "sysctl" which may not be installed. */
-	ksft_print_msg("");
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
-	ksft_print_msg("");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
 	affinity();
-- 
2.43.0


