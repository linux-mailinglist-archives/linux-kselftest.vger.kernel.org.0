Return-Path: <linux-kselftest+bounces-29794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F4A70CC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96982175721
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F6826A0EC;
	Tue, 25 Mar 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fJDYVBx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71126A086
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941212; cv=none; b=YUkEETHewjurTlnrNzc0WhjhY6GWSEHmmvQVgcK4+O3mc020OYuUgud9E3PqGkz9OozzxJPGnptBQGxJXnDGpVErL3AR124RC5PcPRQUZWtRAijBwwS994TXXY6OQ1t6UDxylFYxSSOZ+yBzOtnbcR2vHUvP+GcAZjIVPIeVpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941212; c=relaxed/simple;
	bh=iUUuXJBiCpZ2KY7Vcl/FqmY4eqvXt95bbU3djV7Lkxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKYO3CNjLeT2mrl8Mjztt1Wd7ZDX2pEfruAwegPPc9ZLaeYIaiaEjnm4cpxU7hXCQFAYkp/asDwnttEPss2mZKcNis9mlbHpZeN5Y2duVDMqQQhPG+ikqojWWKJYG3ojpPgfIKWaxeGCE1WbTXkOSc3yerOQJSF0q0wZg9mrQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fJDYVBx/; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso22068236d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941209; x=1743546009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPFNc5Esbl1AnvK1mUxwxpu3e5PtuYoRUmJc1JKQ2Hg=;
        b=fJDYVBx/mrlK2PuUCUMmRBfN41b6b+r+EJNqKI2yLLMM4kcsW/44O4lBN8UMuF8q9i
         66boKvu/zsn1raXFLh2SaZ4bd3ulNGL9Xq6Qo3dtPLPKp8ci9TS2PmvANGqH5NX0Fhxw
         RM48bmygCfGfY50BWezm0LewX3gTqWyweLBR5JJFzZAYL9D/p3dROUToXDcyIfZED4t4
         MoOEOvEbv+EucOC+8EOLSeqrqcP4n7tV79cvsBcuJw+HZ+E07d5lEUsafoIhuYf5G4Hv
         Yu+x3t2YXj3qAZrD+8TYGm+2Gcabp7pyE6HdleAW9E3pkrfQWfOlG8M44xgVSokGBlKs
         xeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941209; x=1743546009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPFNc5Esbl1AnvK1mUxwxpu3e5PtuYoRUmJc1JKQ2Hg=;
        b=Sd1judcJrX2nqR8wOBi0hH3tfrAzYb4h+l5KycqaPIK+sBnBJWaG72pBPKBNLceeJT
         YJnptydCrj7HMu1D+bKsy1NC+RyKiIQ6uGIsSMvgatu4uAAiN/LnqkYSMjEkiRqz+Qqm
         tlrNZGupXkLb7J6T2NHudihfVwUL7cAkXjFFaoPrTL5ZXOpNBfcxfTt8GEZ9u9wQte5L
         xtz2WejiH9lRexZxwXCtCMxWmuFv+Yx8GWzqwdMVKMfSfmxS1FplwwTiLWIArlQZ9DEv
         pWs4SmBihKmW1Ejyuew6Kwx7YcOmB4Fxb/DNnlWHp67hkQkh5KECa7CsOubAWtmXBXUF
         Jqmg==
X-Forwarded-Encrypted: i=1; AJvYcCXr8AthsH4AWZGLZPPrhLrA1mPFOhA9zo+A9oXlVmq9Op09TIWM8q58PGNPCWZ31iv3a8NQPwO443pdU8J3TeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEh6DCeflNr2ocjm1rNGZX1CxabBjEqLg+q8IdauefzcQtEwT
	4EiRhhNwo5hmcuRXTHgZYGcMGUmGbhGBR/cPMCWGe/5jLMIniyI6otodT/7Gz6p4/ER28+x3c2C
	3kpJVhuTIdnJm/kp3iST3gcsvDrm3EK0a
X-Gm-Gg: ASbGncvCMJ5bGNUWWn4HEARd6JOMBqRcwoLk75QnkZzlnRsNeUaSUoQMicMlr5Src55
	GQ2IAnyb2D/EPfJGl/wcAJSU8pky88eVvu3sjs+4tdhzTcDL64sV+UFKrkpwD1NNsEbEwVLC1zy
	/kc5fcyw1yBo5SACNetnFlptlaWTC/uPMXHhPWeK0XjD6km+ZwV49eVNMR5IWE48ClREu4tjvix
	8eVBoCb3OCq2Nbx2hj3/x1bWrCSe1wJpMEmWai4IrbDqBJJ/lGrcZW9Q1p1mrduDfJ6xLCivV47
	aRnQlL9QD/K1SLqEx9C1EKpN6jM0pJOH15iR38040QzKzoUhcQ==
X-Google-Smtp-Source: AGHT+IHb+86ayT2ygvfsudkk78BISqn0oik+3h9hOJYmO2qtUwGHON9JVTSnF7D/muprKkeWETyBc8or7kNj
X-Received: by 2002:a05:6214:124a:b0:6ea:d604:9e5b with SMTP id 6a1803df08f44-6eb3f27dbd6mr233467416d6.2.1742941209071;
        Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6ecf0aa8733sm3629376d6.8.2025.03.25.15.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5940B3404B9;
	Tue, 25 Mar 2025 16:20:07 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 417E0E40158; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:31 -0600
Subject: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

There are a couple of places in the kublk selftests ublk server which
use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
could easily require it to be set as a prerequisite for these selftests,
but since new applications should not be using the legacy opcodes, use
the ioctl-encoded opcodes everywhere in kublk.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 05147b53c3613a436e3a13848e146e0c66ca2525..b17eee643b2dbfd59903b61718afcbc21da91d97 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -99,7 +99,7 @@ static int __ublk_ctrl_cmd(struct ublk_dev *dev,
 static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_STOP_DEV,
+		.cmd_op	= UBLK_U_CMD_STOP_DEV,
 	};
 
 	return __ublk_ctrl_cmd(dev, &data);
@@ -169,7 +169,7 @@ static int ublk_ctrl_get_params(struct ublk_dev *dev,
 		struct ublk_params *params)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_GET_PARAMS,
+		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)params,
 		.len = sizeof(*params),

-- 
2.34.1


