Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDBBF7F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfIZRwt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 13:52:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfIZRwt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 13:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A18FA142F;
        Thu, 26 Sep 2019 10:52:48 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D183F67D;
        Thu, 26 Sep 2019 10:52:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, Tim.Bird@sony.com
Subject: [PATCH v2 0/2] Fix KSFT toplevel makefile behaviour
Date:   Thu, 26 Sep 2019 18:52:17 +0100
Message-Id: <20190926175219.29805-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

so this series carries two small fixes to the toplevel KSelfTest makefile
which I found useful especially while attempting to run the suite in
automation.

[1/2]
While it is already possible to specify a limited list of TARGETS to run,
it is not instead easily possible to state a list of targets NOT to run
(say due to specific instability issues).
Moreover providing such a skip list through a stripped down list of TARGETS
it is cumbersome and fragile since this poses the risk to stick to an old
stale stripped TARGETS list once upstream decides to add more default
targets.
A new SKIP_TARGETS Makefile variable is provided by this patch to easily
specify a skiplist for target subsystems.

[2/2]
Currently when some target fails to build, KSFT Makefile just carries on
building as much subsystems as it can: unfortunately this is not properly
reflected also in the generation of the runlist inside run_kselftest.sh.
This patch rectifies this behaviour checking for the existence of a target
directory in the INSTALL_PATH before adding the related snippet to the
run_kselftest.sh script.


Thanks

Cristian

Changelog

v1 --> v2
- added Documentation
- various typos fixed
- added a proper override when filtering-out SKIP_TARGETS from TARGETS
  to make it work also when TARGETS is provided too from the cmdline

Cristian Marussi (2):
  kselftest: add capability to skip chosen TARGETS
  kselftest: exclude failed TARGETS from runlist

 Documentation/dev-tools/kselftest.rst | 11 +++++++++++
 tools/testing/selftests/Makefile      | 11 +++++++++++
 2 files changed, 22 insertions(+)

-- 
2.17.1

