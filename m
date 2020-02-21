Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94EF166B5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgBUAOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 19:14:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34909 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgBUAOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 19:14:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so104976plt.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j9NfYN7oFcDu+7se145xCzZu7AyP4VVa9xyrU8e8kGg=;
        b=XWxniDG1LOh43SJp7z2UJovq9YWn0rOeMwHcyEGODF0mipdAE2OM29lnoAol7jNm2k
         GxF8H2F583pmx5hr+jvzunS+dWiBD7ZKqR0kswOHWmaIKeJ1zv2SoF3BHniIwkFFazT3
         aHPsj7/ErkiG7rXIa1poz4II56IxQtU96xc+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j9NfYN7oFcDu+7se145xCzZu7AyP4VVa9xyrU8e8kGg=;
        b=NZSZac+9ABCH9X3iSC6jZJy0vnaaox/Dd1RxPVf4ECv8/+sGNS3SDbh5zDkVB9k5Wk
         9GLCpJsE+zAHBS2zRhKGQe5LpPU+qHZl1nXDgHJhJ71U1dTJdrI0p2DXZJC0HJ5uba6B
         NK2g9zHMH5RQZ2bZ3ATlegz5MSWo6ZTUK+KStdNBmndXqlVDcMublpYo5Wai+agQYDBe
         2d98s4dGsOMXFhwpYpm/NzGSq4TJPCcWddyvYaKzNgH0uke35QI8U0ijCPygPuKYZBqN
         /web2YQNBZohV0h4fHySaKyDWLq80UnzzvjUoJmDE+NFhSHZYHqJwi+5zQfSDI2IPAI4
         i5ew==
X-Gm-Message-State: APjAAAVNHuiMBmk2DZIzYoxkAMjB7/6x4fRFy8s+eQuM6EHzaQWKtQ3Q
        gH4nHUBaogdfcaunmhz2ol0XuA==
X-Google-Smtp-Source: APXvYqx25cvFDEfSsVWYxxtiPJ4i/HB4cCqI6AWGUOOODbhBmUcXo4ZQNzLPzimdl5BHFsOLWIwruQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr6400987pjg.111.1582244061214;
        Thu, 20 Feb 2020 16:14:21 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x8sm701336pfr.104.2020.02.20.16.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 16:14:20 -0800 (PST)
Subject: Re: [PATCH v2 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-3-scott.branden@broadcom.com>
 <20200220012235.GU11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6a810f3c-3e17-fba6-b00d-4333ffa2ecca@broadcom.com>
Date:   Thu, 20 Feb 2020 16:14:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220012235.GU11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

On 2020-02-19 5:22 p.m., Luis Chamberlain wrote:
> On Wed, Feb 19, 2020 at 04:48:20PM -0800, Scott Branden wrote:
>> Add offset to request_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Thanks for following up Scott! However you failed to address the
> feedback last time by Takashi, so until then, this remains a blocker for
> this.
>
> http://lkml.kernel.org/r/s5hwoeyj3i5.wl-tiwai@suse.de
>
>    Luis
I responded to the email query.  Hopefully this addresses your concern.

Regards,
  Scott

