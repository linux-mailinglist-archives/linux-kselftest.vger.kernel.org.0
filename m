Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC87570ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 02:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGRAaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 20:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGRAaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB01E43
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 17:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41D116136E
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227CEC433CB;
        Tue, 18 Jul 2023 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640205;
        bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QFCqQ5kpDBAZut64is23SI4XYkwbREKPk7YnHtzhOX/44gm1e3W0iCQuWoN0WeXGO
         v6N/UtRzdGa8z5j176iLY6EvGSgc2kcColzkxtehcH7krcxnBrb/Lr1nsQlcNiySFE
         ySAuUTl4CR/UFybm39QMKnF0Obr72c//Q19eZudm3E7AjPSnpaEEjwpcUQxyOOAk7S
         rRpHTtpsYljDBneVm9z+lFExD7ty7C6ZIVSHgUOsR/SkshyYqaHU/kfCI4R1Hgq4Iv
         6Zt4fhVCgiJ7X+qhcTByDEXmqTPCo/5o1fGBU2T+nEMR9PIrn27zw6pwuM/LYPQH4B
         zrbyRqmGxlF6A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 01:28:45 +0100
Subject: [PATCH v2 4/5] kunit: Enable ASoC in all_tests.config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-asoc-topology-kunit-enable-v2-4-0ee11e662b92@kernel.org>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktdz7HozPq6/0jZyA+LN1Ps89o2TkTwzkcl5KI
 J3xvqpfRNmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLXc+wAKCRAk1otyXVSH
 0OFvB/9NgrBslexf8gRgZFmniJLbG2h+DpvBHPNQPNoMULIICq6HOmESVC9hKdYwmPPxJ92sKoN
 K3XTy52yPYwRCOLzALT3ySa0Z1SaKNagy+iV+u3y5XU/gIMRLdABWdb8ePxl7nA54dlUWTlQO/7
 Fr7rypotbMCcxtoBmOzWt2yvBM88Ec5e3mSnUfAFebD7kksS1+rWBt1V7Lf7gqPJJRfFknaX3CT
 3duA4rIUoutsJveB9t+ciZaWXD6LZ4CsswIoWkzxE10yh+KgB8rispipeEsf6HvRVX/WokiXCL+
 Of9HYRLBc6vlT/zez7DgpLV56nl//xTUSX4DB/NR7tWGDtgj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are KUnit tests for some of the ASoC utility functions which are
not enabled in the KUnit all_tests.config, do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 0393940c706a..13d15bc693fb 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -35,3 +35,7 @@ CONFIG_DAMON_DBGFS=y
 
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
+
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y

-- 
2.39.2

