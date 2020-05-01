Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD21C15FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgEANhh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 09:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbgEANhg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 09:37:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A8B208DB;
        Fri,  1 May 2020 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340256;
        bh=eRAtNJ/HWH4sVqYaO5Frc3YDE4F9g8IJVo3snPfoH0M=;
        h=From:To:Cc:Subject:Date:From;
        b=FI7jz2afSuPHE4c7uMPD//oMdbnNIcOu6Ys5e8TA8b+S6NjGIouVp5liYXuA8Q3Gb
         HxccV8nXOw9jri5qgO3221uRwfdCTKPrAcQCmySVWx6+O8eMkYaE/qyCqxTuH4xYGx
         m4ep+C55sPz3zw/9uYjjUUNzU2OODh6fSZeHvq4I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: [PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for dash, etc.
Date:   Fri,  1 May 2020 22:37:31 +0900
Message-Id: <158834025077.28357.15141584656220094821.stgit@devnote2>
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

Here are some patches to update ftracetest to fix some issues.
 - [1/3] Fix coloring of XFAIL
 - [2/3] Fix a testcase not to expect just one event entry
 - [3/3] Do not use built-in echo because the behavior is different
         on dash and bash. (Thanks Liu for reporting!)

Thank you,

---

Masami Hiramatsu (3):
      selftests/ftrace: Make XFAIL green color
      selftests/ftrace: Pick only the first kprobe event to test
      selftests/ftrace: Use /bin/echo instead of built-in echo


 tools/testing/selftests/ftrace/ftracetest          |    2 +-
 tools/testing/selftests/ftrace/test.d/functions    |    3 +++
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
 .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
 .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
 .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
 6 files changed, 12 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
