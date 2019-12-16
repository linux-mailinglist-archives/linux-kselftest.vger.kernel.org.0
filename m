Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1377F121BCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLPVfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:35:48 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40384 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfLPVfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:35:48 -0500
Received: by mail-pg1-f201.google.com with SMTP id z12so5962816pgf.7
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=flMQx0RQ+tn1L0OZWy96vlecDFYT8pwNVqw/lok2bBY=;
        b=cLMpQGkx99eeWLH4P/unEkS15oJ0X5gTpKr0Ot5VrGyjOzB4dA0ifIETD5xPnL915T
         rubBQ1Z1iW4qP8ZPAFTNHDSpa1zHhugbJ2QxmSBGJ8YFQSbzxHjfKNHTdoja8vQT2IGs
         ZJ9gn+5y5Ern0CrQyWiOXApsJgUmCFVLDPffnLDVVzBJuidyMrKqQVRQnBM8tnVfAagh
         afrkhSTDsBVhP4jgntZuieMwkliL0ZvcoC6Mlo8Oj52LTnAulg5T+H8eQl5xK6xNjN2+
         jtpvhLNqUrXAu9q2trjCcLueT55qoIgDlBNl9WNltONfRe97/+D2FG+d2akzZiwxjJPq
         fs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=flMQx0RQ+tn1L0OZWy96vlecDFYT8pwNVqw/lok2bBY=;
        b=AOsLSKOeM6k9qBiEZqf4VXs3u/tbb/nYt+7Aito/t67OyHlv2isEhOToJ3Kw7KH7zJ
         b3bTjQO8tiCNnmr7D6abV0Ubi4KJmFcVPXukm+27ZlCqQBXGQn55gHhnIyhdtIcPMPE2
         NNU90m/+XtsWmvICKmEC3GFBX0mqR73IuzyXDxfa/2hm/l9umlltABiVmIUapq0qSSa8
         0tdaNylzoCsUvd0au1RGMeS8DrKc27gysPQuiOeXsiLPhDYzG9T4zuZmXU5DKL6fmnzs
         FJXv2zMWidHz9QKetIGrYXiqgbjtmlIKu654iDYpyHuJ0wye2kzaaTg9K963znCPpjQv
         8A3A==
X-Gm-Message-State: APjAAAWBif9qrFORDSc4LNKQpi97Z6qKEfVEZX0oh34Dijo/2P//vkUZ
        SJk2654BiRDOYwJh4ilKByTIhvs8A42b
X-Google-Smtp-Source: APXvYqy1p58uD7ILOXRlPnATDG1C2VyIQV8EfLRJI2x+ZgT/v8x5ksiTotwGpJiUF6/nvEUtv7a0zUt3NmVO
X-Received: by 2002:a63:b642:: with SMTP id v2mr4217832pgt.126.1576532145784;
 Mon, 16 Dec 2019 13:35:45 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:23 -0800
Message-Id: <20191216213532.91237-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH 0/9] Create a userfaultfd demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When handling page faults for many vCPUs during demand paging, KVM's MMU
lock becomes highly contended. This series creates a test with a naive
userfaultfd based demand paging implementation to demonstrate that
contention. This test serves both as a functional test of userfaultfd
and a microbenchmark of demand paging performance with a variable number
of vCPUs and memory per vCPU.

The test creates N userfaultfd threads, N vCPUs, and a region of memory
with M pages per vCPU. The N userfaultfd polling threads are each set up
to serve faults on a region of memory corresponding to one of the vCPUs.
Each of the vCPUs is then started, and touches each page of its disjoint
memory region, sequentially. In response to faults, the userfaultfd
threads copy a static buffer into the guest's memory. This creates a
worst case for MMU lock contention as we have removed most of the
contention between the userfaultfd threads and there is no time required
to fetch the contents of guest memory.

This test was run successfully on Intel Haswell, Broadwell, and
Cascadelake hosts with a variety of vCPU counts and memory sizes.

This test was adapted from the dirty_log_test.

The series can also be viewed in Gerrit here:
https://linux-review.googlesource.com/c/virt/kvm/kvm/+/1464
(Thanks to Dmitry Vyukov <dvyukov@google.com> for setting up the Gerrit
instance)

Ben Gardon (9):
  KVM: selftests: Create a demand paging test
  KVM: selftests: Add demand paging content to the demand paging test
  KVM: selftests: Add memory size parameter to the demand paging test
  KVM: selftests: Pass args to vCPU instead of using globals
  KVM: selftests: Support multiple vCPUs in demand paging test
  KVM: selftests: Time guest demand paging
  KVM: selftests: Add parameter to _vm_create for memslot 0 base paddr
  KVM: selftests: Support large VMs in demand paging test
  Add static flag

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../selftests/kvm/demand_paging_test.c        | 610 ++++++++++++++++++
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   7 +-
 6 files changed, 621 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c

-- 
2.23.0.444.g18eeb5a265-goog

