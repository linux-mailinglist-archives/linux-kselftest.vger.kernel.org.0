Return-Path: <linux-kselftest+bounces-9976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760758C1B98
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CDDB249E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49939143731;
	Fri, 10 May 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWkOa3oc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1009142E74
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299930; cv=none; b=d34tky+11fA5gxUG/WxUa7jaPla47ey4bEJuTy/4P9LEECJvKO+TEN1wsaunUxTfTyktzwMIfAh8xpAG+SsarsRX6yxn8GWsKABEIqCkkf0s0euptR5eB3hWuk8g5hde8sww+Fqu+FWjTS7zc+06bJhMd6GlWDikXevVbk/qpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299930; c=relaxed/simple;
	bh=bCVhh8pEHF5ZqnCfhVzfgmGYze128EdwiIeM3B3No2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqREtajVPKeuvb0fJgz6YhnDCP2HoewirH+ielknvDCd3QIX5ojXvKDE+OczfWS4ZD2oa6z2v2MPEVoQ3QzzmNMj/BH8mO9YK0lJnxPia3HxT0KNEGH45i8Cx2pXudbiOWp+vDcRbV4xMYX8UWJC1xv5P0dzpfaKsCyXR1TxV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWkOa3oc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f452eb2108so1205136b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299928; x=1715904728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRjTqL5jZBxzwk8RtqE4pMuTf8/KsRch8ACUgOLR1L4=;
        b=lWkOa3ocYSax8JLtAHNoYDrrJetns+4YcpbF+S+4+H0217kzf8AebuMk1hAvOIDe8u
         RPYdrwyYVADQjqQoPjQC8zC5b/kHdazbiBBsWqUFPws0r/tbDylGTQ5fwvoRAQRQUaNN
         7LFfm3qlj3bPJJvZKR4ArsjjZrnBB7xIn66XNoT6OmD43sjGkO5TtINc2un+vf1JSV5I
         NjOdSuzF2tjI+YrGfjjJUejJttzPuUlClL46QsCnYmBhNZgdNURjw7EBg5UU17LN1+Fo
         CoGUFPNBlwvrGaoP/R6XdA9ThVUT2rDJWc6aq8KjCxa0m8+YL5mzuEnFOLegVZ0bu9bj
         Euzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299928; x=1715904728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRjTqL5jZBxzwk8RtqE4pMuTf8/KsRch8ACUgOLR1L4=;
        b=hhv8c4nknlKTGKXEwBSDV/rSX2fMrPyxevsqyDKpJoCW1DGh6ahprQsoTRT/xzhKyx
         GbPBfLJ/RtA4S4Xnkp175/yIdQng3XFSMhDAat9JDYT05XJq0i6KvF/zJYEyVCcBQ5m1
         t9uFHlsEUlOJddHLm2FzbEKUFnF3bZ/A7frZvrsOixL84JSR2GrVvwZpmT7Eb93USeyq
         7kpZ2Yz3Tsv0PIWMNt8Jq4e4J3kpzBSXYx+u0joF8bRJZlsLhonT1lA5TT7oprKPSunj
         LiieFOD5J7YF2Lb4YCq9m7LvQRE5RJboQ/OpLKDhdDrPGL57hcqMMLBTSwwS+o5QoQX8
         rH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWkK8E7PcXUYjkgt3vIqpKjU0ON2zqaVbDS15AlbkyY7OZ/MjFzvqDDxXXkGatbRfJejQXlANLTaWas/s8vlyr9sfa7cxQ472s2a3u3oeok
X-Gm-Message-State: AOJu0YxxmtmoQhLefwqPjXYv24orBF8xf5L0wzUoYZ4OuF0DR2BC30eP
	HPwdBii6X5wRPfeoXEqDpeL2qt/Wm+r7WHGxXMQ7uGYl7oN9/nuxJB2kNtHS/KhkkfH1pzc6PyJ
	I7A==
X-Google-Smtp-Source: AGHT+IGSF9WzQWuvr2wMEGyozUQO7K9UVp16MtXq9kPeGzg8zdiMSf7txQHGnyzqkIc1hkialPRFYFdBrZE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:8c82:b0:6ea:df4b:86d0 with SMTP id
 d2e1a72fcca58-6f4c91f346dmr13199b3a.2.1715299928188; Thu, 09 May 2024
 17:12:08 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:22 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-66-edliaw@google.com>
Subject: [PATCH v4 65/66] selftests/wireguard: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/wireguard/qemu/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e..08113f3c6189 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


