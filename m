Return-Path: <linux-kselftest+bounces-33552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DDAC18A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9405D16B3CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3472E62CB;
	Thu, 22 May 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkymV+Fy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0F2E339D
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957978; cv=none; b=kc+TEeIa2Nbb8dp9qLJmR7v8eJymFShkiLUroKAMIjjiLLj8qFjY0NGDQLXYcyPiYQc8/36xd+IMoGgZwNl1McSo0iosbyWVyexMrLglt/n9flYZq7WC92YlEyj+CyaFdgPHZUAoefoQuqmgDxSMSUJ2j6zEXbyQwM/7vlg0ydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957978; c=relaxed/simple;
	bh=D5aAIRODPQ9yo1mu4fSx9H1qWYbevAdHUxF+P7XNjwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYfraOQc9hob+HOmvIsxP3N6UPvj99HX30v+oCLu1mMKToTEV+RhIUTaAA6JlYpQ3SDrpx85QICxiLB5UzWFBcI3BXdPGzKZOapXWhVuZ6BCxAVPeTyX6oYk3snzca8JIgi/SXA/0qXaybabtcEgKbnFvlMk2lqV9YhTxOiFUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkymV+Fy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e896e116fso5559721a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957976; x=1748562776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iNuUWcLjakGfkNNM+8DkBjBlwJhpM767OVzB+eUiNIQ=;
        b=TkymV+Fy4kBbHciiKl2zobYUUwCyg23vkLg1m7wGHJNb1p5DTQynbi109/vLiHpqe2
         9SxPjPu9aQw4oyv31ZeEVZ5yqoYWDzrw6O5RF4ZgRuuRDpS+uH3ATwQler7CFU9+85FD
         3kTThm5O/qChG+Zy5XOZW4m56gdX8/+a/boStAfKSTmCOhOaXay5F7YIQ7VGjBLfrNLo
         /Je+uVrmTTIWM9i5nJXW6b07TTP3027qsuuyoBpLtOFkcyuslkv34NTnCCdvwnlKr/5A
         xMCSZDjcTM9jYgWj+ftwdQXU78CDsAKS0cT+veT/nPyMp6ZWh+b0AhsxP/qxOEZKaoVn
         FJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957976; x=1748562776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNuUWcLjakGfkNNM+8DkBjBlwJhpM767OVzB+eUiNIQ=;
        b=kelL42AZfuTkg2WFyOlgkTJOVVi+gCgNrjsyondJo2ONKpWRFu7dxC6PCFEO0qTv0v
         96dSsLGy6RMMNk9mINNGbXty3GenVwALTuoB15B9+aRoKeGqi3NkkfLNP20fcTf5tsOA
         IFATFM6+URCz6LRVJdK22GHc89DvoY0METtJ6JxaSarLE9/JB1nUNb/EnduuTQkFRQUl
         gJj8jb/z06SxS/AWrejHj4oEHtypeaE91K/iw6RCaQ1yZ+YxkZ/NR54aArbLQ/JVNVNk
         e/X+9a2MXSxjo0PqGVja2mi9shDidgEFIbEBldEPDk+hsHat1mBlS+1curVa+db2Lt8l
         8BBg==
X-Forwarded-Encrypted: i=1; AJvYcCVprZNkAW2+wknXGGqns0e7tBHBgdujlnXEXLTDYR3cTUi1DxjCwq7dUu0qWZU5rqhrmdpaH0dVPxottbgiGys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUQOldFvlZsw3gCH+utQVc2bREHr3hS0Hs/WsnHLaIWFwsthi
	zqgQmh8I5HtHSZseO7c1fS+SCy5Abfj7dPSyudroJsNqAF0v0FHOVFJ7mO2wjt99WOfazHsFOrH
	5X7aRTQ==
X-Google-Smtp-Source: AGHT+IEoOvxAnrgVMqS3TC3RLkVh5nLtBQqPosDJG4xPj/XHWemBkiBPXcS2x1YfUhLo+1j7jd9m06w7XHM=
X-Received: from pjbpm5.prod.google.com ([2002:a17:90b:3c45:b0:30a:9720:ea33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc7:b0:30c:5479:c92e
 with SMTP id 98e67ed59e1d1-30e830c7988mr39961520a91.4.1747957975748; Thu, 22
 May 2025 16:52:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:23 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-14-seanjc@google.com>
Subject: [PATCH v3 13/13] KVM: selftests: Add a KVM_IRQFD test to verify
 uniqueness requirements
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify that eventfd+irqfd bindings are globally unique,
i.e. that KVM doesn't allow multiple irqfds to bind to a single eventfd,
even across VMs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/irqfd_test.c | 130 +++++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/irqfd_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..318adf3ef6b6 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -54,6 +54,7 @@ TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 TEST_GEN_PROGS_COMMON = demand_paging_test
 TEST_GEN_PROGS_COMMON += dirty_log_test
 TEST_GEN_PROGS_COMMON += guest_print_test
+TEST_GEN_PROGS_COMMON += irqfd_test
 TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
 TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
 TEST_GEN_PROGS_COMMON += kvm_page_table_test
diff --git a/tools/testing/selftests/kvm/irqfd_test.c b/tools/testing/selftests/kvm/irqfd_test.c
new file mode 100644
index 000000000000..286f2b15fde6
--- /dev/null
+++ b/tools/testing/selftests/kvm/irqfd_test.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <stdint.h>
+#include <sys/sysinfo.h>
+
+#include "kvm_util.h"
+
+static struct kvm_vm *vm1;
+static struct kvm_vm *vm2;
+static int __eventfd;
+static bool done;
+
+/*
+ * KVM de-assigns based on eventfd *and* GSI, but requires unique eventfds when
+ * assigning (the API isn't symmetrical).  Abuse the oddity and use a per-task
+ * GSI base to avoid false failures due to cross-task de-assign, i.e. so that
+ * the secondary doesn't de-assign the primary's eventfd and cause assign to
+ * unexpectedly succeed on the primary.
+ */
+#define GSI_BASE_PRIMARY	0x20
+#define GSI_BASE_SECONDARY	0x30
+
+static void juggle_eventfd_secondary(struct kvm_vm *vm, int eventfd)
+{
+	int r, i;
+
+	/*
+	 * The secondary task can encounter EBADF since the primary can close
+	 * the eventfd at any time.  And because the primary can recreate the
+	 * eventfd, at the safe fd in the file table, the secondary can also
+	 * encounter "unexpected" success, e.g. if the close+recreate happens
+	 * between the first and second assignments.  The secondary's role is
+	 * mostly to antagonize KVM, not to detect bugs.
+	 */
+	for (i = 0; i < 2; i++) {
+		r = __kvm_irqfd(vm, GSI_BASE_SECONDARY, eventfd, 0);
+		TEST_ASSERT(!r || errno == EBUSY || errno == EBADF,
+			    "Wanted success, EBUSY, or EBADF, r = %d, errno = %d",
+			    r, errno);
+
+		/* De-assign should succeed unless the eventfd was closed. */
+		r = __kvm_irqfd(vm, GSI_BASE_SECONDARY + i, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
+		TEST_ASSERT(!r || errno == EBADF,
+			    "De-assign should succeed unless the fd was closed");
+	}
+}
+
+static void *secondary_irqfd_juggler(void *ign)
+{
+	while (!READ_ONCE(done)) {
+		juggle_eventfd_secondary(vm1, READ_ONCE(__eventfd));
+		juggle_eventfd_secondary(vm2, READ_ONCE(__eventfd));
+	}
+
+	return NULL;
+}
+
+static void juggle_eventfd_primary(struct kvm_vm *vm, int eventfd)
+{
+	int r1, r2;
+
+	/*
+	 * At least one of the assigns should fail.  KVM disallows assigning a
+	 * single eventfd to multiple GSIs (or VMs), so it's possible that both
+	 * assignments can fail, too.
+	 */
+	r1 = __kvm_irqfd(vm, GSI_BASE_PRIMARY, eventfd, 0);
+	TEST_ASSERT(!r1 || errno == EBUSY,
+		    "Wanted success or EBUSY, r = %d, errno = %d", r1, errno);
+
+	r2 = __kvm_irqfd(vm, GSI_BASE_PRIMARY + 1, eventfd, 0);
+	TEST_ASSERT(r1 || (r2 && errno == EBUSY),
+		    "Wanted failure (EBUSY), r1 = %d, r2 = %d, errno = %d",
+		    r1, r2, errno);
+
+	/*
+	 * De-assign should always succeed, even if the corresponding assign
+	 * failed.
+	 */
+	kvm_irqfd(vm, GSI_BASE_PRIMARY, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
+	kvm_irqfd(vm, GSI_BASE_PRIMARY + 1, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t racing_thread;
+	int r, i;
+
+	/* Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. */
+	vm1 = vm_create(1);
+	vm2 = vm_create(1);
+
+	WRITE_ONCE(__eventfd, kvm_new_eventfd());
+
+	kvm_irqfd(vm1, 10, __eventfd, 0);
+
+	r = __kvm_irqfd(vm1, 11, __eventfd, 0);
+	TEST_ASSERT(r && errno == EBUSY,
+		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
+
+	r = __kvm_irqfd(vm2, 12, __eventfd, 0);
+	TEST_ASSERT(r && errno == EBUSY,
+		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
+
+	kvm_irqfd(vm1, 11, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
+	kvm_irqfd(vm1, 12, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
+	kvm_irqfd(vm1, 13, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
+	kvm_irqfd(vm1, 14, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
+	kvm_irqfd(vm1, 10, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
+
+	close(__eventfd);
+
+	pthread_create(&racing_thread, NULL, secondary_irqfd_juggler, vm2);
+
+	for (i = 0; i < 10000; i++) {
+		WRITE_ONCE(__eventfd, kvm_new_eventfd());
+
+		juggle_eventfd_primary(vm1, __eventfd);
+		juggle_eventfd_primary(vm2, __eventfd);
+		close(__eventfd);
+	}
+
+	WRITE_ONCE(done, true);
+	pthread_join(racing_thread, NULL);
+}
-- 
2.49.0.1151.ga128411c76-goog


