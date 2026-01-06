Return-Path: <linux-kselftest+bounces-48251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A7CF627A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC3D30590D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A3242925;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Pw9gKtRb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6021B9F5
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661097; cv=none; b=s9FCE+7rrsAwf9nxFrRU0MTzqfXWU0vU/fXjpYMkhP6N1xd42XBLlpg64Pllkkj+eQHKZtDZoKnaEiqJJ2z5kjgDp6PyzX493Kge+aUy/FwPaG+nSUjyL4iOwVV67XsTHYeSv+aI/mZ/ytnOdsA2u9KT6yGToHussLGhBCiTw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661097; c=relaxed/simple;
	bh=C7WOnO6ID4LqxTasOYmRz/f/EOUiS1sTWpJj01SHmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSfulv+WspP5N/ZPmvwIhNJF72pb8jgkQAh851RYr1j58tfannVdfr9LDJ1FHXr0sMGxc1zs5i/uiq+5cUYOmAVKDSKNRQ+UMRqz+aWxKQ9Bj9NmfkHhsrL7S3rOK2BVuZ9VHL6AGiNqtNx3o8dSM3TtVhGLuw1tjmHPE/lvikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Pw9gKtRb; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-65f2531a6e3so8267eaf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=Pw9gKtRbEcNvLZ9M2gdnR/rFsJICU9bctaHwYi/qb4qAUecD8D5diL2qS9EUq8DWZd
         nNyp5LLUGBlur0+eszz8Fp6NOYvvAWK3yHlre497PXKF4oT5nCInNOmuGPG0Qb1hYy8j
         GNGq3CaIehBPJ943kOnTPrR0rK9ZdZ5Afrv4DMtYzK8MM/fAFXCI83XjS6RoVKZWvWjL
         CiVapZayTw14ySQ6hZFM7XW+Quq1oXVIqGP6zNAAz2L+9sJ3l3y8DZqwmnv+dLn5oV7E
         +DJb5BZDc8181/rdSnplkCmnK5zAjsJGrvXIYFjcdDPfXn3smC3wvzcg1NbdjT1Eto0s
         AjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=NIEowNQm1B1FgcQbnsU/ykByYpkiVW5NMwr5JLMDI7StkfCF13X+IXk0PlvlqPOuvt
         8LXS6p9t7X9PNzTILEZp/F1eK/1CZ8Nw4a8eRglKeKQO8hysyLTY5/sKMMm65vMfILwb
         95HVm/3zZCUm9VPsfgCUu2d6GR70m+rptNz3ReY4a5TRYlccsv20Fv6lzgdKcJcdObbg
         LUFN+X77ivJN002UJpyOFg5sgkYF6ZiHmZ1+hD+lkBIFS1Lu3T6y4j+AMatBvMbkduBT
         Kimx3IhWpcFEHbtuz4aLPgPruo12mYHbwACawOdHQIrNVkNLF3WQ5sclYz9dF7AiGCwU
         mBaA==
X-Forwarded-Encrypted: i=1; AJvYcCUZDWI0qW2F4Ex1SpcpGRR0o4W7yVrfX64jXTUO+oyGThS41dAoRXRJkR4nHTfKSjigNUwxAhGRh3AhMqMpkko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIubYN6+TBkyesUO0lpwhh9xAB1ikZbtEEKfONTI2VcQtYrcZd
	8C90lMl/MbbWpeod0t/9fdFBsPqpEFod7T4Ts2sXD3siuPe9z9eqytMCL4yWOzMwWnMD5SboFBK
	njbfd/D6HOqBr8VsHPH+VfWe9tEAwhl3/hH0DMibtyuePTcMc2wHi
X-Gm-Gg: AY/fxX4B8fephLWRGFoGJFP4BwAs1mS4mdUn8XGGutsCJGTvkYVCuJhfaO83vXCIcm3
	+3WNtV2eG+PIlqSZwAbz70bHSPnraboVoBH4FY6Sj0a8GVgJmDCUzDdPNDyf3hTz/JGZ2UDUev/
	qHFzIPgzCOvS85tAcqJZuCNGE+JTb/5R+UIZdCgVtGjsT3uZ97osmp7AGWfkAj2ahUtrCjmAQh7
	6jPFJFaaNDQDr3bGez8rOFtFd1H49uIcdNohhG6+O2mN8lWO8NPv9zLNyzsI5++vi8eyF04BYSl
	NAXS90blgnf+UvfY9KLv/93V6X7OIcYyJ9KQvIEVkI7Kl2pMP4Caje6JvFh/ZdINiyg/4d0iVuC
	hVmBGDjzbbBtyP/n+k8zRo03ccH0=
X-Google-Smtp-Source: AGHT+IFG8Io995j2dSJYPSJmiBupcP810PQCJoAnia5A/MggoC25scMJzZR56R+YMLt056CG0G4W8kcI28h3
X-Received: by 2002:a05:6820:6601:b0:654:f5aa:7434 with SMTP id 006d021491bc7-65f479fd91dmr439065eaf.1.1767661090901;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-65f48d05533sm12250eaf.7.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F7C3340960;
	Mon,  5 Jan 2026 17:58:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2103AE44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 12/19] selftests: ublk: display UBLK_F_INTEGRITY support
Date: Mon,  5 Jan 2026 17:57:44 -0700
Message-ID: <20260106005752.3784925-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for printing the UBLK_F_INTEGRITY feature flag in the
human-readable kublk features output.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..261095f19c93 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_UPDATE_SIZE),
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_INTEGRITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.45.2


