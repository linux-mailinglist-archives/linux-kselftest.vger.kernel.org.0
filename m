Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2D28CD05
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgJML4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 07:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgJMLyt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:49 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C43225AC;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=tzgaAgJpIzDjlP2NVIAPK4NTSvcnNtwteXFciBdLZFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nb6alqc59amhsSKHlBfBaX3FBd5o2g+LMPnJE9KjApg8ajQyCbBkm3ZLE24M62EA7
         WL/aCZTzURo1nQoBIu085dqf0HGnbLnjIGNJ8u6qH/kGM54CKIWhufnAWgngBr9A69
         VH8X46Q+DjKKCUn32omasTJGH+34szgyEfVxgW5g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CWC-Gk; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 64/80] kunit: test.h: fix a bad kernel-doc markup
Date:   Tue, 13 Oct 2020 13:54:19 +0200
Message-Id: <8d3ec9c166ba2697b22a5d47c510946a7005a533.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As warned by:

	./include/kunit/test.h:504: WARNING: Block quote ends without a blank line; unexpected unindent.

The right way to describe a function is:

	name - description

Instead, kunit_remove_resource was using:

	name: description

Causing it to be improperly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 41b3a266bf8c..5c5ed262a950 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -498,8 +498,8 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
 }
 
 /**
- * kunit_remove_resource: remove resource from resource list associated with
- *			  test.
+ * kunit_remove_resource() - remove resource from resource list associated with
+ *			     test.
  * @test: The test context object.
  * @res: The resource to be removed.
  *
-- 
2.26.2

