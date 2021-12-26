Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C347F4EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Dec 2021 03:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhLZCcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Dec 2021 21:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLZCcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Dec 2021 21:32:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72DCC061401;
        Sat, 25 Dec 2021 18:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cWKiDxQpg3CrpeNWpGyXUibJ4Au13VIXyN0weQaKLtg=; b=T9AkBBbQpskIAS4pd1nv1N7oEE
        yXugSyE5AF+l/+BL3+nULPQPWeH0GclhmJ4EZbRGj/pMUu7iyO/mkbrB7NPbm0VyEFZG2f5FksRNU
        N2ctbVC4zTQovyiKCY+InnEeqA+U5pXWpvPm8lOcGWY/QB4k10SgQbKOkkGLGionQQ940+fPnkfSK
        5/AHMpentWQwC0fFO1Q9Hl/Dx5KxOKRdcivtVr5Eg4LUrEDNqpFdeCXINgObK3o7xaOMBNqqKKaPw
        Wj3nr1RCu4+YA9nYlzy0QuB3S+k+2NmYuHrRshbYyhUAi0DxAFBjT394S7PZmemfItGQImNEhZYMd
        kSutER/w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1JKP-00FEOT-96; Sun, 26 Dec 2021 02:32:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: func_event_triggers: fix typo in user message
Date:   Sat, 25 Dec 2021 18:32:04 -0800
Message-Id: <20211226023204.18315-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Correct typo of "it's" to "it".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211224.orig/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ linux-next-20211224/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -85,7 +85,7 @@ run_enable_disable() {
 	echo $check_disable > $EVENT_ENABLE
     done
     sleep $SLEEP_TIME
-    echo " make sure it's still works"
+    echo " make sure it still works"
     test_event_enabled $check_enable_star
 
     reset_ftrace_filter
