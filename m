Return-Path: <linux-kselftest+bounces-9934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF88C1ABC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BC71F20F97
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319612EBC5;
	Fri, 10 May 2024 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iB1PM/pV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA412E1DB
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299810; cv=none; b=RsId+xd4Nc2tv5tzsmSI6/AFGdUKufA9dwbrTbHdRYpdOW/IwBYdexlQNz0dtlxqL24H/doul/nAwuj88d9boQH3d98s3WF7EDxYPYlTzR+n2FG9R21pJnPj41YjqTi0EUcvr5iqN7uhzwgYkXKZLk5oaMcQZA56ew22dbpaBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299810; c=relaxed/simple;
	bh=+d8CQHMwdr5m1UXfqt84Rk+9oU3MD5AKwJEZCVMgKFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L1l9nldhwQCPgXiSUmLavEgru0capUYeLSfpCWO6BgIFS7ZXD1wU17TxEXwxp+nC7UbjkLWPLfHKLd/rwr1nFKuVMUTNMm9i4fjlk7DWjtJi21jn752mtbuPjAFhFMReIjK6W8m04T1h33GE6Ibb4vl/ZPw57F7xpLWKqTcTHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iB1PM/pV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f449ea6804so1462185b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299808; x=1715904608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdE+UHGZ+SYdvl2kt1cRiCVPiIb/90RAcCx31Rbgw4E=;
        b=iB1PM/pVwfoxA7BRjZeIFSZ++NLVzt/YP1TnyJOSY7BfOWMs+SJMI4oV3Gkj3u2UCK
         c47VU3NfR4vXvBmusv8lLnfJ0GoWEgDkuEkPtNAavo8B+xiJJ/S+l2+vCJdmv9vCvrXr
         ca7hPOQuKbHp8Bpkwe6svNSwI5K4WEanTKC5eesSjrlChifltDzPUgHB5BEC6Yy0wako
         4ccCt0Uhkw1w8uL/ZaHUy5iiu3ZDy06rhBhcutIrx1/i05Pr2rFbYtGmuwAylgVqeOMw
         RA61JCmxRE2Fg8glarCuVcjEOR6hpzMfxlqGlOxnhtWe11uhbDRLxChgDWM6COfTskGX
         uFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299808; x=1715904608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdE+UHGZ+SYdvl2kt1cRiCVPiIb/90RAcCx31Rbgw4E=;
        b=KmDX+HXWK2piEFZSHfMMdY8HBDgS3cphLa8G/A/W2ZG01kLUDMuc5+6wTA9KCbySLX
         9QtaTfltkNaDJnZxhM2kRmd5SruARZ7Ydmokq6gOejQKOiqbi4F1HoLCZ68T+Z5nBlp6
         x9oTETPKZu2LipeqkiDEDGhjVTYjKSYNEmz5gQArD0sYvL6KWiRFyYYe9WbzFgWeyEL7
         o21TWJRIdFmY/ohuse1J1aldb7KrklOBnkv6T6jmWU2YyJDMtIBTjOb3/ZbjfugLdU/H
         iToNRZNR1DaiSZBvNbKnxoUhsnLmxa3Qy+btu7s5HcXDuDQdI3lrHzNIuI0V0oAP9YuC
         P7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCPBBh1KsH2LENH5JnEgf5jWPcKLtxnc+tWhy5qgvUxcNPYseM3FQsRLhRBXUd/jd8ks9sGIUp6SwEOrYO76MK8/5O4W0NGAGV8BCV0xeA
X-Gm-Message-State: AOJu0YzbcyW9YMK5SPJuJpqY00vaLRnfkjlJ8F3eQBOreVR+XGhg4MuB
	2t/e6fswSpHPPrX3w/mxZ6qoTl2vfb+n1i6bwZDOptrl6lYV1nZk+6vE1ticxoSJ8F5LIThNvNi
	aeg==
X-Google-Smtp-Source: AGHT+IEfJXtiyieqL6lLKw5PMbyK05+5j/j0TJ21PWb0NkhFN18JJcDrrkKCOPfn5mFZZTU5hg5qrhmQ0UI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3ccd:b0:6f3:c10a:7be8 with SMTP id
 d2e1a72fcca58-6f4e0145c08mr76656b3a.0.1715299808177; Thu, 09 May 2024
 17:10:08 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:40 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-24-edliaw@google.com>
Subject: [PATCH v4 23/66] selftests/ipc: Drop define _GNU_SOURCE
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
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ipc/msgque.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..45aba6aa8e1d 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


