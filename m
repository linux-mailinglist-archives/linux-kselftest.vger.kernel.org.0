Return-Path: <linux-kselftest+bounces-21103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A49B64B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3381C21895
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89BF1F470F;
	Wed, 30 Oct 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="H0LPKZEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E01F429B;
	Wed, 30 Oct 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296229; cv=none; b=JFO9sNJPzrc4q9NlUldfO3bJ3V2Iy8ExURtX+JlZ8TpYGLBF/SP10J5a7bjl07jKgj2LInNEMWyKkOanDeat5RvEt8tfviy5pCB9D3ekCrwY/0y6QPztAAEm4N4LPNhZq+YrYvRIWZJ517QNaHfflRMel2a4kewxqmB/3VEqHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296229; c=relaxed/simple;
	bh=FAJGeRXl9a0HaaXXjrMbG8MsdF8trJRmwI5h5Mf4g50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVjEzGNngPLEU6hHw/zCwCiZCz+7QDdzpYXB5m8U/CB1ICQARKEfStJloMRepXn6bPcYUFXRW8tSP1NJoiyEBzWT8LitTGr5cnOsWIKiY9yJp64u/wagrii+ok4zHQIt/FGQ0tvYNe8SLYj4sKEpQYPezL+brdvnEW2j7WiK4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=H0LPKZEl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730296227; x=1761832227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/QSX0mI8qQz8W316WTJxbTS4bB3Lyue/iJHbqNfB18=;
  b=H0LPKZElGSyh8F95k4F7Snm1mijNWKwD48JnAiP9h5u08WMGqEmkfJZp
   spbAfawmiWksmQBvcRzQ5x+LcioguecGAlLrmWGj4Aiuly5wMpmvwHNuX
   ebzRFCjzewRIROFQExbIF+i6yC/qQ4vNmyKUz4+D64yKi0OI/tEikyvyW
   U=;
X-IronPort-AV: E=Sophos;i="6.11,245,1725321600"; 
   d="scan'208";a="142980689"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:50:27 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:32764]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.52:2525] with esmtp (Farcaster)
 id cb6221e8-e82a-4b95-aff9-f29080c6cf67; Wed, 30 Oct 2024 13:50:26 +0000 (UTC)
X-Farcaster-Flow-ID: cb6221e8-e82a-4b95-aff9-f29080c6cf67
Received: from EX19D014EUA004.ant.amazon.com (10.252.50.41) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:50:23 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D014EUA004.ant.amazon.com (10.252.50.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:50:23 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 30 Oct 2024 13:50:22 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id 93E2B41303;
	Wed, 30 Oct 2024 13:50:13 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <tabba@google.com>, <quic_eberman@quicinc.com>, <david@redhat.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <jthoughton@google.com>,
	<ackerleytng@google.com>, <vannapurve@google.com>, <rppt@kernel.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <graf@amazon.com>,
	<jgowans@amazon.com>, <derekmn@amazon.com>, <kalyazin@amazon.com>,
	<xmarcalx@amazon.com>, <linux-mm@kvack.org>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v3 4/6] kvm: gmem: add trace point for direct map state changes
Date: Wed, 30 Oct 2024 13:49:08 +0000
Message-ID: <20241030134912.515725-5-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030134912.515725-1-roypat@amazon.co.uk>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Add tracepoints to kvm_gmem_set_direct_map and
kvm_gmem_folio_set_direct_map.

The above operations can cause folios to be insert/removed into/from the
direct map. We want to be able to make sure that only those gmem folios
that we expect KVM to access are ever reinserted into the direct map,
and that all folios that are temporarily reinserted are also removed
again at a later point. Processing ftrace output is one way to verify
this.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/trace/events/kvm.h | 22 ++++++++++++++++++++++
 virt/kvm/guest_memfd.c     |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 74e40d5d4af42..f3d852c18fa08 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -489,6 +489,28 @@ TRACE_EVENT(kvm_test_age_hva,
 	TP_printk("mmu notifier test age hva: %#016lx", __entry->hva)
 );
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+TRACE_EVENT(kvm_gmem_direct_map_state_change,
+	TP_PROTO(pgoff_t start, pgoff_t end, bool state),
+	TP_ARGS(start, end, state),
+
+	TP_STRUCT__entry(
+		__field(pgoff_t, start)
+		__field(pgoff_t, end)
+		__field(bool, state)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->state = state;
+	),
+
+	TP_printk("changed direct map state of guest_memfd range %lu to %lu to %s",
+		  __entry->start, __entry->end, __entry->state ? "present" : "not present")
+);
+#endif
+
 #endif /* _TRACE_KVM_MAIN_H */
 
 /* This part must be outside protection */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 54387828dcc6a..a0b3b9cacd361 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,6 +7,7 @@
 #include <linux/set_memory.h>
 
 #include "kvm_mm.h"
+#include "trace/events/kvm.h"
 
 struct kvm_gmem {
 	struct kvm *kvm;
@@ -169,6 +170,8 @@ static __always_unused int kvm_gmem_folio_set_direct_map(struct folio *folio, pg
 	r = __kvm_gmem_folio_set_direct_map(folio, start, end, state);
 	folio_unlock(folio);
 
+	trace_kvm_gmem_direct_map_state_change(start, end, state);
+
 unlock_xa:
 	xa_unlock(&gmem_priv->direct_map_state);
 out:
@@ -216,6 +219,8 @@ static __always_unused int kvm_gmem_set_direct_map(struct inode *inode, pgoff_t
 		folio_batch_release(&fbatch);
 	}
 
+	trace_kvm_gmem_direct_map_state_change(start, end, state);
+
 	xa_unlock(&gmem_priv->direct_map_state);
 out:
 	return r;
-- 
2.47.0


