Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF60485333
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 14:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiAENGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 08:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236796AbiAENGx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 08:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641388012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPbUxj6ghyTrgwhNP+U3qhJU5iyb67zbb1namC5tcQQ=;
        b=Nlnz7EQHx2PLHuoPXmt7IuQw77twpUosRrHwQbfOatzcDJzXxhgFME1deVQxKIYstfhMGJ
        y2c+wE13Q6J2SqBynsvOXadijawRhWn414echOXt1MzEtRM13YTqjYyVpGDsIP1+BLxhDs
        FnlL4P/giHUZzoUSiMa3KP0JuOyUmGA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-6urUz-9lMeixVNKTBA4A8A-1; Wed, 05 Jan 2022 08:06:51 -0500
X-MC-Unique: 6urUz-9lMeixVNKTBA4A8A-1
Received: by mail-ed1-f71.google.com with SMTP id m8-20020a056402510800b003f9d22c4d48so1157443edd.21
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 05:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qPbUxj6ghyTrgwhNP+U3qhJU5iyb67zbb1namC5tcQQ=;
        b=V5lO9Ilg9RCux7wCZtO15qVdFBhE1a+xg7WW4i9P0D5X0pMMTEru7RyBecsfLr1WFF
         zR6uuRU9cVc9aHpEDBb4EESufW2L8uc9Y4HohLM03QZJe9blGS3e+KAn7rECmVVnCHlm
         pepGebNRq2PM+VMP/ELyi+euNhM1g6pnpTXnkOfM6PMPshXAMP3jVi56xsZkCsfXxw8e
         34GqldyFlT8B5W3q/im2y0sCHn6CBzFyJXf7haQkH7qUnupBz8/JxC5N0tAe+x11UuaB
         hGKCRQIw4Dv+SSqyZIrqWuFDnI/K/0MrWxrLhMmhdvJ2UaASe9OCK2TwhSpCZ36glCKC
         SEew==
X-Gm-Message-State: AOAM530uJjglFQNKnFig8vyx1RD31b1SFSaWl+pLbxz+NESCUMvhLMD2
        aQSTw9miCqusqxcr0A++c8S4N0cQ4qC4Akv2/8s9Yw8Sfm388WzE0dCabBA8EwEH9UTsj4zIp5a
        +wajinQsvLRLhWk9VGEeYzfcKjj20
X-Received: by 2002:a17:907:7f9e:: with SMTP id qk30mr40517145ejc.313.1641388010168;
        Wed, 05 Jan 2022 05:06:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2kvcaNQ8zr5/pOMq5wIiwszyeeQoUKvE+rInBlWiKyo00Mr1ysjR1/zCjvH1iUYUbX+TRaQ==
X-Received: by 2002:a17:907:7f9e:: with SMTP id qk30mr40517123ejc.313.1641388009929;
        Wed, 05 Jan 2022 05:06:49 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id o12sm15956818edz.71.2022.01.05.05.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 05:06:49 -0800 (PST)
Message-ID: <c99d0b82-a44f-db8e-3f81-93d2394f9a02@redhat.com>
Date:   Wed, 5 Jan 2022 14:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 07/21] x86/fpu: Provide fpu_enable_guest_xfd_features()
 for KVM
Content-Language: en-US
To:     Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-8-yang.zhong@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220105123532.12586-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/5/22 13:35, Yang Zhong wrote:
> +int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
> +{
> +	lockdep_assert_preemption_enabled();
> +

The old fpu_update_guest_perm_features(guest_fpu) is equivalent to

	fpu_enable_guest_xfd_features(guest_fpu, guest_fpu->perm);

Missing doc comment:

/*
  * fpu_enable_guest_xfd_features - Enable xfeatures according to guest perm
  * @guest_fpu:         Pointer to the guest FPU container
  * @xfeatures:         Features requested by guest CPUID
  *
  * Enable all dynamic xfeatures according to guest perm and requested CPUID.
  * Invoked if the caller wants to conservatively expand fpstate buffer instead
  * of waiting until XCR0 or XFD MSR is written.
  *
  * Return: 0 on success, error code otherwise
  */

Also, the check for 32-bit is slightly imprecise:

	/* Dynamic xfeatures are not supported with 32-bit kernels. */
	if (!IS_ENABLED(CONFIG_X86_64))
-		return 0;
+		return -EINVAL;

since we only get here with xfeatures != 0 (if it compiles, just removing
the IS_ENABLED check altogether would be even better).  With these changes,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

