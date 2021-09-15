Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54440CF5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhIOWgR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 18:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232650AbhIOWgQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 18:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631745296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2aVR2KW9hCZ2kkHP6ld7LFEUvut6M4OyuO1clchMrMg=;
        b=R4hInkYOkv27DXBqKb5zPSMmnfjTy1+rHOIiu90q2JiMKtqNHFezYwBHzXCOPyhp4wN3vC
        wR6JWGbMzTzmPJ6OGYsVJrPqkM0/8w1pWwKBxWkffN8w5LFvQQR7EPgMb05WyJerQ2hP9T
        tb6fHZDe7uAEjIpuykSEv/pxj2iQ+p8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-sWrQPprJOQSprByo6RtqAQ-1; Wed, 15 Sep 2021 18:34:55 -0400
X-MC-Unique: sWrQPprJOQSprByo6RtqAQ-1
Received: by mail-ed1-f69.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso3142956edb.11
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 15:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2aVR2KW9hCZ2kkHP6ld7LFEUvut6M4OyuO1clchMrMg=;
        b=qo2lG3vdSDoy036Avn3xdNvp2aacV1C67U44WqxmttabPnmj2TazNuRBudrHul9pkq
         2FHfdtJuCj3j2zoVKQoAQLmM0r6e/Tt21gd7yLkx9pRWnIm9LlDQ98fRRDIahn+YELDO
         FKeDPehLICcSoYShuEXky+6GlzOebVhBezQs76bZh9gipivWkcluiRnkk3vso0x4ucDB
         BjdcFJHNvF+R8k3V01+6KjBY4rE5SYtYBAhZMExsThYv3GGh2nlgojcjPUBBanT17oEz
         JqBIfy3/MH1J/RNYn1SXWSPSGfARON6nrjQaADmo7T2mOxpmJE888GywSIsP0H6oFgNW
         txLw==
X-Gm-Message-State: AOAM530wlXg6vad3b6PnbprdZrWkbwBDx62LoPOviyl3z4jjyA9tEinh
        oVcSidqgEGcmq64HLL2aWRhNp2rv17AHrx4uaQPmtVcuLkLUrPqvWIneQobp67ALFj7Vg+Cxeve
        F1CAZeMAQgCKp3bGOY2ap0iiWDZuK
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr2605716ejm.48.1631745293998;
        Wed, 15 Sep 2021 15:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZJrGZSlvJZDeNAgWKaufqGkjNdb1v/zNXE2aHdxS0gwiV/n++x4BlcgEyz1CR3FsYSoKbVw==
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr2605695ejm.48.1631745293810;
        Wed, 15 Sep 2021 15:34:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id dn28sm573547edb.76.2021.09.15.15.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 15:34:53 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1631737524.git.skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
Date:   Thu, 16 Sep 2021 00:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1631737524.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/09/21 23:28, Shuah Khan wrote:
> This patch series fixes fscanf() ignoring return value warnings.
> Consolidates get_run_delay() duplicate defines moving it to
> common library.
> 
> Shuah Khan (4):
>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>      warn
>    selftests: kvm: move get_run_delay() into lib/test_util
>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
> 
>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>   5 files changed, 26 insertions(+), 33 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks Shuah!

Paolo

