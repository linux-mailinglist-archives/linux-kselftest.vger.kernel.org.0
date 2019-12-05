Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00D113C62
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 08:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfLEHdQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 02:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEHdQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 02:33:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93805206DB;
        Thu,  5 Dec 2019 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575531195;
        bh=6MSmDF1wsTQbX7omPNbsHVIlX+msL+WrwUY59b4bZTo=;
        h=From:To:Cc:Subject:Date:From;
        b=N5yU1QUBuvZbQUCn1DPy9r/mICfxemI9mpprnlqoyeHtiIUaesv4fWrSGNm7z38L+
         yMDX18yav4dQXbNbEtuO0FiJlvH3mgAKIHkfijHjppydghZsmdqZNbiuD7C0cOqtpa
         g2QfSBqZygk+BIrfc2s9SZoFeK7euyh//RNdeqBY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH 0/2] selftests: safesetid: Fix build warnings and errors
Date:   Thu,  5 Dec 2019 16:33:12 +0900
Message-Id: <157553119188.17524.1379079312058580155.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here are the patches to fix build warnings and erorrs on
kselftest safesetid.

Thank you,

---

Masami Hiramatsu (2):
      selftests: safesetid: Move link library to LDLIBS
      selftests: safesetid: Check the return value of setuid/setgid


 tools/testing/selftests/safesetid/Makefile         |    3 ++-
 tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
