Return-Path: <linux-kselftest+bounces-2160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A981770C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEA11F26539
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708F4FF65;
	Mon, 18 Dec 2023 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gt1cwHPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365542386;
	Mon, 18 Dec 2023 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI6fl3a012777;
	Mon, 18 Dec 2023 10:10:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=PODMain02222019; bh=UjG2FX1pYQgdsa
	d8oZ3msOCc5wPjlvgk283e8XXjitk=; b=Gt1cwHPw0m8gzvlZnMusZlonkCVBrd
	dexXLx7+WNx+dZDH716tyRPjDCM0cfNRRLcUcbdaELky+tBHaFg/klkiLbkNyz2Z
	TeAixobK6KnuxlKiQ4shUMxxuaWgoFJxNyQunXIn5Ks6pcRs7JQ4K0SE773UB+xH
	OayeHEmebcCIfjitjdlRw6HmjL1VM7tNv4yo78qndWZSoTiaNldTbpPOCgopwnjP
	Xuv7aWsXwzvdZtgRVvrCH9gnNsE1qyUOVJjXn/3uqIFnT+FjtuwtfKwasH1MJMxn
	8WkZqrvfGqJGClroTiyrnj2euVX4axIl9CJQhX0eYFuk88ehpoVHA92g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a622x3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 10:10:49 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 16:10:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 18 Dec 2023 16:10:47 +0000
Received: from work-debian.ad.cirrus.com (EDINJ39Q8D3.ad.cirrus.com [198.61.65.115])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DDDF615A0;
	Mon, 18 Dec 2023 16:10:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] kunit: Allow passing function pointer to kunit_activate_static_stub()
Date: Mon, 18 Dec 2023 16:10:43 +0000
Message-ID: <20231218161044.215640-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8MoppAXG9dsU7CBuucIKj2cMnzATIQJ_
X-Proofpoint-ORIG-GUID: 8MoppAXG9dsU7CBuucIKj2cMnzATIQJ_
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


