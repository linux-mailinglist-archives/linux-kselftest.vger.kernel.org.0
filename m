Return-Path: <linux-kselftest+bounces-9926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E88C1A93
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432041F21B3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C102DDC9;
	Fri, 10 May 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMwzbfWA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C453E02
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299792; cv=none; b=g63t7YLM0h36BlgH3QCHf7ZRNM+FGjqyQUiCWWuph2urqbbkG0cJxFaoLEDEfoZW0mdprqNCtB0FR1fYxutv42LWBatdz80vW++anYcrRbOerD49EAP1tpMr+Nm3FEzMiazC0qH+VW0EPURpNAuvS4m8bl12SvF3R/EUdcVEcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299792; c=relaxed/simple;
	bh=fU2P3ohii6eOx7fFDBDMrp0qI5AdjDGRbNifJZQ3D6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPYQSUEh962UYKo5OQLeqm//8mJQOkFelwCZGajDVf25Vmc9LHJbGIjF8PtIhCRvWQFn+t10SI/p397vz7vNmpGW+jBHXhdyhHpXoDb2mUu2QJwwQKsFcUv62pFkQVPwoi10/S00R+P4C6/jH62YqN+yr8jpzpDJA8XQSNBv/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMwzbfWA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be530d024so23421737b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299788; x=1715904588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=iMwzbfWADYzCPMDndmgHFn00o1+BKONgdmpKKz/Wkkr0HLzaVF+J1f3LYTBpjPATO+
         0GPhQWJzqA2gUUTcg+Bmrch6B2+wMsCg0mtPwSgddyM+8YVxwytm6PLuWox3nzv5bHYl
         1RMApk+i2xo/cf7eEQ+o/AL47bG/eqQXgxgvlynmEP59kSiVaObm6e3Y8vqpB8mKd00Q
         skYW+49pWncMcJcj2JYo5kTodhI8irLgyi5+7pV2nM7EyJyuUOc//Jf/yhcbUIS9Q6bq
         8oIrnGXkObXCVOw6znLLe+uq+nJg7ys9+I1VpcNjI0iu8k+n1BEK8wvPxu04Hgivfgx+
         bdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299788; x=1715904588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=PN+PmpRTZ5ixfcBqupQx6wWbMSc8m0f/ZESIXHuiqYgYV/XcbdEuX6uC1jgl5BwMHm
         O3gdyk0ftubmllIdOgd4Ch13YweT0jdvIzzXU4LajZ8D88FAGkTlpH27PQMAKlDTLorg
         uYMYFbROTzTgxcy6m/qAyNnZEJt6quqKZtoteDSZaRsIOKrt//0E1aq9cwgquRMNJHZK
         tpSHRqDziMlL6/mrC3uVYtQtxY1mplG8VvYU+zbi2Ky080h66qMn2zjFOupoLQseDj4A
         ZFCFuQ3zSBimKZZkUTHRx01VRGjIjx/D/gztPYFmrGbNcbE4t8dY+6qLRuwyKgjRs6rU
         DhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcjLakB+5AZhBpuR6oP88vDOTrchOn6ZfFVVo1MN0x+6EWJ8gazXc0+bVJ+/ueKjsEFmzk4Gs4C0iutjMvTmPsSLycsZ27LXFOlWuDk1T4
X-Gm-Message-State: AOJu0YxGALrsBJq9fHTO9rXNxecT82n6uzudP5+jPt59ThxdPMNca9Rt
	eD/VCR8TYhd0pzW0eqr4P7Qh3+PZ7kAFnJd+2FtX8afMIsUh935q/2+jV4DEytkiaoD1GryIGOw
	2WA==
X-Google-Smtp-Source: AGHT+IGVLgMcKP7k6+jbHoBvicQj4jJfGTq3ct3mJmsySja7BFFB2IfjyDeVqng7lmOeRf+Hm3qC1VhoGlw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6211:b0:618:8bdf:9d56 with SMTP id
 00721157ae682-622afffb2b1mr2640537b3.7.1715299788317; Thu, 09 May 2024
 17:09:48 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:32 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-16-edliaw@google.com>
Subject: [PATCH v4 15/66] selftests/filelock: Drop define _GNU_SOURCE
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
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


