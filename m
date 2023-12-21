Return-Path: <linux-kselftest+bounces-2296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87181B3E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9169C28199C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D076ABAB;
	Thu, 21 Dec 2023 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wbuvniu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E486A35A;
	Thu, 21 Dec 2023 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL5AA93026850;
	Thu, 21 Dec 2023 04:39:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=PODMain02222019; bh=8swxHzLIkGDzxO
	I8Vz/Y9c2HnswUaOPTF6vff2JboJ8=; b=Wbuvniu8ayMnN13D8UbM+PrBpqBKl0
	EJ7oxwH1b2NXi42Q9t44nQD72ACQ7e0dWv64s3xBf118yFvdNQ3bSgivqpJ21HSv
	1vmtSpFg1V7h0R72WTYK4udLVqfAnM3MuiG28yF6VKc74aiYbMs6P0vti1TT/91q
	eZOGSSS1zyj/E0FxIfwMFm7HyG27gez2dBSUhAe5oI+Iv/K7fH4zgcZk26cUU/Q2
	NjbBGB/hmN7CF/qiGV90vLcrowjnvqjeIQtN+HjXlFdf7TOUj60pePmxuP32/H4G
	Lx9b/Mbh+6CIuRCWrI2vZVuQqWgTHQuu1DD3U5DpAMA6Prz49D8P/j7w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196nf3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 04:39:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 10:39:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Thu, 21 Dec 2023 10:39:00 +0000
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.187])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C722711D1;
	Thu, 21 Dec 2023 10:38:59 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/2] kunit: Allow passing function pointer to kunit_activate_static_stub()
Date: Thu, 21 Dec 2023 10:38:56 +0000
Message-ID: <20231221103858.46010-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iyZnRFjCVFG0a-1xJ0ABpQ3lQ2HcCyVa
X-Proofpoint-GUID: iyZnRFjCVFG0a-1xJ0ABpQ3lQ2HcCyVa
X-Proofpoint-Spam-Reason: safe

Swap the arguments to typecheck_fn() in kunit_activate_static_stub()
so that real_fn_addr can be either the function itself or a pointer
to that function.

This is useful to simplify redirecting static functions in a module.
Having to pass the actual function meant that it must be exported
from the module. Either making the 'static' and EXPORT_SYMBOL*()
conditional (which makes the code messy), or change it to always
exported (which increases the export namespace and prevents the
compiler inlining a trivial stub function in non-test builds).

With the original definition of kunit_activate_static_stub() the
address of real_fn_addr was passed to typecheck_fn() as the type to
be passed. This meant that if real_fn_addr was a pointer-to-function
it would resolve to a ** instead of a *, giving an error like this:

   error: initialization of ‘int (**)(int)’ from incompatible pointer
   type ‘int (*)(int)’ [-Werror=incompatible-pointer-types]
   kunit_activate_static_stub(test, add_one_fn_ptr, subtract_one);
      |                             ^~~~~~~~~~~~
   ./include/linux/typecheck.h:21:25: note: in definition of macro
   ‘typecheck_fn’
   21 | ({ typeof(type) __tmp = function; \

Swapping the arguments to typecheck_fn makes it take the type of a
pointer to the replacement function. Either a function or a pointer
to function can be assigned to that. For example:

static int some_function(int x)
{
    /* whatever */
}

int (* some_function_ptr)(int) = some_function;

static int replacement(int x)
{
    /* whatever */
}

Then:
  kunit_activate_static_stub(test, some_function, replacement);
yields:
  typecheck_fn(typeof(&replacement), some_function);

and:
  kunit_activate_static_stub(test, some_function_ptr, replacement);
yields:
  typecheck_fn(typeof(&replacement), some_function_ptr);

The two typecheck_fn() then resolve to:

  int (*__tmp)(int) = some_function;
and
  int (*__tmp)(int) = some_function_ptr;

Both of these are valid. In the first case the compiler inserts
an implicit '&' to take the address of the supplied function, and
in the second case the RHS is already a pointer to the same type.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Rae Moar <rmoar@google.com>
---
No changes since V1.
---
 include/kunit/static_stub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
index 85315c80b303..bf940322dfc0 100644
--- a/include/kunit/static_stub.h
+++ b/include/kunit/static_stub.h
@@ -93,7 +93,7 @@ void __kunit_activate_static_stub(struct kunit *test,
  * The redirection can be disabled again with kunit_deactivate_static_stub().
  */
 #define kunit_activate_static_stub(test, real_fn_addr, replacement_addr) do {	\
-	typecheck_fn(typeof(&real_fn_addr), replacement_addr);			\
+	typecheck_fn(typeof(&replacement_addr), real_fn_addr);			\
 	__kunit_activate_static_stub(test, real_fn_addr, replacement_addr);	\
 } while (0)
 
-- 
2.30.2


