Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F054272A1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIUP3X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgIUP3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 11:29:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2034C061755
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Sep 2020 08:29:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so12734216otr.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Sep 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/Sp8/Ct7t0ZTiq1Xr0Yocof5/M/e8jbq9qWgWA4x1I=;
        b=fcFymVWCDK1NTSyUb0xYTXZXCOJSiWx7LgjazN3/n2MgaUERF1raIUFCopnvzcpvNq
         j/AW1gV3h3BAm/tQMCSsJ7dCpWNG4sFqAjbBB2TXc9yAHFPXmdivczyAMeyRbdKb9TNr
         aH5zORPXPEYR7YOhUNvxPT8mq+uBLAvxxDVUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/Sp8/Ct7t0ZTiq1Xr0Yocof5/M/e8jbq9qWgWA4x1I=;
        b=B2kCrVRulpbhoezJJQRCR4KM4H1lJTlI0gHuqdYYglfdj3R+mvKADU9q+iHd9uOj4u
         XeMpXFARDQxt0TtVlywwuSWeh2qntDoRz3A/Ccicb70Sm1YvpOPdC8zEN9WOqoG3J/B9
         zbbU5acc8/v6p3RFhHNUmeYyIVF5mvIBvRRp41Qhf4RfGrxh3WlyOpBN3Ghpz/ByRtzp
         /Ltdch2AplsoWVtgGBSE8l1A3NQiM6boqHgYyC+L6GN+osBdAUX9IHP2HH+VCe2OYhIE
         wEQEa7QpySrsju72Y8hCaAnkUwi2gNfDHFMTauLSQUva/VVIRq+uGCN8Ez2PhvOEIVrd
         HIVA==
X-Gm-Message-State: AOAM530Hl+9yWPGwL9L7do1vwUmg4vj+tVpCOKzeWeoLwJ+62vwN3Px8
        NZGJtQeraaflWUejASu2s6Qyuw==
X-Google-Smtp-Source: ABdhPJyqazFYF2ucxlCKuEevc0ZSkdHJS0HdqX/Gzk8DgpBEXO97wcLIEdqCqGtSsYMHbQm4BpTqCg==
X-Received: by 2002:a05:6830:1f03:: with SMTP id u3mr17622otg.365.1600702155178;
        Mon, 21 Sep 2020 08:29:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y7sm6121410ots.11.2020.09.21.08.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 08:29:14 -0700 (PDT)
Subject: Re: [PATCH] selftests: Add missing gitignore entries
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kernel@collabora.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200905053139.3769803-1-krisman@collabora.com>
 <87a6xkf1hm.fsf@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b6ffeb89-044e-5f3c-5672-7de7edfbfa27@linuxfoundation.org>
Date:   Mon, 21 Sep 2020 09:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87a6xkf1hm.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/20/20 5:54 PM, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> 
>> Prevent them from polluting git status after building selftests.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Hi Shuah,
> 
> Friendly ping here.  Thoughts?
> 

I can pick these up.

thanks,
-- Shuah
