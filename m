Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1627D353133
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Apr 2021 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhDBWoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBWoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 18:44:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46034C06178C
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 15:44:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i2so10792266ybl.21
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=irIfy9SDJhrUqaDE5ZN6w1PVEQaG5IbsoR3bDTu0jl4=;
        b=oINmMmgMmoW/oyIcAkt+qHnpbVapAHO0BtBXorG5hnuc57P8B5zKJ7zBvQRstcANLe
         g5n4RamBX4W+J0lM7mec5Dp6K9/13ohk6ZXhVLCPFigMH64M84+iBExfaQf9hmAzQUiH
         bZY7VNQunFlIiJhRNQFdKfJbFOB0Z5ctHSCkx6H0TH0GoqpNH18oGgLzf1ZN153zxYSn
         am8EWHgEB72tVSDwUwtxKSTamIpb7vD/rP8Huv89Yo4aqk6V3/tf8JCDm3oqnXL+hCsQ
         02z6sYthCN9r+ritpQhL7w8X3C0Qqdj7AVHhTJsVELFIHoQjykQwl0v9h8r/bTrDVKjH
         X99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=irIfy9SDJhrUqaDE5ZN6w1PVEQaG5IbsoR3bDTu0jl4=;
        b=Uyzw7B0ECXY+uScuExE4id7sy1ZT8vdPnvAyx3iFTedeKj8nrzdbKVsF38tTrGIvQ6
         zMXk+YM/4YpWuFSCV17sfeluXexJprtCGqfqkK+37IJwKDzSFTSjV40Fslc0df0if8t2
         UOEDtTkZE/7SPVejSAnAPb47+Y4D9SBkRKoGr4a2YKOapuVwTbHMnXZugPgzuYN1cqer
         RXUj6gbDILuTbtprIZA4KwFf4xYpSUWqi37izDIMJlolNZVANdKr8Ri5bL8GQtML7DRo
         S6sRvaX/FNcTmWTN8OW4MNUXOQPDvtdrKHFItobxvO6F/OBwdqvHzw6iK5Byg6U/BxQ3
         JzuA==
X-Gm-Message-State: AOAM5328LZ85tofhgw8WwsM2jpQUYPJHcs2p4s4yy46+eZyqPAcGkI00
        inbPMoWTWAyt2GK62fGlK7VL1HOOhGPK7xpAog==
X-Google-Smtp-Source: ABdhPJyjY/9bgZ4cfSTi5H9NxDPqiTmNCSs6veZkAE2t6SvpxZwTxmf38XzA4gMlvXfjJgmYTh/5eLdnr+RrZ8+4Rw==
X-Received: from jingzhangos.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:513])
 (user=jingzhangos job=sendgmr) by 2002:a25:4dc4:: with SMTP id
 a187mr21783146ybb.78.1617403453215; Fri, 02 Apr 2021 15:44:13 -0700 (PDT)
Date:   Fri,  2 Apr 2021 22:43:55 +0000
Message-Id: <20210402224359.2297157-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 0/4] KVM statistics data fd-based binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
In this patchset, every statistics data are treated to have some
attributes as below:
  * architecture dependent or common
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous,
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics date
are still being updated by KVM subsystems while they are read out.

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 169 ++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  42 +-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  67 +++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  68 +++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  63 ++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 133 ++++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  71 +++-
 include/linux/kvm_host.h                      | 132 ++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  48 +++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 370 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 virt/kvm/kvm_main.c                           | 237 ++++++++++-
 24 files changed, 1401 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: f96be2deac9bca3ef5a2b0b66b71fcef8bad586d
-- 
2.31.0.208.g409f899ff0-goog

