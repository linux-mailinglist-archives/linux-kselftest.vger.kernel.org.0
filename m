Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973F7313B9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhBHRxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhBHRv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 12:51:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD9C06178A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 09:43:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e7so1749934pge.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RxLUe7o0XBsEMnyZ2ayM5Zt5mnJyMnV0qymbKsVL5xI=;
        b=Fl/ILLaQ27dYD+8sqFnFsVrXGNE10dTiegetvaiJTd8Yx6XriE47wKym0jVJrTwrHf
         BmXGbYYJjosrvsmaLpdY3H9q8eF58k8PP1WFfWPi2qffZgrb0bNsvXa+VX5kf/QlqCkg
         zW4C1Pgh1YcHlMdx2FTREafj2nwr2qb8xCxF5CC0JuF7pQad93EkK6uHwL4TQ0IkiiDw
         FJr4HH2jpQqHubAZoiIhJicivZ4xX7kULKs7IFpO3L7Vq8FbOv9flC917FeP7y19cUoB
         3oGKpOxnPKNDCLpYb9Q629nRD1dx2AcBjTiqkhi/qvw1ElSP4jICnl2jLeWyNUPnju0P
         Zh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RxLUe7o0XBsEMnyZ2ayM5Zt5mnJyMnV0qymbKsVL5xI=;
        b=dCaShK7KUPnudw5kGh13CpcjaXqSz0o1oKeEaXVB3iWVjQk0HYZvIE5hhw3kWwBjJ5
         So1EAOFTlvU5wxDKJ3vQiOAqmrie0YcGqJynNDK+rkhGiWO1tZ44sc0/Mc2SZOxeBeWa
         apsdpvOTaScyMrYy90YHac7qN3AL4xc2dnbt9BshiSUw4IxImp5F+Zqec4TdmWWJFrYK
         5V5Oa6IJTvIBrgB/kTjyo8HK2dWL6NsY93/eyOSqPL/KKWzjCsgWxz4DAPAuJMv+54/X
         ZPziBGame0VKcGwuYXz5+T+2UFhcvCao6bG8lsPSkyyzennzeRR3lmy7u8+R9Wfe2Xcg
         4sDg==
X-Gm-Message-State: AOAM5325V6w5u/pqAoKMcTaFBsI9CqSaIe+KF9u+f5l6tUip0VVPfZ1w
        d4kbyJ1wIV/Uj6IFcIZXEgapUQ==
X-Google-Smtp-Source: ABdhPJzgH48OCVyI5hH228/HKK7dPLNGjKP1Ay4WnHabg31jANO3Rit48bQBOUDkqOCYP8c+u+pspQ==
X-Received: by 2002:a62:8cd7:0:b029:1d9:447c:e21a with SMTP id m206-20020a628cd70000b02901d9447ce21amr14414194pfd.2.1612806215874;
        Mon, 08 Feb 2021 09:43:35 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
        by smtp.gmail.com with ESMTPSA id c18sm9730201pfo.171.2021.02.08.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:43:35 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:43:28 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Subject: Re: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of
 vm_mem_backing_src_type
Message-ID: <YCF4QCPtSEFg3Qv4@google.com>
References: <20210208090841.333724-1-wangyanan55@huawei.com>
 <20210208090841.333724-2-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208090841.333724-2-wangyanan55@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 08, 2021, Yanan Wang wrote:
> Add a macro to get string of the backing source memory type, so that
> application can add choices for source types in the help() function,
> and users can specify which type to use for testing.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 5cbb861525ed..f5fc29dc9ee6 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -69,7 +69,9 @@ enum vm_guest_mode {
>  #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
>  
>  #define vm_guest_mode_string(m) vm_guest_mode_string[m]
> +#define vm_mem_backing_src_type_string(s) vm_mem_backing_src_type_string[s]

Oof, I see this is just following vm_guest_mode_string.  IMO, defining the
string to look like a function is unnecessary and rather mean.

>  extern const char * const vm_guest_mode_string[];
> +extern const char * const vm_mem_backing_src_type_string[];
>  
>  struct vm_guest_mode_params {
>  	unsigned int pa_bits;
> @@ -83,6 +85,7 @@ enum vm_mem_backing_src_type {
>  	VM_MEM_SRC_ANONYMOUS,
>  	VM_MEM_SRC_ANONYMOUS_THP,
>  	VM_MEM_SRC_ANONYMOUS_HUGETLB,
> +	NUM_VM_BACKING_SRC_TYPES,
>  };
>  
>  int kvm_check_cap(long cap);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index fa5a90e6c6f0..a9b651c7f866 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -165,6 +165,14 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>  	       "Missing new mode params?");
>  
> +const char * const vm_mem_backing_src_type_string[] = {

A shorter name would be nice, though I don't have a good suggestion.

> +	"VM_MEM_SRC_ANONYMOUS        ",
> +	"VM_MEM_SRC_ANONYMOUS_THP    ",
> +	"VM_MEM_SRC_ANONYMOUS_HUGETLB",

It'd be more robust to explicitly assign indices, that way tweaks to
vm_mem_backing_src_type won't cause silent breakage.  Ditto for the existing
vm_guest_mode_string.

E.g. I think something like this would work (completely untested)

const char *vm_guest_mode_string(int i)
{
	static const char *const strings[] = {
		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
	};

	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
		       "Missing new mode strings?");

	TEST_ASSERT(i < NUM_VM_MODES);

	return strings[i];
}


> +};
> +_Static_assert(sizeof(vm_mem_backing_src_type_string)/sizeof(char *) == NUM_VM_BACKING_SRC_TYPES,
> +	       "Missing new source type strings?");
> +
>  /*
>   * VM Create
>   *
> -- 
> 2.23.0
> 
