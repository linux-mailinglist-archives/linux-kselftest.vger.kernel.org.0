Return-Path: <linux-kselftest+bounces-29790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C694A70CBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19F71898D01
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C626A08B;
	Tue, 25 Mar 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TCE65fsy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD9269AE7
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941210; cv=none; b=pcFXeLsg0g4sssKta7v+xms6ghd/Xg7PBHEJIhaKMwphAY2biB1fhjBpmjuCEivEhJuljqxHPio+7Hp6qA38iZUDNgSHwAS1O71/VxpGQ+6Dvm014DkhQhHnvGi8XkV6tgbgXrT9eLDRpa1fRCLjiEELgGbz3qbCWei3ELxxqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941210; c=relaxed/simple;
	bh=IukoZe1GMKFKCT6AG9qWXRdmFYXwpjtymU1Xp2ZmbHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APrqIRZ5QE8DbBbnDkNAQzSrS7weHcApLgzfZJugU2WgyBuetcW6nEuLt42HjNiMTyj20jPfGmLNkaMUGyDtMGoa1sr57cVxi+K/8JPQdhHVdQI0EpwcJ+iSelspWmHbAPLOxDx937ms2+uJzYEV3S5qrmwOjZhXzeu65w16XP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TCE65fsy; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso8530054a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941207; x=1743546007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=TCE65fsy8ydcRESp4tvrbk/aj/S4bs/oaxUdNYYNI5KaqFDGxGw2dreY20sfOYpME/
         /ukTG1Pqzu0UKz9Bv4BIpe1SkI14zLaJvYMAZ/vxT7B0z7v+cuO4T3m7aY7WzB7mBZJ5
         BBZ5oRUb/kuFYPjxM8IBBxCpiFxKJwsZ3nIKYy7oHI+X+CeVlhiqJTee+X/ygAXYTnx8
         6poILVYgWhaJfiU/c4ykr+0MWmNiHYFG+CYFt8yDMM60nEtR8z7A6Hueoj8cH0pB9rE1
         FqW6LEfNjGRXgR2ECfahd8/yrxxMTECawlQFtaoK7Z3uzLip226eBKN/fijnu0Xow603
         8oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941207; x=1743546007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaD1f0dkmAmr6EkfX2zgrSqJ41O3Qgw2EtPX5+qTxTA=;
        b=P8gkC2QdVorEsfEUG0YDCXRhH3XtnBvE1U938uKjiLOgnFlgl9S4nB4u8ZSpMISzKR
         S0orzEESuIUthxABJz2uyjsX0G2DWBuhKR4gLqGMlHTvqMU4yOkOUdHckax3agUhAv3F
         hdAvF4ckqXFlkTwqc39K7908LstexlMVNAjDicNIuuvM5Z7VRSb9NnyO6GWTMfphi7ig
         IbVx+Fw98GhMhBXxjr+KoYsHgP/Ck2bkTjvlzcBM+Q7CYavhTdaiLDnnzaviAZ8UzLMV
         u4ai9S+dCOz9ZvlR6MIOVNe4ZifnWyYlw9zLS89QA74gTSpDW3MDEJwwuZTe8MLgBHVh
         f8ig==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6p4xPxKlS8eJttdplnOJvMUfgZhjrhR920kXmM1OBHsyn0O4+vM4XDsWTMkZF0EFE7rHzplPc8xmTnmkVV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRYJuzpJ2Y3lM0oHNbkU8Gx4S8+rQT2KP+nJwNlnn0VfVRlru
	xIkj3nUhYbTjXwS3kydV4QLh2AeOra54fm3n8eANUQTin7EgRSwrs9DnZC+NGCoGLxcRpia0rS/
	8Yolh+UzYB3ojdtOdt3TtmP8HAUGRLowi
X-Gm-Gg: ASbGncuaJvhjHPG6lSujN1iIt9smqD6gZEPkX/uowAJMRElC19xTvCs8Y7zxh4sm6EX
	uTngt2Wmnpurp402zydCPnqCJJzco3dOi4NARU5Up3UDN19bOVckemoLUXX1YkvMFPqNoMEw7VE
	DpyZ1mgDkwPV7guAkNgZ5v5gOgkQLdnQ2LnhCTu33LIVh5PNKO6s4nUbWg0F7SRbRPoirMGvINW
	XP4yH//CivKNKL1F108/4I9i7sekvJG2tKrZkLsIOZCnAuF+8KltR2ecN4k8apVs7Ygwt1G663a
	8y1CbcKyvgewdIjMnpJmDT8Zmd396VQJL1576FzJ4smp4/ZJ5w==
X-Google-Smtp-Source: AGHT+IGS6Daus7qm2CJ7Yu+HWXaf3SPjvYYwo50CAFD4+MN72OYepK7+CxhHCMpyyk0kzla/ZeuQ4Em/0fZE
X-Received: by 2002:a17:90b:4c07:b0:2ff:4bac:6fbf with SMTP id 98e67ed59e1d1-3030fe56aa9mr28017596a91.7.1742941206960;
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-301bf61e28fsm914628a91.14.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 58E573404B9;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4740EE415CA; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:32 -0600
Subject: [PATCH 2/4] selftests: ublk: kublk: fix an error log line
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When doing io_uring operations using liburing, errno is not used to
indicate errors, so the %m format specifier does not provide any
relevant information for failed io_uring commands. Fix a log line
emitted on get_params failure to translate the error code returned in
the cqe->res field instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b17eee643b2dbfd59903b61718afcbc21da91d97..ded1b93e7913011499ae5dae7b40f0e425982ee4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 
 	ret = ublk_ctrl_get_params(dev, &p);
 	if (ret < 0) {
-		ublk_err("failed to get params %m\n");
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
 		return;
 	}
 

-- 
2.34.1


