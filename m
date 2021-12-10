Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87347096E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhLJS54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245657AbhLJS5z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49ECC061A32
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C2FB8298D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735EAC341C7;
        Fri, 10 Dec 2021 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162457;
        bh=XbRD8SE9Sm0L9EqdqTLSsceqzxrGreq0c6O1rAa3MBc=;
        h=From:To:Cc:Subject:Date:From;
        b=TZyIfG8DNL/Yenj56XTMp0Ly4pf0vThKI2RG0IQkDPgq+lpDEsQKewfIEu5BPZe+q
         YD+k2n0yUDKbEIbaFDSLEntxCBteGE4lxUUJW27NRqGTIH4E7NV36Uy5iu0C/gsCtp
         Q829sNNc2Azqd8/5QDqarvFbjRlxV6DQ3SBMJPpEjx7X8alo1MXW/CuaJPR680Pe7U
         nt8D0WbxzUSZylwqfrDwX4iPVfYe9GTXus2p6RFGphFZi/lPuAFifqfSRc1GF5lIM8
         7e4I3J0Y1X/1mo+kEMV/uSVi5dCzM9f3MsuirjF6GvNBQVS0//ZIW5X89IXmjkZwcM
         wkWdglbcCcc7w==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/3] kselftest: alsa: Add basic mixer selftest
Date:   Fri, 10 Dec 2021 18:54:07 +0000
Message-Id: <20211210185410.740009-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; h=from:subject; bh=XbRD8SE9Sm0L9EqdqTLSsceqzxrGreq0c6O1rAa3MBc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs6JNtwJ3yuNNBnA+kg5bbxoV9/a46bXFdIrJi0hh Zdw64mqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOiTQAKCRAk1otyXVSH0MbuB/ 9QwexZoBery3pAU+uCEWgX/JEIu0zq/p01FUryP7d8JOAxEki92E0DmnHf8mdERVtY8kjHnIxDpWAk JlMwwv/5fhCdQeWFE1JgBPecLhqBq1KlmVpc6U0zh02QhByjUG/oavGhcbypBBeNDKFNu/vN0MF6hX BsXPeK1NTVbE6mYfk2rnKgQnozBl9B1htQaERnwTqyTvpRoY+aX1KvrWSWTbBh22azPrJ8XFZ9JHoU z05B63AHHlrAkjSbopaBFCL0VmVvmXZBj9lG5goZlRrsMbPkqyJJD065u3yIYn4p6cM1D3SZo9H3Ff SFMBDyh8paRNpJnoGHARI3F0dcHiHy
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds a basic selftest for the mixer interface, as discussed
in the cover letter for the main patch there's plenty of additional
coverage that could be added but this is a good starting point.

v4:
 - More stylistic updates suggested by Shuah.
 - Fix build with older alsa-lib.
v3:
 - Pull in incremental updates adding a fixed library configuration from
   Jaroslav and support for volatile controls from Takashi Sakamoto.
 - Stylistic updates suggested by Shuah.
v2:
 - Use pkg-config to get CFLAGS and LDLIBS for alsa-lib.

Jaroslav Kysela (1):
  kselftest: alsa: Use private alsa-lib configuration in mixer test

Mark Brown (1):
  kselftest: alsa: Add simplistic test for ALSA mixer controls kselftest

Takashi Sakamoto (1):
  kselftest: alsa: optimization for SNDRV_CTL_ELEM_ACCESS_VOLATILE

 MAINTAINERS                               |   8 +
 tools/testing/selftests/Makefile          |   3 +-
 tools/testing/selftests/alsa/.gitignore   |   1 +
 tools/testing/selftests/alsa/Makefile     |   9 +
 tools/testing/selftests/alsa/mixer-test.c | 665 ++++++++++++++++++++++
 5 files changed, 685 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/alsa/.gitignore
 create mode 100644 tools/testing/selftests/alsa/Makefile
 create mode 100644 tools/testing/selftests/alsa/mixer-test.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.30.2

