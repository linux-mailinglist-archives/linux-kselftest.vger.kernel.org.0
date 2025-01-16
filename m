Return-Path: <linux-kselftest+bounces-24635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC90A135EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE053A50F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696A1D61A4;
	Thu, 16 Jan 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN+WlgIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC322301;
	Thu, 16 Jan 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017989; cv=none; b=nKEb+0W/de0+VY9MaTxaacUo76D+tU3hcV1XKkK9U4AeaOiyp1cAVewumEkiz9hEa0v2g1k95ryID6uHBeZrvjiTYidqQAQh/WXnSNhiQhjTheLY4bylidnsBdAZ5wgaYjpEqXDOq/f/EUv2HJkhs0GRpub7buAufBfYrMCkNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017989; c=relaxed/simple;
	bh=oyVNGXZz4OCy+CYaKUJrspWuFEkTi10N9LufJVAO1q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osWzPAFk6aMUluMoIpcCkcVtfbAXXR1q6oU/bPmYc82PUhMglJ8mjjVgDdD26HlQ1rd50VIkl75qZvJC3H0uBOjeKSjmYq9vY+uiyP9AOACaGOeseqa55o19Sk/sy0BBtj+Hxbr+fVWXL+eNErkGLLNg3wZLHa9x1ZvPieaF1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN+WlgIt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so322307f8f.2;
        Thu, 16 Jan 2025 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737017986; x=1737622786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyVNGXZz4OCy+CYaKUJrspWuFEkTi10N9LufJVAO1q0=;
        b=DN+WlgIt7k1kA/SfzeNQzCb18O6oQH7yi2tu1trh1BI19fUF59ujRvlWUYBG1UuIph
         pPZOT079DA8QoQze4D3LPYg9UtSzSr5z/xu8HkTFvAJsMaGXJ2xXc2oJW95AD/VmYREJ
         vvD1n+KUpxm1vKEfEkvHzW+gaW5Pt/Pb66T5tC0N3LxgaDQhdZnNsAqCdMrNyf67dWqK
         paIxyAou8aZShLklcHhg183DjIjHuJZsfdBhtSUdpxn9MbEPPfKpe3k8eZ7C5clA3Zu5
         zJXlzilhKJk+bswbOreT5kIXn36NmwZiE/Qa285UvPlk1u+thJhoHFPYCupEYPILX8Fd
         l/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017986; x=1737622786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyVNGXZz4OCy+CYaKUJrspWuFEkTi10N9LufJVAO1q0=;
        b=HLHFMNn6X2qMm1PRZFjVTE/AoxG3MUvorbjpYHNluqzSKB4L9znG6TZx6AlLAa9Ccp
         sT4W5NCocIZtAfXCHmUd8J/gK6Lkjc+7dsA4zZ/RfhvU+PRRFgQ7qFjPppdxZ5PvyXtX
         e00jbD4XQZMfRBdhqCSh9wKItrJzovAoMkeSikcrpydtadsNhftl5rlRaZZ5/R3XLzvg
         cMhPldVseoiGYU5m6CnEhdahoQcEDWvWO0ripQJRDqCILvnMset/9Hzkk3P6+2bvdTX3
         CGXxc2+px6uk7aIeOaaTBNmqg1L8yu77cB4SHb+jvIblPjHaQ14BmV5DAxpHWMNweR1O
         /etg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Tr6P5sB+9yZ5FMUL6moybaJAbJi0/pT0ezK2646WcGY9VnPOqxaMs9lf3lQY6DtxF9zfbd5TSIVMkHw=@vger.kernel.org, AJvYcCW9ZoQVfU8FxJF+diPLUmO3cmz/wIfjqwy79Bayeh/n74/XUPDKFrB3KhCq24F4qkIr1vT3dCUvhvp44JKtgJ/J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0j7z2wY8BQhH6l/O9wi+tDa4X+vdgN8ka47wnSze/6Ks39Ekq
	TKN9llE38V21koWfDACprS4oz25DtwLc0ag/xtqyySwZCYUreeA3eAF3Ow==
X-Gm-Gg: ASbGncu+WcBBoeIGwmNLSBVDTwtZGInVmBpCeY/PUdnxb+2wdWsPHVJC4MYfjlwQkmC
	pKg4u2Dy52OFfxY82RSf5YQpoUOIm/Y/cijhb0LLTbS1k+aa0q2eYuRWzfXwvJ9k55yFvyrudPv
	ai6hC38OCz0G47nvtSgMRFhEu+g6qNEj1imgL6x3gsWCd/gqDzHrhaFPx/8HWK5m4ngI18mSIPC
	tMHY2PGZrOul38ayvGXjaAHEC3iMyADa7NBOkFDCjf7G4cYUwI8I9R+sc2UtOjVtzjp91kcxh3L
	ypBLvg==
X-Google-Smtp-Source: AGHT+IE4rZp+78b1HlE7LoTR+uNySR1Aj523uXtNGikhJ3QdRwl3NnSzDDDqZc6eAiwWtfmBuMOISg==
X-Received: by 2002:a05:6000:184d:b0:38b:ef22:d8c3 with SMTP id ffacd0b85a97d-38bef22db2cmr989876f8f.35.1737017986129;
        Thu, 16 Jan 2025 00:59:46 -0800 (PST)
Received: from localhost.localdomain ([197.63.255.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d090sm19655955f8f.2.2025.01.16.00.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:59:45 -0800 (PST)
From: Khaled Elnaggar <eng.khaled.elnaggar@gmail.com>
To: shuah@kernel.org
Cc: Khaled Elnaggar <eng.khaled.elnaggar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/.gitignore include missing log file
Date: Thu, 16 Jan 2025 10:59:28 +0200
Message-ID: <20250116085929.313677-1-eng.khaled.elnaggar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tpm2/AsyncTest.log to .gitignore

Signed-off-by: Khaled Elnaggar <eng.khaled.elnaggar@gmail.com>
---
Hello

After running kselftests, AsyncTest.log file showed when running git status.
I just added it.
---
 tools/testing/selftests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index cb24124ac5b9..87d532c08a3e 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -4,6 +4,7 @@ gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
 kselftest_install/
+tpm2/AsyncTest.log
 tpm2/SpaceTest.log

 # Python bytecode and cache
--
2.45.2


