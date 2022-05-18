Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040052C4E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiERU76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 16:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiERU74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 16:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 412EE254726
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652907594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+niHEoMuTDRFqut4OdKlEaLEgHKW232XIT+7USRZJg=;
        b=ZcjrHmq9mstvyhnLCc3avAl0uOBY39K61KNA+1oH2JV9goBkawEnQL386+hNrptB58HgQU
        0YZ3aNgjh1LtzzwSix1FCFAiV3wr4DXAIEe0aONyObrZlW4/YxHVMaCoSZclelAWMksASu
        zSJvy7++TsfPiTKOh+N92qd576Woe/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-cMpIVQCjNICd9pEeRpcK1g-1; Wed, 18 May 2022 16:59:49 -0400
X-MC-Unique: cMpIVQCjNICd9pEeRpcK1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F7AE811E83;
        Wed, 18 May 2022 20:59:48 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9A402166B25;
        Wed, 18 May 2022 20:59:43 +0000 (UTC)
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
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v5 04/17] libbpf: add map_get_fd_by_id and map_delete_elem in light skeleton
Date:   Wed, 18 May 2022 22:59:11 +0200
Message-Id: <20220518205924.399291-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
References: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to have a better control over maps from the kernel when
preloading eBPF programs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v5
---
 tools/lib/bpf/skel_internal.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index bd6f4505e7b1..bc1db60ad744 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -251,6 +251,29 @@ static inline int skel_map_update_elem(int fd, const void *key,
 	return skel_sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
 }
 
+static inline int skel_map_delete_elem(int fd, const void *key)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = (long)key;
+
+	return skel_sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
+}
+
+static inline int skel_map_get_fd_by_id(__u32 id)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_id = id;
+
+	return skel_sys_bpf(BPF_MAP_GET_FD_BY_ID, &attr, attr_sz);
+}
+
 static inline int skel_raw_tracepoint_open(const char *name, int prog_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint.prog_fd);
-- 
2.36.1

