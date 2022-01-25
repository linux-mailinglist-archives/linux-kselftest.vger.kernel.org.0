Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E88649BD7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 21:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiAYUw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 15:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiAYUwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 15:52:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1EC061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:52:07 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id i62so9525436ioa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCJUq5jHgfkgVNsby7KQbTGRdgGOLVS/mZVDvuvbVQM=;
        b=XDtRUAzCdycPSIlpf0grik4f8dPgS2/nusSo3wILEaRv793kD9AXzo4pKaWOqWar/f
         uxh7UJmUzs4kR724KcwWUgC0Y+wcTV9abtTgnE3RxAl/iMre3I89ECkvpFucq7R65eRi
         oUrt6KoJedPddvKQOmpMOTFPz6TYCTmsgInrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCJUq5jHgfkgVNsby7KQbTGRdgGOLVS/mZVDvuvbVQM=;
        b=OjV3ivoTVbvw42Yv3EDxZyPJdPSrwMGiXDI9ktVVD+fiKV7YzEiSzvYA49neb55f/p
         AofjreXpWOS6PHxSZ6r4R47RbW7MtHn8qgKQbC7oUNcPjQ0GI30Wy+iIQwSKvzYL2/Ok
         8dv40GVr4PwZcVnNTsv/56mcNPorMt8NqsoJNQz6TPgfcnltBXHII2LaDHVW8Q+7WMSm
         QjuemCJrAQya8q3SGCRZB94W/bfRuW5Ml9/L5FeLxIHKUHm2ovh510wLKeVhpsezXK/s
         l8ItkN8iVStq4ys9/e1eoQHZM3wK9kNVCbbl9f9Hk1zYmG5LgUi1IzPWlxOGgrZVzuXQ
         A7Qg==
X-Gm-Message-State: AOAM532iB14WWLz8S86akOuWP+RbDU4BaIUczRd8jbj+Dywg3lRg9PT+
        76uMCtydeEoEBbigQ/6b2xXlRVMi4Z8q+Q==
X-Google-Smtp-Source: ABdhPJyjdSeD5XUu2Mr1BnYKELR7qedOQe1LHbs1/7dxduM5uthKYktGexZ5EoGuH31VcQ5SL4t/JA==
X-Received: by 2002:a05:6638:3009:: with SMTP id r9mr10016866jak.262.1643143926581;
        Tue, 25 Jan 2022 12:52:06 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id q16sm8238668ion.27.2022.01.25.12.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:52:06 -0800 (PST)
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Petr Vorel <pvorel@suse.cz>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <61DFC646.7060707@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2055a76c-f50a-467f-e1ae-e8b8496a4911@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:52:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <61DFC646.7060707@fujitsu.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/12/22 11:26 PM, xuyang2018.jy@fujitsu.com wrote:
> Hi Ping
> 
> Best Regards
> Yang Xu
>> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram has
>> switched to per-cpu streams. Even kernel still keep this interface for some reasons, but
>> writing to max_comp_stream doesn't take any effect. So remove it.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>

Reviewed and changes requested.

thanks,
-- Shuah
