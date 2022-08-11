Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9585907F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiHKVVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHKVVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 17:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661F99C222
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660252907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OE49Bx/6b5Z5OCjJ/iaAetDXMbSvHfaw/2U0UjvSkCQ=;
        b=C8U/X1bhtMJ5BjSJtKBfHW/gRAgImQ1+zNbSEpy4qyuffLlu4/fkWBuBZTUA/YnPBFE4Jf
        tkoW+YHtgUW57PthkNABKFfYjM/qI2ns+CJPcK5LU2Ccp2noG13qkxosyDo8oPsp3y5dOK
        sLh1/JDVwzTr7ZTJLAgHeZgrnWpHS2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-hqI00qBSNDauxZ7ewUnFjQ-1; Thu, 11 Aug 2022 17:21:44 -0400
X-MC-Unique: hqI00qBSNDauxZ7ewUnFjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB2501824602;
        Thu, 11 Aug 2022 21:21:43 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.16.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF279459C;
        Thu, 11 Aug 2022 21:21:43 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Yannick Cote <ycote@redhat.com>, Dennis Li <denli@redhat.com>
Subject: [PATCH] selftests/livepatch: normalize sysctl error message
Date:   Thu, 11 Aug 2022 17:21:38 -0400
Message-Id: <20220811212138.182575-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The livepatch kselftests rely on comparing expected and actual output
from such commands as sysctl.  A recent commit in procps-ng v4.0.0 [1]
changed sysctl's output to emit key pathnames like:

  sysctl: setting key "/proc/sys/kernel/ftrace_enabled": Device or resource busy

versus previous dotted output:

  sysctl: setting key "kernel.ftrace_enabled": Device or resource busy

The modification in output was later reverted [2], but since the change
has been tagged in procps-ng v4.0.0, update the livepatch kselftest to
handle either case.

[1] https://gitlab.com/procps-ng/procps/-/commit/6389deca5bf667f5fab5912acde78ba8e0febbc7
[2] https://gitlab.com/procps-ng/procps/-/commit/b159c198c9160a8eb13254e2b631d0035b9b542c

Reported-by: Dennis(Zhuoheng) Li <denli@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 9230b869371d..d5001c9eb72e 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -86,7 +86,7 @@ function set_ftrace_enabled() {
 
 	if [[ "$result" != "$1" ]] ; then
 		if [[ $can_fail -eq 1 ]] ; then
-			echo "livepatch: $err" > /dev/kmsg
+			echo "livepatch: $err" | sed 's#/proc/sys/kernel/#kernel.#' > /dev/kmsg
 			return
 		fi
 
-- 
2.26.3

