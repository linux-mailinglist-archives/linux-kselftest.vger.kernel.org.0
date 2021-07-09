Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431C3C27F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGIRG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhGIRG0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 13:06:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E6C0613E5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jul 2021 10:03:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id j10-20020a05683015cab02904b568e08dccso3919983otr.4
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jul 2021 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YK7jJxbOZAuE7pVlknkPFwr7Jcd4jJxXltp6+8MxV5k=;
        b=AWizmOE3raapwrlS3wvVw/oI5OJoo1PxO36Y3BtGnJpK0VTaTlKByhE8QBIeE1uzTd
         TCV+uM4qI4IMgTnQd6JxCDuay+LnHVRYT1ECf7XFvSe/T7D7JDE3VhOFGpXhOZETjt1t
         lI5Rmn5sJuBQL74che+B4S30uzdYdJQKZ1XKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YK7jJxbOZAuE7pVlknkPFwr7Jcd4jJxXltp6+8MxV5k=;
        b=OzJi0wo27Eiy3AdpnRkuyv8DegFw5n+4zmZERBv5n7acvIFgY3qhSsG1b6o7MS4qAx
         tNmB8aJ+xhDpgVXLj9nFTa01CBni12hF++d0NwAIR6OVRni4fNbfRdfjpVgEUGCzXRBD
         I4FmrPl1381SRIOn23ePiu/puonRryOLQhexuJx6nSyZeByTT6FpXGF3v47g2zwK1Fcn
         yTQHC8S95IuxYjIt52kdbtWEfNuHyLtYpAqVZKVOjjOqgwK1m9SPTQKSs3VvnpJiYrNC
         VO5qMvnRFWXwp1rq0g3vN/wcVudH2miSpmdKuI4cKgphI75S6wC1yoiwR8ZWDqnVU5O0
         pBMA==
X-Gm-Message-State: AOAM533/0UtuIelJBuwlyIQR2DfmZjdOvf4HyVBjbc2D0KyLHhFXZUYp
        EBZ26QFGf0WW202/hH93VHno3g==
X-Google-Smtp-Source: ABdhPJyREhIlHxFR0Am2IjUQXMRO8/xplN/tp0+t0WZlG/C5Srd1cEbGm3xrjpD02qS2DkGiAOx9Aw==
X-Received: by 2002:a9d:2781:: with SMTP id c1mr28732408otb.34.1625850221514;
        Fri, 09 Jul 2021 10:03:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j5sm431609ooo.22.2021.07.09.10.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:03:41 -0700 (PDT)
Subject: Re: [PATCH] selftests: memory-hotplug: avoid spamming logs with
 dump_page(), ratio limit hot-remove error test
To:     Paolo Pisati <paolo.pisati@canonical.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210630145740.54614-1-paolo.pisati@canonical.com>
 <YOhIainrHwydNrGh@amaterasu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <78e2f6eb-6147-6fb5-b093-9534f5b36032@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 11:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YOhIainrHwydNrGh@amaterasu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/9/21 7:00 AM, Paolo Pisati wrote:
> On Wed, Jun 30, 2021 at 04:57:40PM +0200, Paolo Pisati wrote:
>> While the offline memory test obey ratio limit, the same test with error
>> injection does not and tries to offline all the hotpluggable memory, spamming
>> system logs with hundreds of thousands of dump_page() entries, slowing system
>> down (to the point the test itself timeout and gets terminated) and excessive fs
>> occupation:
>>
>> ...
> 
> Anyone with spare cycles could review this? It got one ack already.
> 

Thanks for finding and fixing this.

Looks good to me. I will pull this in as soon as the merge window
ends and 5.14-rc1 comes out.

thanks,
-- Shuah
