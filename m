Return-Path: <linux-kselftest+bounces-7368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EB89B911
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD031F21BB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B117462;
	Mon,  8 Apr 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gudJfyv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F372C197
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562424; cv=none; b=Zl7dIrcVxlvzSSL0p0jYPYeI9rTggBhb4LCleHp0NbTQYCJe5Wvr50xhlMDESxYAVuCnla4+5BW42GML/c88dWxIxKrmMd8zPgi6oaSwY7yxraib0xUaiNsLE2d7HQYoBa9ufOug7Y/qMeZRD7OX4YLYuDQVF4+xD9DwMGVbKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562424; c=relaxed/simple;
	bh=D9YH4Sh4CL5memGtOap6zXb11ax+yAGeO1p+lPfMKeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N92AedQ8afR860CdGHSZM8RKNh0dPHHu/Df9xJ+rUg+RV08XNl5e9SeADuMRexwWUswITI3mZ1Igxr4tscgghw/NZ4ZwqXJrIFytAts0dLcrm2amloZ6JoHLzzlzaRTLqwAsqMOpAIBWyLKIGUckCYdUnULiN9nTunjHdquGk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gudJfyv8; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4X59ClzQ6b;
	Mon,  8 Apr 2024 09:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562412;
	bh=D9YH4Sh4CL5memGtOap6zXb11ax+yAGeO1p+lPfMKeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gudJfyv8xv3LsbE8AjiGjXm1dcThRZhmdQa7BHsFq7fhDuJonaMBlORbQhzTK4PyY
	 nz5G3rh2hnjYoy/xIUH/HnoRvo7YhvEktWOXxWu3L8DtSuxrOIp7vG0PVPt2/48QDs
	 sHplU64y9r6Bjn0B0h8oApD9dXHFnynmrutNAIeQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4X11c5zgkB;
	Mon,  8 Apr 2024 09:46:52 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kunit-dev@googlegroups.com,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 RESEND 1/7] kunit: Handle thread creation error
Date: Mon,  8 Apr 2024 09:46:19 +0200
Message-ID: <20240408074625.65017-2-mic@digikod.net>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
References: <20240408074625.65017-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Previously, if a thread creation failed (e.g. -ENOMEM), the function was
called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
marking the test as failed.  Instead, fill try_result with the error
code returned by kthread_run(), which will mark the test as failed and
print "internal error occurred...".

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-2-mic@digikod.net
---

Changes since v2:
* Add Rae's and David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit/try-catch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..a5cb2ef70a25 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 				  try_catch,
 				  "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
+		try_catch->try_result = PTR_ERR(task_struct);
 		try_catch->catch(try_catch->context);
 		return;
 	}
-- 
2.44.0


