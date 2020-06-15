Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6941F9E69
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFOR2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 13:28:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36164 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731183AbgFOR2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDYd5mUdjgScnsnMuq70DAzpJt/WeKbHjzW7zJWYAes=;
        b=b4ng5xXb/fpuFMovvJclS1lIv03lLeyw5LiUwEphDlzcIEGdA+PwpFdndYzGASylKzzgU+
        XBOGe//261tA2LwE1j4F2G7cyXtZcQoCJjwl41NLXjuIJRh46j8oR0bg4vrheSZfCDehBP
        HrkzRdrbPFmPnL6gqT9wId0+Tuz5694=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-mHKY17zYNs2TniF4H1symw-1; Mon, 15 Jun 2020 13:28:03 -0400
X-MC-Unique: mHKY17zYNs2TniF4H1symw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416B610059B3;
        Mon, 15 Jun 2020 17:28:02 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A4A19C66;
        Mon, 15 Jun 2020 17:28:01 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/4] selftests/livepatch: add test delimiter to dmesg
Date:   Mon, 15 Jun 2020 13:27:56 -0400
Message-Id: <20200615172756.12912-5-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make it bit easier to parse the kernel logs during the selftests by
adding a "===== TEST: $test =====" delimiter when each individual test
begins.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index cb8a6df8c73a..d2b831cc710e 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -264,6 +264,7 @@ function start_test {
 
 	save_dmesg
 	echo -n "TEST: $test ... "
+	log "===== TEST: $test ====="
 }
 
 # check_result() - verify dmesg output
-- 
2.21.3

