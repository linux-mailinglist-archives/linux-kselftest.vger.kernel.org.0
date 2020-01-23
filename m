Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891AD147054
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgAWSFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:05:03 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34790 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgAWSFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:05:02 -0500
Received: by mail-qk1-f201.google.com with SMTP id u10so2227562qkk.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UdYBz3AD49871PUkNPj4Uebf8Il0FeRd7J00v5oi04U=;
        b=n+Pcpr5wOrgmU2c65Sgk80FsAlBLVRmkLo0XbwUrvO9lDOhlDLvWFp2fHgsz+gjvvb
         9lx4qvrnQ8p0/CkVzkNSU4oXoXO4CMa9BtSrE3crfGshR1UTDh0RwJK+DOwDma3gFbB8
         F2dNcvr12Zzft48S7piu2oUTIsarWn5vyptyDl6Z6M0aEf95Ms8tdNZBCUyhPXA4tfav
         D2CILGxOu/uL0cyVXZztwjdsLpDRa641IIbvddCDN9ZqBeb5/T0uxvaWjoTO+YiCRWmn
         e+kv/mrOHQAq2kqUGToqJpMknvIq8Zd00f9/JSuXKO3dmmwH4r909as/b2CLtB0pcfrn
         Sxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UdYBz3AD49871PUkNPj4Uebf8Il0FeRd7J00v5oi04U=;
        b=Z40P4/+XzYNRqLDs8Yiqddo2mCBCR1o2erVmesBvT4vqRMxImlDvVB5EJYNShCp8Dh
         UfeDhVR9ZraSpV/m91pbvfOQGV2PG2CALYKjMS+iskzX03a2BVYVa7GuwU/2XRRQJmGJ
         QcKkXSvrBSnIwADIN5IFq33zLPkgbli+nxfVATi22tzctM6ZCarZB0wfZDIO/bUTSs70
         NmwUnSBusqUVDNvoVOvbMk7gTeLzFNCBwFkr/mNdGo9iEWL0q/nw8oJ9R+PNPAWJVO1h
         y7Zl1oSTyoI2c7QJ0kMHOFGrB7+rkOFxQhJQiXwB477ASeNyLHOz1uA9q9en/D9y/gnw
         OG+A==
X-Gm-Message-State: APjAAAVIYYtJC4hmSPYhFKTtqYCZ0SWB+nBv0IDoKSEI2R/RXb6/3kYM
        0ID8p6xOyrS0sHSaoPY+3jNO1tqK2vFT
X-Google-Smtp-Source: APXvYqw/mRdsaZ41fljNpl0GCv0XtJYfDahhtiR1QNY/cSbWhanCWfktv1CfZhgA95ua8wi2fyuKZN0sD5DP
X-Received: by 2002:a37:a881:: with SMTP id r123mr5611982qke.275.1579802700645;
 Thu, 23 Jan 2020 10:05:00 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:35 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-10-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 09/10] KVM: selftests: Stop memslot creation in KVM
 internal memslot region
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM creates internal memslots covering the region between 3G and 4G in
the guest physical address space, when the first vCPU is created.
Mapping this region before creation of the first vCPU causes vCPU
creation to fail. Prohibit tests from creating such a memslot and fail
with a helpful warning when they try to.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 41cf45416060f..5b971c04f1643 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -113,6 +113,8 @@ const char * const vm_guest_mode_string[] = {
 _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
 	       "Missing new mode strings?");
 
+#define KVM_INTERNAL_MEMSLOTS_START_PADDR (3UL << 30)
+#define KVM_INTERNAL_MEMSLOTS_END_PADDR (4UL << 30)
 /*
  * VM Create
  *
@@ -593,6 +595,20 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
 		guest_paddr, npages, vm->max_gfn, vm->page_size);
 
+	/*
+	 * Check that this region does not overlap with KVM internal memslots
+	 * which are created when the first vCPU is created.
+	 */
+	TEST_ASSERT(guest_paddr >= KVM_INTERNAL_MEMSLOTS_END_PADDR ||
+		    guest_paddr + npages < KVM_INTERNAL_MEMSLOTS_START_PADDR,
+		    "Memslot overlapps with region mapped by internal KVM\n"
+		    "memslots:\n"
+		    "  Requested paddr range:      [0x%lx, 0x%lx)\n"
+		    "  KVM internal memslot range: [0x%lx, 0x%lx)\n",
+		    guest_paddr, guest_paddr + npages,
+		    KVM_INTERNAL_MEMSLOTS_START_PADDR,
+		    KVM_INTERNAL_MEMSLOTS_END_PADDR);
+
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
-- 
2.25.0.341.g760bfbb309-goog

