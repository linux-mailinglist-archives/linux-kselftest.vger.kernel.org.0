Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5D750CC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjGLPkq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGLPkp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 11:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5411DC
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 08:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538E96187E
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 15:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43149C433AB;
        Wed, 12 Jul 2023 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176443;
        bh=wIDy4Ldxd4+i9OmlzEvt7V0TFFLprPKh/f/oN7VNRpA=;
        h=From:Subject:Date:To:Cc:From;
        b=Zmi6T9PuOAkXcMaj4y/q7ZMYB0TPRDi3yeMJVZkIZgdSBCd7XDP5ZaRahyyX36/+r
         HzjOJpcHIS6MktVILdDt1Z55yKPD81cgTTP+Wfej/mCkoEweV5iJ1lb4L8RatbNTpw
         UbTpMz6BzEtly1/sax2glsyT660UC4ZLjpXwNapyZOs7gxtY0c0A253QNPseWufCUJ
         DhSvrbZ5TmjD6nfc9cE9dgoQrSsvpWJ4ZMOf+fp97VRlsss75TkCLKulzFTGJa06cT
         7vipq557FslwVZlcLbSTVRSvj6EL4nx64r/qvksBzC6rCOUvrFw4G2jMNgkCWf061h
         9kbObCQlubwZQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] ASoC: Improve coverage in default KUnit runs
Date:   Wed, 12 Jul 2023 16:40:33 +0100
Message-Id: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHJrmQC/x3MQQqDQAwF0KtI1g1Eiyi9Sulian5tUCYyY0uLe
 HcHl2/zNspIhky3aqOEr2XzWFBfKhreIY5g02JqpLlKJzWH7AOvvvjs45+nT7SVEcNzBrfoVVt
 RgXZUgiXhZb8zvz/2/QDV6jRMbAAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wIDy4Ldxd4+i9OmlzEvt7V0TFFLprPKh/f/oN7VNRpA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrsl1QS1pmVldcxYi+H70yyCvbUuiQCynvzCI8
 WRRcADsZ7iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7JdQAKCRAk1otyXVSH
 0DYeB/4+v15wF2X9u3d7Re1k35aXLJXk1/VwrntcT3z+BcRpxWaKL5wlKgis7csg/CARvByVGiL
 x26Fh+UhDFcjxzaibYBZD0WTxNzJFPBsfVif3T5MaIzKUduMwVrF69M1DtVHCBXEO8hW1sHknJ2
 KQqNce7oyPjjsjo5VXFWQzbNZM+jkHJt2OEIKTZ7IEPqgtAoS994IilDSt59rnC5tU7jm0lQpre
 OTYerq9VhEViQXvDga0zVxrL+3S50Zp4P1boYWfg8nHKe+B5GqAenKBiboIpwWwRy3i5Qqgc/w/
 zQGRe8TJcTrpFpq+fDd4Yzvicp3E1qLBbCuo8cSiBCNPqa6d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have some KUnit tests for ASoC but they're not being run as much as
they should be since ASoC isn't enabled in the configs used by default
with KUnit and in the case of the topolofy tests there is no way to
enable them without enabling drivers that use them.  Let's improve that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kunit: Enable ASoC in all_tests.config
      ASoC: topology: Add explicit build option

 sound/soc/Kconfig                            | 11 +++++++++++
 tools/testing/kunit/configs/all_tests.config |  5 +++++
 2 files changed, 16 insertions(+)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230701-asoc-topology-kunit-enable-5e8dd50d0ed7

Best regards,
-- 
Mark Brown <broonie@kernel.org>

