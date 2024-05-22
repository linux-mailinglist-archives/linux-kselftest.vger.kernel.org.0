Return-Path: <linux-kselftest+bounces-10535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372738CB7F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBA31F2A1C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455315532A;
	Wed, 22 May 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFz58pCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FD155316
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339717; cv=none; b=uay0u1QrskkFx7oJUgEJiksLUwdK/vtCI0tD/GoIJfbAtb86IHdsFJ2Fxs4KLpGWDklEknclwSOFEGn8H/0vOeTLeixtCQnChwKEGsOMajvh5wg8nXHw6qEnoKAnLsu4ehf1fSxGEBpZMeQQLOw7H7mpbvelsWz3vCFyzVnSO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339717; c=relaxed/simple;
	bh=fBXBkXghEjNTtFe0F4ADNoBJuC5etV2XYfV9uhnigmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwsNrgixbpUdT2Aaz7BiRr+TEefB4SyGYTTNrNI0idqTi8p+Vh2qFcEvkj/sGbX8UBeafUU4JtMFdcDPCkZFptunW/ZnDsT8URm3RX+GHt3qh/oE/uSuwl+rdGqwYwreuxt0b9ZwLIJZ688pqib4MthBpnjjjMPNl/CMHReoK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFz58pCS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b028ae5easo207944267b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339714; x=1716944514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tX+C4G2dO430Dq5NwbbjDA2nRzbu4A2cHamlSsJi84o=;
        b=tFz58pCSR7AeVGRCYdVEa8hPfg8oap8Vq0N3lDbCt0qlNEDjUFH3l3nIdGq4K0JKgc
         CztzaFYtRWKIZA93x3KHmJL7p51oDBCQE3vb53yKzpgNdAzXfyneJXvJT0Rr74llpnft
         SWniS3Wt9YDat7aKBFlmqUCQgGEZdQb3WAlYqIMdoYqGFF1SQD8xHAbCXryk9bpCtkqS
         PS4iEKY9HKEulQ7YCK2ug+UiTOHC/RaYvaPNYHK24ohrHq2btX93gAY1gj1SiQNeVLGl
         OI/p4F90abY+u28xgBFNmJHkZUJ/8GZ7K54+tEcdFjDqc4+FtdbMpEiRte/NWatq5W9R
         6Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339714; x=1716944514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX+C4G2dO430Dq5NwbbjDA2nRzbu4A2cHamlSsJi84o=;
        b=qM7XkHib012wP/CM3XB7/2XVfsBgkCCZyUtrs235HBjmkQeJAg0Jrf54VL+gZuGH6+
         ntbKF30qZbPieOZvuzEFzgL0eX5JlRrsq6TqpiXhiYOj3zfDa/UMSFUR2v2tLkwBMAZS
         ffdN0cgA0iSQCUaBbabXStL7oompxKEn3Dwo32kESUTvbaY8tQFfwNh+OYAUi+AF+tth
         YIp1UF55Xt4XRrgnX6wbS5DvQjSTyxWefpCcKrv4VoEnB6Tn9wvgZb/BwfyFBEHy8DMK
         JQp9W3oPstK2jjBhWTCYpqh2y+uJYC22rcOk51H+NeVCaa0+8eSKAr5aEGZNU20EV0h+
         vFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVlN3QDc1v+ZvcD7Zgk7jvVSpF0S1BaCEt3GunJP8eM41WklC4xfZFSBtYn6ZKOjg7QGmNOpYBtvYknBc1HzpDH0Q0P9oO/W3v+tN0qbuH+
X-Gm-Message-State: AOJu0YxzMJd3ZQ2S0I1SEbeumYleSHXQMlvfMCMV+N7syqm4g3uOgucb
	lriNzrVWYBZwMwPoYG7z85Nsfy1dIuE14ZVFEHNIHRKukj6hfmifBEp0RtP2BjGv+NgpUxdmWGq
	tEg==
X-Google-Smtp-Source: AGHT+IERd30jv/R2KSgTCg5YZ7ZV2lL0yhmpeb+wESJAYpGBxJBI9/AsRI4az9GMtDgAdquzLZrkmDgFCkE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d80d:0:b0:622:c964:a590 with SMTP id
 00721157ae682-627e46d40c7mr1748647b3.1.1716339714682; Tue, 21 May 2024
 18:01:54 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:34 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-49-edliaw@google.com>
Subject: [PATCH v5 48/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.1.288.g0e0cd299f1-goog


