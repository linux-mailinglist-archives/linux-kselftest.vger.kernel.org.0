Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71739AE9DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfIJMD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMD2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DD6320FD;
        Tue, 10 Sep 2019 12:03:28 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9AF16012C;
        Tue, 10 Sep 2019 12:03:24 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:02:57 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 0/6] Update clone3 self-tests
Message-ID: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 10 Sep 2019 12:03:28 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello.

This patch set updates clone3 selftest in several aspects:
 - adding a check for kernel not ignoring highest 32 bits of exit_signal
   field of clone3 syscall arguments structure;
 - adding clone3 to selftests targets;
 - enabling clone3 tests on all architectures;
 - minor cleanups of the clone3 test.

Applied on top of brauer/linux.git/for-next.

Eugene Syromiatnikov (6):
  selftests/clone3: convert test modes into an enum
  selftests/clone3: add a check for invalid exit_signal
  selftests/clone3: use uint64_t for flags parameter
  selftests/clone3: fix up format strings
  selftests/clone3: enable clone3 self-tests on all architectures
  selftests: add clone3 to TARGETS

 tools/testing/selftests/Makefile        |  1 +
 tools/testing/selftests/clone3/Makefile |  4 +---
 tools/testing/selftests/clone3/clone3.c | 37 +++++++++++++++++++++++++--------
 3 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.1.4

