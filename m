Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52B35197F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhDARx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 13:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236666AbhDARqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbN00XAl17jTfdcL36pqLI9NxKBduDGkH9PWAr5DUrU=;
        b=NA7tfk8lK4hC7pLvMwSJptvbr0OJxuI3NXf4Qtwxwb2H1XittoW+PsS0NM5ak6/P4QF7if
        9GAIQnb8yN3hbGSiq57CqTblGWI28FGJWnFHYEz9DYnmT6MU7HIscpOyGHwcRlmys0L9Ur
        jU0VpqvhIyFyOEpHixEtqKhd0CG8qHM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-PBaX2l-VPwKGEJjNxsmAuw-1; Thu, 01 Apr 2021 10:45:31 -0400
X-MC-Unique: PBaX2l-VPwKGEJjNxsmAuw-1
Received: by mail-ed1-f69.google.com with SMTP id t27so2960011edi.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Apr 2021 07:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbN00XAl17jTfdcL36pqLI9NxKBduDGkH9PWAr5DUrU=;
        b=g6otsT0GV2tsKvEd7M+NCjYz8caOwiX425f99zO+42JmAIruTUR1wcvqX7UNI5fer7
         3QMOgFdLLLHJoXhG6yd42O86Xo8WrtjG2ECqL+hrXpz+0VDd+KlQP3P/sJX/GuhKDTil
         nr5B9dTBH2QaMhpAL6nx0a6UhIuFByATe6C/sFmUAJdH66WzpMQhDxeYwY6kwUMkjIAQ
         +ZDrb4oN3vyPcI6cDbbLPFjU+J9wu/zcd1k377qEXhsx2ZZfVbZ4NDPyU+ozH0l6S2Ce
         1ec9+mG3cuv1ocoSisEj0vrvxpXEP2sAxnxsLsAaa3Tde7iBkvZvXzQdanZ3BqCR+4vz
         skQA==
X-Gm-Message-State: AOAM530oVstFOUN7I1wl6MgGrRTVBAgT2I936LKzUSaQvzGj3BDPimyI
        I0v66QI+7xgmW1IuJAi1vOX4hkRApSpA3XuyGPuLrjLc93vhzh0pTqiNoNsXrIB0gSkdAifs7is
        WwhFBNO6338Wyar4StRT/asx7tVE7
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr10314052edb.125.1617288330507;
        Thu, 01 Apr 2021 07:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0BiWLs8rgC3v72usoRnhjcbcl9AJPbTfNdkmdteh68PTju1z4CTFTvtjEovIrggDeSZOqqA==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr10314041edb.125.1617288330328;
        Thu, 01 Apr 2021 07:45:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ho19sm2798579ejc.57.2021.04.01.07.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 07:45:29 -0700 (PDT)
Subject: Re: [PATCH -next] KVM: selftests: remove redundant semi-colon
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20210401142514.1688199-1-yangyingliang@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1f44dca-a703-e68f-ec29-0d14671c2e6e@redhat.com>
Date:   Thu, 1 Apr 2021 16:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401142514.1688199-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 01/04/21 16:25, Yang Yingliang wrote:
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index 804ff5ff022d..1f4a0599683c 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -186,7 +186,7 @@ int main(int argc, char *argv[])
>   		vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &st);
>   	}
>   
> -	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);;
> +	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);
>   	rs->state = 0x5a;
>   
>   	for (;;) {
> 

Queued, thanks.

Paolo

