Return-Path: <linux-kselftest+bounces-12578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C27915A65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857F71F24C98
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D51A2C22;
	Mon, 24 Jun 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgjwStqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B01A2C14
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271738; cv=none; b=LFhfY1L2VnxHyOcQ00z9HaWkxeo48/XmkwMzDYECwREAw0RVE+kLusnY2XiuFO8RfqKU0c3C6JyuzAo8okfsvVEHOyPfDTX2Yj2mYu2huFPeqmmw6xext9Px/c9MydIJ0YYljy6+VQr66FaXNuuC59PlqWBMfeQctComkav3wHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271738; c=relaxed/simple;
	bh=PoyedOSrLslMpcZQkdr7wxw6LDAVWLOCZchvs+PQ4E0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QFnsk7wz65IFLjKapB9DWJIsK548vdFTOrs4mU+mc0iX7DrYdlZchfUvLGi5zJB0M1fU9texBMuIaRQdIEA+sWIqZ+JzvMTBQtIhQUUGU6n8/uDp3RL0djzX+KI/pNEzwlOARYksLbo3vq0Winj839DMHP0AZmLfGeudIRmgr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgjwStqp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b58759c2so9681342276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271736; x=1719876536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEnvDY+YQtOlDLldfWY9bO5cHBXotclBQZRJTAhLrGQ=;
        b=dgjwStqpJK2cevyFHSqu82OowcDEUjS8BXpZhl0dqSJZwjKmAHE6Zt2BWb3AMmkf66
         UW6rL3FncfNPWL2flTT6rP3XRmxsQKYJLVIQhMh9CeQifzA8puyrttkYt/KANShPdXpj
         u6y817H09ijBYdBTY2wrYpzrCdr21uJqejv4uPRE0bJ9pLn3dq8LHBP7SZ6pnizft7Pl
         s1xycHgo4J8z0D/1o1ufNRMTqKusvEQAgmC6ZSwMDNyjD+7tuc50KRNnAMisyY7w1sb4
         AjNApIRFtg09/FCD2LI6poJmOHd4eTdWjTsSUpF91UWUNmJqdTTL9CIFGSOVZwVhjmfG
         VGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271736; x=1719876536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEnvDY+YQtOlDLldfWY9bO5cHBXotclBQZRJTAhLrGQ=;
        b=wyiNS8fRuANtoU/upmE7d6D0bxMhIxmZJJfHzH9m6/PIh82j/Xp5j9RIiPgcQsSlto
         m85G85S80BwUDoq4A+rOvtXiHOKKTvNCskLhQRz+O6EAE7fIiwF3bmQzpdMXDWd2kahv
         r4wa/FcVtc+bvLBIFUFdvCAUKav0uJ6zmLcJfI+BqV50NxZg9KsBuF+Xv2gtJ2i+tp0Q
         O7PzmuesbNCIfBLkjddL9O9rIfRwFFTYCc1dVe7xovehBCNa5m1fY9yCvI8+oPjcv9dQ
         kuvDsxo2LM38Gvjutm/3mpef7JGV3+mK/HeXep6y6cWZzdt7Uv2gIu0NXfZ9BBWt4aCj
         YPag==
X-Gm-Message-State: AOJu0YwmRcW1ecngo/Itx2ZO/eGjh7ZZKNL6BETkoshJdv/14/2aSOIw
	wsI/rcFTf74LOfLZMndvrgaWz9Yd9n1UsQtqu+Phfj7X4iDYhLf2YW3G5Wi/uA0yRXURnEiXBg4
	Oi5w2et/7LUWO5K0/G9ParsVnUg5AIRBByiVYXTLGQIoyXZw/x0n462TElHR0ehyaND9mGeW/im
	j5B0WIoqpYdfkPP0UMj8n5d3jvRQjyz76zNrEykuE6tvV8
X-Google-Smtp-Source: AGHT+IGo0nBr4OMWeDQdXO7gLmA8943vaa7AUjGpvpzDg1f7Z8BrI79oFtF9sCT7oXO1KDCB6pUDmCcxQng=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1081:b0:dff:4788:ea88 with SMTP id
 3f1490d57ef6-e0303d692f7mr20462276.0.1719271735356; Mon, 24 Jun 2024 16:28:55
 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-1-edliaw@google.com>
Subject: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Centralizes the definition of _GNU_SOURCE into lib.mk and addresses all
resulting macro redefinition warnings.

These patches will need to be merged in one shot to avoid redefinition
warnings.

The initial attempt at this patch was abandoned because it affected
lines in many source files and caused a large amount of churn. However,
from earlier discussions, centralizing _GNU_SOURCE is still desireable.
This attempt limits the changes to 1 source file and 12 Makefiles.

v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
v2: https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@google.com/
 - Add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
   location.
 - Remove #define _GNU_SOURCE from source code to resolve redefinition
   warnings.
v3: https://lore.kernel.org/linux-kselftest/20240509200022.253089-1-edliaw@google.com/
 - Rebase onto linux-next 20240508.
 - Split patches by directory.
 - Add -D_GNU_SOURCE directly to CFLAGS in lib.mk.
 - Delete additional _GNU_SOURCE definitions from source code in
   linux-next.
 - Delete additional -D_GNU_SOURCE flags from Makefiles.
v4: https://lore.kernel.org/linux-kselftest/20240510000842.410729-1-edliaw@google.com/
 - Rebase onto linux-next 20240509.
 - Remove Fixes tag from patches that drop _GNU_SOURCE definition.
 - Restore space between comment and includes for selftests/damon.
v5: https://lore.kernel.org/linux-kselftest/20240522005913.3540131-1-edliaw@google.com/
 - Rebase onto linux-next 20240521
 - Drop initial patches that modify KHDR_INCLUDES.
 - Incorporate Mark Brown's patch to replace static_assert with warning.
 - Don't drop #define _GNU_SOURCE from nolibc and wireguard.
 - Change Makefiles for x86 and vDSO to append to CFLAGS.
v6:
 - Rewrite patch to use -D_GNU_SOURCE= form in lib.mk.
 - Reduce the amount of churn significantly by allowing definition to
   coexist with source code macro defines.


Edward Liaw (13):
  selftests/mm: Define _GNU_SOURCE to an empty string
  selftests: Add -D_GNU_SOURCE= to CFLAGS in lib.mk
  selftests/net: Append to lib.mk CFLAGS in Makefile
  selftests/exec: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/futex: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/intel_pstate: Drop redundant -D_GNU_SOURCE CFLAGS in
    Makefile
  selftests/iommu: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/proc: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/resctrl: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/ring-buffer: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS in Makefile
  selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS

 tools/testing/selftests/exec/Makefile             | 1 -
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 tools/testing/selftests/intel_pstate/Makefile     | 2 +-
 tools/testing/selftests/iommu/Makefile            | 2 --
 tools/testing/selftests/kvm/Makefile              | 2 +-
 tools/testing/selftests/lib.mk                    | 3 +++
 tools/testing/selftests/mm/thuge-gen.c            | 2 +-
 tools/testing/selftests/net/Makefile              | 2 +-
 tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
 tools/testing/selftests/proc/Makefile             | 1 -
 tools/testing/selftests/resctrl/Makefile          | 2 +-
 tools/testing/selftests/ring-buffer/Makefile      | 1 -
 tools/testing/selftests/riscv/mm/Makefile         | 2 +-
 tools/testing/selftests/sgx/Makefile              | 2 +-
 14 files changed, 12 insertions(+), 14 deletions(-)

--
2.45.2.741.gdbec12cfda-goog


