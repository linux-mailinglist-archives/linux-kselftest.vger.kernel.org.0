Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6D1EF651
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFELRH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 07:17:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23886 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgFELRG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 07:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591355825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzGbqSL35ilUIrPGSPIeyg9y7kmtyuP/TetCRHblnU4=;
        b=P4TfUdTrPc9BV9LOz20kRYmXWc4Ai80Y4fTFcbidFdZoyv+uygKAVWqrWTOLNZfXdLd1/+
        jkE1ZCCcHR2TAE1odNGm5QsdgkHQZtrNr7DT797qqaH0sk1F3HZXDpMa1wSaCWEHiqLksy
        9eoUP7biqwNhnAGE6ESDscSSvCUe8L8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Yg77fjzGMga2IGhkiB2fpg-1; Fri, 05 Jun 2020 07:17:03 -0400
X-MC-Unique: Yg77fjzGMga2IGhkiB2fpg-1
Received: by mail-wm1-f69.google.com with SMTP id l26so2899278wmh.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 04:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RzGbqSL35ilUIrPGSPIeyg9y7kmtyuP/TetCRHblnU4=;
        b=K+KyXGMtkMFmIrexQ9AXt9bEYC2rdswCevCXVAWCM1bBGyXewNvZW7cAzrbz4ht2Ot
         imGZRMK9p8Fx4++21Ufky6kO9gBWMz3xVxQelp3vY7/i1FllFalmsXyia1B2vOjSt3UT
         ddYDtVh5PSH6Cv1XucPwLLWAlK+Kj/q1sEeJQZSxCmxVjZfy8RqPwNdZNw2/LrYzMWRy
         Y++TX+8eIZaucpU7jVEpex3dxyFRHXOqCo2yFmONsLrSvX5DWWzpnyMymGO+lu0l9fmr
         i3GXd3TH6s/HIyerJqRym5gg1e+QbMQusXEbJ0OTl1Uo2JMaF5sddQ+9R460ZnX6diuk
         6hYA==
X-Gm-Message-State: AOAM531cjHn83yRNUDbEQ3dvP5GJGOZI5umCQfjfyzdAgHkO7UFVB/Fk
        BPXDBDcSwjg3j/l8whFNUIGYyAuXGHzuhP5ofW4A2lPdIkeJz69Tu0iiGke/sDjMJn63MidlD5P
        6Nlvml7ClrfRkoHQsUFqpyc8evM+t
X-Received: by 2002:a5d:684a:: with SMTP id o10mr8428656wrw.4.1591355822348;
        Fri, 05 Jun 2020 04:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoWCY4kIj3NwURBaGZZ95zPlotZFEwtkK4J/GiE+YPjhOoebb8RUzODqnboUSiNMmXSnQIpA==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr8428638wrw.4.1591355822101;
        Fri, 05 Jun 2020 04:17:02 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id 30sm11840903wrd.47.2020.06.05.04.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 04:17:01 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: delete some dead code
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200605110048.GB978434@mwanda>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
Date:   Fri, 5 Jun 2020 13:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605110048.GB978434@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/06/20 13:00, Dan Carpenter wrote:
> The "uffd_delay" variable is unsigned so it's always going to be >= 0.
> 
> Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 360cd3ea4cd67..4eb79621434e6 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -615,8 +615,6 @@ int main(int argc, char *argv[])
>  			break;
>  		case 'd':
>  			uffd_delay = strtoul(optarg, NULL, 0);
> -			TEST_ASSERT(uffd_delay >= 0,
> -				    "A negative UFFD delay is not supported.");
>  			break;
>  		case 'b':
>  			vcpu_memory_bytes = parse_size(optarg);
> 

The bug is that strtoul is "impossible" to use correctly.  The right fix
would be to have a replacement for strtoul.

Paolo

