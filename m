Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031FA3CB03
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfFKMUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 08:20:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfFKMUE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 08:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30A92B01F;
        Tue, 11 Jun 2019 12:20:03 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] firmware: Add support for loading compressed files
Date:   Tue, 11 Jun 2019 14:19:54 +0200
Message-Id: <20190611121956.27460-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

here are the rest and the main part of patches to add the support for
loading the compressed firmware files.  The patch was slightly
refactored for more easily enhancing for other compression formats (if
anyone wants).  Also the selftest patch is included.  The
functionality doesn't change from the previous patchset.


thanks,

Takashi

===

Takashi Iwai (2):
  firmware: Add support for loading compressed files
  selftests: firmware: Add compressed firmware tests

 drivers/base/firmware_loader/Kconfig              |  18 +++
 drivers/base/firmware_loader/firmware.h           |   8 +-
 drivers/base/firmware_loader/main.c               | 147 ++++++++++++++++++++--
 tools/testing/selftests/firmware/fw_filesystem.sh |  73 +++++++++--
 tools/testing/selftests/firmware/fw_lib.sh        |   7 ++
 tools/testing/selftests/firmware/fw_run_tests.sh  |   1 +
 6 files changed, 232 insertions(+), 22 deletions(-)

-- 
2.16.4

