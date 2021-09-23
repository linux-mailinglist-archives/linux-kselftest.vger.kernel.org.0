Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812A416135
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhIWOlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbhIWOlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A66C06175F
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 07:39:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x2so6807561ila.11
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipddjsuaxiI/286Gm4qQfceIdGUHDBcUdts4yKeCSH4=;
        b=uHYx8lMBcD3fdcBCoAhrmnl4hqnthU6myTzNsuLBS41zx+AqXblbex40h1gs0amATB
         ytAxAfRYGJCxEEEZ8nUjC7HLIt/MSp6hWb7eL7ZvBSAsyS+8sdNsc/t/jmDtUM+vkNpF
         a4s00ie4KO9obs+cSOMmuycxJsi5I9ukm4x0BeZ193Yj/u7k5bXAdaucOC49J6yXR9Vs
         RV7BB+tM0IITyprJH1F0M4vIhD0CboqhgrfYGnaDMNemQ+tE30lmGrJ4LDyMUVqT69qT
         M1fiLKBUAbt4LnV7UMFOn//p4SEft0ZcO5NINwbZfiHnCUulSxpPSZtpg/naRBkJL91T
         kunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipddjsuaxiI/286Gm4qQfceIdGUHDBcUdts4yKeCSH4=;
        b=26P94QhizZllm+HY2gjJ5/zlAjR4HVKxRwbMjjrJ05r5LilX53SIAxDyfh/KPrcOq4
         EsdPBXwyDE3yHa/qUOg0zfyyiMrrMNvyQzd8hcgomtZilYBqiKz2AKp4x0LZ9FmdXzb5
         RNjvE/1ZrYhiiR+8p0zF1JI1sqw2MG3D3Ms4MddShfxyWDpmF96kcCcG5ewFgYmaZxuj
         Hx3Jvj+ULTyVSpGms0zYe3Cux+Sjp95IbzBNo7Zkur4npzZSItNeiXqZzoA813w+8yJ/
         DLFM2s6iwfy8kI30R2ixT7En+/rYZXlPQQ7A+zUi6XYnpW9+4iUHaQaQHzppNJhEpOd8
         T3+A==
X-Gm-Message-State: AOAM5324Pc7E71usfdEo/92uAl3olAJMicERROoKkAQXDqLmXpeAf5lD
        vrds7t++QVvao//lIrWVPRdHrYPZB1v4xMwqQoU=
X-Google-Smtp-Source: ABdhPJzsOYhSeJ2qNXh716/hXIZ2FZll7ocgoOGbyeZS58c5agnlM8KEzaSe+yFSmFDdRInBy5omkQ==
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr3930805ilv.309.1632407973711;
        Thu, 23 Sep 2021 07:39:33 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d12sm2297274iow.16.2021.09.23.07.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:39:32 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecf3cf2e-685d-afb9-1a5d-1382714cc60c@kernel.dk>
Date:   Thu, 23 Sep 2021 08:39:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/13/21 2:01 PM, Sohil Mehta wrote:
> - Discuss potential use cases.
> We are starting to look at actual usages and libraries (like libevent[2] and
> liburing[3]) that can take advantage of this technology. Unfortunately, we
> don't have much to share on this right now. We need some help from the
> community to identify usages that can benefit from this. We would like to make
> sure the proposed APIs work for the eventual consumers.

One use case for liburing/io_uring would be to use it instead of eventfd
for notifications. I know some folks do use eventfd right now, though
it's not that common. But if we had support for something like this,
then you could use it to know when to reap events rather than sleep in
the kernel. Or at least to be notified when new events have been posted
to the cq ring.

-- 
Jens Axboe

