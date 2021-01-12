Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA12F3D96
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbhALVoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbhALVn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 16:43:58 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B787C0617AA
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:42:58 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m1so79871qvp.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=U+CbYhEX3bk6CbEgkAzVDMsXIsxbjmYTO8NB12RiUfg=;
        b=ZYv6sEPqBHAArWWsUp2QL2JuEOAXcxNJ/TbleUpNix3Zom4HvsFXD6eBgs0/JiuL8S
         RcC1e//0CvYuIWl8eVu13IUXE/CsevnVnke/u6pKoUh8iiHXOER4VvVQafnlPnmlAft8
         IPP4Z4TjBYoZLIA6As9ZWQ3/6zwgdW1r/QykaNd0NxkuFhTYSFysEDk58A8TKx8oCI+4
         niiR71NrYJaivrHtLYhDIPWFeH4AHZhSo8YIrSKNB19Oq8kd94F/lH+OGNbCfTSoPYIe
         fJ8FVeeiInuJ3Tlo0Ydy1IEQ4MNRWlX3hErJuv9pGKd75FQd+Htl2xNJa6mB45RXHbDK
         5RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=U+CbYhEX3bk6CbEgkAzVDMsXIsxbjmYTO8NB12RiUfg=;
        b=RW/IecmB8ywlsrgakqgk+bxqmkbVo0ZQpvA49pjGNHb1E0GEmpHsrVIjrf7B0AMb7F
         4owqfrSQ77n2WaydVdPVIM+61ebrABYcYZ62UTqUCO6G44XK1DxMh018NVT5po2q6qg2
         PcpAk9xbKaSu7/JjbsXu5GX278bGugxAuziH++uWhcVcW4iOH7ermJ8lq914QCddqjBj
         ruUwnWn7drG2MC3kzHvcZbrf6QCSH/CAhokob5FPD7K1d0TyJ4ryWHtfRuAv/Bv2E4PC
         ZRwb23z5nWoIIqluiN8yl0zNR5gc6l12nUs39vo7d1cDXqFusumFcUHZvTwI2yzZKJyd
         Ae6w==
X-Gm-Message-State: AOAM530s37Lk6342judpRtDnR5Vdsmz1CuThxwgZzPJLJa6W1DbQJaEB
        i4MYFfSjV94UmwTdhiwninaVTxJOJX49
X-Google-Smtp-Source: ABdhPJwcwZH2KZ2pN7t1zlwuuRyYOL6A378R4xORgoSVJhlmFt3unwT0CSROZTnrTQpMBKu6C2QJNlR2YppO
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a0c:da87:: with SMTP id
 z7mr1679434qvj.41.1610487777488; Tue, 12 Jan 2021 13:42:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:42:47 -0800
Message-Id: <20210112214253.463999-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/6] KVM: selftests: Perf test cleanups and memslot
 modification test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series contains a few cleanups that didn't make it into previous
series, including some cosmetic changes and small bug fixes. The series
also lays the groundwork for a memslot modification test which stresses
the memslot update and page fault code paths in an attempt to expose races.

Tested: dirty_log_perf_test, memslot_modification_stress_test, and
	demand_paging_test were run, with all the patches in this series
	applied, on an Intel Skylake machine.

	echo Y > /sys/module/kvm/parameters/tdp_mmu; \
	./memslot_modification_stress_test -i 1000 -v 64 -b 1G; \
	./memslot_modification_stress_test -i 1000 -v 64 -b 64M -o; \
	./dirty_log_perf_test -v 64 -b 1G; \
	./dirty_log_perf_test -v 64 -b 64M -o; \
	./demand_paging_test -v 64 -b 1G; \
	./demand_paging_test -v 64 -b 64M -o; \
	echo N > /sys/module/kvm/parameters/tdp_mmu; \
	./memslot_modification_stress_test -i 1000 -v 64 -b 1G; \
	./memslot_modification_stress_test -i 1000 -v 64 -b 64M -o; \
	./dirty_log_perf_test -v 64 -b 1G; \
	./dirty_log_perf_test -v 64 -b 64M -o; \
	./demand_paging_test -v 64 -b 1G; \
	./demand_paging_test -v 64 -b 64M -o

	The tests behaved as expected, and fixed the problem of the
	population stage being skipped in dirty_log_perf_test. This can be
	seen in the output, with the population stage taking about the time
	dirty pass 1 took and dirty pass 1 falling closer to the times for
	the other passes.

Note that when running these tests, the -o option causes the test to take
much longer as the work each vCPU must do increases proportional to the
number of vCPUs.

You can view this series in Gerrit at:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/7216

Ben Gardon (6):
  KVM: selftests: Rename timespec_diff_now to timespec_elapsed
  KVM: selftests: Avoid flooding debug log while populating memory
  KVM: selftests: Convert iterations to int in dirty_log_perf_test
  KVM: selftests: Fix population stage in dirty_log_perf_test
  KVM: selftests: Add option to overlap vCPU memory access
  KVM: selftests: Add memslot modification stress test

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/demand_paging_test.c        |  40 +++-
 .../selftests/kvm/dirty_log_perf_test.c       |  72 +++---
 .../selftests/kvm/include/perf_test_util.h    |   4 +-
 .../testing/selftests/kvm/include/test_util.h |   2 +-
 .../selftests/kvm/lib/perf_test_util.c        |  25 ++-
 tools/testing/selftests/kvm/lib/test_util.c   |   2 +-
 .../kvm/memslot_modification_stress_test.c    | 211 ++++++++++++++++++
 9 files changed, 307 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memslot_modification_stress_test.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

