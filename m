Return-Path: <linux-kselftest+bounces-2045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC1814B36
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B632882CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB5364B4;
	Fri, 15 Dec 2023 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Alb9LMkX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC3381BB;
	Fri, 15 Dec 2023 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652821; x=1734188821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kd5+Mqw+LaVo3fOlOuS2NrZCmYXl5TWJGn3rPOJHuqc=;
  b=Alb9LMkXr1gR9dfiAoRQdMtZzZhrkxLIFr7s8Nvz/SdwqToJb0bkZBBH
   VFFjjjQSKSfFjpM6S17arVbn9wn2fTbYHfHunDcx4IY+7hGcYTHCtBqxB
   FZSHtUi+1ZnIEq2qDRGJLsDeupy7yG1LTW2C2uce251bakvahvUvH3FXM
   /mJiuw6/Wwic+JWW/r7E75tirqNKd4Jq5D5QbaMlF3Ie2RlR+ZCmVImp1
   PSnODdIipcbk11ah5ivqpw+0C0Rzi67qUhAojtjSZ4j0tdvVJivkJ9Uwe
   WaLuFxhNWPZXDm7Vq7TekZm/Vgk1YTtq/Vyi0Tz1AU+PmAX9bxKNqAFCY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375432965"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375432965"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021965754"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1021965754"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 04/29] selftests/resctrl: Change function comments to say < 0 on error
Date: Fri, 15 Dec 2023 17:04:50 +0200
Message-Id: <20231215150515.36983-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index 5fb595ed8843..81d1e043e17a 100644
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


