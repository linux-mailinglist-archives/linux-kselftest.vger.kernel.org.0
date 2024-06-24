Return-Path: <linux-kselftest+bounces-12591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D287915AAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE92728A2E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437B1BD02E;
	Mon, 24 Jun 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxcHu7J8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACF1BC099
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271812; cv=none; b=RE93WXq1NTIDo2FtvjqCwi6bWk+N6A474Kpamv4l7Qp3kPzFISpQb8bUKyMrmGBRV8GRv2+rloTKo00c5/UbQnPJHyWOL6Je0e/rowRe1eJ2b/K96lpvTSxODQNWjMPOYl+rAsrQRwpEej2HidavnTSs+pBrIsmkWJ1tXYF4Wh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271812; c=relaxed/simple;
	bh=yboJ131KH75Qql/fVo88i+jFE+X+ykOpyD/H9YpbbNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWmuvxwvEEkbVusKurKQpzFcL07EImuNIc4YTLc/JyzyY62fPy8S1N5/m1fOov4liNcXkJCWYCzzJArhjq+5C6s1IhHCAk4IPcBmbGPErhj9899qnRl9MD+1+j+opQy6vM9hhJCTqlqnPqDohLIWYby8d+wN1gTVPckfLMG1DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxcHu7J8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6716094a865so5941669a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271809; x=1719876609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=RxcHu7J8GG9ooEU1mQavdUQ16Ty88aMw8u8vyst3/5Wy6bFDzVZIw3BqXMHyX7LcG5
         EOZ5LQ81/SWPzmyMwy6F9VDV90ckNKZ0G1219wQO+zFwrY5lZ9KVp4uUmTSVshD8AwAW
         6ELNXt2a+LzWSMCxKNhozkLCtR4AxkUH25E7Kzf516SBnZ9hXlTbXDklqBpryC/Tj622
         K51KcdxL9heYhSkNi/sHnkmei1K36Y/nds6JXSRJj7oUfPucRTuov/HFzJ+F0AdMU8Vc
         Sc7acM8oiTugct7mA0KbbLWBWBW7Z2VfQ0auNSlS3AJjdhd1SNs6KnSdnEST0XP0ADlB
         r0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271809; x=1719876609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=CmIryN0UwWAnPogymIio0Vphif7BuYoLIDbkkRCCjxCJ7hRf1jS8YZ8R6R8k46eR/S
         cbeJEQzbiZLvTySQmpR9U1Q4/VG3I7J944WP6O7IBIAkkZ0HOcm9YKePDTwXudUKeKtP
         EvoFCD4fSUsXTlOmRPbut4hrIBxuwGtEO2ay0K5RiY8jMVmnZvWpHAAV8Am21CXBb6hW
         F19kYJgfxCjJJw/holz5H4P6OUb1rn0YI9aq9OiaY2EqAkUyb+/HNJwBCHaHCu4nms9k
         Tav/1PWUDSd88+nWkOscxxD0S1jqzp1FKg5LXbXHS+MXQ/Xa+vWlAOnnn65sA/ADS0wV
         dJNw==
X-Gm-Message-State: AOJu0Yz6Yvf4jwbb25pOYY1kYMSM1U/U3lF/u+o9gfvbML7WjjiZdYGF
	tqbKcQZ/ROdcRa2C9K962XDE8I0yQOE5RLVtJlIlv8TZaIOwpDniV0TNJXM4dz7NVpBdWnjC1+H
	tJxeGJ+WUoYqy8LouxpYMT7nxThImKzCqJG9ocxNI8HfizK/H9TqCBcmYJZLN2zDYlY39Uqg8FI
	Dx8ZnWKkD8C1RAyc/2z6q4nDCnaELcDGLqA57Xyo9p6QDo
X-Google-Smtp-Source: AGHT+IHcaOj/Ro9h0704QE00MFW9hpEi3kDY+mehE3/RAXufwF49RwalyubuviiuKxGcrX2qWa70mRNXqFw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9d83:0:b0:6e9:8a61:b8aa with SMTP id
 41be03b00d2f7-71ac38a3772mr20790a12.0.1719271808040; Mon, 24 Jun 2024
 16:30:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:22 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-14-edliaw@google.com>
Subject: [PATCH v6 13/13] selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS
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

lib.mk CFLAGS provides -D_GNU_SOURCE= which is needed to compile the
host files.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..03b5e13b872b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
-- 
2.45.2.741.gdbec12cfda-goog


