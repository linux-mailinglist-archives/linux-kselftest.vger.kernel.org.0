Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90A50A427
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390078AbiDUPcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390072AbiDUPcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494A41F8E;
        Thu, 21 Apr 2022 08:29:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 846E41F745;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g5kABB6jK4cQYfyvSKUjcJZOBX6joCc6lu+f86eo0HU=;
        b=bZAmTseYZipk0Yr9p8MTOdgS9kNUlbPZu0Ozbex5hRE/kOaiHxrlW1fNaI5vMOe6xOUop8
        kR4LqRQUfxyAvFbWv/DMTEvrBqqrkmZiCC5TgIX55FX0j8NO3XAiG+k9EcTvx8VG2DF2im
        Q+y1GktCZ60xklp4DeueoaGIwGBqYKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g5kABB6jK4cQYfyvSKUjcJZOBX6joCc6lu+f86eo0HU=;
        b=fXMDEVyVghTGsM4qcVWx0XfDJPmdAKvbrhg+OeY0ksqTA7I8MgYT6ARbfI1tKuZugqc2n6
        Z3BFNUnlUSZUmTDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 6C11D2C141;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] Firmware loader support for ZSTD-compressed files
Date:   Thu, 21 Apr 2022 17:29:03 +0200
Message-Id: <20220421152908.4718-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

this is a revised patch set for RFC I posted some time ago (*).
Since the ZSTD usage became much more popular now, it makes sense to
have the consistent (de)compression support in the kernel, also for
the firmware files.  This patch set adds the support for ZSTD-
compressed firmware files as well as the extension of selftests, in
addition to a couple of relevant fixes in selftests.

(*) https://lore.kernel.org/r/20210127154939.13288-1-tiwai@suse.de


Takashi

===

Takashi Iwai (5):
  firmware: Add the support for ZSTD-compressed firmware files
  selftests: firmware: Use smaller dictionary for XZ compression
  selftests: firmware: Fix the request_firmware_into_buf() test for XZ
    format
  selftests: firmware: Simplify test patterns
  selftests: firmware: Add ZSTD compressed file tests

 drivers/base/firmware_loader/Kconfig          |  24 ++-
 drivers/base/firmware_loader/main.c           |  76 +++++++-
 .../selftests/firmware/fw_filesystem.sh       | 170 +++++++++---------
 tools/testing/selftests/firmware/fw_lib.sh    |  12 +-
 4 files changed, 182 insertions(+), 100 deletions(-)

-- 
2.31.1

