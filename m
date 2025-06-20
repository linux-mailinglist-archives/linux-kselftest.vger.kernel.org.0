Return-Path: <linux-kselftest+bounces-35495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B8AE260B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A145A4DEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F64624397B;
	Fri, 20 Jun 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZTm+7vo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E824167F
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461668; cv=none; b=aOMLOl7h0gCmVWM+iimIq0IxyJcDxMun34DfldSm26F3h2ovkvEyCqUEo2K/sfrLKMUF0Zd/DB4OWH/AwYO/HMD+5x80qwABFISMKiGr2jGNMqlaaPlfKc5cxwFSLkcv5kj92eiPtXWKe8y+/tPmHRQ9MpB1KxSeu3AI/GnGtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461668; c=relaxed/simple;
	bh=cfbcYQT/0EULNPGHPrgqVQx8XCxpvqx3I53+Aox0UdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCEX9fGa+SuLqx2NwRo+WLbjEA+xh4L6eLCIAon+A+oFMr96ZUEB2xNXUT8OJ6t8bN2aJwKOB/AZBVZri/gSSyi7TY5ckV6FpW2cickm411he/5oAHDp6VV3izRUVorXA51b1X7VJNYiGQf/ZQtm3BFl0pnv0O9UIWxPy2MYAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZTm+7vo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso1961959b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461664; x=1751066464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=APzdfr9A/hBMbv017gVqLgGBcbquIdHEboqu0JTdsJY=;
        b=FZTm+7voSXZpLkmB+5KdlIgyAWfNmOng1UHRyN6V8vycQah6G3YEpexX5wrGwq2vdD
         HAGJDEwY2XFI6icNE6zS9ZlMxLuSCr8r8Y0QF53wO3u61xM6p6aPS/OxHMEMoJG0FGBi
         RkKyQiSM8juiv8RPQJ76IfB89duEpIWBrSEcyR+ot463GZbsy/WM8LC7my8Boz9MGqha
         2KlJbJeKrPRxUHNSSz7O1F+GIiguoBY17KKcMSDpRxzXXK9uYuhjLHuFueewWxETP/Gi
         7+Au1qRnnK0SMG4UzclY0j3yH34C4d6XsL8WkyvJuTsiNfJ5yyYAkFuAOjVDTYw0jpoL
         cQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461664; x=1751066464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APzdfr9A/hBMbv017gVqLgGBcbquIdHEboqu0JTdsJY=;
        b=OJQgT9MGA/sXJDVtbuqJgIUp/cpD5E3XoLqJMVSCYDTRmldHHiAek/S4w1WvQgWfDY
         UbgVo19xGFFQbdo+2UefndvouWrbauus882Ou868s8i9To/d7mMiKYghA47Iy7q8Z6lP
         ePPwW2fzZTnGsBT3q7cV+x7NXz/Cl0x6i7pE6yBntM74FMMpRF2rLDjDlTbBt80AoEy2
         gQOV8jmJj9V/nNY4bPCdgAzH7z2YvABFNruk3fZZxo+g2wUDtg5k78sFwxVM9s0kcarI
         dTLHKMIXXk4rHUZ2sS5hk3OtliScozniU0QZBstrXBSt7NsdkETlPySwAEzMUBM+LrnY
         +weg==
X-Forwarded-Encrypted: i=1; AJvYcCWcHCTYQE48PFE3D00eDaV7KrrP6UBgKI+I0XoxZBus2KVoKrpmPBQ1YUadbRfeCrfhPZ+ZyaRR1NgRtsHguzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmXRUGD8PEGv+N+1uEMv2kaWDB/s824uI8CSB2SLedCRtHXtY
	YdX/7qdW6SwQWlPy5bx2dMWRrr6mWpYltYm1b7iq4Bt6yOoWNOoxElhv4W4hRcNzxYkoer41NSp
	I+g7gNpFalrDLdQ==
X-Google-Smtp-Source: AGHT+IFgW5K83UIJEpwFN6RFNHRki1SO8HNtAgwjEFZw5Kh/hAeMfrNShDYFKP3Z/3/2Q+Anjx+OcmKywoGJsQ==
X-Received: from pfme9.prod.google.com ([2002:aa7:98c9:0:b0:742:a99a:ec52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd4:b0:748:e38d:fecc with SMTP id d2e1a72fcca58-7490d71c76amr5373142b3a.22.1750461664562;
 Fri, 20 Jun 2025 16:21:04 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:19:59 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-2-dmatlack@google.com>
Subject: [PATCH 01/33] selftests: Create tools/testing/selftests/vfio
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Create the directory tools/testing/selftests/vfio with a stub Makefile
and hook it up to the top-level selftests Makefile.

This directory will be used in subsequent commits to host selftests for
the VFIO subsystem.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                             | 7 +++++++
 tools/testing/selftests/Makefile        | 1 +
 tools/testing/selftests/vfio/.gitignore | 7 +++++++
 tools/testing/selftests/vfio/Makefile   | 2 ++
 4 files changed, 17 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/.gitignore
 create mode 100644 tools/testing/selftests/vfio/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index f2668b81115c..79a096dc259d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25900,6 +25900,7 @@ F:	drivers/vfio/
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
+F:	tools/testing/selftests/vfio/
 
 VFIO FSL-MC DRIVER
 L:	kvm@vger.kernel.org
@@ -25972,6 +25973,12 @@ L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/vfio/pci/virtio
 
+VFIO SELFTESTS
+R:	David Matlack <dmatlack@google.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	tools/testing/selftests/vfio/
+
 VGA_SWITCHEROO
 R:	Lukas Wunner <lukas@wunner.de>
 S:	Maintained
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b5..ad6312cd2338 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -123,6 +123,7 @@ TARGETS += uevent
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
+TARGETS += vfio
 TARGETS += x86
 TARGETS += x86/bugs
 TARGETS += zram
diff --git a/tools/testing/selftests/vfio/.gitignore b/tools/testing/selftests/vfio/.gitignore
new file mode 100644
index 000000000000..6d9381d60172
--- /dev/null
+++ b/tools/testing/selftests/vfio/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+*
+!/**/
+!*.c
+!*.h
+!*.S
+!*.sh
diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
new file mode 100644
index 000000000000..2bba39aff5d9
--- /dev/null
+++ b/tools/testing/selftests/vfio/Makefile
@@ -0,0 +1,2 @@
+CFLAGS = $(KHDR_INCLUDES)
+include ../lib.mk
-- 
2.50.0.rc2.701.gf1e915cc24-goog


