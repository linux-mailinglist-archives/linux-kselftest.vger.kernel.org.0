Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE291FCC9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgFQLjY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 07:39:24 -0400
Received: from u164.east.ru ([195.170.63.164]:11984 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQLjX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 07:39:23 -0400
Received: by u164.east.ru (Postfix, from userid 1001)
        id 993C1512B46; Wed, 17 Jun 2020 14:39:21 +0300 (MSK)
Date:   Wed, 17 Jun 2020 14:39:21 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] selftests: zram: add generated err.log to .gitignore
Message-ID: <20200617113921.GA29514@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

zram: add generated err.log to .gitignore

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
Fixes: f21fb798fe38 ("selftests/zram: Adding zram tests")
CC: Jiri Kosina <trivial@kernel.org>
---
 tools/testing/selftests/zram/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/zram/.gitignore

diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
new file mode 100644
index 000000000000..b4a2cb6fafa6
--- /dev/null
+++ b/tools/testing/selftests/zram/.gitignore
@@ -0,0 +1 @@
+err.log
-- 
2.27.0

