Return-Path: <linux-kselftest+bounces-34774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D722AD624D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 00:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A21BC0018
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53534246BBE;
	Wed, 11 Jun 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="bYxi7yhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044EA59;
	Wed, 11 Jun 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680347; cv=none; b=YmNfo94xR23XMBGSPFd3oouDHJ94YNF/TtSqOUr0Qdvb/Ye2uFNEfMks7D1c3jscV6w8EIfqyM+9dtqsMyIchPE7lAemIhSQNEgiOCyPZVjV1FCZ1IxI1F/0W1U0E6ronS0/yvoaG6AJ2H3BlfLHaWpjXP/+CoQVbPsdfQgm3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680347; c=relaxed/simple;
	bh=HXOwjej880mZkuxWlQIZhkOHCmBrS0a/om10aHlc1n0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IGdkb97vTAwa5EdDm9M8X140+lkVffH5pGbSGgg3l9ZOklV0KMSg976q/casaEfN5clHwG/IzwMCW05SwYa9eBf6V4aPkF/bO52P0J+8127pg8lL7p5HH3UvatRY2Un6rVuM2iEBQt2Gy7c6EoN/LwTss1/epgeoUAg5E1Ix19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=bYxi7yhk; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJCfB5025810;
	Wed, 11 Jun 2025 22:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=WW7Acv1Kiu7px
	H4zvyRiNOigQgUWmvNiXoRHlhpmKEY=; b=bYxi7yhkWOn5gwd/Mf7k92/vw47nc
	L+xRL0UElEW0EVoMcfhyryfAzFG0CSEdCVM9rg/prKpsleXx1r8GRmhb3tdE/iSM
	FysIBX7crZOwrhsA9oOIjxXnrbhz07BX6lwYDR8O/4ZqLMQcMAwTI97yoQDqb9zU
	yMe8i8M23AYDVQFqXxXLVH1XuZf/4oto8m9upENNUI2QFMEjvR2+dDVQeIstsknB
	41HOfMC8/JnacYJpIdBsU366IsQFI8uGajGXjyGVihZHO/098iLEdZs6Sxf8rbiN
	Q212Q+mhFReMl2giH5KAKk0wTq5/gvm01nPpBneCzKnwt4nW7ZZgeqRYQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4750p2rshh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:18:36 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Jun 2025 22:18:31 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <qmo@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <shuah@kernel.org>, <bpf@vger.kernel.org>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <mykolal@fb.com>, <slava.imameev@crowdstrike.com>,
        <justin.deschamp@crowdstrike.com>, <mark.fontana@crowdstrike.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH bpf-next v3 1/2] bpftool: Use appropriate permissions for map access
Date: Thu, 12 Jun 2025 08:18:15 +1000
Message-ID: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: E3qkwDBxBetlnJFCSvuSM1qecocJmfXU
X-Proofpoint-GUID: E3qkwDBxBetlnJFCSvuSM1qecocJmfXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE4OSBTYWx0ZWRfX0oLMsOIFpSN/
 DpPqDndgLxad4O5httZXIZUmPrY/EWeWRGe5oFfR/0vwM6lUzhwUza6uRrt6lm3nQk7aF8jOkH1
 5/fGosbgbTWnZ4GtF9Ya+yI7tL42kTiaQFWmHmwxbOHom359xr8FDliQ5O6J3KlPw+IB2bHDGlw
 H5Ykl3e1PbI6WXH/Ig5MlHOjPkfcMoTtTElIpnl/glHgH+jp+aRnxkSsw+EgrQC5LntHS1Wlkmx
 8xGqgBcVnbKiyHXGgjfDQ0g/9LlTxGm5zCnyucoPWhWmn9oTj69jTfNDu8BrQacan9jcIYpEWni
 bzdjfroajtgQY0RTIch5BEQ0kgD3UQRSwVmEdKBpMPXuDBZ0JAmifoCn2w4scYfmq5Cq6IdkGAy
 scrOI0q92agbnvM/cZNXO/JNRkFLMiLl8w+j4MUPUr0kY9GE1BQJvCRtVNtkGSXzQhrrbtgI
X-Authority-Analysis: v=2.4 cv=UelRSLSN c=1 sm=1 tr=0 ts=684a00bc cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=6IFa9wvqVegA:10 a=pl6vuDidAAAA:8 a=XUOnwYygNC12sUfAly8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110189

Modify several functions in tools/bpf/bpftool/common.c to allow
specification of requested access for file descriptors, such as
read-only access.

Update bpftool to request only read access for maps when write
access is not required. This fixes errors when reading from maps
that are protected from modification via security_bpf_map.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
Changes in v2:
- fix for a test compilation error: "conflicting types for 'bpf_fentry_test1'"
Changes in v3:
- Addressed review feedback
- Converted the check for flags to an assert in map_parse_fds
- Modified map_fd_by_name to keep an existing fd where possible
- Fixed requested access for map delete command in do_delete
- Changed requested access to RDONLY for inner map fd in do_create
- Changed requested access to RDONLY for iterator fd in do_pin
---
---
 tools/bpf/bpftool/btf.c           |  3 +-
 tools/bpf/bpftool/common.c        | 58 ++++++++++++++++++++++---------
 tools/bpf/bpftool/iter.c          |  2 +-
 tools/bpf/bpftool/link.c          |  2 +-
 tools/bpf/bpftool/main.h          | 13 ++++---
 tools/bpf/bpftool/map.c           | 56 +++++++++++++++++------------
 tools/bpf/bpftool/map_perf_ring.c |  3 +-
 tools/bpf/bpftool/prog.c          |  4 +--
 8 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6b14cbfa58aa..1ba27cb03348 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -905,7 +905,8 @@ static int do_dump(int argc, char **argv)
 			return -1;
 		}
 
-		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+		fd = map_parse_fd_and_info(&argc, &argv, &info, &len,
+					   BPF_F_RDONLY);
 		if (fd < 0)
 			return -1;
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ecfa790adc13..3bdc65112c0d 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -193,7 +193,8 @@ int mount_tracefs(const char *target)
 	return err;
 }
 
-int open_obj_pinned(const char *path, bool quiet)
+int open_obj_pinned(const char *path, bool quiet,
+		    const struct bpf_obj_get_opts *opts)
 {
 	char *pname;
 	int fd = -1;
@@ -205,7 +206,7 @@ int open_obj_pinned(const char *path, bool quiet)
 		goto out_ret;
 	}
 
-	fd = bpf_obj_get(pname);
+	fd = bpf_obj_get_opts(pname, opts);
 	if (fd < 0) {
 		if (!quiet)
 			p_err("bpf obj get (%s): %s", pname,
@@ -221,12 +222,13 @@ int open_obj_pinned(const char *path, bool quiet)
 	return fd;
 }
 
-int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
+int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
+			const struct bpf_obj_get_opts *opts)
 {
 	enum bpf_obj_type type;
 	int fd;
 
-	fd = open_obj_pinned(path, false);
+	fd = open_obj_pinned(path, false, opts);
 	if (fd < 0)
 		return -1;
 
@@ -555,7 +557,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 	if (typeflag != FTW_F)
 		goto out_ret;
 
-	fd = open_obj_pinned(fpath, true);
+	fd = open_obj_pinned(fpath, true, NULL);
 	if (fd < 0)
 		goto out_ret;
 
@@ -928,7 +930,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG, NULL);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
@@ -965,7 +967,8 @@ int prog_parse_fd(int *argc, char ***argv)
 	return fd;
 }
 
-static int map_fd_by_name(char *name, int **fds)
+static int map_fd_by_name(char *name, int **fds,
+			  const struct bpf_get_fd_by_id_opts *opts)
 {
 	unsigned int id = 0;
 	int fd, nb_fds = 0;
@@ -973,6 +976,7 @@ static int map_fd_by_name(char *name, int **fds)
 	int err;
 
 	while (true) {
+		LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts_ro);
 		struct bpf_map_info info = {};
 		__u32 len = sizeof(info);
 
@@ -985,7 +989,9 @@ static int map_fd_by_name(char *name, int **fds)
 			return nb_fds;
 		}
 
-		fd = bpf_map_get_fd_by_id(id);
+		/* Request a read-only fd to query the map info */
+		opts_ro.open_flags = BPF_F_RDONLY;
+		fd = bpf_map_get_fd_by_id_opts(id, &opts_ro);
 		if (fd < 0) {
 			p_err("can't get map by id (%u): %s",
 			      id, strerror(errno));
@@ -1004,6 +1010,19 @@ static int map_fd_by_name(char *name, int **fds)
 			continue;
 		}
 
+		/* Get an fd with the requested options, if they differ
+		 * from the read-only options used to get the fd above.
+		 */
+		if (memcmp(opts, &opts_ro, sizeof(opts_ro))) {
+			close(fd);
+			fd = bpf_map_get_fd_by_id_opts(id, opts);
+			if (fd < 0) {
+				p_err("can't get map by id (%u): %s", id,
+					strerror(errno));
+				goto err_close_fds;
+			}
+		}
+
 		if (nb_fds > 0) {
 			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
 			if (!tmp) {
@@ -1023,8 +1042,13 @@ static int map_fd_by_name(char *name, int **fds)
 	return -1;
 }
 
-int map_parse_fds(int *argc, char ***argv, int **fds)
+int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags)
 {
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
+
+	assert((open_flags & ~BPF_F_RDONLY) == 0);
+	opts.open_flags = open_flags;
+
 	if (is_prefix(**argv, "id")) {
 		unsigned int id;
 		char *endptr;
@@ -1038,7 +1062,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		(*fds)[0] = bpf_map_get_fd_by_id(id);
+		(*fds)[0] = bpf_map_get_fd_by_id_opts(id, &opts);
 		if ((*fds)[0] < 0) {
 			p_err("get map by id (%u): %s", id, strerror(errno));
 			return -1;
@@ -1056,16 +1080,18 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 		}
 		NEXT_ARGP();
 
-		return map_fd_by_name(name, fds);
+		return map_fd_by_name(name, fds, &opts);
 	} else if (is_prefix(**argv, "pinned")) {
 		char *path;
+		LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
+		get_opts.file_flags = open_flags;
 
 		NEXT_ARGP();
 
 		path = **argv;
 		NEXT_ARGP();
 
-		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP);
+		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP, &get_opts);
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
@@ -1075,7 +1101,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
 	return -1;
 }
 
-int map_parse_fd(int *argc, char ***argv)
+int map_parse_fd(int *argc, char ***argv, __u32 open_flags)
 {
 	int *fds = NULL;
 	int nb_fds, fd;
@@ -1085,7 +1111,7 @@ int map_parse_fd(int *argc, char ***argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(argc, argv, &fds);
+	nb_fds = map_parse_fds(argc, argv, &fds, open_flags);
 	if (nb_fds != 1) {
 		if (nb_fds > 1) {
 			p_err("several maps match this handle");
@@ -1103,12 +1129,12 @@ int map_parse_fd(int *argc, char ***argv)
 }
 
 int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
-			  __u32 *info_len)
+			  __u32 *info_len, __u32 open_flags)
 {
 	int err;
 	int fd;
 
-	fd = map_parse_fd(argc, argv);
+	fd = map_parse_fd(argc, argv, open_flags);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 5c39c2ed36a2..df5f0d1e07e8 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -37,7 +37,7 @@ static int do_pin(int argc, char **argv)
 				return -1;
 			}
 
-			map_fd = map_parse_fd(&argc, &argv);
+			map_fd = map_parse_fd(&argc, &argv, BPF_F_RDONLY);
 			if (map_fd < 0)
 				return -1;
 
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 03513ffffb79..a773e05d5ade 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -117,7 +117,7 @@ static int link_parse_fd(int *argc, char ***argv)
 		path = **argv;
 		NEXT_ARGP();
 
-		return open_obj_pinned_any(path, BPF_OBJ_LINK);
+		return open_obj_pinned_any(path, BPF_OBJ_LINK, NULL);
 	}
 
 	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9eb764fe4cc8..6db704fda5c0 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -15,6 +15,7 @@
 
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
+#include <bpf/bpf.h>
 
 #include "json_writer.h"
 
@@ -140,8 +141,10 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
 int get_fd_type(int fd);
 const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
-int open_obj_pinned(const char *path, bool quiet);
-int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
+int open_obj_pinned(const char *path, bool quiet,
+		    const struct bpf_obj_get_opts *opts);
+int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
+			const struct bpf_obj_get_opts *opts);
 int mount_bpffs_for_file(const char *file_name);
 int create_and_mount_bpffs_dir(const char *dir_name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
@@ -167,10 +170,10 @@ int do_iter(int argc, char **argv) __weak;
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
 int prog_parse_fds(int *argc, char ***argv, int **fds);
-int map_parse_fd(int *argc, char ***argv);
-int map_parse_fds(int *argc, char ***argv, int **fds);
+int map_parse_fd(int *argc, char ***argv, __u32 open_flags);
+int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags);
 int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
-			  __u32 *info_len);
+			  __u32 *info_len, __u32 open_flags);
 
 struct bpf_prog_linfo;
 #if defined(HAVE_LLVM_SUPPORT) || defined(HAVE_LIBBFD_SUPPORT)
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 81cc668b4b05..c9de44a45778 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -337,9 +337,9 @@ static void fill_per_cpu_value(struct bpf_map_info *info, void *value)
 		memcpy(value + i * step, value, info->value_size);
 }
 
-static int parse_elem(char **argv, struct bpf_map_info *info,
-		      void *key, void *value, __u32 key_size, __u32 value_size,
-		      __u32 *flags, __u32 **value_fd)
+static int parse_elem(char **argv, struct bpf_map_info *info, void *key,
+		      void *value, __u32 key_size, __u32 value_size,
+		      __u32 *flags, __u32 **value_fd, __u32 open_flags)
 {
 	if (!*argv) {
 		if (!key && !value)
@@ -362,7 +362,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 			return -1;
 
 		return parse_elem(argv, info, NULL, value, key_size, value_size,
-				  flags, value_fd);
+				  flags, value_fd, open_flags);
 	} else if (is_prefix(*argv, "value")) {
 		int fd;
 
@@ -388,7 +388,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 				return -1;
 			}
 
-			fd = map_parse_fd(&argc, &argv);
+			fd = map_parse_fd(&argc, &argv, open_flags);
 			if (fd < 0)
 				return -1;
 
@@ -424,7 +424,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 		}
 
 		return parse_elem(argv, info, key, NULL, key_size, value_size,
-				  flags, NULL);
+				  flags, NULL, open_flags);
 	} else if (is_prefix(*argv, "any") || is_prefix(*argv, "noexist") ||
 		   is_prefix(*argv, "exist")) {
 		if (!flags) {
@@ -440,7 +440,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 			*flags = BPF_EXIST;
 
 		return parse_elem(argv + 1, info, key, value, key_size,
-				  value_size, NULL, value_fd);
+				  value_size, NULL, value_fd, open_flags);
 	}
 
 	p_err("expected key or value, got: %s", *argv);
@@ -639,7 +639,7 @@ static int do_show_subset(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -672,12 +672,15 @@ static int do_show_subset(int argc, char **argv)
 
 static int do_show(int argc, char **argv)
 {
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
 	__u32 id = 0;
 	int err;
 	int fd;
 
+	opts.open_flags = BPF_F_RDONLY;
+
 	if (show_pinned) {
 		map_table = hashmap__new(hash_fn_for_key_as_id,
 					 equal_fn_for_key_as_id, NULL);
@@ -707,7 +710,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		fd = bpf_map_get_fd_by_id(id);
+		fd = bpf_map_get_fd_by_id_opts(id, &opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue;
@@ -909,7 +912,7 @@ static int do_dump(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = map_parse_fds(&argc, &argv, &fds);
+	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -997,7 +1000,7 @@ static int do_update(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, 0);
 	if (fd < 0)
 		return -1;
 
@@ -1006,7 +1009,7 @@ static int do_update(int argc, char **argv)
 		goto exit_free;
 
 	err = parse_elem(argv, &info, key, value, info.key_size,
-			 info.value_size, &flags, &value_fd);
+			 info.value_size, &flags, &value_fd, 0);
 	if (err)
 		goto exit_free;
 
@@ -1076,7 +1079,7 @@ static int do_lookup(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);
 	if (fd < 0)
 		return -1;
 
@@ -1084,7 +1087,8 @@ static int do_lookup(int argc, char **argv)
 	if (err)
 		goto exit_free;
 
-	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL);
+	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL,
+			 BPF_F_RDONLY);
 	if (err)
 		goto exit_free;
 
@@ -1127,7 +1131,7 @@ static int do_getnext(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);
 	if (fd < 0)
 		return -1;
 
@@ -1140,8 +1144,8 @@ static int do_getnext(int argc, char **argv)
 	}
 
 	if (argc) {
-		err = parse_elem(argv, &info, key, NULL, info.key_size, 0,
-				 NULL, NULL);
+		err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL,
+				 NULL, BPF_F_RDONLY);
 		if (err)
 			goto exit_free;
 	} else {
@@ -1198,7 +1202,7 @@ static int do_delete(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, 0);
 	if (fd < 0)
 		return -1;
 
@@ -1209,7 +1213,8 @@ static int do_delete(int argc, char **argv)
 		goto exit_free;
 	}
 
-	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL);
+	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL,
+			 0);
 	if (err)
 		goto exit_free;
 
@@ -1226,11 +1231,16 @@ static int do_delete(int argc, char **argv)
 	return err;
 }
 
+static int map_parse_read_only_fd(int *argc, char ***argv)
+{
+	return map_parse_fd(argc, argv, BPF_F_RDONLY);
+}
+
 static int do_pin(int argc, char **argv)
 {
 	int err;
 
-	err = do_pin_any(argc, argv, map_parse_fd);
+	err = do_pin_any(argc, argv, map_parse_read_only_fd);
 	if (!err && json_output)
 		jsonw_null(json_wtr);
 	return err;
@@ -1319,7 +1329,7 @@ static int do_create(int argc, char **argv)
 			if (!REQ_ARGS(2))
 				usage();
 			inner_map_fd = map_parse_fd_and_info(&argc, &argv,
-							     &info, &len);
+							     &info, &len, BPF_F_RDONLY);
 			if (inner_map_fd < 0)
 				return -1;
 			attr.inner_map_fd = inner_map_fd;
@@ -1368,7 +1378,7 @@ static int do_pop_dequeue(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, 0);
 	if (fd < 0)
 		return -1;
 
@@ -1407,7 +1417,7 @@ static int do_freeze(int argc, char **argv)
 	if (!REQ_ARGS(2))
 		return -1;
 
-	fd = map_parse_fd(&argc, &argv);
+	fd = map_parse_fd(&argc, &argv, 0);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 552b4ca40c27..bcb767e2d673 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -128,7 +128,8 @@ int do_event_pipe(int argc, char **argv)
 	int err, map_fd;
 
 	map_info_len = sizeof(map_info);
-	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len);
+	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
+				       0);
 	if (map_fd < 0)
 		return -1;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 96eea8a67225..deeaa5c1ed7d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1062,7 +1062,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
 	if (!REQ_ARGS(2))
 		return -EINVAL;
 
-	*mapfd = map_parse_fd(&argc, &argv);
+	*mapfd = map_parse_fd(&argc, &argv, 0);
 	if (*mapfd < 0)
 		return *mapfd;
 
@@ -1608,7 +1608,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			}
 			NEXT_ARG();
 
-			fd = map_parse_fd(&argc, &argv);
+			fd = map_parse_fd(&argc, &argv, 0);
 			if (fd < 0)
 				goto err_free_reuse_maps;
 
-- 
2.34.1


