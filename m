Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D2269B1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 03:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgIOB3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 21:29:14 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10924 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIOB3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 21:29:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6018520000>; Mon, 14 Sep 2020 18:26:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 18:29:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 18:29:02 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 01:29:02 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 15 Sep 2020 01:29:02 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.52.22]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6018de0005>; Mon, 14 Sep 2020 18:29:02 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] selftests/vm: fix false build success on the second and later attempts
Date:   Mon, 14 Sep 2020 18:29:00 -0700
Message-ID: <20200915012901.1655280-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915012901.1655280-1-jhubbard@nvidia.com>
References: <20200915012901.1655280-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600133202; bh=x5qALEIabmrvz75oOg/DIfroc5FkHi76HfQxR/yMV5M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=fzuigUMOi4XuHMYL2JqDjqpHHqh+1Hn8/y7RSrLY+PziwtmntBZUtaor39QJCTqyj
         QzXfM1spGRgn4WmAWIO0dsY0nWXwO+il9Xq4iDBstgKadbuSU5tngCKo7W6vBg9C+5
         kCtRFCgNpk5sIYNUuVuvGdbnhxQuSHfsXBff2E8jc/Tayx5+0pgXJ8Xi1/8LIWTYVE
         bqnfkdol+ENCS3euCQD+mZfSnW/K54S+tiHe5xcvNkSS06pZdLFGm3ibvXcdqhBc05
         mk+c8kTuZ/1CMVUDrA48FfiqcoRavt/8v50NtOEVZsKr7kFuDVMxet8/7xSTqJala8
         eNm3rHVUiEA1Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If one or more of these selftest fail to build, then after the first
failure, subsequent invocations of "make" will make it appear that there
are no build failures, after all.

That's because the failed build products remain, with up-to-date
timestamps, thus tricking Make (and you!) into believing that there's
nothing else to build.

Fix this by telling Make to delete targets that didn't completely
succeed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index a9026706d597..9f2625bebf07 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -3,6 +3,11 @@
 uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
 MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
=20
+# Without this, failed build products remain, with up-to-date timestamps,
+# thus tricking Make (and you!) into believing that All Is Well, in subseq=
uent
+# make invocations:
+.DELETE_ON_ERROR:
+
 CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS =3D -lrt
 TEST_GEN_FILES =3D compaction_test
--=20
2.28.0

