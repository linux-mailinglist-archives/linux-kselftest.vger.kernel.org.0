Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34E47DA0F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJ0Sr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbjJ0Sq5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:46:57 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7033ED42;
        Fri, 27 Oct 2023 11:46:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 52AA05C011D;
        Fri, 27 Oct 2023 14:46:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 14:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698432409; x=
        1698518809; bh=nP9Y4w8cEDkdbu0SQUaqN73Z1uHj1qUJsMQXhKfpDYE=; b=U
        2jKeIKWZhpAFnKOEGisP3X2OTwULVu6uA00edpE2BKVpMbdUps02uL6KvPu8t1Zz
        ceav99cysXwJvpeDVn5yMgf6VqsVPHYmiVBln+ykCseBQCkMl0Mu5Wl3ebOVXTr8
        2AmIlJfhCVlPbasmzGWByRF7OU8gXW6qx0ZuUOuTrT+bK9fOsMCbXp28ML7fuO7j
        VYa+8BxQzcoUG1nmULUXR2Fe3IeowljW/Rbu8/Ek0xVJNPwOR2ZQ8X9Iofho47oG
        5ywhpbvMvpDvRuu4ByQGfp6Z76w1m9touFaZ3l+atBmI5WlJZfntNuUP3T8n0VjR
        1MFUBXqZyPp3fajyPdJ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432409; x=
        1698518809; bh=nP9Y4w8cEDkdbu0SQUaqN73Z1uHj1qUJsMQXhKfpDYE=; b=T
        f3bKV0890z9hGcvgfMP91KTCiXB/N9i249HareWwHbWX0MdFjIz/WB8QxTJnUi4+
        x4prYMZdCeSxrjNauRaJBGX2qWcMLbg2+bpP3Ku6U7A3bRCgcZEIcuLEl7WTCr5D
        gx6ctfdYoAaz1VCVtM/zA1IwvETmayWOohytR3rukueUjkH0oYB79JArSxqTpina
        NmwUca17hHFNaxXqBOXxwIzXZf0FeCiBwXfDcLapOS5d78ua525RJzi/ZjqqxN27
        uk1ns0O9W9fL9ltEhAHgtnFvHThr7uZ/YrGTOJ8skYcyUdoI4rzIW+6WcHg2z1/D
        +zawDQN9TrcofAo+wG6UA==
X-ME-Sender: <xms:mQU8ZW-Gs1aCFD8KdTdSol0NiBKfVnLKKK0ogcP9cCTmCNlxPovQ4w>
    <xme:mQU8ZWsTgq0VnF7hkw8jUsi9CReCdSSOidmTMxm5xq4byHdCokv301HTS_g84zKLm
    eWfppM_2banJv5S4w>
X-ME-Received: <xmr:mQU8ZcC-2GXvNA-s9QqfKe74Df2aN0-OJl-RHiG6w7DpdMJcRxD5QyKjfov3hi5-DVB96IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:mQU8ZecjjbbvPzmCdUFvzIRGzToUvcM4x-qncAWpXGIEFsOE1Yf_zw>
    <xmx:mQU8ZbOXkS_ajVakM-gxnx6xY3NrB2gsoXLlzr7TiWU1O8te1wC9BQ>
    <xmx:mQU8ZYkFM6NrG35quR7FKvZUaAWpI85LXFx5alPBA1LnirVkEU-9EQ>
    <xmx:mQU8ZUzL2ne0A_NZZV2lE-EM5c_xg0Rjxk5jvnxp83kc7FNqcYV5eA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:48 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, steffen.klassert@secunet.com,
        antony.antony@secunet.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org
Subject: [RFC bpf-next 5/6] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date:   Fri, 27 Oct 2023 12:46:21 -0600
Message-ID: <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Switching to vmlinux.h definitions seems to make the verifier very
unhappy with bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

It looks like disabling CO-RE relocations seem to make the error go
away.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..ec7e04e012ae 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_PRESERVE_ACCESS_INDEX
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
2.42.0

