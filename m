Return-Path: <linux-kselftest+bounces-17222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9996D855
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A169428C3A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90019F471;
	Thu,  5 Sep 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLE2Cgt5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0E19E819;
	Thu,  5 Sep 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538841; cv=none; b=C3iVF9O/vMrSMXdgJ16l8tn45p01zmGU1abC5UwPKYUd+dB0jgo+3hGXhHMYqF0t1EerC86yT/5kT6/G/j3QvAuXTcecoXPHBbjWYfo+Jhx1a83wfYTOFrC4h5SJ6aVexRXgUx+emXvbUnzrEsEDfTZ+8Zo2NQAXgAZ8r7M5IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538841; c=relaxed/simple;
	bh=lTBimKBaGs1ZkBL0WNg4qnL25GeofL7qynlulrl3LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHZs+ye9/eSwD+vLoY1HvSWlQCueRSUxYGvtgur92lW4aXcdcOCYBNWggvT112lNHNWNHYT8QbTLGB6Y9tzKVlIQP7Zrf+9K0h8GarjWsIPzpucrWrvLoapaJXfdlmtbggSrCVKvv+gv1rGJV05rf+MYefpzXKbj36/xRo57wNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLE2Cgt5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso7218615e9.1;
        Thu, 05 Sep 2024 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538838; x=1726143638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrbcAlTnlmTabJ3YUIAlxnWUZ+5STpJgWmlTb5FWPhs=;
        b=XLE2Cgt51WzkoQ6SALorCh1ECgly/zbQyyJsql4NhZBafdNmj17ecb2ARBT6z2PgF3
         UlYrA+Q3YmECIPkxwowDBn+IdaIQSjBC7U1QSIpQ8m/LuCADJts6uLfEeWffsY6n6mnU
         ijR/UQlT2HHfOwcipVUYjrhADtD7NREmgMsw2Ehuf3tx6GhELptwD2MSWhLxn4+uKYhz
         JUBiuU/Fx3IVYrVZKy/ygcyk1QZd3IDBxddyt7lWC8dAnNtCvGpJjmvFHGvsBltIP0nG
         4NRH0kAgy6yGTvoOCZwpLfsf6/T0eb7bwFOg56yD3qxclaD6n/8lkWN8Ry8gfL1TqPWH
         Hpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538838; x=1726143638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrbcAlTnlmTabJ3YUIAlxnWUZ+5STpJgWmlTb5FWPhs=;
        b=KcISPpfMmngTgTMF6UEOlFw+2tT01MQ9N86kYfWNGvsXgohrNoaM/EZEM9Bp3O/UdP
         pgJnuOuAvqO8EPtAG1Hr6ixe5/wlm3XJKTdpPoWgi6yG89ze6QvP6HBnad6wDNmKttZz
         LtPrnMzoXnDX5a8ShotN88+RH9ChAl9sbJUmVvijsnTDxC72+henHIqN4j4PkW4Fxm2I
         ciBeneN9/1pZsjYv5XhAMLf9fKdH7OcAtr+2DWNgHWluq1P+Yct4V3j2o2dyGNW93XVq
         Anci78N46hxnONqGljq74y6XhE6xzc1NBptn/TNdbLNYnyASkfRkdNeqpT1U1B4zdikn
         O9+g==
X-Forwarded-Encrypted: i=1; AJvYcCXXFxPBNwaoHMffGuSQ0MFQlxQDpRzDgr2j4FbpqPmBWM9FF/4tDzZXmYRvtGoVgWQajQrIDSqvdZYwbFitULA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfByUuoDxy4/4aWCvdV9sErrqSgXoCQQ8bOcZjtM//mWeGRU+
	QRXTdprp8ns8DbDomBFRZlfiHWjw7nRMzwkMgc144yEl7jdlqTWEX3E5PmD1UIg=
X-Google-Smtp-Source: AGHT+IH1y62oVq3A7PoH6CYDdpSm5g4nRO5BNyX08uLqwzy6RI+6Cp/eKFKScAI+HQtlogwERfmxew==
X-Received: by 2002:a05:600c:1c8a:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-42c9a365902mr20646915e9.13.1725538838425;
        Thu, 05 Sep 2024 05:20:38 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:37 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH 10/18] kunit: string-stream-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:18 +0200
Message-ID: <20240905122020.872466-11-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
---
 lib/kunit/string-stream-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 7511442ea98f..7734e33156f9 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -9,6 +9,7 @@
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/ktime.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-- 
2.46.0


