Return-Path: <linux-kselftest+bounces-47131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B0CA8A0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 911663021AB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5902D7DCE;
	Fri,  5 Dec 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdFUrQpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C872D7812
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956009; cv=none; b=mUXLGE5sXOTLGAj4KRKlUVEvYcZXDlGLK+YI3RxSLt4NnBebJSHESuYes6MzWyXKTO99rWFQPQ0354pGpu5LbRH11uyCwRpsJzSmljO0Q4U4m0l2V6y2aZxwx0HZI6URynavjhOh0a5BbpKAL/JlRIqocLcP/DyradLUz8gBTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956009; c=relaxed/simple;
	bh=eB9+/Eym8/sl6sVLo+TtE0s7XKYj4AnzHDQpqXfgiDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc7t8/yWohiao1bxc74tOdR2bOEAv1EqWfVEQZfo45nmhGsigGS6GqnIzNwuIQszegIrJsmOBfAaOWvHJujkc2a6YMwhL4NFx9jtAhxf1XqRlFbaPa+ITy4aVZFsUd9zJBuJ3k8htgqPXyvHGYsIkdmmeLzBtaBsCvsPFjEg22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdFUrQpE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1168265f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764956005; x=1765560805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amtNQuwco1BO2PnhLkDFqIyQgPKVg/vOsmaYbePwmG4=;
        b=xdFUrQpEygW9kfCFezSYsTLHAgyOhGlvJzf0GuG1tHvN0OS3w2IkkGNJFuFRz9IrKX
         6bUIy/YBVP3wg+oa2BWbEmP0uvk3Auu+1VOtgY6UtJx3yxzi29uH8D5oCVIBX+pgTq1+
         UwfoPTQMx+yx7/W7hpiTkzV1WXwHwKVi5V+iWurbSUZnra+H6ZrRJ7ldVEr2LZV2qSdb
         oVX+fdRZ3LKF1PoftqN8oPBTxhVZNViBqLn85vN58rm4phKKPhUCF7m6OtQogtabvsot
         rgx6GjHujpCfWK2DAWi+fTS1jUeNdFbpRapgFzs0lleQc7MPXf9AqET2gSogEKpwcw3w
         ejqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764956005; x=1765560805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amtNQuwco1BO2PnhLkDFqIyQgPKVg/vOsmaYbePwmG4=;
        b=UsEvWWf8ab+CZ/DBww0aF9qs7iIcR8qBUHLUM16UfA/zgy1+JtyluQbCmR/zMbBbvG
         O++qig8olhRjWON2ptdmSaCphAMTdpgTT+D/0tG850GgNoC6kem8q4XxhZtaRDnif/oc
         iH74kdZOnwng1K4K9mZM5qBlQ1k/n8dkx7in5rjXU39KkFHitasnjzlo0iKXaLwX+nWz
         3FFxooL2HmQiS70cZLqJZkWdXx9ZtDRG+1WCZzlI2SCWRC3bvH7oiBVNynM6Xm8Mkr4q
         eTta9RG1lqBj9Kkk8w/c8fT7QupczI7WOTqqG02WbeYpf04LY2rQDCUwEPCLQp8FvJU1
         306A==
X-Forwarded-Encrypted: i=1; AJvYcCXmw48k52M0PulKjIhMuoU3fpmOjPOBHxJ55Z69d2RCFnzfl/OFAQXjw6eSil7bS8NAPmQV3u1e12VSl2JX95M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzC+Vs8vmgptKqX3k60d6YD+fhVHbjo8kjsAncnAcRdqdTWA9
	//B8ewLUNQNTuo3Zf2Yr2FXsFXr46OSoHhR40RDh3COJ10FZklTaIYjOJYiBjdiXTg==
X-Gm-Gg: ASbGncsY8DNPHDHaK3lTbS1eVisQR99ufzVowEqhE2fEQftLmOPG3ALJ3i1Ka/S7sQn
	OrWvRreXkksiacEvmBthg8XYxEDwTp8X3RJl/AZi+s1SqhbkzrLNOasZ36H5gP41WGKizIYO+br
	nOIy4OkfFIgi7RaN7HacZiQwETmojSLMyOMUi3/8VK38/RW5azHuVXVpEaSDnB5Iyv5U5J0qRYE
	lBy0LXYfNEezv5YUu8UNr9TJ4USffoBtuRcQG031F5rAdihG4++jaOrh3vuVHzJbE0WkwDYMj9h
	XavZ9KwzxtZectzd87uSjqZVwkO70E0Yg2ZNOigddUFLTNT1kunIehPHEhwvZWZfpQMb1njvNv7
	JzWGj/ztU04tWZduDsugIU/haht4kZXUIvH9HNdALASwlJ3y8RAqxBo2C5aQm+IqbVdRhGKvHLv
	NkflYPmf0eaF8W47lcplB+R2vHGxMEYWuut1Hq2/DKFegTmuk0Wg==
X-Google-Smtp-Source: AGHT+IG7GHbywu/ls/wVemuOmr6xVx9MQPax08/Ei7Uq0ye9NoSzMgiNsTxCLJQTc1fcXLx9fTdYtw==
X-Received: by 2002:a5d:64e3:0:b0:429:cf03:8b2e with SMTP id ffacd0b85a97d-42f89ecee3fmr43760f8f.13.1764956004866;
        Fri, 05 Dec 2025 09:33:24 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226d0sm9793222f8f.21.2025.12.05.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:33:24 -0800 (PST)
Date: Fri, 5 Dec 2025 17:33:21 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com, xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk, jackabt@amazon.com
Subject: Re: [PATCH v3 2/3] KVM: selftests: Enable pre_fault_memory_test for
 arm64
Message-ID: <aTMXYZgZM3QvZP2i@google.com>
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
 <20251119154910.97716-3-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154910.97716-3-jackabt.amazon@gmail.com>

On Wed, Nov 19, 2025 at 03:49:09PM +0000, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> Enable the pre_fault_memory_test to run on arm64 by making it work with
> different guest page sizes and testing multiple guest configurations.
> 
> Update the test_assert to compare against the UCALL_EXIT_REASON, for
> portability, as arm64 exits with KVM_EXIT_MMIO while x86 uses
> KVM_EXIT_IO.
> 
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/pre_fault_memory_test.c     | 78 ++++++++++++++-----
>  2 files changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 148d427ff24b..0ddd8db60197 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -183,6 +183,7 @@ TEST_GEN_PROGS_arm64 += memslot_perf_test
>  TEST_GEN_PROGS_arm64 += mmu_stress_test
>  TEST_GEN_PROGS_arm64 += rseq_test
>  TEST_GEN_PROGS_arm64 += steal_time
> +TEST_GEN_PROGS_arm64 += pre_fault_memory_test
>  
>  TEST_GEN_PROGS_s390 = $(TEST_GEN_PROGS_COMMON)
>  TEST_GEN_PROGS_s390 += s390/memop
> diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> index f04768c1d2e4..674931e7bb3a 100644
> --- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
> +++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> @@ -11,19 +11,29 @@
>  #include <kvm_util.h>
>  #include <processor.h>
>  #include <pthread.h>
> +#include <guest_modes.h>
>  
>  /* Arbitrarily chosen values */
> -#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
> -#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)

After applying on top of the base commit
8a4821412cf2c1429fffa07c012dd150f2edf78c, it does not build.

That TEST_NPAGES seems to still be used in delete_slot_worker(). I believe
that's because of

  "KVM: selftests: Test prefault memory during concurrent memslot removal"

Related issues with the pre_fault_memory() prototype.

Is that the correct base-commit or shall I use something else?

> +#define TEST_BASE_SIZE		SZ_2M
>  #define TEST_SLOT		10
>

[...]

