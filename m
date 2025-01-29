Return-Path: <linux-kselftest+bounces-25385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E269EA2232C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE817A12CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA01E25ED;
	Wed, 29 Jan 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c66lT+NG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531F1E1A20;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172366; cv=none; b=kTvfioiOF2yNg/jzw56u6LymNndTZu5c7kXmmq14Cq5Ti1swM5j1dSn2wcIoHkx23X4jwiVAGxOXQRvP9/xjg24dy1dz0yV4JwH98N/79Z9+9OdoCj7ULYe2fWltoJaSODPTwZvcMep8U2n+8hLcJLq5gzg77mHJXicEDoClupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172366; c=relaxed/simple;
	bh=cwT7OOd3e8YXByY5buE5GBsrd7k//w95I9xIgQ/WRW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adyci1CU9goOmvt04TrrU/zF3ff45QIK/nc4QTqZkyX1uRx7Z/s6LvtSPIi6SJZWB7XzOmsxt0Nw6+6RQj9FqZ/64F5Z0uxLsG0mN/TYZanLVxw83jj28IcxYMepH7i6VyQqp/4STsv9sxYVXUQxUUOrfG9XbalWPekZH/1kHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c66lT+NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE00C4CEE0;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738172365;
	bh=cwT7OOd3e8YXByY5buE5GBsrd7k//w95I9xIgQ/WRW4=;
	h=From:To:Cc:Subject:Date:From;
	b=c66lT+NGSCB6o/1+C/adMYxB0BKHdkN4p7Edc+LnmLQJ3P0ejYLVX6TC2MaE0GAFx
	 COByEcmhb66oKJjBjk8tshZas4m+ZhfzmyrRL0OEmpv+l6CcSAmP+m+XF3hZLiyKLk
	 pDZcI/wq30cZiVOwPuAwXKHxqWVv8YAYWyVnkFuqEH8YzsPuQN++DTT2et9kUrym0n
	 ZdRtdr5ssORyevTXtJc4uczAsr8DgbFMX76IzdXQ8Ku6kqDEerSnOOwBc/p7MXmQ+y
	 IbL41XKnOrVX+0bTA+ww+6eVrYai9NWdOzoFB1OV0rNhQ0/Vfzn2yGJR6DmKMdf7kX
	 L/zJuHuxVcrbA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdC26-00000004SdB-33Fx;
	Wed, 29 Jan 2025 18:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <mchehab+huawei@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <mchehab+huawei@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <mchehab+huawei@kernel.org>,
	Song Liu <mchehab+huawei@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/6] Address some issues related to Python version
Date: Wed, 29 Jan 2025 18:39:02 +0100
Message-ID: <cover.1738171937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This series remove compatibility with Python 2.x from scripts that have some
backward compatibility logic on it. The rationale is that, since 
commit 627395716cc3 ("docs: document python version used for compilation"),
the minimal Python version was set to 3.x. Also, Python 2.x is EOL since Jan, 2020.

Patch 1: fix a script that was compatible only with Python 2.x;
Patches 2-4: remove backward-compat code;
Patches 5-6 solves forward-compat with modern Python which warns about using
 raw strings without using "r" format.

Mauro Carvalho Chehab (6):
  docs: trace: decode_msr.py: make it compatible with python 3
  tools: perf: exported-sql-viewer: drop support for Python 2
  tools: perf: tools: perf: exported-sql-viewer: drop support for Python
    2
  tools: perf: task-analyzer: drop support for Python 2
  tools: selftests/bpf: test_bpftool_synctypes: escape raw symbols
  comedi: convert_csv_to_c.py: use r-string for a regex expression

 Documentation/trace/postprocess/decode_msr.py |  2 +-
 .../ni_routing/tools/convert_csv_to_c.py      |  2 +-
 .../scripts/python/exported-sql-viewer.py     |  5 ++--
 tools/perf/scripts/python/task-analyzer.py    | 23 ++++----------
 tools/perf/tests/shell/lib/attr.py            |  6 +---
 .../selftests/bpf/test_bpftool_synctypes.py   | 30 +++++++++----------
 6 files changed, 25 insertions(+), 43 deletions(-)

-- 
2.48.1



