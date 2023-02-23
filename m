Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABAB6A0BC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjBWOSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjBWOSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 09:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649B57D3A
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677161861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X+vaKO2aKzaKFNowjoezt+q34xazm76j77hEz35B3zk=;
        b=ixui7eBzeuXqhK+I4pIHGckqP0EOCTcTFlto5yjTTTaHxsBDYQs2aI6Ax/c6Q59l7KU0Ho
        3zNN9Yp50O0TWZw8SlTLtZu23n+EuRC2FK5UelgfdRz/MuSNNcr91/ldrG36JcuaMXaBTT
        58CrEAmD6KH6NJPrMnF2/e2YPL4kBsQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-QVtcFkUXNGOhfQqIXjVevg-1; Thu, 23 Feb 2023 09:17:39 -0500
X-MC-Unique: QVtcFkUXNGOhfQqIXjVevg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 543C93C025B4;
        Thu, 23 Feb 2023 14:17:39 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36F1840C1423;
        Thu, 23 Feb 2023 14:17:38 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 23 Feb 2023 15:17:26 +0100
Subject: [PATCH] selftest: hid: fix hid_bpf not set in config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-fix_hid_bpf_kconfig-v1-1-71b213bd8e2b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAHV192MC/x3N0QrCMAyF4VcZubZQO3TWV5FR0i5dg9iNREQYe
 3c7L38OH2cDJWFSuHcbCH1YeaktzqcOUsE6k+GpNTjreutcbzJ/Q+EpxDWHZ1pq5tncvMertzi
 k4QJNRlQyUbCmctgX6pvkGFah5v93j3Hff10zooF+AAAA
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677161857; l=830;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=v/TWiCuxjXitwyd6nR56q0PQFJdoKNQDW7w5Z4tWehg=;
 b=0ni4kb1AnUdsPUNxfHNmS7177I7WTMIC5VB60xRHYqvq+vePhnobVyDKgYhih63n+vUL6Cjnq
 inUmbNqDb1gAYb13uO5XA6jFr7RAkXIIbA3hVr2dp5D+AOIOL2dGSm2
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that CONFIG_HID_BPF is not automatically implied by HID, we need
to set it properly in the selftests config.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 9c5a55abca6b..5b5cef445b54 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -17,5 +17,6 @@ CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_TRACER=y
 CONFIG_HIDRAW=y
 CONFIG_HID=y
+CONFIG_HID_BPF=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_UHID=y

---
base-commit: 6c71297eaf713ece684a367ce9aff06069d715b9
change-id: 20230223-fix_hid_bpf_kconfig-899a690a7c75

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

