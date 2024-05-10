Return-Path: <linux-kselftest+bounces-9964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4A8C1B5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18841F20C66
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61113D62B;
	Fri, 10 May 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QP679QKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FE13D539
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299901; cv=none; b=jdM5GqEJTagB0PNgdzSJTw7Cm+o5LC2pF2J0jltXj9NwGH1A6ix1QZEugejDtl9xC8QLNrHQEjy4p4BJqr//Y+Qmwn2C4PyR+0p9P/wKOMG6+OqO/kqdxUVt37Ltmrzi5sGWVraqPDbpzHmOb/miYH8fy5Dh0gEzsCuNieKtZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299901; c=relaxed/simple;
	bh=JvbDWxGt73x+3I5wycvjFh+GG2YkBR1D3FMaXjgEOUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmCPc82vBmoEZO3tUwlQloVL6WwIb6NQDh8mPgTaOENzGMiUbMPQG2khKNb7+DINmxC0MhldQtjqkww0h0cHjv25G3R9wg/79LvFVLxC07DUnEf6/ho/vcZTz9kxVHof4DcdNjoQR7cuOZVH2xiiP4aYz7fOsrOqGPWeWobCWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QP679QKJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so1996219276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299898; x=1715904698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=QP679QKJ+YJmUJRm34oeIG2z2fV+eM5+XdTrCwfV3+3XDob7WXz7VcW2vVJIl+ymif
         DtsIA/CliHTTsjmF5m0TikO7867fp+6gSTDWNVuL3FFExEU3lt/9RU9o82DqKRskInMw
         OUFYnwG/v9PfiyXeX5L9a3L/9VCdD2SY/k6Vd6j6Uk2h3tmyZSBVROJ0UxTUuA46x5zY
         sD3BGmKGBS535ty0/EQJhQEGQZ2DYWvrLvXb4IVftMe7RDGttpOuusFpaCgbrQ/EDJyl
         UGhvFjlABNB2orh/7PnnVebuPNvOjyXbkW4MeLCVvvFpXQM2O4n6Aevfb5DeH5PnK799
         WzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299898; x=1715904698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=cx6C5mt/pgqJRrfFQ6B7kooQZOTeWeo3TklCE0g+V/hJEnwUUCn8DPuQsyj/pioIbv
         DjVE/XhmIVhjVrY6LDZildVJ4ExkF/YoRZoX7bZMbd3MyH3e9Q31z+QBT4T2EoI4hDv6
         vKLyvyTWDMv+cV9lxv0CF0J9+cDuislMowH4Dw6rQPIyxI9isGNqRWixYTqiT5O+9sbO
         W3lFyuzIdZLlABAU3Rk4wQPYme6ksq7veTUqZ4E19yRDdp0cqOGlM1Fz6BAEG0MSdDBK
         Xllc3/gK4Ee2WyZKxYLz910RfOw+bIIVthf6YTe63NftImkn1aFsyjK98zPoAw0I0vty
         CJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU05/2j8SiSgC6xGyaLMjKtXS6pTu2NIKHh95tDAhNFZJBwGO9EmMy2I3YBj21VIpoJIG6RGKi/L3T4DN2AkIMr7bCLXb83w9gzCbCt+RRh
X-Gm-Message-State: AOJu0YyhwUHUK/yRPsmjRflq/9CWkNEdjDWmM8ux3LNuk+njdu+bOWxJ
	EvBPTeftOCKQinzS/vQwoxgP5xUe+YA1j5pQ9BfOWr1w8ufgHnjmI9NfQf0OC1pOpmHxe1UbA22
	H1Q==
X-Google-Smtp-Source: AGHT+IHvqoyfuJd+zpWyzRtMJpM3tPkSIvIsjPanUafDlQuCX9siiHmpPTAd92EjaLgk71HiYZjK7/db9Q4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b31a:0:b0:de4:64c4:d90c with SMTP id
 3f1490d57ef6-dee4f4fb5bdmr99366276.12.1715299898422; Thu, 09 May 2024
 17:11:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:10 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-54-edliaw@google.com>
Subject: [PATCH v4 53/66] selftests/safesetid: Drop define _GNU_SOURCE
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
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


