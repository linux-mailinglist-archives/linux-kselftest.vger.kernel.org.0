Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A08AF63
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfHMGLl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59186 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfHMGLj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68qlv039282;
        Tue, 13 Aug 2019 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=MkGlaRzfhOaspuCgCSxv0mcumwSprFHBy9GelM51bZI=;
 b=cXO/RaN4hhWyYwTI/ANiRV7dNU7drhUyZyVr/adYVTkP1RuK4WkzvjLB9Peeg7ZhR9zd
 PlKH+Ohmmmw/buNLkc0XHTBvHzXjG+42G6e7y806+teV5g8PeHT+wrO6ID+gyTkoAtYo
 JaawzE9cJ0iYQKE0ozcSThhlM/bhPDG2AKaKKq9mWRr8+e9XQ7nAxAWwMpPTWoKbUr2r
 bf0qOs8/ata9OtLbulu/KzU+2ImgEgV3qItogvtV1LuSGRg1wuyFCGuVBbYnUcdf5jtR
 ndz66saasOvb7skjWTuXO9E5FzRxnsVZECSdx1xd/4sC2CzFMHYyqxR8/1IxG7hN/bxF 4A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=MkGlaRzfhOaspuCgCSxv0mcumwSprFHBy9GelM51bZI=;
 b=aCt6nQ319nkZ7IZwz8tkum/s1PGwUPj9v8VbBEz7OnEBWLqoiR8KLw7xTVJHnDwe3uz0
 0a+N0xPESPrvVcjL6EQhMDSDwZFZqK7uyIF/7Zia3HC69ziDE9IskQ7m6WBhy4uvpeZC
 mfL3z4p3+Cet93Ye8wK2yw+lZAMXqRSbkUN+rDW2Fa6Rn+vPjYudlwk186So+3/txj9l
 ezSK5M4Jdd9h44ur22jRqBGn7SOhpMmhbviGU/zuYhA+KoLfNhaqsEv8d/4JOFY9nhjj
 dLFzWCXxi0+DLaKXM4bBVpbJE2cWyfZQxidpEenO9lEepn4cnEgvHElgi+f0fkHK8enL Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvp41g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67Rqj096715;
        Tue, 13 Aug 2019 06:11:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u9m0aydx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6BIs8026626;
        Tue, 13 Aug 2019 06:11:18 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:17 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 07/19] ktf: Simple coverage support
Date:   Tue, 13 Aug 2019 08:09:22 +0200
Message-Id: <a195920c376f836c563a8e11169be946267734fe.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

Allows reports of code coverage and memory allocation.

ktf_cov.c:       Code coverage support implementation for KTF.
ktf_cov.h:       Code coverage support interface for KTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/ktf_cov.c | 690 ++++++++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_cov.h |  94 +++-
 2 files changed, 784 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_cov.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_cov.h

diff --git a/tools/testing/selftests/ktf/kernel/ktf_cov.c b/tools/testing/selftests/ktf/kernel/ktf_cov.c
new file mode 100644
index 0000000..f917994
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_cov.c
@@ -0,0 +1,690 @@
+/*
+ * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_cov.c: Code coverage support implementation for KTF.
+ */
+#include <linux/kallsyms.h>
+#include <linux/debugfs.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/stacktrace.h>
+#ifdef CONFIG_SLUB
+#include <linux/slub_def.h>
+#endif /* CONFIG_SLUB */
+#ifdef CONFIG_SLAB
+#include <linux/slab_def.h>
+#endif
+#include <linux/string.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include "ktf.h"
+#include "ktf_map.h"
+#include "ktf_cov.h"
+
+/* It may seem odd that we use a refcnt field in ktf_cov_entry structures
+ * in addition to using krefcount management via the ktf_map.  The reasoning
+ * here is that if we enable and then disable coverage, we do not want to
+ * purge the entry data as we likely want to examine counts after disabling
+ * coverage.  So the first enable will add entries to the cov_entry map and
+ * subsequent disable/enables will simply update the entry's refcnt.  The
+ * free function below should only be called therefore from cleanup context
+ * when the cov entries are finally removed from the cov_entry map.
+ */
+static void ktf_cov_entry_free(struct ktf_map_elem *elem)
+{
+	struct ktf_cov_entry *entry = container_of(elem, struct ktf_cov_entry,
+						   kmap);
+	if (entry->refcnt > 0)
+		unregister_kprobe(&entry->kprobe);
+	kfree(entry);
+}
+
+/* Comparison function is subtle.  We want to be able to compare key1
+ * and key2 here, where key1 may either be an existing object, in which
+ * case it has an address and size; or it may be an object offset, in which
+ * case k1's address will be the address with offset of size 0.  In both
+ * cases for the -1 case we can simply check if k1's address is less than
+ * k2's.  For the 1 case, we need to ensure that the address is >=
+ * k2's address and it's size, since this ensures the address does not
+ * fall within the object bounds.  Finally we are left with the case
+ * that k1.address >= k2.address _and_ it falls within the bounds of k2,
+ * which we consider a match.  For a concrete example of how this matching
+ * is used, see how we walk the stack of functions within the kmalloc
+ * kretprobe below: we will have a function + offset on the stack, and we
+ * want to see if this offset falls within a function in our coverage entry
+ * map.  If it does, we track the allocation.  The implicit assumption is
+ * no overlap between different objects.
+ */
+static int ktf_cov_obj_compare(const char *key1, const char *key2)
+{
+	struct ktf_cov_obj_key *k1 = (struct ktf_cov_obj_key *)key1;
+	struct ktf_cov_obj_key *k2 = (struct ktf_cov_obj_key *)key2;
+
+	if (k1->address < k2->address)
+		return -1;
+	if (k1->address >= (k2->address + k2->size))
+		return 1;
+	return 0;
+}
+
+void ktf_cov_entry_get(struct ktf_cov_entry *entry)
+{
+	ktf_map_elem_get(&entry->kmap);
+}
+
+void ktf_cov_entry_put(struct ktf_cov_entry *entry)
+{
+	ktf_map_elem_put(&entry->kmap);
+}
+
+/* Global map for address-> symbol/module mapping.  Sort via symbol address
+ * and size combination, see ktf_cov_obj_compare() above for comparison
+ * logic.
+ */
+static DEFINE_KTF_MAP(cov_entry_map, ktf_cov_obj_compare, ktf_cov_entry_free);
+
+struct ktf_cov_entry *ktf_cov_entry_find(unsigned long addr, unsigned long size)
+{
+	struct ktf_cov_obj_key k;
+
+	k.address = addr;
+	k.size = size;
+
+	return ktf_map_find_entry(&cov_entry_map, (char *)&k,
+				  struct ktf_cov_entry, kmap);
+}
+
+static void ktf_cov_free(struct ktf_map_elem *elem)
+{
+	struct ktf_cov *cov = container_of(elem, struct ktf_cov, kmap);
+
+	kfree(cov);
+}
+
+void ktf_cov_put(struct ktf_cov *cov)
+{
+	ktf_map_elem_put(&cov->kmap);
+}
+
+/* Coverage object map. Just modules supported for now, sort by name. */
+static DEFINE_KTF_MAP(cov_map, NULL, ktf_cov_free);
+
+struct ktf_cov *ktf_cov_find(const char *module)
+{
+	return ktf_map_find_entry(&cov_map, module, struct ktf_cov, kmap);
+}
+
+/* cache for memory objects used to track allocations */
+static struct kmem_cache *cov_mem_cache;
+
+static void ktf_cov_mem_free(struct ktf_map_elem *elem)
+{
+	struct ktf_cov_mem *m = container_of(elem, struct ktf_cov_mem,
+					     kmap);
+
+	kmem_cache_free(cov_mem_cache, m);
+}
+
+/* Global map for tracking memory allocations */
+DEFINE_KTF_MAP(cov_mem_map, ktf_cov_obj_compare, ktf_cov_mem_free);
+EXPORT_SYMBOL(cov_mem_map);
+
+struct ktf_cov_mem *ktf_cov_mem_find(unsigned long addr, unsigned long size)
+{
+	struct ktf_cov_obj_key k;
+
+	k.address = addr;
+	k.size = size;
+
+	return ktf_map_find_entry(&cov_mem_map, (char *)&k,
+				  struct ktf_cov_mem, kmap);
+}
+
+void ktf_cov_mem_get(struct ktf_cov_mem *m)
+{
+	ktf_map_elem_get(&m->kmap);
+}
+
+void ktf_cov_mem_put(struct ktf_cov_mem *m)
+{
+	ktf_map_elem_put(&m->kmap);
+}
+
+static void ktf_cov_mem_remove(struct ktf_cov_mem *m)
+{
+	ktf_map_remove_elem(&cov_mem_map, &m->kmap);
+}
+
+/* Do not use ktf_cov_entry_find() here as we can get entry directly
+ * from probe address (as probe is first field in struct ktf_cov_entry).
+ * No reference counting issues should apply as when entry refcnt drops
+ * to 0 we unregister the kprobe prior to freeing the entry.
+ */
+static int ktf_cov_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct ktf_cov_entry *entry = (struct ktf_cov_entry *)p;
+
+	/* Make sure probe is ours... */
+	if (!entry || entry->magic != KTF_COV_ENTRY_MAGIC)
+		return 0;
+	entry->count++;
+	if (entry->count == 1 && entry->cov)
+		entry->cov->count++;
+	return 0;
+}
+
+static int ktf_cov_init_symbol(void *data, const char *name,
+			       struct module *mod, unsigned long addr)
+{
+	struct ktf_cov_entry *entry;
+	struct ktf_cov *cov = data;
+	char buf[256];
+
+	if (!mod || !cov)
+		return 0;
+
+	if (!try_module_get(mod))
+		return 0;
+
+	/* module_mutex is grabbed by register_kprobe() */
+	mutex_unlock(&module_mutex);
+
+	/* We only care about symbols for cov-specified module. */
+	if (strcmp(mod->name, cov->kmap.key))
+		goto out;
+
+	/* We don't probe ourselves and functions called within probe ctxt. */
+	if (strncmp(name, "ktf_cov", strlen("ktf_cov")) == 0 ||
+	    strcmp(name, "ktf_map_find") == 0)
+		goto out;
+
+	/* Check if we're already covered for this module/symbol. */
+	entry = ktf_cov_entry_find(addr, 0);
+	if (entry) {
+		tlog(T_DEBUG, "%s already present in coverage: %s",
+		     name, entry->name);
+		ktf_cov_entry_put(entry);
+		goto out;
+	}
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	(void)strlcpy(entry->name, name, sizeof(entry->name));
+	entry->magic = KTF_COV_ENTRY_MAGIC;
+	entry->cov = cov;
+	entry->refcnt = 1;
+
+	entry->kprobe.pre_handler = ktf_cov_handler;
+	entry->kprobe.symbol_name = entry->name;
+
+	/* Ugh - we try to register a kprobe as a means of determining
+	 * if the symbol is a function.
+	 */
+	if (register_kprobe(&entry->kprobe) < 0) {
+		/* not a probe-able function */
+		kfree(entry);
+		goto out;
+	}
+	entry->key.address = addr;
+	entry->key.size = ktf_symbol_size(addr);
+	(void)sprint_symbol(buf, entry->key.address);
+	if (ktf_map_elem_init(&entry->kmap, (char *)&entry->key) < 0 ||
+	    ktf_map_insert(&cov_entry_map, &entry->kmap) < 0) {
+		unregister_kprobe(&entry->kprobe);
+		kfree(entry);
+		goto out;
+	}
+	tlog(T_DEBUG, "Added %s/%s (%p, size %lu) to coverage: %s",
+	     mod->name, entry->name, (void *)entry->kprobe.addr,
+	     entry->key.size, buf);
+
+	cov->total++;
+	ktf_cov_entry_put(entry);
+
+out:
+	mutex_lock(&module_mutex);
+	module_put(mod);
+	return 0;
+}
+
+static int ktf_cov_kmem_cache_alloc_handler(struct kretprobe_instance *,
+					    struct pt_regs *);
+
+static unsigned long register_kretprobe_size;
+
+/* Handler tracking allocations.  Determine if any functions we are
+ * tracking coverage for (coverage entries) are on the stack; if so
+ * we track the allocation.
+ */
+static int ktf_cov_kmem_alloc_entry(struct ktf_cov_mem *m, unsigned long bytes)
+{
+	struct ktf_cov_entry *entry = NULL;
+	int n;
+
+	/* We don't care about 0-length allocations. */
+	if (!bytes)
+		return 0;
+
+	/* Find first cov entry on stack to allow us to attribute traced
+	 * allocation to first coverage entry we come across.
+	 */
+	m->nr_entries = stack_trace_save(m->stack_entries, KTF_COV_MAX_STACK_DEPTH, 1);
+	for (n = 0; n < m->nr_entries; n++) {
+		/* avoid recursive enter when allocating cov mem */
+		if (m->stack_entries[n] ==
+		    (unsigned long)ktf_cov_kmem_cache_alloc_handler)
+			break;
+		/* ignore allocs as a result of registering probes */
+		if (m->stack_entries[n] >
+		    (unsigned long)register_kretprobe &&
+		    m->stack_entries[n] < ((unsigned long)register_kretprobe +
+		    register_kretprobe_size))
+			break;
+		entry = ktf_cov_entry_find(m->stack_entries[n], 0);
+		if (entry)
+			break;
+	}
+	if (!entry) {
+		m->nr_entries = 0;
+		return 0;
+	}
+	ktf_cov_entry_put(entry);
+
+	m->key.size = bytes;
+	/* Have to wait until alloc returns to get key.address */
+
+	return 0;
+}
+
+/* Handler tracking kmalloc allocations. */
+static int ktf_cov_kmalloc_entry_handler(struct kretprobe_instance *ri,
+					 struct pt_regs *regs)
+{
+	struct ktf_cov_mem *m = (struct ktf_cov_mem *)ri->data;
+	unsigned long bytes = (unsigned long)KTF_ENTRY_PROBE_ARG0;
+
+	return ktf_cov_kmem_alloc_entry(m, bytes);
+}
+
+static int ktf_cov_kmem_cache_alloc_entry_handler(struct kretprobe_instance *ri,
+						  struct pt_regs *regs)
+{
+	struct kmem_cache *cache =
+		(struct kmem_cache *)KTF_ENTRY_PROBE_ARG0;
+	struct ktf_cov_mem *m = (struct ktf_cov_mem *)ri->data;
+	unsigned long bytes;
+
+	if (!cache)
+		return 0;
+
+	bytes = cache->object_size;
+	if (cache == cov_mem_cache)
+		return 0;
+	return ktf_cov_kmem_alloc_entry(m, bytes);
+}
+
+static int ktf_cov_kmem_alloc_return(struct ktf_cov_mem *m,
+				     unsigned long ret)
+{
+	struct ktf_cov_mem *mm;
+
+	m->key.address = ret;
+	mm = kmem_cache_alloc(cov_mem_cache, GFP_NOWAIT);
+	if (!mm)
+		return 0;
+	memcpy(mm, m, sizeof(*mm));
+	if (ktf_map_elem_init(&mm->kmap, (char *)&mm->key) < 0 ||
+	    ktf_map_insert(&cov_mem_map, &mm->kmap) < 0) {
+		/* This can happen as inexplicably the same probe
+		 * can fire twice for _kmalloc; this results in
+		 * us attempting to add the same address twice, with
+		 * the result that we get -EEXIST from ktf_map_insert()
+		 * the second time.  Annoying but the end result is
+		 * we track the allocation once, which is what we want.
+		 */
+		terr("Failed to insert cov_mem %p", (void *)ret);
+		kmem_cache_free(cov_mem_cache, mm);
+	}
+	tlog(T_DEBUG, "cov_mem: tracking allocation %p", (void *)m->key.address);
+	m->nr_entries = 0;
+	return 0;
+}
+
+static int ktf_cov_kmalloc_handler(struct kretprobe_instance *ri,
+				   struct pt_regs *regs)
+{
+	struct ktf_cov_mem *m = (struct ktf_cov_mem *)ri->data;
+	unsigned long ret = regs_return_value(regs);
+
+	if (m->nr_entries)
+		return ktf_cov_kmem_alloc_return(m, ret);
+	return 0;
+}
+
+static int ktf_cov_kmem_cache_alloc_handler(struct kretprobe_instance *ri,
+					    struct pt_regs *regs)
+{
+	struct kmem_cache *cache =
+		(struct kmem_cache *)KTF_ENTRY_PROBE_ARG0;
+	struct ktf_cov_mem *m = (struct ktf_cov_mem *)ri->data;
+	unsigned long ret = regs_return_value(regs);
+
+	if (cache == cov_mem_cache)
+		return 0;
+
+	if (m->nr_entries)
+		return ktf_cov_kmem_alloc_return(m, ret);
+	return 0;
+}
+
+static int ktf_cov_kmem_free_entry(unsigned long tofree)
+{
+	struct ktf_cov_mem *m;
+
+	if (!tofree)
+		return 0;
+
+	m = ktf_cov_mem_find(tofree, 0);
+	if (m) {
+		tlog(T_DEBUG, "cov_mem: freeing allocation %p",
+		     (void *)m->key.address);
+		ktf_cov_mem_remove(m);
+		ktf_cov_mem_put(m);
+	}
+	return 0;
+}
+
+static int ktf_cov_kfree_entry_handler(struct kretprobe_instance *ri,
+				       struct pt_regs *regs)
+{
+	unsigned long tofree = (unsigned long)KTF_ENTRY_PROBE_ARG0;
+
+	if (!tofree)
+		return 0;
+
+	return ktf_cov_kmem_free_entry(tofree);
+}
+
+static int ktf_cov_kmem_cache_free_entry_handler(struct kretprobe_instance *ri,
+						 struct pt_regs *regs)
+{
+	struct kmem_cache *cache =
+		(struct kmem_cache *)KTF_ENTRY_PROBE_ARG0;
+	unsigned long tofree = (unsigned long)KTF_ENTRY_PROBE_ARG1;
+
+	if (!tofree || cache == cov_mem_cache)
+		return 0;
+
+	return ktf_cov_kmem_free_entry(tofree);
+}
+
+static struct kretprobe cov_mem_probes[] = {
+	{	.kp = { .symbol_name = "__kmalloc" },
+		.handler = ktf_cov_kmalloc_handler,
+		.entry_handler = ktf_cov_kmalloc_entry_handler,
+		.data_size = sizeof(struct ktf_cov_mem),
+		.maxactive = 0, /* assumes default value */
+	},
+	{	.kp = { .symbol_name = "kmem_cache_alloc" },
+		.handler = ktf_cov_kmem_cache_alloc_handler,
+		.entry_handler = ktf_cov_kmem_cache_alloc_entry_handler,
+		.data_size = sizeof(struct ktf_cov_mem),
+		.maxactive = 0, /* assumes default value */
+	},
+	{	.kp = { .symbol_name = "kfree" },
+		.handler = NULL,
+		.entry_handler = ktf_cov_kfree_entry_handler,
+		.data_size = 0,
+		.maxactive = 0, /* assumes default value */
+	},
+	{	.kp = { .symbol_name = "kmem_cache_free" },
+		.handler = NULL,
+		.entry_handler = ktf_cov_kmem_cache_free_entry_handler,
+		.data_size = 0,
+		.maxactive = 0, /* assumes default value */
+	}
+};
+
+static int cov_opt_mem_cnt;
+
+static int ktf_cov_init_opts(struct ktf_cov *cov)
+{
+	int i, ret = 0;
+
+	if (cov->opts & KTF_COV_OPT_MEM && ++cov_opt_mem_cnt == 1) {
+		if (!cov_mem_cache) {
+			cov_mem_cache =
+				kmem_cache_create("ktf_cov_mem_cache",
+						  sizeof(struct ktf_cov_mem), 0,
+						  SLAB_HWCACHE_ALIGN | SLAB_PANIC,
+						  NULL);
+
+			if (!cov_mem_cache)
+				return -ENOMEM;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(cov_mem_probes); i++) {
+			/* reset in case we're re-registering */
+			cov_mem_probes[i].kp.addr = NULL;
+			cov_mem_probes[i].kp.flags = 0;
+			ret = register_kretprobe(&cov_mem_probes[i]);
+			if (ret) {
+				tlog(T_DEBUG,
+				     "%d: failed to register retprobe for %s",
+				     ret, cov_mem_probes[i].kp.symbol_name);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static void ktf_cov_cleanup_opts(struct ktf_cov *cov)
+{
+	int i;
+
+	if (cov->opts & KTF_COV_OPT_MEM && --cov_opt_mem_cnt == 0) {
+		for (i = 0; i < ARRAY_SIZE(cov_mem_probes); i++) {
+			if (cov_mem_probes[i].nmissed > 0) {
+				tlog(T_INFO, "%s: retprobe missed %d.",
+				     cov_mem_probes[i].kp.symbol_name,
+				     cov_mem_probes[i].nmissed);
+			}
+			if (cov_mem_probes[i].kp.addr)
+				unregister_kretprobe(&cov_mem_probes[i]);
+		}
+	}
+}
+
+/* If the module we are monitoring coverage for was unloaded/reloaded
+ * while coverage was disabled, we can end up re-enabling kprobes at
+ * different addresses for the same function.  The problem is however
+ * we reference coverage entries by their address in the coverage
+ * entry map, so we need to clean it up to reflect the new locations
+ * of the probes.  So we remove/re-add the entries with the updated
+ * addresses.  It would obviously be easier to just remove the entries
+ * on coverage disable, but that limits our ability to examine coverage
+ * data - a common pattern is enable coverage, run test(s), disable
+ * coverage, check coverage data.
+ */
+static void ktf_cov_update_entries(const char *name, struct ktf_cov *cov)
+{
+	struct ktf_cov_entry *entry = ktf_map_first_entry(&cov_entry_map,
+							  struct ktf_cov_entry,
+							  kmap);
+
+	while (entry) {
+		if (entry->cov != cov ||
+		    (unsigned long)entry->kprobe.addr == entry->key.address) {
+			entry = ktf_map_next_entry(entry, kmap);
+			continue;
+		}
+
+		/* Address has changed; remove entry with old address as key
+		 * and re-add with new address/size as key (size may have
+		 * changed if module was re-compiled).
+		 */
+		ktf_map_remove_elem(&cov_entry_map, &entry->kmap);
+		entry->key.address = (unsigned long)entry->kprobe.addr;
+		entry->key.size = ktf_symbol_size(entry->key.address);
+		if (ktf_map_elem_init(&entry->kmap, (char *)&entry->key) < 0 ||
+		    ktf_map_insert(&cov_entry_map, &entry->kmap) < 0) {
+			tlog(T_DEBUG, "Failed to add %s/%s", name, entry->name);
+			unregister_kprobe(&entry->kprobe);
+			entry->refcnt--;
+			entry = ktf_map_next_entry(entry, kmap);
+		} else {
+			tlog(T_DEBUG, "Added %s/%s (%p, size %lu) to coverage",
+			     name, entry->name, (void *)entry->key.address,
+			     entry->key.size);
+			/* Map has changed, reset to root. */
+			entry = ktf_map_first_entry(&cov_entry_map,
+						    struct ktf_cov_entry, kmap);
+		}
+	}
+}
+
+int ktf_cov_enable(const char *name, unsigned int opts)
+{
+	struct ktf_cov *cov = ktf_cov_find(name);
+	struct ktf_cov_entry *entry;
+	int ret = 0;
+
+#ifndef KTF_PROBE_SUPPORT
+	return -ENOTSUPP;
+#endif
+	if (!cov) {
+		cov = kzalloc(sizeof(*cov), GFP_KERNEL);
+		if (!cov)
+			return -ENOMEM;
+
+		cov->type = KTF_COV_TYPE_MODULE;
+		cov->opts = opts;
+		if (ktf_map_elem_init(&cov->kmap, name) < 0 ||
+		    ktf_map_insert(&cov_map, &cov->kmap) < 0) {
+			tlog(T_DEBUG, "cov %s already present", cov->kmap.key);
+			kfree(cov);
+			return -EEXIST;
+		}
+		register_kretprobe_size =
+			ktf_symbol_size((unsigned long)register_kretprobe);
+		mutex_lock(&module_mutex);
+		kallsyms_on_each_symbol(ktf_cov_init_symbol, cov);
+		mutex_unlock(&module_mutex);
+	} else {
+		ktf_map_for_each_entry(entry, &cov_entry_map, kmap) {
+			if (entry->cov != cov)
+				continue;
+			if (++entry->refcnt == 1) {
+				/* reset kprobe as we're re-registering */
+				memset(&entry->kprobe, 0,
+				       sizeof(entry->kprobe));
+				entry->kprobe.pre_handler = ktf_cov_handler;
+				entry->kprobe.symbol_name = entry->name;
+				ret = register_kprobe(&entry->kprobe);
+				if (ret) {
+					tlog(T_DEBUG, "Failed to add %s/%s",
+					     name, entry->name);
+					entry->refcnt--;
+				}
+			}
+		}
+		/* Probe addresses/function sizes for functions may have
+		 * changed if module was unloaded/reloaded - entry map
+		 * needs to be updated to use new address/size as key.
+		 */
+		ktf_cov_update_entries(name, cov);
+	}
+
+	ret = ktf_cov_init_opts(cov);
+
+	ktf_cov_put(cov);
+
+	return ret;
+}
+
+void ktf_cov_disable(const char *module)
+{
+	struct ktf_cov *cov = ktf_cov_find(module);
+	struct ktf_cov_entry *entry;
+
+#ifndef	KTF_PROBE_SUPPORT
+	return;
+#endif
+
+	if (!cov)
+		return;
+
+	ktf_map_for_each_entry(entry, &cov_entry_map, kmap) {
+		if (entry->cov == cov) {
+			if (--entry->refcnt == 0) {
+				unregister_kprobe(&entry->kprobe);
+				tlog(T_DEBUG, "Removed coverage %s/%s",
+				     cov->kmap.key, entry->name);
+			}
+		}
+	}
+	ktf_cov_cleanup_opts(cov);
+	ktf_cov_put(cov);
+}
+
+static void ktf_cov_mem_seq_print(struct seq_file *seq)
+{
+	struct ktf_cov_mem *m;
+	char buf[256];
+	int n;
+
+	seq_puts(seq, "\nMemory in use allocated by covered functions:\n\n");
+	seq_printf(seq, "%44s %16s %10s\n", "ALLOCATION STACK", "ADDRESS",
+		   "SIZE");
+	ktf_for_each_cov_mem(m) {
+		for (n = 0; n < m->nr_entries; n++) {
+			sprint_symbol(buf, m->stack_entries[n]);
+			seq_printf(seq, "%44s", buf);
+			if (n == 0)
+				seq_printf(seq, " %16p %10lu",
+					   (void *)m->key.address,
+					   m->key.size);
+			seq_puts(seq, "\n");
+		}
+		seq_puts(seq, "\n");
+	}
+}
+
+void ktf_cov_seq_print(struct seq_file *seq)
+{
+	struct ktf_cov_entry *entry;
+	struct ktf_cov *cov;
+
+	seq_printf(seq, "%10s %44s %10s\n", "MODULE", "#FUNCTIONS",
+		   "#CALLED");
+	ktf_map_for_each_entry(cov, &cov_map, kmap)
+		seq_printf(seq, "%10s %44d %10d\n",
+			   cov->kmap.key, cov->total, cov->count);
+
+	seq_printf(seq, "\n%10s %44s %10s\n", "MODULE", "FUNCTION", "COUNT");
+	ktf_map_for_each_entry(entry, &cov_entry_map, kmap)
+		seq_printf(seq, "%10s %44s %10d\n",
+			   entry->cov ? entry->cov->kmap.key : "-",
+			   entry->name, entry->count);
+
+	ktf_cov_mem_seq_print(seq);
+}
+
+
+void ktf_cov_cleanup(void)
+{
+	struct ktf_cov *cov;
+	char name[KTF_MAX_KEY];
+
+	ktf_map_for_each_entry(cov, &cov_map, kmap) {
+		ktf_cov_disable(ktf_map_elem_name(&cov->kmap, name));
+	}
+	ktf_map_delete_all(&cov_map);
+	ktf_map_delete_all(&cov_entry_map);
+	ktf_map_delete_all(&cov_mem_map);
+	kmem_cache_destroy(cov_mem_cache);
+}
diff --git a/tools/testing/selftests/ktf/kernel/ktf_cov.h b/tools/testing/selftests/ktf/kernel/ktf_cov.h
new file mode 100644
index 0000000..56ae753
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_cov.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_cov.h: Code coverage support interface for KTF.
+ */
+
+#ifndef KTF_COV_H
+#define KTF_COV_H
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+#include "ktf.h"
+#include "ktf_map.h"
+
+enum ktf_cov_type {
+	KTF_COV_TYPE_MODULE,
+	KTF_COV_TYPE_MAX,
+};
+
+struct ktf_cov {
+	struct ktf_map_elem kmap;
+	enum ktf_cov_type type;		/* only modules supported for now. */
+	int count;			/* number of unique functions called */
+	int total;			/* total number of functions */
+	unsigned int opts;
+};
+
+/* Key for coverage entries (functions) consists in function address _and_
+ * size - this allows us to find offsets in function on stack.  Also used
+ * to track allocated memory - allocated address + size.
+ */
+struct ktf_cov_obj_key {
+	unsigned long address;
+	unsigned long size;
+};
+
+#define	KTF_COV_ENTRY_MAGIC		0xc07e8a5e
+struct ktf_cov_entry {
+	struct kprobe kprobe;
+	int magic;			/* magic number identifying entry */
+	struct ktf_map_elem kmap;
+	char name[KTF_MAX_KEY];
+	struct ktf_cov_obj_key key;
+	struct ktf_cov *cov;
+	struct ktf_map cov_mem;
+	int refcnt;
+	int count;
+};
+
+#define KTF_COV_MAX_STACK_DEPTH		32
+
+struct ktf_cov_mem {
+	struct ktf_map_elem kmap;
+	struct ktf_cov_obj_key key;
+	unsigned long flags;
+	unsigned int nr_entries;
+	unsigned long stack_entries[KTF_COV_MAX_STACK_DEPTH];
+};
+
+#define	KTF_COV_MEM_IGNORE	0x1	/* avoid recursive enter */
+
+struct ktf_cov_mem_probe {
+	const char *name;
+	struct kretprobe kretprobe;
+};
+
+extern struct ktf_map cov_mem_map;
+
+#define	ktf_for_each_cov_mem(pos)	\
+	ktf_map_for_each_entry(pos, &cov_mem_map, kmap)
+
+struct ktf_cov_entry *ktf_cov_entry_find(unsigned long, unsigned long);
+void ktf_cov_entry_put(struct ktf_cov_entry *);
+void ktf_cov_entry_get(struct ktf_cov_entry *);
+
+struct ktf_cov *ktf_cov_find(const char *);
+void ktf_cov_put(struct ktf_cov *);
+void ktf_cov_get(struct ktf_cov *);
+
+struct ktf_cov_mem *ktf_cov_mem_find(unsigned long, unsigned long);
+void ktf_cov_mem_put(struct ktf_cov_mem *);
+void ktf_cov_mem_get(struct ktf_cov_mem *);
+
+void ktf_cov_seq_print(struct seq_file *);
+void ktf_cov_cleanup(void);
+
+int ktf_cov_enable(const char *, unsigned int);
+void ktf_cov_disable(const char *);
+
+#endif
-- 
git-series 0.9.1
