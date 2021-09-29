Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7284B41C6DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbhI2OjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344557AbhI2OjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hw0JON3PSPNzJHfAUlyfJy6KTExGOX1e2ePjdnrAKBE=;
        b=IH/8ML6nhlNIskKiDz4Frg131lLtX+EAxXueSkFhsQbafRR7dPbnHbhkJ0NdUnUTzdJFzf
        P9hF+DpX9MBLImx+dpOkuBtcerd1qp6JKqgL/9qIeg3A7yZLC/0SxNrKwaKN+SUucdVKjI
        624tunqB+oUBTcUvRJImVSd//CdTmVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-Xso30JzGNKapCJmAP5WIeA-1; Wed, 29 Sep 2021 10:37:18 -0400
X-MC-Unique: Xso30JzGNKapCJmAP5WIeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D29802C94;
        Wed, 29 Sep 2021 14:37:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6CE510016F4;
        Wed, 29 Sep 2021 14:37:08 +0000 (UTC)
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
Subject: [PATCH v1 3/6] mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit
Date:   Wed, 29 Sep 2021 16:35:57 +0200
Message-Id: <20210929143600.49379-4-david@redhat.com>
In-Reply-To: <20210929143600.49379-1-david@redhat.com>
References: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

32 bit support is broken in various ways: for example, we can online
memory that should actually go to ZONE_HIGHMEM to ZONE_MOVABLE or in
some cases even to one of the other kernel zones.

We marked it BROKEN in commit b59d02ed0869 ("mm/memory_hotplug: disable the
functionality for 32b") almost one year ago. According to that commit
it might be broken at least since 2017. Further, there is hardly a sane use
case nowadays.

Let's just depend completely on 64bit, dropping the "BROKEN" dependency to
make clear that we are not going to support it again. Next, we'll remove
some HIGHMEM leftovers from memory hotplug code to clean up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ea8762cd8e1e..88273dd5c6d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -125,7 +125,7 @@ config MEMORY_HOTPLUG
 	select MEMORY_ISOLATION
 	depends on SPARSEMEM
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
-	depends on 64BIT || BROKEN
+	depends on 64BIT
 	select NUMA_KEEP_MEMINFO if NUMA
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
-- 
2.31.1

