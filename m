Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0223E1C99DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgEGSvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 14:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgEGSvm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 14:51:42 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C9D2495B;
        Thu,  7 May 2020 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877502;
        bh=g2B3WHP3TtTh6XPDE/6X/pw7R5qG55xrJfAjLiXMLog=;
        h=Date:From:To:Cc:Subject:From;
        b=M2kYlSroDA8yK19NxCXt3sWB0sdiIQlQWo1ZBS4p//O7WzVbRRE9snCfeymw212ic
         iUO0vWvAt63WMmD2T9garVTMdfNfB7aHFdZ1oc0pyyk01RriSyVRPRkRDcQbkQlh1d
         mAcicuXulY9ntyoUmsA+BwcUncRd4H6CjtRZWGMM=
Date:   Thu, 7 May 2020 13:56:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing: Replace zero-length array with flexible-array
Message-ID: <20200507185608.GA14779@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/testing/selftests/nsfs/pidns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e0d86e1668c0..e3c772c6a7c7 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -27,7 +27,7 @@
 #define __stack_aligned__	__attribute__((aligned(16)))
 struct cr_clone_arg {
 	char stack[128] __stack_aligned__;
-	char stack_ptr[0];
+	char stack_ptr[];
 };
 
 static int child(void *args)

