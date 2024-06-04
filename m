Return-Path: <linux-kselftest+bounces-11166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB108FA82C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 04:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC141F26E53
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD31411CA;
	Tue,  4 Jun 2024 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kw3CUsG4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E36140399
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466784; cv=none; b=I3FDOU0kjOqo2yJwom6qvg6NNE5HZjtJ3ZftcLT97WBHp/Ol3K7D6EToRaVY9ghQEBZ9u+9YA9c+B1aY+yS/2TFDuwt8MmTEr97q9gN8Zej7/cc3ODGePqG9ProtIVeZwgGkWuNKSBjiK5GZJRYCiZKP9e5Brij5kEGi8zAzL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466784; c=relaxed/simple;
	bh=eASpyk4WWK4m1u5bAgzdZmzHoLxlNRCkiIkqJ+AFaTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOlUGT6XNnvICm3YvXFQ93bGx7ULfkbfWIuQwkqItdwYt1nZpCMaevDdBhQYMFT0xxSISQaqlcB8yy/EuqR4Vp/Cs0/4fzFFF8vkM0fqxb3YUDMV2wB+cnbNTz1f2FfLNU1c7zZ0SJZCsDV3zUoVC09vcjc0v9onB4azlb5lpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kw3CUsG4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a3dec382eso54944257b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466782; x=1718071582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnO0wJpr9VrNuJfB7YNxreIL5h7wQch0G6mtECTuPNI=;
        b=kw3CUsG4HuXRbBfwPxIlmqbR59+zdoruCRpZfL487nlZ/KeYrxAz5IYal2lceH7KcQ
         M090USlbcJr0vsXC4S19u/7Wl64ULN/7p+VrkpqJB2xukoqq/ZTtsK2BND/MKg5tcRP4
         g68Zq1Lyl0xQ8Qyos4iFJUsv2uRnYVQV77jpfMKFYy8gHKVKh+k99f9oDe9eijg5ov1r
         GiveBNjP+eolSf94p441u8j3HDuZO8hjKV63kEie0Og9IeVVt7JVw1FbSj+Luv6/vNz4
         49+OPKcDmrWbAf9Nn7Mm+iKp8S/jQisMIqWGJekmOVrt92iCG9X1IkSqj0yC5GpD1vVM
         1Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466782; x=1718071582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnO0wJpr9VrNuJfB7YNxreIL5h7wQch0G6mtECTuPNI=;
        b=KjuJRIlII+6xQFYDDBN6iBZ6Yy1iSBvtf7yenuk7ZYd6ylmbBIKffMwNzWidWTmJuF
         alXFCG/Z8h16P9slca2M6e0DcSyto12hBVLOIxvqug8gjgVhx1Vu1SiscYISkTf4ekxK
         uR4e5d8LCb5a+/FR6DNIJRSH5zhbS2TAgo0xQmMeIZcqkSiVJ5oEAyczp7HnXMBdh7Yf
         XOgTPIuDB5oGF3KLXYJN5bC+OWgab1hhHJa+e9PwOT0LeFgGE/Ez7+yjT25KdiTMYSvV
         60Vlvf6YAMQahpusYHVbEpbT4VC7B/YJypmVLg9TPzshP6w5UIGfGAb6B9uUnjhALk80
         AQjA==
X-Forwarded-Encrypted: i=1; AJvYcCV6noyIs3MxP5/uYrBSJBAgOC06d8181pFkuAc9TsAd3MwnsuitvARteAB//s1mOYiPz77yhJDynBb0GgO+cDaM1bocbNfhHKsrv9H2Blw6
X-Gm-Message-State: AOJu0YzP3jFPet5rSkuLSqDyp/4ehfuTXT9Bof1W4tdYRcroUxbWQQX0
	tKrTbx97E3+imbQrUzC9K7B7bg0F3OBZty6ITy6iy3DNImnYfiRtsZxIT5EtO5dOPPC/8TirChe
	PQqIgbA==
X-Google-Smtp-Source: AGHT+IGZTKhErP0mteEdLmLII+zOO1bIGHOtdpRtyYGuauHmWRG/AEKax0/K3QpTHO4KkINtPULvAXTKU6Gn
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a81:c906:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-62cabc4cd34mr3112857b3.1.1717466782241; Mon, 03 Jun 2024
 19:06:22 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:49 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-9-yuanchu@google.com>
Subject: [PATCH v2 8/8] Docs/admin-guide/mm/workingset_report: document sysfs
 and memcg interfaces
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
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
index 1f883abf3f00..fba987de8997 100644
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
index 000000000000..f455ae93b30e
--- /dev/null
+++ b/Documentation/admin-guide/mm/workingset_report.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Workingset Report
+=================
+Workingset report provides a view of memory coldness in user-defined
+time intervals, i.e. X bytes are Y milliseconds cold. It breaks down
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
+* ``CONFIG_LRU_GEN_ENABLED=y``
+
+Sysfs interfaces
+================
+``/sys/devices/system/node/nodeX/page_age`` provides a per-node page
+age histogram, showing an aggregate of the node's lruvecs.
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
+``/sys/devices/system/node/nodeX/page_age_interval`` is a comma
+separated list of time in milliseconds that configures what the page
+age histogram uses for aggregation. For the above histogram,
+the intervals are:
+::
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
+While ``page_age_interval`` is defined per-node in sysfs. ``page_age``,
+``refresh_interval`` and ``report_threshold`` are available per-memcg.
+
+``/sys/fs/cgroup/.../memory.workingset.page_age``
+The memcg equivalent of the sysfs workingset page age histogram,
+breaks down the workingset of this memcg and its children into
+page age intervals. Each node is prefixed with a node header and
+a newline. Non-proactive direct reclaim on this memcg can also
+wake up userspace agents that are waiting on this file.
+e.g.
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
+e.g.
+::
+
+    echo N0=2000 > memory.workingset.refresh_interval
+
+``/sys/fs/cgroup/.../memory.workingset.report_threshold``
+The memcg equivalent of the sysfs report threshold. A per-node
+number of how often userspace agent waiting on the page age
+histogram can be woken up, in milliseconds.
+e.g.
+::
+
+    echo N0=1000 > memory.workingset.report_threshold
-- 
2.45.1.467.gbab1589fc0-goog


