Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1C7DE7D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 22:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjKAV7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjKAV7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 17:59:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04F139;
        Wed,  1 Nov 2023 14:59:00 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id C83773200A06;
        Wed,  1 Nov 2023 17:58:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 17:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698875938; x=
        1698962338; bh=KK2MSw+ePMRXTZH/SbfDOSqSIdpqVExAhBHLCe+DNog=; b=p
        DAgC1L3836BlhtLQ49NyWQ+xJShuybBQ7p+n+FS21GYJhH3f+dI3f4MSSA7HNm4T
        yT8VGaYjiTSORJMRABLFi0/E+zuD8fyxVEyuA9nJIPBKFSxydSFKlB/VF4YSdT4m
        Vj+FyVPQuLKwCckqT3btm5KfgFCHzKuwhkJqy5sfrwVO2cUTsMqM6t2dfcoykB6r
        pph3/sdcM/nOUwVzZGIByIK2VWz0lQvCuttUakqpqcvjoQS6nO3VbHxmmWxCr9GW
        E/7FH4hThH8VwSPGeSmzv3ZcD0PiiZjo5KQkLrskCld1RzuHBYY8mXUc0L+z/LxY
        d6+KObZJlNapQi8G3eZMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875938; x=
        1698962338; bh=KK2MSw+ePMRXTZH/SbfDOSqSIdpqVExAhBHLCe+DNog=; b=v
        GFIV5SeOc3k6inxUYPJJ00tbyKmDypjYzC4TRLecv7gdUkUYx9WAXGRDy77gOVM+
        1xCJw6YREQD8O/qTxkhwns8Dn7FtBT707X6cR3+/lfRCJclWBGUMr4QklbfJvzwg
        AhIl2R77V1ECcGfqBGG+3q1HDwswd8Le9SFxbf8fe9GlaJuGFgQswwo5EPNoCMCu
        se4FKziEYkqKMpnme2jgpGS1Wky3SSUkU46X9blYpsxkTRYfOciBvaq5fG0xhPWd
        xTltTsC0e9ugXvvkNScZuwPAtRIMLcExAAimOAxElMrzFytL2sau69yeIEaA8t+L
        T5oACAP579HTRoLJ57Dzw==
X-ME-Sender: <xms:IspCZc9q7i_NdSiPIq-dsg6tiUSpwJGWQX8rFsToSUJrPS5SqiXfBA>
    <xme:IspCZUuQQ91qAX8xU5z0e9OGC1Edi1nPYTOiA4tVTZSdIf3zg4ocUQ8OGmCcKUZkH
    1EAYNZNBNjsulGSzg>
X-ME-Received: <xmr:IspCZSAq7O_6_s6PPzqU8pScfxvQlz_sFdhqJYCdsNfAqwor-NEtYg8Ys8hXPDOQLz6kxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:IspCZccbyi8I1VeL-nsJrjD8My3i2f3hbeYWwIyUHifgrmEoc_ZtWA>
    <xmx:IspCZRNiuldN7IL9Hbe85IuG_GXgjNDELtdOXj_if2ooqpiRl_YSsQ>
    <xmx:IspCZWlw4zLMCXcv94uSzEnt0r8TU3MC-J1Kskox63GRRjfVWPrQoQ>
    <xmx:IspCZSyXt9e1qno4s6VNp5-gBym47Bp-m43NL99dS2UB4ikHMjfe0Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:56 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, shuah@kernel.org, ast@kernel.org,
        andrii@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 6/7] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date:   Wed,  1 Nov 2023 14:57:50 -0700
Message-ID: <8f31cf3c28b1e69d872e51614dce548a12a54b94.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
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

