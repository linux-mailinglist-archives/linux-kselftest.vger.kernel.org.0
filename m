Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37347177199
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 09:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgCCIyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 03:54:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgCCIyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 03:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjsWUXqjUWqBSkSGCD4PbdKz2btlJQttY4xDooxfz/U=;
        b=ADh48kCNYCMHEDMMIE7F2ggKcYH6TV9UqPz9VPM/pbLe1ikNBRhKVVhqlyIo/sOTGKBbev
        hyS2IAI8pmIpKd/UxqCuA4Tb5YfM2us/WDmgaoL0MP37oYLCBeto878fzxXyY7voYv7A9p
        ohgTOT7Ojf8DsE9yD+uLsgay3dMYFtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Bx7qxOdqOOGGUsmeOjVhzw-1; Tue, 03 Mar 2020 03:54:15 -0500
X-MC-Unique: Bx7qxOdqOOGGUsmeOjVhzw-1
Received: by mail-wr1-f70.google.com with SMTP id 72so924177wrc.6
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 00:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OjsWUXqjUWqBSkSGCD4PbdKz2btlJQttY4xDooxfz/U=;
        b=gwZxv+mdST8YDL2XRg9S/Px3/9ElcdZfWt0270ZG/5KNyJCJnmrZA7EXJLP283jOnN
         TjKVlGgKApq8lr4vFmVeJ5GetH6dm14lDohB79kdlCdK9IbKgM1n1gYSLbkZ5nsQF8y8
         CzG4YUdhIfBRGC7+uLT5wyO9juMMJ+0HxEWUi772o1TdYB6nYdwFdQHbedE0cRi+EYvH
         PnINY33/awWRuoWgDZt998wsfBeOjrzFBpxtxIj9H++9JfITnYNTEdnS3kMA2lwcSLxn
         +SnHAp45PSuwlMZxLoD+jdz0hCGUh8PShi+2qAge7+6wksZBJXQOVX/93W3oxOo8QavR
         8Cew==
X-Gm-Message-State: ANhLgQ3oTO3Cyrx4Kc2uRrlSjym8uyl52GsPSQ6lIckJSBMEm73TqOUB
        X6qZwpRYpeLV1LJZ48B2ZJsT3eBxr/t34VsHPbAbdSOsUOjFwgy7vqV7eVI2bPrSjrl76B+HIqJ
        wl+JG8lmjUhi0AhBzks22bhE9yQbK
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4208155wrn.88.1583225653993;
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtxioLATY0Il+f/lYtoQmrW/DITC8fuFwFe+1VWyWHfMfdr9VUldKUP1b6K08oPMsyN/DiChQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4208133wrn.88.1583225653782;
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id t124sm3204441wmg.13.2020.03.03.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
To:     Jay Zhou <jianjay.zhou@huawei.com>, kvm@vger.kernel.org
Cc:     peterx@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxinxin.wang@huawei.com, weidong.huang@huawei.com,
        liu.jinsong@huawei.com
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
Date:   Tue, 3 Mar 2020 09:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303080710.1672-1-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/03/20 09:07, Jay Zhou wrote:
>  #ifdef USE_CLEAR_DIRTY_LOG
> -	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
> -		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
> +	dirty_log_manual_caps =
> +		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> +	if (!dirty_log_manual_caps) {
> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
> +				"skipping tests\n");
> +		exit(KSFT_SKIP);
> +	}
> +	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
> +		dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
> +				"%"PRIu64", skipping tests\n",
> +				dirty_log_manual_caps);
>  		exit(KSFT_SKIP);
>  	}
>  #endif
> 

Thanks, instead of this final "if" it should be enough to do

	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
				  KVM_DIRTY_LOG_INITIALLY_SET);


Otherwise looks good, I'll test it and eventually apply both patches.

Paolo

