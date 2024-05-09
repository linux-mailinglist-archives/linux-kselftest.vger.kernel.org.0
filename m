Return-Path: <linux-kselftest+bounces-9863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D48C16A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D8F1C21050
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58413DB9B;
	Thu,  9 May 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W507AtNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F434127B46
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284967; cv=none; b=kPMIfQra853zhcvfH7ONYTiYt+t+PYs6U+28ui+gOcCz1+INTGoBP2osziG7W3jFn9eS3akuyM+kjuZ4IofIJsSNfsmPqy4ZdLsHoakNXmZEaTNDzqGMa2bvFZFxz3aQ6RW1rlagj7ld3LS43Rg5XY+CNPPKDmgkxUYt7Xont24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284967; c=relaxed/simple;
	bh=+slCGtFXvcRjQNf9pPixrF7VucIjnTrEcVdfQN1I3Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vCs3aaJwv6PVQ1jxd0lJuBzXXsZvjMgJermU/ERUvSshx9tVs1NEaj0StKC3C0WNeWi+uzd1Z3Xa4Ca/hOaJxmKSWXeYWmX/VCuLvi0z/kT4Rkl8qGJGIOOCRyOVELaL7L/MlnzZVTdrMNkj7vqxTjT7UhpRL/dZIfT4epxxUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W507AtNA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec896dae3cso11870085ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284965; x=1715889765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ROtSes3ZQb3WG9zfhdXtPEPHl3PoGiMttA81TOGVo=;
        b=W507AtNA+pZUQqou2EZd9Sie6CNxjyTU7sCi3FFBXhwGK/XQBVVwRTjWN0yIrUelVf
         mNZSX4WiAuNSe8d1eGWFM7RpsmDydQs5qr1q/vzOV3LSTjqcFLYZ2BH0GbAKQS6h7OrO
         UoMhYUi+jvhWBjVkOMmW4oS49z7oOEoRgwJtExi6Nrp5tIJKw9PA9BwvzV+b4k94EqjB
         CMClzuIWKr8EHMWj9U6GhQh5KJtM/tPMQU9QmL+WiT2HOPvNXHESMVokymSDrS+bp7ap
         y+2j+9KT9driNYKph9w//69YzEOAPk/ziuf1o4NNGyy2xT2AlYmKXBoFUm/okKETXLHo
         bsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284965; x=1715889765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ROtSes3ZQb3WG9zfhdXtPEPHl3PoGiMttA81TOGVo=;
        b=NcKdYpXd/K3XdJXdkQSbu+Pm+K3IeJQPvJPcicqbh9nk9pdAlY/YdAKvR1tKx1nuao
         jprGYE+i/L2X4RXj4iJpALbITebyohh4wXAiMuicApacwJFVdB8yxNNFV9ZajLhnRWn/
         huT7D/OH1cm99jFb/+jJ8pjnc2dDzXiFdbibSsV4ePXOggbFFStDd5ZWQN96WtbP22qR
         Cza6Jm6XrNu1bumZ6EJv7DQsQPGFiEMZSCQ0t6UNg1q8nKjdQep5s85TvpBwZVS/bRuY
         Z+IZUZVslTrTbZIh1HGJBzMRldP+JyCQJgiNQNbfwqagCsuQBzrGn5qU8Y0Y4BsoCzPi
         PPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoGPC4DWpc5CAWZhU6G7QojMr1pqE7HvhgN4pqzIOoYg7KEr2rmKpkEptG20wRVEbzXWmCk0HRTH14k1CdyP6fXGKby/KxKPrKOzrAtbiC
X-Gm-Message-State: AOJu0Yw9FuQEEhed5ya3QizvwLNHd4z9l/eUkcYer+LcXWb6KvwxN/QX
	KAbd0zFy2/jTlJrHlIzdD2kIluldRIbU0eeEZ3pmfbLFR7NcRGB+q9ianmSfuzJ92YzfE85aRKt
	C+A==
X-Google-Smtp-Source: AGHT+IGvJuQrQiMk9Le6lHJjBtL89ErJtLYzOJrcQMdwjm9MuNs1OLxjtGfyc0HVY5s6lkIGlnPJdYKFNqo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f54b:b0:1e4:a76f:6da1 with SMTP id
 d9443c01a7336-1ef43f522edmr136425ad.12.1715284964895; Thu, 09 May 2024
 13:02:44 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:32 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-41-edliaw@google.com>
Subject: [PATCH v3 40/68] selftests/nsfs: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nsfs/owner.c | 1 -
 tools/testing/selftests/nsfs/pidns.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nsfs/owner.c b/tools/testing/selftests/nsfs/owner.c
index 96a976c74550..975834ef42aa 100644
--- a/tools/testing/selftests/nsfs/owner.c
+++ b/tools/testing/selftests/nsfs/owner.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e3c772c6a7c7..9136fcaf3f40 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


