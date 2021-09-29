Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D6341C6E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbhI2OjT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344547AbhI2OjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLxcCiYIbNHJEkXFC5QxlI7iwOjqXPnMUZfpGd39ZZE=;
        b=hY7oA8WeYiNbi9QIalzu62Q820WspxYWC71C/pr26QyxZb6Z/ELuQqYHnAjtTYxuHWKdz8
        wlXHd8pjVcPP92Kn2jcMTpEVBqNiVq/5/S2QaXlx4VCktQsHm5Zjkpw8QNGDQZIYeEHF97
        oI4qdDsB4DgoRvUkSY7IW53Ufw0Ho1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563--XXMhINBPL6qoUIRaZ8cFQ-1; Wed, 29 Sep 2021 10:37:31 -0400
X-MC-Unique: -XXMhINBPL6qoUIRaZ8cFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160F31926DA0;
        Wed, 29 Sep 2021 14:37:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E10931017CF5;
        Wed, 29 Sep 2021 14:37:21 +0000 (UTC)
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
Subject: [PATCH v1 5/6] mm/memory_hotplug: remove stale function declarations
Date:   Wed, 29 Sep 2021 16:35:59 +0200
Message-Id: <20210929143600.49379-6-david@redhat.com>
In-Reply-To: <20210929143600.49379-1-david@redhat.com>
References: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These functions no longer exist.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e5a867c950b2..be48e003a518 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -98,9 +98,6 @@ static inline void zone_seqlock_init(struct zone *zone)
 {
 	seqlock_init(&zone->span_seqlock);
 }
-extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
-extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
-extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 extern void adjust_present_page_count(struct page *page,
 				      struct memory_group *group,
 				      long nr_pages);
-- 
2.31.1

