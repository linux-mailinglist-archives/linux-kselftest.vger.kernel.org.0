Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B621BD1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGJSiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 14:38:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727059AbgGJSiu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 14:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594406328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SEP36VS2Na3Dpdjhr4B8rjzaMa6HxzPcJ4UGj5hivCg=;
        b=UYREYhvj8bKPmk7OirZouwItavidknx50ICRx3xoOdBhrEdzChR8cTaKo0JTkRWzze9Q4/
        JBbCw/jHlMot/F+eHxALPge31L8PUmX+yUN12b6yZm0JjXJ/ILLAmwUxiy8gD33floenZ+
        sgC9KKj3FQhRB3ObmddqBYc2Tf/z8xA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-78YOfHzTOgSt_xqVfleYMw-1; Fri, 10 Jul 2020 14:38:46 -0400
X-MC-Unique: 78YOfHzTOgSt_xqVfleYMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B13107ACCA;
        Fri, 10 Jul 2020 18:38:45 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-73.rdu2.redhat.com [10.10.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31B791A7CE;
        Fri, 10 Jul 2020 18:38:45 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests/livepatch: Use "comm" instead of "diff" for dmesg
Date:   Fri, 10 Jul 2020 14:37:45 -0400
Message-Id: <20200710183745.19730-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

BusyBox diff doesn't support the GNU diff '--LTYPE-line-format' options
that were used in the selftests to filter older kernel log messages from
dmesg output.

Use "comm" which is more available in smaller boot environments.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

based-on: livepatching.git/for-5.9/selftests-cleanup
merge-thru: livepatching.git

 tools/testing/selftests/livepatch/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 36648ca367c2..408529d94ddb 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -277,7 +277,7 @@ function check_result {
 	# help differentiate repeated testing runs.  Remove them with a
 	# post-comparison sed filter.
 
-	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
+	result=$(dmesg | comm -13 "$SAVED_DMESG" - | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
-- 
2.21.3

