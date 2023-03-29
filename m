Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766246CF1CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjC2SIV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjC2SIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:09 -0400
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326874C0D
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:08 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id eh3so66713256edb.11
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l3JqaZ/F1Xw0Z8kRSNKL5fbAB/UmHB3O5Uun2MQO78=;
        b=MAEEH3HGa7M9V3alShG0dh2Xaw5ztphBzVuDATfWiwHZz9OiqSWIhmfByHZRYFH1Gv
         B6m8yXnt/TzXSc5GPdCovGkuC2K4kXPOFLB/uUWaVJhTHZAjPVrvLRkSK66nbW5KH2PI
         81PmW3uYvOvbKdc64Wi6FTaA8LqvXQleGboes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l3JqaZ/F1Xw0Z8kRSNKL5fbAB/UmHB3O5Uun2MQO78=;
        b=LmYesoJvuicCmiYXbeksApB4TTUrKh2IOVntc64EESjMlpjqeU6BrufQDaDcFMOVSB
         bR8RhFRSLdE/HcT31m7ibyOqJ43b/+8bXNaw3wq8VnIgsdpcbtVYgTAMaWSlNEMDRLme
         EiHfGrMsu+aaJbMlknlDGBh9lup6sPiTr6evB+kGkZGYRC5u3ch09byMeqAOE/du2i2R
         S0dG/hfmI4e2/beQC/ByiIPlurVCBjYDqXWJ5078F17CBsjixHdviKbRLPwZ3vbXlVgZ
         GIGbgfUY8zDrNXVnmy+N4AFZUs2PxzZXAeinj9p4nm21x3jwEcRmOTZmsTtUrvlJDNMW
         yABg==
X-Gm-Message-State: AAQBX9eKR18kkPl2SMQelRYMArFrI3lnAqFrhF6f1U5otGV+94UJSlHT
        9cS67j1PjeyDyKeiW6GXjRGkNKgpHD3CTuU5v/+gYg+6BJEk
X-Google-Smtp-Source: AKy350aQv50ZGqox8uPY+2MEmJO7lJ/IIxyNCBGekrZLoOoqIDUhuBJK1lUho1/76aZAxM3hdDjQ1Y2kqQOp
X-Received: by 2002:a17:907:c609:b0:93f:9b1b:f303 with SMTP id ud9-20020a170907c60900b0093f9b1bf303mr17483715ejc.75.1680113286692;
        Wed, 29 Mar 2023 11:08:06 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:06 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 05/10] selftests: xsk: Disable IPv6 on VETH1
Date:   Wed, 29 Mar 2023 20:04:57 +0200
Message-Id: <20230329180502.1884307-6-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329180502.1884307-1-kal.conley@dectris.com>
References: <20230329180502.1884307-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change fixes flakiness in the BIDIRECTIONAL test:

    # [is_pkt_valid] expected length [60], got length [90]
    not ok 1 FAIL: SKB BUSY-POLL BIDIRECTIONAL

When IPv6 is enabled, the interface will periodically send MLDv1 and
MLDv2 packets. These packets can cause the BIDIRECTIONAL test to fail
since it uses VETH0 for RX.

For other tests, this was not a problem since they only receive on VETH1
and IPv6 was already disabled on VETH0.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/test_xsk.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index b077cf58f825..377fb157a57c 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -116,6 +116,7 @@ setup_vethPairs() {
 	ip link add ${VETH0} numtxqueues 4 numrxqueues 4 type veth peer name ${VETH1} numtxqueues 4 numrxqueues 4
 	if [ -f /proc/net/if_inet6 ]; then
 		echo 1 > /proc/sys/net/ipv6/conf/${VETH0}/disable_ipv6
+		echo 1 > /proc/sys/net/ipv6/conf/${VETH1}/disable_ipv6
 	fi
 	if [[ $verbose -eq 1 ]]; then
 	        echo "setting up ${VETH1}"
-- 
2.39.2

