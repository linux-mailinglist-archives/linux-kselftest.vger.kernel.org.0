Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A484CDAF3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiCDRg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiCDRge (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 12:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2687E2364
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646415315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgcKpbYcf2hi8vkeeDFW+llAZ4317MhJ4ll5aBH+/Nc=;
        b=QV4bn7u30hpOAauo9eyombRXH/ZkSJ/cxel7x/PVeSBUqM2x3i+KkUTz3qWqCdB1FFB/k3
        iwd4srDaqwRbYTlxA0+AhmoWCobm8goRTFoyhLIrRMbcUYk8k7Wa5bDkpQMHllnFj7uZ1x
        geQ+oEeDRYoIK9nzJTPfIhgWoGrF2ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-DY3KTqRHNQ-zHvi72pqlHg-1; Fri, 04 Mar 2022 12:35:12 -0500
X-MC-Unique: DY3KTqRHNQ-zHvi72pqlHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333015EF;
        Fri,  4 Mar 2022 17:35:10 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8B886595;
        Fri,  4 Mar 2022 17:35:02 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v2 28/28] samples/bpf: fix bpf_program__attach_hid() api change
Date:   Fri,  4 Mar 2022 18:28:52 +0100
Message-Id: <20220304172852.274126-29-benjamin.tissoires@redhat.com>
In-Reply-To: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the new flag parameter.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 samples/bpf/hid_mouse_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/hid_mouse_user.c b/samples/bpf/hid_mouse_user.c
index d4f37caca2fa..bfae25e7b659 100644
--- a/samples/bpf/hid_mouse_user.c
+++ b/samples/bpf/hid_mouse_user.c
@@ -98,7 +98,7 @@ int main(int argc, char **argv)
 	bpf_object__for_each_program(prog, obj) {
 		progs[prog_count].fd = bpf_program__fd(prog);
 		progs[prog_count].type = bpf_program__get_expected_attach_type(prog);
-		progs[prog_count].link = bpf_program__attach_hid(prog, sysfs_fd);
+		progs[prog_count].link = bpf_program__attach_hid(prog, sysfs_fd, 0);
 		if (libbpf_get_error(progs[prog_count].link)) {
 			fprintf(stderr, "bpf_prog_attach: err=%m\n");
 			progs[prog_count].fd = 0;
-- 
2.35.1

