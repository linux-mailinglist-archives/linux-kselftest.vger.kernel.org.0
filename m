Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6E3AF5CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFUTIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 15:08:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:60414 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhFUTIw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 15:08:52 -0400
IronPort-SDR: cXHMRXQz4mGFt8clh0K/+U60tuEvJGnG9o8q3y2PDpQeeAg/J21wpyRflPDzQwN1gIFu7q8Bjq
 gvhORtvMmfcg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187293641"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="187293641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 12:06:37 -0700
IronPort-SDR: z75lA64KpVlDa81rKjUVEAaNoYT9JJwKTUEy4mZGDOJKS4BvtY3G4Ps0S59j1/vwGbGelPPs2N
 16KUGjrgClIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="405721024"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2021 12:06:36 -0700
Subject: [PATCH] selftests/sgx: remove checks for file execute permissions
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        tim.gardner@canonical.com, jarkko@kernel.org,
        reinette.chatre@intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 21 Jun 2021 12:05:56 -0700
Message-Id: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


The SGX selftests can fail for a bunch of non-obvious reasons
like 'noexec' permissions on /dev (which is the default *EVERYWHERE*
it seems).

A new test mistakenly also looked for +x permission on the
/dev/sgx_enclave.  File execute permissions really only apply to
the ability of execve() to work on a file, *NOT* on the ability
for an application to map the file with PROT_EXEC.  SGX needs to
mmap(PROT_EXEC), but doesn't need to execve() the device file.

Remove the check.

Fixes: 4284f7acb78b ("selftests/sgx: Improve error detection and messages")
Reported-by: Tim Gardner <tim.gardner@canonical.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---

 b/tools/testing/selftests/sgx/load.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff -puN tools/testing/selftests/sgx/load.c~sgx-no-file-exec tools/testing/selftests/sgx/load.c
--- a/tools/testing/selftests/sgx/load.c~sgx-no-file-exec	2021-06-21 11:48:25.226294281 -0700
+++ b/tools/testing/selftests/sgx/load.c	2021-06-21 12:03:28.023292029 -0700
@@ -150,16 +150,6 @@ bool encl_load(const char *path, struct
 		goto err;
 	}
 
-	/*
-	 * This just checks if the /dev file has these permission
-	 * bits set.  It does not check that the current user is
-	 * the owner or in the owning group.
-	 */
-	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
-		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
-		goto err;
-	}
-
 	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
 		perror("mmap for read");
@@ -169,13 +159,13 @@ bool encl_load(const char *path, struct
 
 #define ERR_MSG \
 "mmap() succeeded for PROT_READ, but failed for PROT_EXEC.\n" \
-" Check that current user has execute permissions on %s and \n" \
-" that /dev does not have noexec set: mount | grep \"/dev .*noexec\"\n" \
+" Check that /dev does not have noexec set:\n" \
+" \tmount | grep \"/dev .*noexec\"\n" \
 " If so, remount it executable: mount -o remount,exec /dev\n\n"
 
 	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
-		fprintf(stderr, ERR_MSG, device_path);
+		fprintf(stderr, ERR_MSG);
 		goto err;
 	}
 	munmap(ptr, PAGE_SIZE);
_
