Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359A51B4A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 02:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiEEAar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEEAaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 20:30:46 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 17:27:04 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E3FB45060
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651710423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+VFB+RbqDxtdPfXH5fs43HvbZapK8JlXZrJfass0jo=;
        b=iPcBX47jh+qpj+j3L6zJpDUABVmc0DGKs38DLwZZTCppKkBRD2p7OwdK9KfwZNdASWxQhW
        wsFxvmh2N1CVOQ6iRfSCS57M/BWUikrlyWZ3uLFu8aVR2oym7NhoT8rghivtGSWpraxVtd
        yGzWHAezDOkbCVCtNeLUEAwjfO5jgA8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-fo4V7Ae7OfOGecZyX4ny4Q-1; Wed, 04 May 2022 20:25:58 -0400
X-MC-Unique: fo4V7Ae7OfOGecZyX4ny4Q-1
Received: by mail-qv1-f71.google.com with SMTP id kc6-20020a056214410600b0045a97658c7dso2033171qvb.16
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 17:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+VFB+RbqDxtdPfXH5fs43HvbZapK8JlXZrJfass0jo=;
        b=eiUKj8CFxr68v3GlS7utF2aasUb8C1wdXI4HVFcRmMa3IpyKXZq7pEzk1Yb0CTFX2Q
         xqQGkhlpxAF6U0jIAT3NxrVXSS9BmT5lCusiQsxCMgtwWmRLtVk07CT1rsQPRXZMUQ8Q
         sUG8DlwPAhhHIBmDF0Ndpzcw+lFpONvK27xQpeBPHYKu0THFI0suoEdlNH+PsGynHVEm
         nwFJBzKea/SETF45aJ61mzZosbNMaogL+ewcy6A5dq7s/SUz3Vrx3++BnVB9XDSLA4rR
         o+UhD6xQLWYX9Xy+3UTEcyqObt2wofpnT8LY8bynxdo3wDcjx7GTWeFwy1V+gDNV5wdc
         E0wA==
X-Gm-Message-State: AOAM531RXD2jc3NUmhJU4kVhKLYfsTirHy/SLvWwTKr71YfFM+ODdUXQ
        CMVMk78awz29Cdx7tgJGBz29TExV4lWBbDeybHtABseSwfLvfd55YnNcQSVbTNFN+pHQsHfSFWV
        TQ9GYduDrpt/3cqEFEvVppBZkiwSS
X-Received: by 2002:a05:620a:45a5:b0:6a0:455:b829 with SMTP id bp37-20020a05620a45a500b006a00455b829mr7166822qkb.450.1651710358147;
        Wed, 04 May 2022 17:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDVIxSAgnbeoc2yDLtyhSKIPinnZELTTVOPCTW8YB9dKfNNvKXWcHNIVe6LME42AGiK4No6A==
X-Received: by 2002:a05:620a:45a5:b0:6a0:455:b829 with SMTP id bp37-20020a05620a45a500b006a00455b829mr7166816qkb.450.1651710357920;
        Wed, 04 May 2022 17:25:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:5610:6e80::41? ([2600:1700:5610:6e80::41])
        by smtp.gmail.com with ESMTPSA id n1-20020ac81e01000000b002f39b99f679sm18727qtl.19.2022.05.04.17.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 17:25:57 -0700 (PDT)
Message-ID: <9b00397e-f0fd-18c2-8268-c071257443cd@redhat.com>
Date:   Wed, 4 May 2022 20:25:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests: vm: Makefile: rename TARGETS to VMTARGETS
Content-Language: en-US
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20220504214032.1283777-1-jsavitz@redhat.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220504214032.1283777-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/4/22 17:40, Joel Savitz wrote:
> The tools/testing/selftests/vm/Makefile uses the variable TARGETS
> internally to generate a list of platform-specific binary build targets
> suffixed with _{32,64}. When building the selftests using its own
> Makefile directly, such as via the following command run in a kernel
> tree:
> 
> # make -C tools/testing/selftests install TARGETS="vm"
> 
> One receives an error such as the following:
> 
> make: Entering directory '/root/linux/tools/testing/selftests'
> make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
> make[1]: Entering directory '/root/linux'
>   INSTALL ./usr/include
> make[1]: Leaving directory '/root/linux'
> make[1]: Entering directory '/root/linux/tools/testing/selftests/vm'
> make[1]: *** No rule to make target 'vm.c', needed by '/root/linux/tools/testing/selftests/vm/vm_64'.  Stop.
> make[1]: Leaving directory '/root/linux/tools/testing/selftests/vm'
> make: *** [Makefile:175: all] Error 2
> make: Leaving directory '/root/linux/tools/testing/selftests'
> 
> The TARGETS variable passed to tools/testing/selftests/Makefile collides
> with the TARGETS used in tools/testing/selftests/vm/Makefile, so rename
> the latter to VMTARGETS, eliminating the collision with no functional
> change.
> 
> Fixes: f21fda8f6453 ("selftests: vm: pkeys: fix multilib builds for
> x86")
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.comTested-by: Nico Pache <npache@redhat.com>
Acked-by: Nico Pache <npache@redhat.com>

