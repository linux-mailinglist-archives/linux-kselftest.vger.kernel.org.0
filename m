Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4C41C6E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbhI2OjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344577AbhI2OjH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBk2o3Wn5ME4zAyV3V8BGHHmKTT8FNWmDcNVAxfbuKM=;
        b=as8s4IcxzNXJLtAGPFuO5UeAN9KEljqNf4LBXnV0rQUGM7NRnaxag/k2oWyjXbxj26cXb2
        IxBCoUmkDQtsO4imQ5Ftxir+FZIj3V9dMw8fEEK/4DI9WxcKIqPK82/mNrZ9of29Z4/evD
        kz+cTHUFOzc266Z3vIycgWmspGY9DYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-54DoF-KKPJ6fw6WeyltG_A-1; Wed, 29 Sep 2021 10:37:24 -0400
X-MC-Unique: 54DoF-KKPJ6fw6WeyltG_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83AE719253C3;
        Wed, 29 Sep 2021 14:37:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1BC100760B;
        Wed, 29 Sep 2021 14:37:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v1 4/6] mm/memory_hotplug: remove HIGHMEM leftovers
Date:   Wed, 29 Sep 2021 16:35:58 +0200
Message-Id: <20210929143600.49379-5-david@redhat.com>
In-Reply-To: <20210929143600.49379-1-david@redhat.com>
References: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We don't support CONFIG_MEMORY_HOTPLUG on 32 bit and consequently not
HIGHMEM. Let's remove any leftover code -- including the unused
"status_change_nid_high" field part of the memory notifier.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/core-api/memory-hotplug.rst     |  3 --
 .../zh_CN/core-api/memory-hotplug.rst         |  4 ---
 include/linux/memory.h                        |  1 -
 mm/memory_hotplug.c                           | 36 ++-----------------
 4 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
index de7467e48067..682259ee633a 100644
--- a/Documentation/core-api/memory-hotplug.rst
+++ b/Documentation/core-api/memory-hotplug.rst
@@ -57,7 +57,6 @@ The third argument (arg) passes a pointer of struct memory_notify::
 		unsigned long start_pfn;
 		unsigned long nr_pages;
 		int status_change_nid_normal;
-		int status_change_nid_high;
 		int status_change_nid;
 	}
 
@@ -65,8 +64,6 @@ The third argument (arg) passes a pointer of struct memory_notify::
 - nr_pages is # of pages of online/offline memory.
 - status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
   is (will be) set/clear, if this is -1, then nodemask status is not changed.
-- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
-  is (will be) set/clear, if this is -1, then nodemask status is not changed.
 - status_change_nid is set node id when N_MEMORY of nodemask is (will be)
   set/clear. It means a new(memoryless) node gets new memory by online and a
   node loses all memory. If this is -1, then nodemask status is not changed.
diff --git a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
index 161f4d2c18cc..9a204eb196f2 100644
--- a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
+++ b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
@@ -63,7 +63,6 @@ memory_notify结构体的指针::
 		unsigned long start_pfn;
 		unsigned long nr_pages;
 		int status_change_nid_normal;
-		int status_change_nid_high;
 		int status_change_nid;
 	}
 
@@ -74,9 +73,6 @@ memory_notify结构体的指针::
 - status_change_nid_normal是当nodemask的N_NORMAL_MEMORY被设置/清除时设置节
   点id，如果是-1，则nodemask状态不改变。
 
-- status_change_nid_high是当nodemask的N_HIGH_MEMORY被设置/清除时设置的节点
-  id，如果这个值为-1，那么nodemask状态不会改变。
-
 - status_change_nid是当nodemask的N_MEMORY被（将）设置/清除时设置的节点id。这
   意味着一个新的（没上线的）节点通过联机获得新的内存，而一个节点失去了所有的内
   存。如果这个值为-1，那么nodemask的状态就不会改变。
diff --git a/include/linux/memory.h b/include/linux/memory.h
index dd6e608c3e0b..c46ff374d48d 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -96,7 +96,6 @@ struct memory_notify {
 	unsigned long start_pfn;
 	unsigned long nr_pages;
 	int status_change_nid_normal;
-	int status_change_nid_high;
 	int status_change_nid;
 };
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8d7b2b593a26..95c927c8bfb8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -21,7 +21,6 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
-#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -585,10 +584,6 @@ void generic_online_page(struct page *page, unsigned int order)
 	debug_pagealloc_map_pages(page, 1 << order);
 	__free_pages_core(page, order);
 	totalram_pages_add(1UL << order);
-#ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page))
-		totalhigh_pages_add(1UL << order);
-#endif
 }
 EXPORT_SYMBOL_GPL(generic_online_page);
 
@@ -625,16 +620,11 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 
 	arg->status_change_nid = NUMA_NO_NODE;
 	arg->status_change_nid_normal = NUMA_NO_NODE;
-	arg->status_change_nid_high = NUMA_NO_NODE;
 
 	if (!node_state(nid, N_MEMORY))
 		arg->status_change_nid = nid;
 	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
-#ifdef CONFIG_HIGHMEM
-	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
-		arg->status_change_nid_high = nid;
-#endif
 }
 
 static void node_states_set_node(int node, struct memory_notify *arg)
@@ -642,9 +632,6 @@ static void node_states_set_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_normal >= 0)
 		node_set_state(node, N_NORMAL_MEMORY);
 
-	if (arg->status_change_nid_high >= 0)
-		node_set_state(node, N_HIGH_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_set_state(node, N_MEMORY);
 }
@@ -1801,7 +1788,6 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 
 	arg->status_change_nid = NUMA_NO_NODE;
 	arg->status_change_nid_normal = NUMA_NO_NODE;
-	arg->status_change_nid_high = NUMA_NO_NODE;
 
 	/*
 	 * Check whether node_states[N_NORMAL_MEMORY] will be changed.
@@ -1816,24 +1802,9 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	if (zone_idx(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
 		arg->status_change_nid_normal = zone_to_nid(zone);
 
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * node_states[N_HIGH_MEMORY] contains nodes which
-	 * have normal memory or high memory.
-	 * Here we add the present_pages belonging to ZONE_HIGHMEM.
-	 * If the zone is within the range of [0..ZONE_HIGHMEM), and
-	 * we determine that the zones in that range become empty,
-	 * we need to clear the node for N_HIGH_MEMORY.
-	 */
-	present_pages += pgdat->node_zones[ZONE_HIGHMEM].present_pages;
-	if (zone_idx(zone) <= ZONE_HIGHMEM && nr_pages >= present_pages)
-		arg->status_change_nid_high = zone_to_nid(zone);
-#endif
-
 	/*
-	 * We have accounted the pages from [0..ZONE_NORMAL), and
-	 * in case of CONFIG_HIGHMEM the pages from ZONE_HIGHMEM
-	 * as well.
+	 * We have accounted the pages from [0..ZONE_NORMAL); ZONE_HIGHMEM
+	 * does not apply as we don't support 32bit.
 	 * Here we count the possible pages from ZONE_MOVABLE.
 	 * If after having accounted all the pages, we see that the nr_pages
 	 * to be offlined is over or equal to the accounted pages,
@@ -1851,9 +1822,6 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_normal >= 0)
 		node_clear_state(node, N_NORMAL_MEMORY);
 
-	if (arg->status_change_nid_high >= 0)
-		node_clear_state(node, N_HIGH_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
 }
-- 
2.31.1

