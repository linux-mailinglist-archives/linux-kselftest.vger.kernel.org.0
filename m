Return-Path: <linux-kselftest+bounces-22864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB779E5488
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F085280AB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A16211708;
	Thu,  5 Dec 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKseGfJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBB33997;
	Thu,  5 Dec 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399380; cv=none; b=PnfO7ChCCGtS11nDXaZ3vbN5uCvpTULndOl7F3FQAsAu/JB9SZqX2XmG6njxqtW+Tamq7v56Cua8Cw+AuivO5+1+XiKIasgRC/Bppzrz/1dra7dB5tik7S/qIYJXQp5hKdexBB2BSlhZEg0Ot54LqrHlDryvX3GE3jyCF0CHFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399380; c=relaxed/simple;
	bh=ANoOfkEq9siRl1UYE3y6K707AQeoCp3gbZJa2JeC834=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYh/XJtyDpjmChvjQUsLY4/3jlcwv5gRXSTUG/sQhca03ce7ly68avaEBZ0xjfqB3MXKR8iiUm4uQp8imlooJvglYxD5o6DN6pJDwcA4kx/R9JxT/iqgUdebi2mdWl7eKkYEgkYbB2kMsYJpPJT2KuGqpcZik74xaBzkp0bYuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKseGfJe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215b45a40d8so6507775ad.1;
        Thu, 05 Dec 2024 03:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399378; x=1734004178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSb55hgaIF6sPbuy7Sr7FEE6i7EQgiEZMQZaE58gR1s=;
        b=dKseGfJeOXiouJtwUnCfdLSkD2ROrJv6+CeGPGFApFqYe+Har+Bk6C6s/l4cyihrrQ
         JjUe64JEYs6dZ+gVrH/rMWeu+U9WwsvBPw3bmB3AGYRZJqBEzqOtcRXiHhhtIThutSXn
         hlQFYDTfP527Vb8LIwDeA355qnAur6fqFcAvar3MOa2XpMju5DwO48SKxxF6I+pMOIhl
         g+bP46g9J9CGiZ9Q7OfVFOnJDJw3XxYJUNZQ2lIo8YNVXLaZIZiYcFVMOFH88RFqu0px
         X31uUqisq/sHq8d02wf8yM36r9QOf07QDtTHQHhjJxOiUAKhGIehfZAmUIJvRNWrfeo/
         ioUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399378; x=1734004178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSb55hgaIF6sPbuy7Sr7FEE6i7EQgiEZMQZaE58gR1s=;
        b=iheM0248sv88M5FuzWKiS0ZMkBtYN+jfbY/aSq2Zd+EGQF3HErZ1iQEsUs8brYOIM+
         QPEujxpooSopy7kCKLs+YWkg0oSaKzBn+Jftkh8B9aQbA/KANki1/8ZqSZNb3df88PWL
         fE6OCCJh/bgtcwJLljDC/kOcx8NOD2lHEo9ruOJYKtvgbOMrwnXvCFIcvlnRCmFa9xEV
         os06+VcTwqKoxdqjPceJDvyzZj+IZW5CTKmDy6rE8DOTpuwsl2YTVTADn5aLyQ2JrKMU
         4X3L85xeB+Xia76PsF9O7juWO+MfDz0XDz6JrCZ92ml1Dk2qtJ5ddRMM0oakdeEMtWx+
         zA8A==
X-Forwarded-Encrypted: i=1; AJvYcCVG6lS5HmApArq4fYq3ty40FD1ySVcc0TFTcTg6GHLsdN5VhUMV1OZEepEA31knrqCqTwKoadQ/0II=@vger.kernel.org, AJvYcCVLRZ+Gxub0R30dAHJQhRvgWTtJouWMcL5Pu8NmuGyJpaW0Mj9yogaVzo0k+8u5855W5uL2tPAkR984@vger.kernel.org, AJvYcCWMSJLhqcfnn55OQkDsx4lDvRv3bmdNeRpAK5NUeQLGfvmD+RGJ4HBWHexdqXxxfA1ZUQtKWWDOn9kzhEdvpUs0@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZENEOx2Uc08VkywEZ5UvTX8pSm6H/bvnMWULlg+FTSCkb73q
	BFrqSyrnlvNh4B2wQ8zOmfpdIpOFq/97AwapTPhP6uENNRdQOZj5
X-Gm-Gg: ASbGncu52K0DbP2cqJz3w4yETAciYJ/ZVX9paIdb0eDls6e8TEKjFBV6j9BFI4LlRwY
	2ya1GM5V9MWx24JV3gkNxc9sKjP9SuAz9lsaAPs7+Gb1lcx6saUQrrW697ECx9K9CCl4NShFS6T
	NDN9Cgw3wCjAV0sbnx+qutq8Arb+dB17CcDWCT/4bWXohCigbHWDj+rGDGcHDZx/O+XQ/D2tf5L
	OpjpgbuVVsvYR7PHlP1dEd79bzw5DPw/+Met08n+mJsjgYUhZGTMqtq1Jainh+yLXB/VLXOALM=
X-Google-Smtp-Source: AGHT+IFi3AxSklvusir1J2r+A5L//3GqGHVOGLBLMA10fIfD5qPloXXEdzaJ5qgUCzqR2EorPo2/sA==
X-Received: by 2002:a17:903:98f:b0:215:8c36:9ce with SMTP id d9443c01a7336-215bd0f6349mr128165095ad.30.1733399377846;
        Thu, 05 Dec 2024 03:49:37 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm10965545ad.3.2024.12.05.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:49:37 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: mbenes@suse.cz,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/3] docs/kselftests: Explain the usage of TEST_CONFIG_DEPS
Date: Thu,  5 Dec 2024 17:17:55 +0530
Message-Id: <20241205114757.5916-2-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205114757.5916-1-simeddon@gmail.com>
References: <20241205114757.5916-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation to explain the TEST_CONFIG_DEPS flag in lib.mk.
TEST_CONFIG_DEPS is used to validate the presence of required config flags
specified in the selftest makefile before compiling or running a test.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 Documentation/dev-tools/kselftest.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index fdb1df86783a..e816b282363f 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -301,6 +301,9 @@ Contributing new tests (details)
 
    e.g: tools/testing/selftests/android/config
 
+ * Use TEST_CONFIG_DEPS to specify required config options to be enabled 
+   before a test is allowed to run or compile.
+
  * Create a .gitignore file inside test directory and add all generated objects
    in it.
 
-- 
2.39.5


