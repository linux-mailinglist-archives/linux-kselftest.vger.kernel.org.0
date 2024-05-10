Return-Path: <linux-kselftest+bounces-9957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5078C1B36
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F641C2011F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572E13B7A7;
	Fri, 10 May 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3UAtSei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECB13B591
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299883; cv=none; b=WkHBF+2y9Aax6vul7U2woTkpr4sm5ACL5+3MulIBWa6mHsmvpzkMoCwwpXyNC92odxyPH5Mda+I4AJNqx4oR2GpFBLovBPo6oeAFN+mX86/XNgASrm0/PGAyZybysneY8SryavfGjFtOkMKe0nXfH21BYcZ+Wlv60zJgJNSCZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299883; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uS1SRgZXHFWtigrCyTYtflMf+aynK3hdd3B/4lEAynqKF/PPv3af8rbTCOzJsdIVJ+NN4q/sv6TtIR9eKQZMgv4J+yWAs+5OWH51JKS1IknxuIlw46PZ5OACXzKotp0eA+Ewo1P+5yPNruWSD82B6c4IGFeSP8uHNXOqQY10G8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3UAtSei; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c296333so30243277b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299881; x=1715904681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=N3UAtSeiPrlt9OW2F0rY6m+iv9lq7dDYhKPowMfiXC0i4M50l9Dq0C9BY4cBKpwwg7
         4g6Mso3wfhFFxAlqDrz2MZQMJX/BVKKsTSO0W12iZ0mWIZagIVaL1MDW33UdTQmbTbE+
         lwyQuyKgkExHf0eOHbu/v+DVpB7mWUq0XdsaAJICDUe9zrvd7cg7OddH7V1tZtlvSHwD
         HKgaAxuHATqOmhoKn76xQshp45Ob9vFkc06thVQ8OpsulnW+BalfUaJQ8pXpEpDV7geb
         suWaXWhKX4tDdAjpjzOtOqlzSVoqjniLl6CS3BH4zRnuPDy/NZmeoCatx+ZfUc/pCvLo
         spTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299881; x=1715904681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=mgqffvx77bNvLbFkz1IsrJDVbS4m6VPaR23OU+SQ/3LNYX0f1ow+fW5OkWSOL3+Owq
         7CV2j72lKmJdpuLF9rRpHaCjVvJuA/OJ5FS/Cfi+5fTXWzmGw0qZrl8FeICGuvPm27Fo
         dKHoA7Swtz2cJ4cMnypc6/SyXza/Npx59J6+P1JHqaxCfCy+QoUwEnFXkUG+kmsltraP
         uxWTe0tbH4mCiBpOGIFPtwsskEpwmvB/yJwLrhDiRSiHYdbIoCp9FD+CvgFCXLEjFIkg
         sxYH6dTIj7DBDJ4JR+NhNpGEhXX/+SMl34YoNA0wjaKqotHyA1/dwtEoELBz7yALiX9+
         huLg==
X-Forwarded-Encrypted: i=1; AJvYcCVap0WFDl+NBVjZNw74Allj3gKT/f3hHUwOewekDaYfldpdjdhXriartVG7fEq48LZgW7ISPJWocOffnsG+a3xsQ0DjXd1S1C+urtFVzH76
X-Gm-Message-State: AOJu0Yz5bC6Y499zH5MPr5DnTxpIUZrwZt5Uy2VctwyZfts6uGXH69fm
	bM+TYExGQvr9fLP7n7xDe2HdTAtB9dJ5GrKWsfotwF+zv7UgG3xKWP3Dl3Dht+f8oLJRvAOr/Rw
	LXg==
X-Google-Smtp-Source: AGHT+IE/x9wCS8dXfiCveNKLMUww3zuulXyRB+TBegOeq8yRgm7kXDMXOCAjHlMh4xirNEVxhfl/HnwXW8Y=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr363352276.3.1715299881350; Thu, 09 May 2024
 17:11:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:03 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-47-edliaw@google.com>
Subject: [PATCH v4 46/66] selftests/proc: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.0.118.g7fe29c98d7-goog


