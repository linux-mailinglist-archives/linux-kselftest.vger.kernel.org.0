Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801B947F2B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Dec 2021 10:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhLYJLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Dec 2021 04:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231230AbhLYJLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Dec 2021 04:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640423508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zldxMj+mOa4xEISADiWr6dy8ahQABwEEuVquONVwlSU=;
        b=dHRaPVDDTdKn/Z28wgdsHNReryDweiMjJmQYnPkR8WG+jnAkmER0aGBl3ZurDrwxnkK6lQ
        9Rthp/v8W4zmYRi3IrRQD5KzwaHaGXz6j9/ioPZ8j6S9kDyKopOo/V3V82GvRMFT9lWdT4
        8WuqE06OKGVtfNtoyYJTUa8HlXhNni8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-LtkqmtWNMJSoySlw7yWPtQ-1; Sat, 25 Dec 2021 04:11:47 -0500
X-MC-Unique: LtkqmtWNMJSoySlw7yWPtQ-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a056402271100b003f7ef5ca612so7925596edd.17
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Dec 2021 01:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zldxMj+mOa4xEISADiWr6dy8ahQABwEEuVquONVwlSU=;
        b=oNxiA3868VPgIrmBst5SR++voxrAn2Pj3OGD4R+4I5i/6kaULUOcV1/28mtHfKU+lf
         y1b7n6IMHKh0KQazSuoCfyQGUiO7K0r0Vh6yQhRHKmCQaJ3hX9tRT21VFA8C0GSVgcmp
         /Kx4VNBc7L3Lsf2ZgGJVcj3IjgAhN48860UDgbRfXYRiOm4B4J93gU9cMxjA/wT+8/pg
         UEIQ6nqL0ihqYWeda5P2JLHzuV1vJ8pFIuZNiKUdnxWxubDCvUqEqe+bRpQmYjBMHvRg
         LJ8irVIGwjJMeyf6fygX0x+pSZnDlGNTTcQAcYqlsCOn0M80/yb63f7BOP/64qJF/PbG
         8LLg==
X-Gm-Message-State: AOAM533p3Yq5l5GPhQ673k5qmMYxmpUdil0D/Bk8KSF8VEkB634N2kg0
        Q9dO+ezxF3iQ7JQ8XLtAnFb57L0hrXM9zZYiMAwqOfAkNXUNO5Id9vwikoDUwWBHRvN73oyTA/D
        1Yawz1ZFX58ftffOv4A98Cc3HGenT
X-Received: by 2002:a17:907:9717:: with SMTP id jg23mr8342961ejc.593.1640423505866;
        Sat, 25 Dec 2021 01:11:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYG9NlF9xuaeOATknk+JawNqx6o5eHic3XVZf5gR+23IdJV86It317VASJSiDbLfIH+6i+wA==
X-Received: by 2002:a17:907:9717:: with SMTP id jg23mr8342924ejc.593.1640423505581;
        Sat, 25 Dec 2021 01:11:45 -0800 (PST)
Received: from gator.home (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id y17sm3923961edd.31.2021.12.25.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 01:11:44 -0800 (PST)
Date:   Sat, 25 Dec 2021 10:11:42 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH RFC 02/10] kvm: selftests: move ucall declarations into
 ucall_common.h
Message-ID: <20211225091142.k6szpew4uatrvaus@gator.home>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <20211210164620.11636-3-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210164620.11636-3-michael.roth@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 10, 2021 at 10:46:12AM -0600, Michael Roth wrote:
> Now that core kvm_util declarations have special home in
> kvm_util_base.h, move ucall-related declarations out into a separate
> header.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>  .../selftests/kvm/include/kvm_util_base.h     | 49 ---------------
>  .../selftests/kvm/include/ucall_common.h      | 59 +++++++++++++++++++
>  3 files changed, 60 insertions(+), 49 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/ucall_common.h
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index c860ced3888d..c9286811a4cb 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -8,5 +8,6 @@
>  #define SELFTEST_KVM_UTIL_H
>  
>  #include "kvm_util_base.h"
> +#include "ucall_common.h"
>  
>  #endif /* SELFTEST_KVM_UTIL_H */

Now that kvm_util.h is looking like a "libkvm.h", then we can do some more
header cleanups to make that official. After this series is merged I'll
send a series that

 - removes unnecessary includes from kvm_util_common.h and other headers
 - renames kvm_util.h to libkvm.h
 - also includes guest_modes.h and test_util.h from libkvm.h
 - simplify the includes of all unit tests since they'll be including
   libkvm.h
 - probably move include/sparsebit.h to lib, since no unit test needs it

Thanks,
drew

> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 8fb6aeff5469..4e2946ba3ff7 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -360,55 +360,6 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
>  
>  void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
>  
> -/* Common ucalls */
> -enum {
> -	UCALL_NONE,
> -	UCALL_SYNC,
> -	UCALL_ABORT,
> -	UCALL_DONE,
> -	UCALL_UNHANDLED,
> -};
> -
> -#define UCALL_MAX_ARGS 6
> -
> -struct ucall {
> -	uint64_t cmd;
> -	uint64_t args[UCALL_MAX_ARGS];
> -};
> -
> -void ucall_init(struct kvm_vm *vm, void *arg);
> -void ucall_uninit(struct kvm_vm *vm);
> -void ucall(uint64_t cmd, int nargs, ...);
> -uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
> -
> -#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
> -				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
> -#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
> -#define GUEST_DONE()		ucall(UCALL_DONE, 0)
> -#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
> -	if (!(_condition))                                              \
> -		ucall(UCALL_ABORT, 2 + _nargs,                          \
> -			"Failed guest assert: "                         \
> -			_condstr, __LINE__, _args);                     \
> -} while (0)
> -
> -#define GUEST_ASSERT(_condition) \
> -	__GUEST_ASSERT(_condition, #_condition, 0, 0)
> -
> -#define GUEST_ASSERT_1(_condition, arg1) \
> -	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
> -
> -#define GUEST_ASSERT_2(_condition, arg1, arg2) \
> -	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
> -
> -#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
> -	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
> -
> -#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
> -	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
> -
> -#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
> -
>  int vm_get_stats_fd(struct kvm_vm *vm);
>  int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
>  
> diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
> new file mode 100644
> index 000000000000..9eecc9d40b79
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/ucall_common.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * tools/testing/selftests/kvm/include/kvm_util.h
> + *
> + * Copyright (C) 2018, Google LLC.
> + */
> +#ifndef SELFTEST_KVM_UCALL_COMMON_H
> +#define SELFTEST_KVM_UCALL_COMMON_H
> +
> +/* Common ucalls */
> +enum {
> +	UCALL_NONE,
> +	UCALL_SYNC,
> +	UCALL_ABORT,
> +	UCALL_DONE,
> +	UCALL_UNHANDLED,
> +};
> +
> +#define UCALL_MAX_ARGS 6
> +
> +struct ucall {
> +	uint64_t cmd;
> +	uint64_t args[UCALL_MAX_ARGS];
> +};
> +
> +void ucall_init(struct kvm_vm *vm, void *arg);
> +void ucall_uninit(struct kvm_vm *vm);
> +void ucall(uint64_t cmd, int nargs, ...);
> +uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
> +
> +#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
> +				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
> +#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
> +#define GUEST_DONE()		ucall(UCALL_DONE, 0)
> +#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
> +	if (!(_condition))                                              \
> +		ucall(UCALL_ABORT, 2 + _nargs,                          \
> +			"Failed guest assert: "                         \
> +			_condstr, __LINE__, _args);                     \
> +} while (0)
> +
> +#define GUEST_ASSERT(_condition) \
> +	__GUEST_ASSERT(_condition, #_condition, 0, 0)
> +
> +#define GUEST_ASSERT_1(_condition, arg1) \
> +	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
> +
> +#define GUEST_ASSERT_2(_condition, arg1, arg2) \
> +	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
> +
> +#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
> +	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
> +
> +#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
> +	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
> +
> +#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
> +
> +#endif /* SELFTEST_KVM_UCALL_COMMON_H */
> -- 
> 2.25.1
> 

