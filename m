Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D664140D97
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 16:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAQPPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 10:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgAQPPp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 10:15:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 899D9AE2C;
        Fri, 17 Jan 2020 15:15:42 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        alex.shi@linux.alibaba.com, guro@fb.com, kernel-team@android.com,
        linger.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, tomcherry@google.com
Subject: [PATCH 0/3] cgroup: Iterate tasks that did not finish do_exit()
Date:   Fri, 17 Jan 2020 16:15:30 +0100
Message-Id: <20200117151533.12381-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116043612.52782-1-surenb@google.com>
References: <20200116043612.52782-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
I was looking into the issue and came up with an alternative solution that
changes task iteration to be consistent with cgroup_is_populated() check and
moving the responsibility to check PF_EXITING on the consumers of iterator API.

I haven't check your approach thoroughly, however, it appears to me it
complicates (already non-trivial) cgroup destruction path. I ran your selftest
on the iterators approach and it proved working.

Michal Koutný (2):
  cgroup: Unify css_set task lists
  cgroup: Iterate tasks that did not finish do_exit()

Suren Baghdasaryan (1):
  kselftest/cgroup: add cgroup destruction test

 include/linux/cgroup-defs.h                |  15 ++-
 include/linux/cgroup.h                     |   4 +-
 kernel/cgroup/cgroup.c                     |  86 ++++++++--------
 kernel/cgroup/debug.c                      |  16 ++-
 tools/testing/selftests/cgroup/test_core.c | 113 +++++++++++++++++++++
 5 files changed, 176 insertions(+), 58 deletions(-)

-- 
2.24.1

