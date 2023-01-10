Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F6664BCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjAJS7g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 13:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjAJS6i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:38 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4363B3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 10:58:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c2-20020a17090a8d0200b002269fb8d787so9753763pjo.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=krYhVfxFdN/OVvO7sdngJN4LpQA8BhAq8fwbwKihSS8=;
        b=O9ItegwgqSdf9S3Iv63GEthUTZhP5FUZI+MT3lb+9NWKW9t6zk8D2GR+Cw5akBAGQx
         /iHGnhJSx/SKzNfYYeiI3TfWQN2bkIq7eqi/iYr/knX0VFHF9648QoLTNUACE+bfgFc8
         YDKwXVbgjfk4keBM+zPZNwelyFjLMIgSTaA/Hlqkd2/+anDe3rtHSfwuGTdVBvpKMijM
         2quqNB4PIlkQwBod0JYV9epuLONJF1sCYy6qu4OqOYlggpormasntRD18lHTetmoqV9+
         XYORoo+Jswq68VuPP6dko7VH8zHAPO7ZMEKNZVC+L4L9yctXVw0UP2ucoeMPbmZ1f+he
         r+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krYhVfxFdN/OVvO7sdngJN4LpQA8BhAq8fwbwKihSS8=;
        b=VnRt6xn/ZV87gXsseEhNoqEluax14lZ2JvtnJjCK3W5VM5ocZZw9PQqR3y1MCBM0uc
         kyvhcg1klUcQ/IuhGBX1HiMbpDU+/bolCZYz/lMMoWN+bOvz0+vkLtM4msHs9q3T1yK4
         mWxm8NRLNsEA9eIBFx6uWXTJTjzssX6uuMutCDF7QqcNYBteh2xDI2soMr0hbiIBWzM3
         tpCD/lgHqEt1txl15Cw2SYW3p/o6qS0vEZD4v45vCKnZTmdxX/Q2CtpxGlhn/aFjpKIa
         rnabLdcoKYl/8imEfdlmmVp9N6HNVOo/q3aZo2eD4HvxtAKUaTcwUrOrOMM+l/3RmtBK
         kVIg==
X-Gm-Message-State: AFqh2kpvJ7nG5hTBvdCV2OdP+1fE7BiUY/fj0KnQOMw+TRQp7XmdfAPp
        /dvCPgeMsjOhgGddZHzLKUOmeWGgIs2b
X-Google-Smtp-Source: AMrXdXvCjmCa9O6/KeGFFD7GjOdnGSnZJ5JG8mXWNWnm2F7cqhMSqGBK4M+3Ys4LYImgNL219OzEklN6VRe5
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:6487:0:b0:587:ca14:26ae with SMTP id
 y129-20020a626487000000b00587ca1426aemr977638pfb.71.1673377113465; Tue, 10
 Jan 2023 10:58:33 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 10 Jan 2023 18:58:23 +0000
In-Reply-To: <20230110185823.1856951-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110185823.1856951-5-mizhang@google.com>
Subject: [PATCH 4/4] KVM: selftests: x86: Repeat the checking of xheader when
 IA32_XFD[18] is set in amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Repeat the checking of AMX component in xheader after xsavec when
IA32_XFD[18] is set. This check calibrates the functionality scope of
IA32_XFD: it does not intercept the XSAVE state management. Regardless of
the values in IA32_XFD, AMX component state will still be managed by XSAVE*
and XRSTOR* as long as XCR[18:17] are set.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 18203e399e9d..9a80a59b64e6 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -235,6 +235,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
+
+	/*
+	 * Bit 18 is cleared in XSTATE_BV but set in XCOMP_BV, this property
+	 * remains the same even when IA32_XFD disables amx tiledata.
+	 */
+	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
+	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
+	GUEST_ASSERT((get_xcompbv(xsave_data) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);
+
 	GUEST_SYNC(6);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
 	set_tilecfg(amx_cfg);
-- 
2.39.0.314.g84b9a713c41-goog

