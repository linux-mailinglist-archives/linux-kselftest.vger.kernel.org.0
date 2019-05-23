Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6327973
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEWJlG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 05:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJlG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 05:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 187FB3086228;
        Thu, 23 May 2019 09:41:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DDF21802F;
        Thu, 23 May 2019 09:41:04 +0000 (UTC)
Date:   Thu, 23 May 2019 11:41:02 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Wrap vcpu_nested_state_get/set functions
 with x86 guard
Message-ID: <20190523094102.cn2xpnofhl2fltcc@kamzik.brq.redhat.com>
References: <20190523093114.18182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523093114.18182-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 23 May 2019 09:41:06 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 11:31:14AM +0200, Thomas Huth wrote:
> struct kvm_nested_state is only available on x86 so far. To be able
> to compile the code on other architectures as well, we need to wrap
> the related code with #ifdefs.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 8c6b9619797d..a5a4b28f14d8 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -118,10 +118,12 @@ void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
>  void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
> +#ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
>  			   struct kvm_nested_state *state);
>  int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
>  			  struct kvm_nested_state *state, bool ignore_error);
> +#endif
>  
>  const char *exit_reason_str(unsigned int exit_reason);
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index cf62de377310..633b22df46a4 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1248,6 +1248,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		ret, errno);
>  }
>  
> +#ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
>  			   struct kvm_nested_state *state)
>  {
> @@ -1279,6 +1280,7 @@ int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
>  
>  	return ret;
>  }
> +#endif
>  
>  /*
>   * VM VCPU System Regs Get
> -- 
> 2.21.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
