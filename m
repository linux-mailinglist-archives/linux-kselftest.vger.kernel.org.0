Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAF148424
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391863AbgAXLk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 06:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:50758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390760AbgAXLkc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 06:40:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75869ACB1;
        Fri, 24 Jan 2020 11:40:29 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tj@kernel.org, tomcherry@google.com
Subject: [PATCH v2 0/3] cgroup: Iterate tasks that did not finish do_exit()
Date:   Fri, 24 Jan 2020 12:40:14 +0100
Message-Id: <20200124114017.8363-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120145635.GA30904@blackbody.suse.cz>
References: <20200120145635.GA30904@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
thanks for your feedback. I'm sending updated solution that changes task
iteration to be consistent with cgroup_is_populated() check and moving the
responsibility to check PF_EXITING on the consumers of iterator API.

Changes from v1
- v1: https://lore.kernel.org/lkml/20200117151533.12381-1-mkoutny@suse.com/
- Swap the fixing and refactoring patch (in order to make the fix easier for
  backport)
- Don't introduce tasks lists array because of unnecessarily long access code
- Fix comment in selftest
- I leave the CC:stable on discretion of the maintainer

Michal Koutný (2):
  cgroup: Iterate tasks that did not finish do_exit()
  cgroup: Clean up css_set task traversal

Suren Baghdasaryan (1):
  kselftest/cgroup: add cgroup destruction test

 include/linux/cgroup.h                     |   4 +-
 kernel/cgroup/cgroup.c                     |  60 ++++++-----
 tools/testing/selftests/cgroup/test_core.c | 113 +++++++++++++++++++++
 3 files changed, 146 insertions(+), 31 deletions(-)

-- 
2.24.1

