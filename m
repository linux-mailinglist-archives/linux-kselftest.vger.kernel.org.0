Return-Path: <linux-kselftest+bounces-37033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC35B00B94
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A43B779F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A12FCFF4;
	Thu, 10 Jul 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5qkPhzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DB2FCFE1;
	Thu, 10 Jul 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173114; cv=none; b=a9CbMMqMZzy5xh522wH376JOaBo2j1b5LBVnFI+zwaWj4IZHiaK2M/TeSYqYcD6ZcRYvAwOfbzKRUNPLTav8QCdfkSfmFyhElYs1ssb226+JOipn9K/m1w76j0FKWYK1Qwib/s0D2LCF0lsKdLqz6ydPHmMdOcbgsmdDJik2x/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173114; c=relaxed/simple;
	bh=1gZpUDwTSy0yw4iTCi2xeacRJBhw0u5mnJO2WFSvX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ0aTwiK58VAkngNbwtYr4jes7LN0VAlHMvFrP0gMBtwr7OyJPbKlfba1g7gHFKNnFvnC5ZHGr2PCcEFjowxglIgio1ZXm4kObqG1Hz2aZtqNNGNqvNz+89J/QUu0LBxpbmRpAZ3AXtD86ocgYEbfQbva5tPf/Wwpw0NjPkKP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5qkPhzI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453749aef9eso5109535e9.3;
        Thu, 10 Jul 2025 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173110; x=1752777910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI/CdLAUZ4D6ZFVUjUJXlmHQhesmh8grM2Oun3Io+fA=;
        b=P5qkPhzIT/KXIW8epEP4lt4ZA4rLz5+d/KB7vBocVP1a1a5hV/MWCTLoiPeFzvddT/
         9fxmCxJDbUN6tUlIXIUN0+wG5kKL3TShO60+MTWNK2+/MM9v3y4J5P5qKMs1yrMnxK9s
         1s9c4teiBxwQUy1QMmwJqzkBoS3+AaQU3fqUKnnRVxHVVvqqv+BDvCp6p0IcXAbP9p9k
         hdTwceNGM0vJ5X7sI5RblxeWlU5mA/k/O32FzkW+h+ePSBODlm4STc1+f0tlVwDk4a7a
         WgpF7u+8zg/FSy+T1J38na9TYAvg7YeTdLJOIUU9CII33F9iL8Efhi/ZgB2nbheF3j/Z
         1gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173110; x=1752777910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI/CdLAUZ4D6ZFVUjUJXlmHQhesmh8grM2Oun3Io+fA=;
        b=mF381zuIjZQ6o1sxIQ3uhLumJcwVhQBF/2UO+6Y9lQnso7uaSxQ0OwNxfDElAY/dKs
         tmKcPGgl9DbOTqQCh1LpfplEO/5nBBA9ioXuxeBfsGKrsdBuzpWjXyKtwaOd02lTWlqI
         2A3sd1HyqMzJapvEvsOLeKHaBQ0eO6xbuJanymaxtqdB5LpWfHum3WqanH8akHa9SRxH
         lpSOODuUka4RpBg2dc72WdkB+8T8bv+opziw+H2Azgo4O8mgus4K1ae8oanu6/uYDmjX
         F6Aa6A34DkURpNmyuOfSiHZD0itE57Yfe3H2VEd+I44TGQBhG6v2J0gRb/6KFbDDVZHH
         LPAw==
X-Forwarded-Encrypted: i=1; AJvYcCVUA/z4RCw92wft3cOJ4WtUaGQYhfN2bgee00cf3A/jTIgdAdGJ6tmbMvpl8k20jTxuTBH3PrMsmxT7R8BfOOuW@vger.kernel.org, AJvYcCXtnZ2IzYd+0elAY9HkaRLo7F1WxnxxS+x2c7/g69ipglb21FsppX6BDL7gVovkxLStync=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmgiEKCR1QYEL1IUoW73QVj0yX6sLmKjU/ukJa5iygV691fiK
	gbk7jBHqLersrQwu+Czmn/w0uERu9AHzmfMQhsP6A7vR3/U9Gex8MJHP5DuNe4Za
X-Gm-Gg: ASbGncuqM+JyxqaAUA80CqvgljK2bEsCUtOjhY75Pj3HhotiJAr8mMh3xhBQLzvmIDt
	ZdYJyOtl24KLjhlnnwRQDYlIX1J/cJjUKv3lQjQzNGSoyT5dlBv3FsGuNVlRJakVKqaWfWv0Dfu
	anZZ9tX6icuLAX90ns34HsFeSubv45fh5cbPQWQUpQw5J37WqO1bz5oTUqPz0Xras/Dm7uaRV9l
	BuZpzalJaTLwbosGD/9B8/IHXPRvQ1PpWhlEZh+ZSzIgknvXCeDkuJza9Euu4a4RwYwlFn80X50
	a8sJDaw3/Z8Dwth0+xMYn5fbofBtXI07Mvn/v8CHsWs4Ney4f4mzYUPojkdO
X-Google-Smtp-Source: AGHT+IGB4T2HgJ9H9ExzpNYlriCZp/aYASowinUrBAvEmZWc7wj564V55ekUmL4uhxoeQIWQyQgSOw==
X-Received: by 2002:a05:600c:1c9e:b0:44a:b793:9e4f with SMTP id 5b1f17b1804b1-454db8681d0mr48745055e9.19.1752173110272;
        Thu, 10 Jul 2025 11:45:10 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537d07sm26854885e9.25.2025.07.10.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:45:09 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/5] selftests: drv-net: Add bpftool util
Date: Thu, 10 Jul 2025 11:43:47 -0700
Message-ID: <20250710184351.63797-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710184351.63797-1-mohsin.bashr@gmail.com>
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf utility to simplify the use of bpftool for XDP tests included in
this series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 2 +-
 tools/testing/selftests/net/lib/py/utils.py            | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index fce5d9218f1d..39968bc3df43 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,7 +15,7 @@ try:
         NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen
+        rand_port, tool, wait_port_listen, bpftool
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 34470d65d871..acf0e2c38614 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -175,6 +175,10 @@ def tool(name, args, json=None, ns=None, host=None):
     return cmd_obj
 
 
+def bpftool(args, json=None, ns=None, host=None):
+    return tool('bpftool', args, json=json, ns=ns, host=host)
+
+
 def ip(args, json=None, ns=None, host=None):
     if ns:
         args = f'-netns {ns} ' + args
-- 
2.47.1


