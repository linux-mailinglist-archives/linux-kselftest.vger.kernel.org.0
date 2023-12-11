Return-Path: <linux-kselftest+bounces-1530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0B80C966
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E81F2151A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9C3AC06;
	Mon, 11 Dec 2023 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaRKJaRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2C10A;
	Mon, 11 Dec 2023 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297158; x=1733833158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3OS8Ji8BqE/MCcvl7qGVBtVBgnW2p5uUjRJ5057fA8=;
  b=MaRKJaRRgo+Gk2IYjsfc9aiKOLyr58g5GiKYtr8EtzAuqlQwQKmKduPq
   niHdDxYENo8uROD5x361WjAusj04Fb14KMVxshWRKDj/66YG89+z4v2ic
   Tx34Fuyg46rPv50MLF1c0Hyc/oszeqLZ+5+VG2NthZ0h+w6J/f7jPUW0R
   LqqOgHorMoUcJ4Hwi6RDgcR8By20XcGnYvH/RRx/lLgUvrpzT51FTjc91
   aT23e/pLLyVBnt4bl2cmtewf/xkWgz/P5jx8boglBW/O1nFzRgJiiey4g
   HIeG/ZBfC6TU8dxLLNILg4FWFA8jwDqssQ7bxAsFW827ruRT1sa33Z8Ug
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1509494"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1509494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776656505"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="776656505"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 04/29] selftests/resctrl: Change function comments to say < 0 on error
Date: Mon, 11 Dec 2023 14:18:01 +0200
Message-Id: <20231211121826.14392-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A number function comments state the function return non-zero on
failure but in reality they can only return 0 on success and < 0 on
error.

Update the comments to say < 0 on error to match the behavior.

While at it, improve cat_val() comment to state that 0 means the test
was run (either pass or fail).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/cache.c     |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 6d60a2f1b3aa..a9a0394b3d08 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -206,7 +206,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  * @param:		parameters passed to cache_val()
  * @span:		buffer size for the benchmark
  *
- * Return:		0 on success. non-zero on failure.
+ * Return:		0 when the test was run, < 0 on error.
  */
 int cat_val(struct resctrl_val_param *param, size_t span)
 {
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f5664392473c..c030a8a8377e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -56,7 +56,7 @@ static int find_resctrl_mount(char *buffer)
  * Mounts resctrl FS. Fails if resctrl FS is already mounted to avoid
  * pre-existing settings interfering with the test results.
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int mount_resctrlfs(void)
 {
@@ -276,7 +276,7 @@ int get_core_sibling(int cpu_no)
  * @bm_pid:	PID that should be binded
  * @cpu_no:	CPU number at which the PID would be binded
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int taskset_benchmark(pid_t bm_pid, int cpu_no)
 {
@@ -300,7 +300,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  * @grp:	Full path and name of the group
  * @parent_grp:	Full path and name of the parent group
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 {
@@ -376,7 +376,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  * pid is not written, this means that pid is in con_mon grp and hence
  * should consult con_mon grp's mon_data directory for results.
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val)
@@ -435,7 +435,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  * Update schemata of a con_mon grp *only* if requested resctrl feature is
  * allocation type
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 {
-- 
2.30.2


