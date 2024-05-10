Return-Path: <linux-kselftest+bounces-9958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60938C1B3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035391C20891
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2F13BC2C;
	Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDr/juiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2E13BAD0
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299886; cv=none; b=dUfjw3m4Kn0gKhKDTnneVNTx1u0mYg9KA52KWsB1B0byU/Kz5VHhbHrZI0c7bQlbR3upjnpzuJ4zrg9kPj4U76IIQ0ZMwLcqqcI4Vo9DmpHltr6OicEzsRPa/nsJoFPmwWhfXEko1wSph+H5dA1a79AI80s4cGBU9tTC3QiQH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299886; c=relaxed/simple;
	bh=2Hd7RVO2oQyAycS+cMBSvHkXH+GbjR8gypYKXDXO3so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgFx04UjHIInCq4z6Wn9HtYH4IEOC8MVi7Vlw+A1bC8P+P294hE4tz13G74gwHIG1/gA5cUWnyyOLD8wVyqoai9KKvZyBGiWP3ByZXbvj1DqYbi+GXz+RovZloEKncN6AeHZhw9krBlKGtWDjEsbkCv9/cHyKNFD2n1hObpfBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDr/juiT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b34facb83aso1425883a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299884; x=1715904684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=nDr/juiT9/zNodX5yvr5pUwsI3rUbPg8efciwqnMYworN8aFFupTmfNPrC9w/nXRrB
         SFIjAC9YRGovqgXyC1118ywtXhI7rFvSnD57uYVSZ6NLRyXEFnSMaze0+D8X7ktQ4Fzs
         DqhB6JXvOh6nBPnac7EqAKoRyszx/wiNEdGlHzOLBK89cHp/2P0Ud7NQY9lIsXG2l+yV
         JS+ve2b0rAd5qgdhHmJGkCUjBPfa1wViiYKcHoAx2YryidsBDbLXZa2DvEkOUMOw2qLk
         FniSHwOVIe79bQD7f93Q15yY0p7PNQ6dYKLXXvtnre4VGz+ny6qZzHR87Y0h8HeJDgNe
         Qc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299884; x=1715904684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=BoGqt6uarvPhIEbqC23jhxZcLX0/SYDZG0RHCGcN/05V0o1Wc8g7jGVqiXpAaUv/cp
         mjmV7xkDtc8xAniqnxIemfOBT6kWpssAw2LahRFgflD6BJrheFcqFs/cBKe4E+YUqMSa
         Aqh+uFJyoUswVHwv98V5lGu5UHI7cCAvOIKktqGxHWDFeHH5ulPzs6KVTaSF/jUNRbCT
         NNBNrrVwFmycNPbycSrBPHCQgP5+y1/svgap6mcYJXUjsDtZEsSqpT6g6R1S6Kvv+WSy
         aHJQi/elebGIliixi7e/WuwzBRR0GPiHcouQdCPtr9pmyoahuF57x1qPc03FpVJ40gVc
         Pv8w==
X-Forwarded-Encrypted: i=1; AJvYcCWbw35IJk57Qk6lVcrZ0l+B30fxoXt8Y8eOj2eiwFy2g4LeOBRmSR6CKJYDdVbNB6JFWNIG36XXlqdpRfjvicOi3yfbK9pPRrzeOFMpnNK8
X-Gm-Message-State: AOJu0YwLx8He9DtZvYUw8Fv+eJqC/oIOl3yTFjzf6vMPbb2CcVYSEW7h
	d+gB6YaP3y3sRMA4mqxoPqKljbmUo6Adope2KckCjVsYscL+/EMYugsdr3ggHfqV7odEjsWs1nt
	8Lw==
X-Google-Smtp-Source: AGHT+IEeA3HoMtx0riBcurUZp19Bisk3YOU2mcitL9911KMtdK5oYFtWJ3cEeUHag98MrRliuC7lKihL3M8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:c7d1:b0:2b6:c70e:d3b6 with SMTP id
 98e67ed59e1d1-2b6cc44fa2fmr2940a91.2.1715299883775; Thu, 09 May 2024 17:11:23
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:04 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-48-edliaw@google.com>
Subject: [PATCH v4 47/66] selftests/ptp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


