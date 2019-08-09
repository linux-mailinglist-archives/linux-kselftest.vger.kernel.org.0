Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485BB87343
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbfHIHja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 03:39:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIHja (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 03:39:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so4690055wmj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 00:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaUE+b2Ivx2DbXYmJvLDQ+HYNnryuMwKv4SoNgWueQs=;
        b=NmKX6s8+9PVaSp88FrEajAadjNz7yU/lxPFhQqPKOBFCO0E5h49m4OD3aQx1lO2OXf
         q58WXJ+/M92zRozbKAYKg+ujTzI1g9Rt4YRqJiN8wK4HkUw5knF3qpFF8T6UdhzH4Hm5
         kVtkSIYXhJq3S7XZQoXhKH6Z6JbeJxDv2YdioTI/URvYJuKk3jodraj0QSEkbgmOl2xp
         wSiFhb/tQV7/A3pC3xhOL51Wx3UYm9gtq+5AgOspfXHuNx1KltukI+acaCsdp7AlUscJ
         wSaCz2ySEybN5U13KTRcPNMtQpa4a3ev/gTY11ODs5cWfh19b9JQTLVNIM8enL8aKzO9
         knxQ==
X-Gm-Message-State: APjAAAWvoJRVEZ0iAlpCVq44Zk1t3zuVyYjXv8uFiHVi8sTmAXOoMsHT
        /46xnzaYlF4rzLOae6LQgm8BFsx+HIA=
X-Google-Smtp-Source: APXvYqxytvGnBCzeMG9C+zJI7RJIXc4jYF8EQLjKxY1xmaERR0icUaDIN9Wz/zR8CgJLJXbU7OMqZQ==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr9078528wmh.139.1565336368260;
        Fri, 09 Aug 2019 00:39:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61? ([2001:b07:6468:f312:b42d:b492:69df:ed61])
        by smtp.gmail.com with ESMTPSA id m7sm80941667wrx.65.2019.08.09.00.39.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 00:39:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] selftests: kvm: Adding config fragments
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190809072415.29305-1-naresh.kamboju@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com>
Date:   Fri, 9 Aug 2019 09:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809072415.29305-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/08/19 09:24, Naresh Kamboju wrote:
> selftests kvm all test cases need pre-required kernel config for the
> tests to get pass.
> 
> CONFIG_KVM=y
> 
> The KVM tests are skipped without these configs:
> 
>         dev_fd = open(KVM_DEV_PATH, O_RDONLY);
>         if (dev_fd < 0)
>                 exit(KSFT_SKIP);
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/kvm/config | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/kvm/config
> 
> diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> new file mode 100644
> index 000000000000..14f90d8d6801
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/config
> @@ -0,0 +1 @@
> +CONFIG_KVM=y
> 

I think this is more complicated without a real benefit, so I'll merge v2.

Paolo
