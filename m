Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBA29F05
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfEXTY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 15:24:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36081 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfEXTY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 15:24:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so3006519wml.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 12:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvn6Z+8CNLO1tsaW5/zxMotanzz8ExB5H3ow81Rb1J8=;
        b=qRYsxMG9FrOLT8U6+AK++/2g7ksw8Dfs5bGi0wIBbJSlyRlD1T2vINHiXuTFgtKg1J
         DnwjRFRuJ/6guZIcaQqGdTmzzWgOVXAiiKs+pmrsxdqvWyS4nkD3A5524SP/dXrU2gEU
         fdRqiR+BiSi/AAP8oxzTNidNU4nci10pJp9xrcUPPQtFg2BXejHYffTzcQXPd0/HhS9a
         HHhY3G/ioEMIhg7TLZa8LJqvVYmRpghatKg7eABWRakXZPU38TCdW10f9XAsTTsw0qLh
         KUV9PmsDg4HgAdjaFS36BIL/nMm50Itx92em6CFEgox0Mas41Zb/8RLnHmWd+3lVXibV
         pv+A==
X-Gm-Message-State: APjAAAUC4uUM/vPrNslCzk7x/zPH3hvlxlrFWQHwOM/HCwFYTdQx4x/h
        zheGbbw8BQUyDa3yIq4CVoDaoDcoTZ0=
X-Google-Smtp-Source: APXvYqzfqL+E+LxIXGZhopDTwiNLeQSCRmfercctqPmlnf0LEtgtnNgAywaKzY5YC3KvCOvA4KPUcQ==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr18350497wmj.25.1558725865276;
        Fri, 24 May 2019 12:24:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 74sm3410408wma.7.2019.05.24.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:24:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Wrap vcpu_nested_state_get/set functions
 with x86 guard
To:     Thomas Huth <thuth@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190523093114.18182-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cb9f031-3483-b721-2e74-b12664b705ec@redhat.com>
Date:   Fri, 24 May 2019 21:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523093114.18182-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/05/19 11:31, Thomas Huth wrote:
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
> 

Queued, thanks.

Paolo
