Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF5217DE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 06:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGHEHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 00:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgGHEHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 00:07:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6031C08C5E1
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 21:07:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so44358926wrw.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 21:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DmAnW+aNGSPXA4C+WrMJa+vZ8I/2yjEhwhvCqyjrf7Y=;
        b=fCztVvNuDI1vxwSHFZrzUHl20rgV2FUL9YtFDf6ClChW8eytN1eZvcQPgEg9UkhzrD
         qTflp5G7V2JknyBoAT2rmvgi7qvLrmQPysDBRPDhcX3y7r1iXblAx3davUCG0hQe/ArX
         CDzlhKWrcFFyh79S3f5faVfWQayMukqk7b5RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DmAnW+aNGSPXA4C+WrMJa+vZ8I/2yjEhwhvCqyjrf7Y=;
        b=ZTYrFRPcjAy8OG9UJ3IFok8uWH4G/XqI/Bbjjz7Yu2Sley3wuR9TtIm3JIdoIeD7+0
         pKXnU5XvJlPlGJWCljsbwjvGH39//BUsNg9pSK19Xjo+lHyht3PvBgiqMJqwJUsyZwV/
         Jf0ov/Sl9hIJnZTXRIITauSDRXjDL0+zpDexrHCIc0u/MEQE8migrviKlO1SJZg1JZ8j
         M5uDAsuRiiOZJhvwkvr9xZ0PM/guG1exQhuLahqg8+pPtAHhRrz43Q3eRDZQazlC5AQA
         SiP0Fm7ItCUEtjAuZ2yU3CaRQuFkmFsQylxg4Peujdu+QqVCWhVfXO/LqQwmelLvLUGp
         15gQ==
X-Gm-Message-State: AOAM530U5e5+7dbq2Q4ODjt5rRF1FxYbU1Rc8qq3FEKQN/9m0l31tqLQ
        4/S7qWlUhK72pPq/Miknme5Eig==
X-Google-Smtp-Source: ABdhPJyzr90jOVAoqFWvMEUHYTnBp5r5AE5rgTXyXvuhrlE1JUT/h/4/UApapPz2oWQxlhwEWPjRgg==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr53961498wrx.332.1594181233107;
        Tue, 07 Jul 2020 21:07:13 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 1sm3703411wmf.21.2020.07.07.21.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:07:12 -0700 (PDT)
Subject: Re: [PATCH v10 3/9] firmware: add request_partial_firmware_into_buf
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-4-scott.branden@broadcom.com>
 <202007071657.55C2CFA57@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0681c21c-b2de-068a-76f3-965cecfbf93c@broadcom.com>
Date:   Tue, 7 Jul 2020 21:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071657.55C2CFA57@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2020-07-07 4:58 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:03PM -0700, Scott Branden wrote:
>> Add request_partial_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
> Just tear out the differing "id" and just use FW_OPT_PARTIAL and I think
> if Luis is happy, you're all set.
>
I hope so.  Also, I will need to call 
kernel_pread_file_from_path_initns() if FW_OPT_PARTIAL is set
and kernel_read_file_from_path_initns() otherwise to avoid a swiss 
army-knife approach of calling a common function with multiple parameters.


