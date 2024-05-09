Return-Path: <linux-kselftest+bounces-9835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3A8C1619
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7240B1C22FC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D1130E20;
	Thu,  9 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuy2xw9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB712D759
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284886; cv=none; b=dLXb6qQDljJBSfhf7c+4vCkOIyJd2wWAgvu8oHzBipekGMySoAW6dLMroZE2DTpekozdGFtYyZXG9ITd8kr6Am+ugHBffxSIxgU1/qhgDemcoWtCZRWbNeD0DonKB4VpZeJzXLv99dlChtWJOr6cnY2K/m7VJ13XRFis+E9GaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284886; c=relaxed/simple;
	bh=1K0xCZRVD3vn54vwOcfFPXDF9T0L4kexPHQ9ePKy6Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RJ4KQjU2Lv1QdgiaAU56ddu551JDjpANqIuhFYWiQ3Jeoy6r5q3K3xEF0dzq/NyP3mcBTvfXZtpVxa1By3kKHznquNh9kMBv9oN1/RD8dyOU9HwbUJTzg918Oo1VWWnqw9vlJsfRyr9D9eYv97O1G/4km/jqdg2FjPYmOuFMeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuy2xw9z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f467b9e948so1252858b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284883; x=1715889683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=yuy2xw9zJxR0T90PEJcbIfBYa4md0HVAwOlsng3ZA8QNPP5v8ZXCGsUNTqKpJU9DHz
         Jz7MqlxMY+JfBQBdvjuHBjmIvUAa/bPUF9Nge3DC8oijKARoygZ/DOQt72njtY9PMaBg
         fqKoCNhRCHh85tISlcnnyaZqDyVaIkgHkLZZ0Uy1cnsrD4Nul36lya5dm2iR/g+xKJ7V
         iudhx/3GAtRnNTm1TqyuYeUCn2uk0b9d2wCwxtaP9XAYFyfZZujsyX6UNRWckrh/D39K
         kIXqoTaxhGiKIJS2oYupSUUQ0AOvMre3tLCw5++Xofo3KjmsjULAegRdpGOaPetFoqv2
         tnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284883; x=1715889683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=Fh5tya0oznslJCazCxVA6Jxm0bn85vSVfdoInxzvd5clMb0BHOlviB13IPdmPJFTLv
         rTM1Or9y0DWsFGqtt8xm/RNIOg16lSN5g6RCUCauVJZBM1EANBqngoRXyvsrzARZmTkP
         5JnDb7rey+Xbveue/g0FFywVW+8u+ypDNl06EX3M1joFRGxbuwq1jxC/vIyv1gTh0z8Q
         mRBjQ3pwHVIsZDzDVeTCoLBMmO5C285kzQSaGHj2LewN2fKfSrkdOsEG7AdTfPT7lbVk
         KWq5kH6WzMN25dHwxrvvmDX5jYyOYBP1pSKCYWQY2PyUlfccky3J6Dx/x3fCCritXlHS
         sX3A==
X-Forwarded-Encrypted: i=1; AJvYcCWisH17Gv6UttKASgh0Sjg/Mztz3csmeqrlnj8SKN0zfsOYnzTnBSZJU3lBaai5yeT6v2GQDpwS3mPT/O+hSSqZNIxZs4DDigSofyHTohM0
X-Gm-Message-State: AOJu0YwAruP40/gyxL1qZto2p3HxQJf+Hqkx5LJWDA2iZXl40vn1yxVg
	inUCYcnaSuSdAcdDIcCObJB8MB9vDW6UxwNGfIqPCXV/E93uGO/Y1ySxc9/Zr9g0amRAtyvuR0I
	vwA==
X-Google-Smtp-Source: AGHT+IF1zeNl7G2mrY5GSol57Wmpqj9CLyOfkFGR2ecW54/KxC4a46reBAyc7WewMqRKduaOo7Ktdkz2CAY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:98b:b0:6f3:ead3:c280 with SMTP id
 d2e1a72fcca58-6f4e027813amr25753b3a.2.1715284883459; Thu, 09 May 2024
 13:01:23 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:04 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-13-edliaw@google.com>
Subject: [PATCH v3 12/68] selftests/core: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c59e4adb905d..1c2902bcc913 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


