Return-Path: <linux-kselftest+bounces-9163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43E28B832D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B361C22AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55EB1C660C;
	Tue, 30 Apr 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Yx2vh98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E721C6601
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521080; cv=none; b=tvoyv7F2hpNtw8kUY/ykFqSqBi0ENzFU+D11kCTOz7DptHHPfFb3eb612WC7/AGCowdjZ2ZxQB7BVuxLu+nqL7vQj/QrOvy4cJ/w9Nkclt/wvvKRfeUC2jVRFyAXV3kZ8rE5Vc6w0R3a4UFJXJ3zzyU4ROUnO+LQ7J/uzhj6pZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521080; c=relaxed/simple;
	bh=hoKCCWVOkE0ESMxaMi+qTIS8AurEZYZfNn5Rvt++a10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGF+zdUwbXtpaykFZIGICop5AZYh0nUj5SyoPefX8f1P2Tv48hq6kckmxCKHFeH9wqTlcKSrh+KSf2WifFZhgHk5ifqhT+HUOOSuxfe3Pq+ZqrbSQ+zxWpksoo7mad2IHu/0HHrXioYGFKP/nmP7wSmE1FMgBcXPgf4kIpsHkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Yx2vh98; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so15237364276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521078; x=1715125878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjaSNnvftOLawQ81uXTzdayleIIMFIclLDs0BuljtK4=;
        b=4Yx2vh985eAUe73b/Mn7onj2pzj/LBoS71ImaFxNWPt/0DIGzmxTlaskzv3d+Gb+Hp
         L2oyQ8B+7Xe0YZPUQst64aeW5xQCZJ9QXvCd83LpZL4+vT/DG5ys9nm6CxNHyB3q2+Mr
         j9r4MsmhFMUh7tLzhQZhsqgCwU0ukuUnqw5JUzUZxw4pwyQPvzdILp98ErP/aW3/auMy
         F/8HNoZtgvnD+ZwgUY7EoXvui5bBGspVCW3oSJhWFO/pKtL7j3F5MTOtOALW1shc33DW
         Yen84kX/hc1OH9b/W8IWVNIozK+opZC24W78s/cOLHhVbp2x5QLhClbx9YC3xI7RLrCc
         n65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521078; x=1715125878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjaSNnvftOLawQ81uXTzdayleIIMFIclLDs0BuljtK4=;
        b=u/4Q5kH2+BIwIFybcnhXdw0FxzBTji0hlFdC0optMuETZkn16rreLnc2jZU55rymj+
         dVM6lyhRItv7B+IhKwKxiwp9ugr0PPhc5r4nre1aq3qjFIRbJUx1FStNDmpU9Em2lWJo
         h+eTydqhRny2j6VNhnWp7zMzbu2h5uJbutCGF5NfrfdtovSB3KE4I9XwK+yTsQIdUzpR
         yz5ZHa1tQlHlJDKOXEqAdjoA0gJJSXXsfjRtkBQAEPGeVAXsOkGwN/L5Vo/7N5IMxilH
         yWFTOhMv4eZMWpLjPFXiq7rgh2gtbCorLvUBX8Ds39CH6XrEH4rzVfySOMRhPdRnG0ne
         JG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXn+mJYu/Zl+d0WMr7ZTdS0WfygNFagXbndX4oMLt8tWznnVCZrKXrm8CSwfkA0aIOPeGV/DXtdY/CKCqLvvJRjLGdYWcPbQwyalJ5FJu1o
X-Gm-Message-State: AOJu0YxI86X94tanRcenIfMxbhsEP2SXZeSidQe5ezPiwoGFBrjuSIln
	V8owcN3S4wM616zgVUTV+rUPzT3YoiQaocukIODa+Wxsy0/7Be8DOXfCeU9r95pt3AMNuZbk2+4
	9Yw==
X-Google-Smtp-Source: AGHT+IGPMJHhRXW4IxX0wuIaJEnkwrFiECPVYI3NjrGHekGnxptI0a1rv8ukdUNpyZcLuFV1IvoMatGim7A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:150a:b0:dc2:398d:a671 with SMTP id
 q10-20020a056902150a00b00dc2398da671mr352958ybu.10.1714521078081; Tue, 30 Apr
 2024 16:51:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:10 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-2-edliaw@google.com>
Subject: [PATCH v1 01/10] selftests/sgx: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/sgx/sigstruct.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..272da790d9ae 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif

 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -D_GNU_SOURCE
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index d73b29becf5b..a0c2de7c5302 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <getopt.h>
 #include <stdbool.h>
--
2.45.0.rc0.197.gbae5840b3b-goog


