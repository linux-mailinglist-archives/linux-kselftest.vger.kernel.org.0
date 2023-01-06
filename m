Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2A65FEE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jan 2023 11:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjAFKZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Jan 2023 05:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjAFKY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Jan 2023 05:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B36C2A0
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Jan 2023 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673000642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAV1mEJ1RePKSiP31eA7Zb3huEWrI68yI1mkY2joYvU=;
        b=L1fSDT6e8c48YN3vNl1gXaJ5OpUreUB5U1cslTkZMQ53k6wUJF3WN4ey8dmiqFrObhl13U
        NYvlPXhXR2yDxGHZg67bkgwA/gV0KmeK7vNlet2SlerylLJ9l3tGiSVSRMS1ppJzAhNCkz
        yvk6LonKo6vXjAa11A6cMNS61rMllfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-Wk7HD-MSOPaFh-Au9Y_ciQ-1; Fri, 06 Jan 2023 05:23:56 -0500
X-MC-Unique: Wk7HD-MSOPaFh-Au9Y_ciQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C41A21871D9A;
        Fri,  6 Jan 2023 10:23:55 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17C5C15BAD;
        Fri,  6 Jan 2023 10:23:53 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH HID for-next v1 7/9] selftests: hid: enforce new attach API
Date:   Fri,  6 Jan 2023 11:23:30 +0100
Message-Id: <20230106102332.1019632-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20230106102332.1019632-1-benjamin.tissoires@redhat.com>
References: <20230106102332.1019632-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that the new API for hid_bpf_attach_prog() is in place, ensure we
get an fd when calling this function. And remove the fallback code.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/hid_bpf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 9a262fe99b32..2cf96f818f25 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -638,11 +638,7 @@ TEST_F(hid_bpf, test_attach_detach)
 	LOAD_PROGRAMS(progs);
 
 	link = self->hid_links[0];
-	/* we might not be using the new code path where hid_bpf_attach_prog()
-	 * returns a link.
-	 */
-	if (!link)
-		link = bpf_program__fd(self->skel->progs.hid_first_event);
+	ASSERT_GT(link, 0) TH_LOG("HID-BPF link not created");
 
 	/* inject one event */
 	buf[0] = 1;
-- 
2.38.1

