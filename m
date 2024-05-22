Return-Path: <linux-kselftest+bounces-10541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39238CB80F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2301F2A374
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F63157A74;
	Wed, 22 May 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItcZRn/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C315749E
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339732; cv=none; b=iD88GZ6w1FMFUwM3gq96TX4bfesADSxxPSdNK0GLoAz1iFr0nGMvEYf9Pb6CIzYvz/Ess1eGb+yfEfxyzFWxJ4JlxBMzmzdRUD0TJURhGVYPQILQHYp6er8Hi1dXcsZr7bcJ1/GPYHMYh5e/5e/LIvKXuwZ9TZX+xj193mrd6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339732; c=relaxed/simple;
	bh=dJ85qN/xTEbZ63SxHH0m0xAmkKXsbnokjAxVAVbXUYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FPJd/OmcaurLjoMRxPngwYLgMyO2H0XApOfTQ0PLLjTRfkvDQYtq/FZmresqS7hSY1nuJucGLAFn80jaYZ/n4MRp2BcgZkOu3Ho/6HSA1cpvmy7sWaQuh6FDnEOzwlglayOcMoHFUNOFUK5gSBVQH6r8VokKX4Os8if7PGZOKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItcZRn/q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-658b03ebe58so5654343a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339730; x=1716944530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fXSc6I7YRPoBA8Qsdus0HRtiChwdWQfuChuYoJ2sTo=;
        b=ItcZRn/qKy0+dMoDHGMHF3oVnRGIuHr520WDVebGSTwNdUlB6hTHiFCioK9oRDxCRe
         /qojIVW0aTa6EfnvRzyvptrf5EgfOi7cI0jYb3u3YGl1kduogCAG72SJtVwBQGEBgTeJ
         sRJ9SQZvaDXDtErpyA9UtsUOScr9CFJJsweFtmNyatXusEu7Yjio2JyIj4rP+1YKYwzO
         5AI6uHiNgh4vkw/2LylW4XY2t+acjxUwT2SrnRH4D/0UaEyMFw0t9LDy6SrVaxz3KgJd
         TFbSRcATbESjj+Mi2xIjVEsaiNz6YuFfmmI5xOWwufXXjmJppsBzX040SWRdrR3Peybo
         s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339730; x=1716944530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fXSc6I7YRPoBA8Qsdus0HRtiChwdWQfuChuYoJ2sTo=;
        b=WUSjZUqTAo79xoPDReDg0k735ARwvvUVY5eK6my3ZWkL8WwduizDblA9snBNRdxA7u
         ZIucf+s4aIByFW8f/Q70+ULXeXDy7Bb8KSd8njn8y3OzRrmZFb4ClmIVEcRzU/dporby
         xUCPL6TDlklTuOcbYD8rDLQ2DnTog9X8xjrG1UMCs9OfKZRsPJtNPqt21M9ZnpSE/Mwy
         UxG4Px8HQZqpnqdCHkC4lgCFdFbMsuDUu2tFtLfRAfaGphi4T+9sPBSjN9vNWdHfbq/5
         ntAB+YL4Pbuzfg6kwDSsz+GxUDAhu5G0wzIZRJPM6mfyo1kdiZz79hBE7aHoBJdSFNEn
         yOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXML7fRAp5ql1iJ/fzMTXk6DSE2jddtk5XIphbASp850r4c9UYndmVWCbuu54o5Qo1YjN9AIBOJ24mHtY02bU4qefWhNFP+vUFOkKcc98Ye
X-Gm-Message-State: AOJu0Yzc4H3YlmUkMRCuTIVMSs52leWTtkEVIJ2dY50yFIJmhN39tYnV
	s2z/CdzoLB5uR3lcMfAQ/YE3j5CSYtIS95HSjM5EujyaA0oDFtJyS3RaRJJ4d9r84XW414FRY7K
	+aQ==
X-Google-Smtp-Source: AGHT+IHRMV7k1LU0lDtq57tRvT7lk2XfR2s4R9nKcPSkC/DgzGkI8VQdGVam1DqlKbogDEXoBxPpDW2FdZ0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9250:0:b0:673:9f86:3f1d with SMTP id
 41be03b00d2f7-67647ae60abmr1189a12.3.1716339729367; Tue, 21 May 2024 18:02:09
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:40 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-55-edliaw@google.com>
Subject: [PATCH v5 54/68] selftests/sched: Drop define _GNU_SOURCE
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
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 62fba7356af2..abf907f243b6 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -18,8 +18,6 @@
  * You should have received a copy of the GNU Lesser General Public License
  * along with this library; if not, see <http://www.gnu.org/licenses>.
  */
-
-#define _GNU_SOURCE
 #include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-- 
2.45.1.288.g0e0cd299f1-goog


