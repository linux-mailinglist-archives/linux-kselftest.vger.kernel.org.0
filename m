Return-Path: <linux-kselftest+bounces-22553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E349DA0E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59371284416
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB60149C69;
	Wed, 27 Nov 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNoog/aa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A7823C3
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676279; cv=none; b=S7rygI8DYMxbqWwU7qvGUVmO+mAV5ldkckeTCZ2X+aUxi/ba4OG2xmKHfr5AzuKcjL+3Ry7E+MK6Jbt/IZQVIraGAJXWmjzmyseDa3ang1qj5hrVWP//gIVolox7N4Ow0YhB4Dq7p78k5M+cTNp82t4v6TRr5NaaiRDIKOL8oXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676279; c=relaxed/simple;
	bh=qleIIFAwfTwv5qoVB4dJO6WTQiIO1s+7ceRpumwVu1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NcgolKAtZqHnbtyXgd4t4JOJ18CGBL9LNvg6c47AI3B8sf+BOomffXN2ru0Wg7irZPqFxqHwKvtJjXaKT2DSUw0hti94XerVq9OGsoTHAzh75LgZ7mvzF0Y/aWRJU57KVhggHprmqWD9A5XNtehb1Aw6VTMJeOPYOLjeNz8ppuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNoog/aa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea5bf5354fso6170459a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 18:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676276; x=1733281076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdWbI+s0p0wBgh+VsWAydrlLqfgeB+x4CgOEMGbe8TM=;
        b=eNoog/aaskHAOAAiARJN/HRdDhAXTPDkWMMUozqnIr/YU7DpKxtxWhZuLCTAizdzls
         L0tsmd57aJFuCtPQmP/FXrzQYo+53C4NzGnb56eKVlNBsGvmgQOEjrXddbABNNrYBXXI
         6DfVpMLXqAKXrFR+fHhP7hIaOovH8Fdxl6PsfWraMp5bXpQqyE/ZvhrCNaIXfrTMtTT+
         pFzcSidV6cZ0sqwcMxSRbk2PF5EIrgalNVIqWQXcf0CLU/54wBYlLIpXVO7Hq+Jcjpks
         +kt6VMXq0Nw01yar8eYkcl2gTi3jeY+WlOxBM4e5rZWT60qVUOiT987aDSF6/biDsgyO
         Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676276; x=1733281076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdWbI+s0p0wBgh+VsWAydrlLqfgeB+x4CgOEMGbe8TM=;
        b=Vz3wR5unwRj+QWzzaiRe2GObSBNeKGKpuTNQSTxYYL9BN/AvaZlRSfgsB7qljZA+sN
         psk55YCP6soLG7dPh93E5jhwA6tC5ob2IFzNqEbYB1jLh5/Lub4SWE/7hOI9io6ci4FE
         Lplgvw37lFqKx590HkksOgHp6MTaxF93G2azF8EVACDofNz3xaC38hZDY21SWlJsCxLc
         X6t/O1eWvXQNEmpQn/peRr6rtMhOytyt0wM77CZxbwU5iEJtx0CJP63TOmcPU0gfiJe4
         X1G90nyS5MtgZB6Z70Q/VvAcFXw+VuR2qD7Nr2fDYcmeczEIvt8DJCaMXk1fMcm/M9Cw
         1LDw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Bv9fhgzqGc9e2+kks42nDpGUnIuME5KZ8OL7Xrp8gNkVrnr+Lob0BLQBvxKP5tauKjfhOORTOtlWtfOxkj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/z/PS8HRQMaU/E2c8GBL+zTr0Hh17QYrC9Ju6NJeHaoFfMEt
	h11ZlFTCtWOU7qAw3ld8/HCHMgsdG7pO5PgXhzVrNmCNSFAs1Rg/1LJh7dQKwqlJ1oUF9wiawJS
	Tj0M6Ng==
X-Google-Smtp-Source: AGHT+IGwhfii5+MtQdbRihMKL41ITlobJS3ldyPZjP/ITZaiG2+mPbpCQb3KZbCSJSGpnWkssvQZr9R3iWRd
X-Received: from pjbok13.prod.google.com ([2002:a17:90b:1d4d:b0:2da:ac73:93e5])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d10:b0:2ea:aa56:4b0
 with SMTP id 98e67ed59e1d1-2ee08e99941mr2057809a91.3.1732676276518; Tue, 26
 Nov 2024 18:57:56 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:26 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-8-yuanchu@google.com>
Subject: [PATCH v4 7/9] Docs/admin-guide/mm/workingset_report: document sysfs
 and memcg interfaces
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add workingset reporting documentation for better discoverability of
its sysfs and memcg interfaces. Also document the required kernel
config to enable workingset reporting.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/workingset_report.rst      | 105 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/workingset_report.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 8b35795b664b..61a2a347fc91 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -41,4 +41,5 @@ the Linux memory management.
    swap_numa
    transhuge
    userfaultfd
+   workingset_report
    zswap
diff --git a/Documentation/admin-guide/mm/workingset_report.rst b/Documentation/admin-guide/mm/workingset_report.rst
new file mode 100644
index 000000000000..0969513705c4
--- /dev/null
+++ b/Documentation/admin-guide/mm/workingset_report.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Workingset Report
+=================
+Workingset report provides a view of memory coldness in user-defined
+time intervals, e.g. X bytes are Y milliseconds cold. It breaks down
+the user pages in the system per-NUMA node, per-memcg, for both
+anonymous and file pages into histograms that look like:
+::
+
+    1000 anon=137368 file=24530
+    20000 anon=34342 file=0
+    30000 anon=353232 file=333608
+    40000 anon=407198 file=206052
+    9223372036854775807 anon=4925624 file=892892
+
+The workingset reports can be used to drive proactive reclaim, by
+identifying the number of cold bytes in a memcg, then writing to
+``memory.reclaim``.
+
+Quick start
+===========
+Build the kernel with the following configurations. The report relies
+on Multi-gen LRU for page coldness.
+
+* ``CONFIG_LRU_GEN=y``
+* ``CONFIG_LRU_GEN_ENABLED=y``
+* ``CONFIG_WORKINGSET_REPORT=y``
+
+Optionally, the aging kernel daemon can be enabled with the following
+configuration.
+* ``CONFIG_WORKINGSET_REPORT_AGING=y``
+
+Sysfs interfaces
+================
+``/sys/devices/system/node/nodeX/workingset_report/page_age`` provides
+a per-node page age histogram, showing an aggregate of the node's lruvecs.
+Reading this file causes a hierarchical aging of all lruvecs, scanning
+pages and creates a new Multi-gen LRU generation in each lruvec.
+For example:
+::
+
+    1000 anon=0 file=0
+    2000 anon=0 file=0
+    100000 anon=5533696 file=5566464
+    18446744073709551615 anon=0 file=0
+
+``/sys/devices/system/node/nodeX/workingset_report/page_age_intervals``
+is a comma-separated list of time in milliseconds that configures what
+the page age histogram uses for aggregation. For the above histogram,
+the intervals are::
+
+    1000,2000,100000
+
+``/sys/devices/system/node/nodeX/workingset_report/refresh_interval``
+defines the amount of time the report is valid for in milliseconds.
+When a report is still valid, reading the ``page_age`` file shows
+the existing valid report, instead of generating a new one.
+
+``/sys/devices/system/node/nodeX/workingset_report/report_threshold``
+specifies how often the userspace agent can be notified for node
+memory pressure, in milliseconds. When a node reaches its low
+watermarks and wakes up kswapd, programs waiting on ``page_age`` are
+woken up so they can read the histogram and make policy decisions.
+
+Memcg interface
+===============
+While ``page_age_interval`` is defined per-node in sysfs, ``page_age``,
+``refresh_interval`` and ``report_threshold`` are available per-memcg.
+
+``/sys/fs/cgroup/.../memory.workingset.page_age``
+The memcg equivalent of the sysfs workingset page age histogram
+breaks down the workingset of this memcg and its children into
+page age intervals. Each node is prefixed with a node header and
+a newline. Non-proactive direct reclaim on this memcg can also
+wake up userspace agents that are waiting on this file.
+E.g.
+::
+
+    N0
+    1000 anon=0 file=0
+    2000 anon=0 file=0
+    3000 anon=0 file=0
+    4000 anon=0 file=0
+    5000 anon=0 file=0
+    18446744073709551615 anon=0 file=0
+
+``/sys/fs/cgroup/.../memory.workingset.refresh_interval``
+The memcg equivalent of the sysfs refresh interval. A per-node
+number of how much time a page age histogram is valid for, in
+milliseconds.
+E.g.
+::
+
+    echo N0=2000 > memory.workingset.refresh_interval
+
+``/sys/fs/cgroup/.../memory.workingset.report_threshold``
+The memcg equivalent of the sysfs report threshold. A per-node
+number of how often userspace agent waiting on the page age
+histogram can be woken up, in milliseconds.
+E.g.
+::
+
+    echo N0=1000 > memory.workingset.report_threshold
-- 
2.47.0.338.g60cca15819-goog


