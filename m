Return-Path: <linux-kselftest+bounces-9962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F18C1B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477E91C20F4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF313D275;
	Fri, 10 May 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEW7pCqF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454713D24D
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299895; cv=none; b=pB91jM6ekM6EUvrp7SJH28OPN16339ZU/pXC+TCL+mCqgawVSV9wjOsZ/CZD/DdlXbQcyKii1AL4XOA5BKTKczkncTweFsdgXgAGFZFAChIyPHtOiDXtBxVI7vfLeNaRknNTNO2ujYiUnr+E+wpCuFxfte7SX7/CpmaiGJE/XaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299895; c=relaxed/simple;
	bh=UhdxB0VCuAo+FfSdpwQFoDNnyUeVez9iXJJZWBhO1qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qui6mOKKVhjIrFhp1S/PgZIepy1zpAwlpDfokFuffD5koiTyWYSdiQDMLtYsWID+5fzpUPE9vAGiahlDXpHm5/XFckzqU92bJqPazR6GVQwce62woaEzj5aAag+R5F8d7v7eTDcfaiQHhYJD3Yp+aYPsJ2IN+9WDeS7CqCioqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEW7pCqF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f452eb2035so1500812b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299893; x=1715904693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uDFF+JWYl//M2d4lSrsSDaCKGHAotkO1fbl9/EIGoc=;
        b=cEW7pCqFHwN1YvTeUAqvC/0tFEblWEm2k7GX9n6dqpEvTevvprOuHRPFJfacuzWifx
         FPOIb2ex8S/iZinQB6RbOlpb5S5RN6xRmEyNWhmRLRX89T1X6wCI5l3tTEledh85cmYr
         EKyCuWZoTbfwDziUmeFIWF8u/+5O5iVsT74jAlGDImor9nxCh8OY+49UWfER7HSB5jP2
         r0c0MnMBe0h+/IR6ialnMC7e1ffkwqdPYnQr5IST87Lv9BdZsWjosWty/MwkPYCVP/ID
         Y+LJ4Z9jvLOGALVECfEmQ+sdf20+16nEZk0K+LJvqaa6uHSeGDGTgO1YPxbMfYKF6iZg
         09XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299893; x=1715904693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uDFF+JWYl//M2d4lSrsSDaCKGHAotkO1fbl9/EIGoc=;
        b=jJFshcAfbMDuVutCwIxvAa35GpgcHfbT1rbBr7a0PKaetXxnkZYYADeL5yHFGF9Mry
         Sryi/kbCPfnSHqUrhI7Rq9YtdxoBYZuufhaiODuhbCek7D65V9A2ruFEWKVuwag3sdUV
         77X7EBzaYbm57q9eAdf39gfRE5kajhf6PqOw1cdRUDPVQt4Sn9PeH1wga1nZ5YuPDKLo
         X/x+Gta/T3ASK1zOBd5lcgrh/rP6erPCwWwDlEm0jawEFp5y6d/bm7RIz22hAE3TB9He
         aBTzO4MtDXbBiMvB3LoEidEEb65D3vjzUTdRuKvn6urhEKat26d+U2xoA3zH3p8da9Z1
         4g0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3D6NB/uEGXw07zu7lVhbvkxn0mNRuXCeJgS+BL0G1EsQ+uARoxj/teO1UUH1mFebVgF41/5mx2xDx2eD991X5pArDADzqTiDz6b7Y+av/
X-Gm-Message-State: AOJu0YyQ8phUw/BZJJq9RhJ2/9iSwjVY7sMYohV5Foi/22GvZhCq6Jjj
	pqWWumxnMP3Kv4AmeSaflmsBfm7K26TuHanmdOGQKpTWZduFL/9PRFOTLf2EapMFA+KXEMxAlg2
	LXA==
X-Google-Smtp-Source: AGHT+IEdJ42TdgwwL6jMZitLCucOiECkZvqcMbyvNAdvNm+hAFnab+iaBg+Mn7Odij0H4KRyDB3AI1IKDGc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3912:b0:6e7:956e:4388 with SMTP id
 d2e1a72fcca58-6f4e015ee8dmr16017b3a.0.1715299893193; Thu, 09 May 2024
 17:11:33 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:08 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-52-edliaw@google.com>
Subject: [PATCH v4 51/66] selftests/rlimits: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rlimits/rlimits-per-userns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 26dc949e93ea..e0b4f2af9cee 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -2,7 +2,6 @@
 /*
  * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
  */
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/time.h>
-- 
2.45.0.118.g7fe29c98d7-goog


