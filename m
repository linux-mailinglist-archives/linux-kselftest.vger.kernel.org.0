Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70B3A9244
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 08:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFPG3x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhFPG3x (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B31C7613C2;
        Wed, 16 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824867;
        bh=0D3LAev4kCUmKrz9qs1KQpeWtZ5Y0DsGWhPtBA+LVLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCSQlGVpcBqwzrTv4ajvjMbv0G996eSfe3WXBDL+kcDHLtXeln2q0Si4IqIN5tuV6
         jlxVQk/vIgkgSkxALeq1ERqT1ZCCvKfXZrINMC+OIUsna8+1wRPAO9VyTwWjzx0ERt
         nq5Ctb/rqheNRa2sKp1tD4SUofXIEvAG5WfJ+NERsyeGik9dnoimc61pn/o62uUDpu
         OtWUSFzgVNVgzHS2noRhDv8BPY7l5QRoPJ4LOyrYwxfVfb0X0JzxtBmu33LqeFUSgt
         jnUO+bDhXD19Ma0FjDom/kZN9m047iHu3rKO1N+Udb4q1kYstHBxoQQy+wAyrKzexq
         nN8Kku8ItRqdQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1d-004kIP-Ul; Wed, 16 Jun 2021 08:27:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 02/29] docs: dev-tools: kunit: don't use a table for docs name
Date:   Wed, 16 Jun 2021 08:27:17 +0200
Message-Id: <07d3a8ccafbb6345d6e78fb090290859e84361a1.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
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

Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
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

