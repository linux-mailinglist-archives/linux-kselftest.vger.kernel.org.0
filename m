Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301E9340AE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhCRREG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 13:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232206AbhCRRDg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 13:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616087015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=paH0yzmRddoOH+5DM0vbW4Q6jvr8BxZI9BZHxCi1cWs=;
        b=enXXMK8EP3PblA9CmP4GG8B8Xyy4fOwptc7FVCtTUGzYlnA2mtuIl5cAPbGGaT5QIX2i+O
        QN1OvToK+XIo4OIkyGy+b9Kla3jlMoK0s5EPKDPGvv1YWKRDMuMvR7hhLpd6HEYjbfyMTw
        aAkahKlkc6GXGKX1Mt3NxYCCg6QAeeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-AO3aVEPRMcCDaeQvgmn55g-1; Thu, 18 Mar 2021 13:03:31 -0400
X-MC-Unique: AO3aVEPRMcCDaeQvgmn55g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A208107B01A;
        Thu, 18 Mar 2021 17:03:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.196.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6001F1042B4C;
        Thu, 18 Mar 2021 17:03:25 +0000 (UTC)
Date:   Thu, 18 Mar 2021 18:03:16 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
Message-ID: <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
References: <20210318145629.486450-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318145629.486450-1-eesposit@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 18, 2021 at 03:56:29PM +0100, Emanuele Giuseppe Esposito wrote:
> Test the KVM_GET_MSR_FEATURE_INDEX_LIST
> and KVM_GET_MSR_INDEX_LIST ioctls.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/x86_64/get_msr_index_features.c       | 124 ++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 32b87cc77c8e..d99f3969d371 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -5,6 +5,7 @@
>  /s390x/resets
>  /s390x/sync_regs_test
>  /x86_64/cr4_cpuid_sync_test
> +/x86_64/get_msr_index_features
>  /x86_64/debug_regs
>  /x86_64/evmcs_test
>  /x86_64/get_cpuid_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a6d61f451f88..c748b9650e28 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -39,6 +39,7 @@ LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>  
>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features

Maybe we should give up trying to keep an alphabetic order.

>  TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
> diff --git a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> new file mode 100644
> index 000000000000..ad9972d99dfa
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test that KVM_GET_MSR_INDEX_LIST and
> + * KVM_GET_MSR_FEATURE_INDEX_LIST work as intended
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "../lib/kvm_util_internal.h"

I'm not sure why the original kvm selftests authors decided to do this
internal stuff, but we should either kill that or avoid doing stuff like
this.

> +
> +static int kvm_num_index_msrs(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
> +	TEST_ASSERT(r == -1 && errno == E2BIG,
> +				"Unexpected result from KVM_GET_MSR_INDEX_LIST probe, r: %i",
> +				r);

Weird indentation

> +
> +	r = list->nmsrs;
> +	free(list);
> +	return r;
> +}
> +
> +static void test_get_msr_index(void)
> +{
> +	int old_res, res, kvm_fd;
> +
> +	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> +	if (kvm_fd < 0)
> +		exit(KSFT_SKIP);
> +
> +	old_res = kvm_num_index_msrs(kvm_fd, 0);
> +	TEST_ASSERT(old_res != 0, "Expecting nmsrs to be > 0");
> +
> +	if (old_res != 1) {
> +		res = kvm_num_index_msrs(kvm_fd, 1);
> +		TEST_ASSERT(res > 1, "Expecting nmsrs to be > 1");
> +		TEST_ASSERT(res == old_res, "Expecting nmsrs to be identical");
> +	}
> +
> +	close(kvm_fd);
> +}
> +
> +static int kvm_num_feature_msrs(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
> +	TEST_ASSERT(r == -1 && errno == E2BIG,
> +		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST probe, r: %i",
> +				r);

Weird indentation. I'd just leave it up on the last line. We don't care
about long lines.

> +
> +	r = list->nmsrs;
> +	free(list);
> +	return r;
> +}
> +
> +struct kvm_msr_list *kvm_get_msr_feature_list(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
> +
> +	TEST_ASSERT(r == 0,
> +		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST, r: %i",
> +		r);
> +
> +	return list;
> +}
> +
> +static void test_get_msr_feature(void)
> +{
> +	int res, old_res, i, kvm_fd;
> +	struct kvm_msr_list *feature_list;
> +
> +	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> +	if (kvm_fd < 0)
> +		exit(KSFT_SKIP);
> +
> +	old_res = kvm_num_feature_msrs(kvm_fd, 0);
> +	TEST_ASSERT(old_res != 0, "Expecting nmsrs to be > 0");
> +
> +	if (old_res != 1) {
> +		res = kvm_num_feature_msrs(kvm_fd, 1);
> +		TEST_ASSERT(res > 1, "Expecting nmsrs to be > 1");
> +		TEST_ASSERT(res == old_res, "Expecting nmsrs to be identical");
> +	}
> +
> +	feature_list = kvm_get_msr_feature_list(kvm_fd, old_res);
> +	TEST_ASSERT(old_res == feature_list->nmsrs,
> +				"Unmatching number of msr indexes");

Weird indentation

> +
> +	for (i = 0; i < feature_list->nmsrs; i++)
> +		kvm_get_feature_msr(feature_list->indices[i]);
> +
> +	free(feature_list);
> +	close(kvm_fd);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (kvm_check_cap(KVM_CAP_GET_MSR_FEATURES))
> +		test_get_msr_feature();
> +
> +	test_get_msr_index();

Missing return

> +}
> -- 
> 2.29.2
>

Thanks,
drew 

