Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBEC638D89
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKYPhF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 10:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYPhE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 10:37:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D202C117
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 07:37:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF1EB8296E
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 15:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81321C433D6;
        Fri, 25 Nov 2022 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669390620;
        bh=3SlyLP19taVwYswP0QsLQCc2T7JAhJt9Ptkt7u+hkVU=;
        h=From:To:Cc:Subject:Date:From;
        b=CGMVcH8kAVCenPMJAjKRJZ4uDXrp/fxoZgTBR7UZW5YNMVZ691sY1Pd68OvimbvQU
         3XbIevd8qHoN8n5dNG6XrD8qPoVNRjIl+0vYzu0mV37taPwYO2T8LHEZU0f0vdojOF
         GbrmG4aFpDiGxpvs/8tYUwJuc59wX8T65/jqPqLDXj+Y/dIzBrgUlsVXAlBCDM8exD
         R7TCC4BxBsOrlWPryuhvipnfSsCUfwUDXaMVIvlknTw8+UUr74rZAsKQkOd0+ZzAxP
         fHnorRJ9ACwEYtOUMy8YNTkU2tgLjMBaulWnaPTusfUJU7u+O2ri/1L8aXxGDBBOVE
         LVAqHvP52GgxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/alsa: Add a .gitignore for the newly added PCM test
Date:   Fri, 25 Nov 2022 15:36:54 +0000
Message-Id: <20221125153654.1037868-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=524; i=broonie@kernel.org; h=from:subject; bh=3SlyLP19taVwYswP0QsLQCc2T7JAhJt9Ptkt7u+hkVU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjgOEV2YYfPnHIDeS8UvUFhCMRNKcY+//gyzotOg1P HkblX7mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4DhFQAKCRAk1otyXVSH0ImVB/ 4oQf/6StF+Gfq++H0MH1tHg7CsCsiIAZrs6dr8zv6g67wQsZboelajPAMtBeA+AX3/Pp+SHLGi0E8W 90/TVQltt5AHw27GmeZhBAdEEtfC/Ic2JjiYZzSzlo/L+WoDiEJlgZ7EXmXBVQ/XTVJqw5IhJuOEKp hHUl/m7cN63cUECQC7QoUXBGQi6ZVm+DtHJUx1O/Q9ZGVHiADTCA3YrM0XYMngPRKZHfdFWePZVExO M6gEMigujLelqcDChtMkKKGWesmSMpbuv7sflv1X6QFEpYQevL4C3B6nrv12oANwkFVAc4btaKEdyH uw6gvvb4SnxU02d6FCGn5uwEcgMzhI
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The newly added PCM test produces a binary which is not ignored by git
when built in tree, fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
index 3bb7c41266a8..2b0d11797f25 100644
--- a/tools/testing/selftests/alsa/.gitignore
+++ b/tools/testing/selftests/alsa/.gitignore
@@ -1 +1,2 @@
 mixer-test
+pcm-test
-- 
2.30.2

