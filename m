Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8663CC2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3AHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiK3AG5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:06:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF37044E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7D64B819A0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEB7C433C1;
        Wed, 30 Nov 2022 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766813;
        bh=aYc5aiemDyUpwG5bKAXR2b2l5eCek4JVHOeT7Vm3QUc=;
        h=From:To:Cc:Subject:Date:From;
        b=ERl+c/rck6NYMeTx33GvpMUFguOgbaRkyvhzlcyfvgSamXuHvZMLudmp8fxi1Mxn/
         gEQT8b1VzZj1vZXoQnCncsqhnC/Tk9e6ePbvrYxGqcYUEZhaMzfomA34/LsX5W3AmT
         vVwjh9hU6XCnCycK+03+RoSmerPThAkuNa46MCd+R3W3xU0Xy5K0l9mUd+GVjVZZh4
         Qi9PsBUJDyHtiJIqGt8bhUJzItzyAosJkiDz6Ez/FJwl8CFzHbgzHUahC8usVM3jQt
         QwV9bmbXsDdN6Dbqh+74KCkfuWDexqrkgLrqVmTM7IWUutGI1gXuDMkod8okfNslM+
         GLjzBjr8zIxQg==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
Date:   Wed, 30 Nov 2022 00:06:02 +0000
Message-Id: <20221130000608.519574-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=broonie@kernel.org; h=from:subject; bh=aYc5aiemDyUpwG5bKAXR2b2l5eCek4JVHOeT7Vm3QUc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5qjNRezU/Mpw4j3O5oOuQVFFLw0IAr8wVZ1oRj h7Zhh6qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aeagAKCRAk1otyXVSH0NVVB/ 9sVMOIsEYoMHcH6lLroIWJJ9AKZXLHbMN2tMgmxyM/xB7vkKUwqgJqb+mUdLEAWaECmzIWdy9f+LnH GVudsqYVUNXUwVfLuLi2Dq7nHzkq241ot0XO4ppNNjYkEEfKbX0chXoyx1IjtBZpmCVT3U7tRFKSZy ZeIqSTQHKNIUGo2jiAdDkuNqI15Ieb0wradK1FgHCmpcgwse2DresFowSka/kEgvyhZWxOmEshoFmJ X8nT0pB0hA9A2QbAP0OyQMuRVTVchVHubQ0ZL8OSW57bGbMSUn0w36cBy3huFJczA2tjreuJ/fvoI7 YZiAyrb1mj+5gYMNGBc8wVaisFJxLx
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

This series provides a bunch of quick updates which should make the
coverage from pcm-test a bit more useful, it adds some support for
skipping tests when the hardware/driver is unable to support the
requested configuration and then expands the set of cases we cover to
include more sample rates and channel counts.  This should exercise
switching between 8kHz and 44.1kHz based rates and ensure that clocking
doesn't get confused by non-stereo channel counts, both of which are I
expect common real world errors, at least for embedded cards.

Mark Brown (6):
  kselftest/alsa: Refactor pcm-test to list the tests to run in a struct
  kselftest/alsa: Report failures to set the requested sample rate as
    skips
  kselftest/alsa: Report failures to set the requested channels as skips
  kselftest/alsa: Don't any configuration in the sample config
  kselftest/alsa: Provide more meaningful names for tests
  kselftest/alsa: Add more coverage of sample rates and channel counts

 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  | 35 ++++----
 tools/testing/selftests/alsa/pcm-test.c       | 88 +++++++++++++------
 2 files changed, 81 insertions(+), 42 deletions(-)


base-commit: 1d8025ec722d5e011f9299c46274eb21fb54a428
-- 
2.30.2

