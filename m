Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6641D39C8AD
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jun 2021 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFENUt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Jun 2021 09:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhFENU0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5E4C6141B;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=4iDY7ITSxco/5aVtxfEvQxWOspvnAzSv9vo4fOxlCv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPQtd/0Bm798vqjdivAGvu0fWShViE0+b/aSVzwdqCKSjKMSRFEbnxpS8G/40/NBh
         WeIDd8lbutDs3YdhzzB+tWK3yFLVgE7AtZnr5taqeDOCmS4dRWNfy3u74tvOuozyPe
         ZRr/BpjUwed/CX0YS6jcZQ8vrhCc3N0vP0rlnKJ9fkKNoLcmtqUQHN5YrSTdcIkVKU
         EjtOrpvfyhjQ2Ji5ZxXzxgPpH3sIZY8mH/l+aofupDRMqZt7i4z2T5iNINFQ+SOvFw
         uStf+WFxvo+1grglejZlR6cVddoH9NDy5oeLWi2M0zdFto5FT8+aTraRZkiEuQ094F
         EGBPKZBxaG7ow==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCB-008GEa-AA; Sat, 05 Jun 2021 15:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 02/34] docs: dev-tools: kunit: don't use a table for docs name
Date:   Sat,  5 Jun 2021 15:18:01 +0200
Message-Id: <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We'll be replacing :doc:`foo` references to
Documentation/foo.rst. Yet, here it happens inside a table.
Doing a search-and-replace would break it.

Yet, as there's no good reason to use a table there,
let's just convert it into a list.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/dev-tools/kunit/api/index.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 9b9bffe5d41a..b33ad72bcf0b 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -10,7 +10,7 @@ API Reference
 This section documents the KUnit kernel testing API. It is divided into the
 following sections:
 
-================================= ==============================================
-:doc:`test`                       documents all of the standard testing API
-                                  excluding mocking or mocking related features.
-================================= ==============================================
+Documentation/dev-tools/kunit/api/test.rst
+
+ - documents all of the standard testing API excluding mocking
+   or mocking related features.
-- 
2.31.1

