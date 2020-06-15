Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A023D1F9E65
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgFOR2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 13:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731179AbgFOR2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTnfSDKYQMCIUSMFxp8JdFDM/zAHFlct5yM67JOLc9c=;
        b=MMn/Xm4vxit7CwcgWOMruykr7uAfBq8arRxwqGwsw0EjDuIjDjchnEq9LkS8W9LYQGWTjP
        bCWrJ2v2Tqb9kPKy2mAvRMKezbSDCeKoAWhbuFT3W7P9W1X5S+XrdjIYr/DZrylfuRrhX2
        Yh4K6TQ/L2zUyOp89gpWPlf+tw+N0qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-xTdFYj8uMJi3bZhI789hyw-1; Mon, 15 Jun 2020 13:28:02 -0400
X-MC-Unique: xTdFYj8uMJi3bZhI789hyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF2B10059B0;
        Mon, 15 Jun 2020 17:28:01 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DEE219C66;
        Mon, 15 Jun 2020 17:28:00 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 3/4] selftests/livepatch: refine dmesg 'taints' in dmesg comparison
Date:   Mon, 15 Jun 2020 13:27:55 -0400
Message-Id: <20200615172756.12912-4-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The livepatch selftests currently grep on "taints" to filter out
"tainting kernel with TAINT_LIVEPATCH" messages which may be logged when
loading livepatch modules.

Further filter the log to drop "loading out-of-tree module taints
kernel" in the rare case the klp_test modules have been built
out-of-tree.

Look for the longer "taints kernel" or "tainting kernel" strings to
avoid inadvertent partial matching.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index bbbb4041f533..cb8a6df8c73a 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -273,7 +273,8 @@ function check_result {
 	local result
 
 	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
-		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
+		 grep -e '^livepatch:' -e 'test_klp' | \
+		 grep -v '\(tainting\|taints\) kernel')
 
 	if [[ "$expect" == "$result" ]] ; then
 		echo "ok"
-- 
2.21.3

