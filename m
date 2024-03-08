Return-Path: <linux-kselftest+bounces-6082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EA875C9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 04:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6808B21684
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34428E2B;
	Fri,  8 Mar 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b+wCmuix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654D163;
	Fri,  8 Mar 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867848; cv=none; b=FLPaWGrR+KZyq/D5510D92ugkB/fnkCjP+3Nl7e9CaIM8cbQD8ijWUJWYuqmvq0x7iEWh0jKtCiyLPo1Ch1gY0lDUuisnEDowObqTgCyFSWlTZ2b4YHgZa+2SiCaGU1kfGHr3JxEUQlgcDWvG96SDRRtq4j3+xtpn8FEwcLuKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867848; c=relaxed/simple;
	bh=HGv/S5b/PZMGYX/YuChf4dhdRWFdGEmMdjmn2fwerKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTaEASchnBzBaTaTR3zj8sZfWQ/Kt61kt/og3PBRtSruOQq1YyNLRsy6smj6CnPkZZZ/wAEh9xmI1A7yXzKtVcGV+gYXtU420xhSp6Kzd/LVnueVP4+4i21IUM3ChyTEgBwMN5A+Llzgool/XRjBysWwlWz1Jg9HxYKrJh5pqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b+wCmuix; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709867843; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5X7XzwizxZx+LYKAiz1/CufFLYi02GfrYmeirmHZ9r8=;
	b=b+wCmuixHyPnOz1FPAKRdm/yY36cXnk6VZD2DlDQ3+B21HfHQ8V3/Rsv6SopmRIx7oob0BFL6MQ/h4quyZgRp4YiOPhEG9SEBDaNTAIBi12DBjJ3dUt2Xbv+JfL+I2sBlhpQOt3r3LBhFnOVz9Bg/l4ZyKy9LYAlTf3I0qOrN+8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21N1Hi_1709867833;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W21N1Hi_1709867833)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 11:17:22 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	yixingrui@linux.alibaba.com,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/4] pstore: add multi-backend suuport
Date: Fri,  8 Mar 2024 11:16:52 +0800
Message-Id: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the 4th version of the patch set. In this patchset we aim to add
pstore multi-backend support then user can register more than one pstore
backend.

Changes in v4:
- Replace all rcu_read_lock with mutex
- Move bif_oops_buf, max_compressed_size and pstore_dumper into
  pstore_info_list
- add a helper to do "is this name in the list" and a helper to do
  "is this backend loaded"
- make comments in pstore_(un)register clearer
- return the max_seen ret or the first negative err in write_pmsg()
- add a /sys/module entry for the list of backends, comma separated
- Link to v3: https://lore.kernel.org/all/20230928024244.257687-1-xiangzao@linux.alibaba.com/

Changes in v3:
- Fix ftrace.c build error
- Link to v2: https://lore.kernel.org/all/20240205122852.7069-1-xiangzao@linux.alibaba.com/

Changes in v2:
- pstore.backend no longer acts as "registered backend", but
  "backends eligible for registration".
- drop subdir since it will break user space
- drop tty frontend since I haven't yet devised a satisfactory
  implementation strategy
- Link to v1: https://lore.kernel.org/all/20230928024244.257687-1-xiangzao@linux.alibaba.com/

Yuanhe Shu (4):
  pstore: add multi-backend support
  pstore: add a /sys/module entry for loaded backends
  Documentation: adjust pstore backend related document
  tools/testing: adjust pstore backend related selftest

 Documentation/ABI/testing/pstore              |   8 +-
 .../admin-guide/kernel-parameters.txt         |   4 +-
 fs/pstore/ftrace.c                            |  27 +-
 fs/pstore/inode.c                             |  57 +++-
 fs/pstore/internal.h                          |   5 +-
 fs/pstore/platform.c                          | 274 ++++++++++++------
 fs/pstore/pmsg.c                              |  27 +-
 include/linux/pstore.h                        |  23 ++
 tools/testing/selftests/pstore/common_tests   |   8 +-
 .../selftests/pstore/pstore_post_reboot_tests |  67 +++--
 tools/testing/selftests/pstore/pstore_tests   |   2 +-
 11 files changed, 358 insertions(+), 144 deletions(-)

-- 
2.39.3


