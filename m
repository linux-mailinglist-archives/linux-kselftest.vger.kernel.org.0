Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3769166B49
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgBUAGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 19:06:50 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36283 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgBUAGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 19:06:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so216000pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2SZEgD5g5TBz11BF0RQOXvwvVsuErja6hQBhQx9iqtI=;
        b=YaGJ1WcJmrZ9+UccHzdSAh0ocSCrEkLtIKG+wxpLLF5UCP4a9dn/4qDx6NEQEadWCH
         K6NzCNrgRJZaIu8hAHddRJAPGjbZSsZTwPOdqZtEpnYEay7Gouyomz3ZPxoyE78CDS+Y
         0/yJ9nzBOwSj/1cvAmJByGdfRF82SHRVeKCiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2SZEgD5g5TBz11BF0RQOXvwvVsuErja6hQBhQx9iqtI=;
        b=sJYuRTOVTrNLB0ECDTb+/EWB3jfKoMlI/LRsAvJROWlg7HZ+fm4JGF5oQa/KuDZm1T
         n0aFaj7yi7RYJaKpkg9F3Lp6xLwM3n3j7bGYufFKzG8n3LTahAKYfXU7iO+EbyckJ8iV
         aOXSILods8gCbgBufiRj2VDVb3KFgzxp3L5O91Opb3mth4S5Rub0ObtWhvqAuB8f/TtX
         uYVgFP2nTubj5EcEZshsCL0NrX80cDRFffn07nsl7GY1DBOIv21LIlmnvYPSsbUOW86b
         +a6PNCSPfCeBau8rrzBrdTwy73PFnZnRGbUaI+OC1O4Cj1OI0QNQxNOutMGBtuhqhidE
         i8eQ==
X-Gm-Message-State: APjAAAXdlg/ta39pOZSJrPyhAQxTYp4RV083mgcC1szbZLm4AQ7PWY8q
        KQlB1wnH+96Nmi/Vd193wNVkJw==
X-Google-Smtp-Source: APXvYqw9fUeVqImRN3Q03UIMQbkuQySGlRq4FWfWYNUs3nc8AjQHb2oXb636cz8lJotP6M35Bxu35Q==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr6523527pjw.43.1582243609242;
        Thu, 20 Feb 2020 16:06:49 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x10sm706267pfi.180.2020.02.20.16.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 16:06:48 -0800 (PST)
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <827a4520-95ce-5264-90d9-ed730e5918e6@infradead.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <22c48aaf-21e2-56ab-3f40-e497a69cd936@broadcom.com>
Date:   Thu, 20 Feb 2020 16:06:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <827a4520-95ce-5264-90d9-ed730e5918e6@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Randy,

On 2020-02-19 5:04 p.m., Randy Dunlap wrote:
> Hi,
>
> On 2/19/20 4:48 PM, Scott Branden wrote:
>> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
>> new file mode 100644
>> index 000000000000..c75dfb89a38d
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/Kconfig
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Broadcom VK device
>> +#
>> +config BCM_VK
>> +	tristate "Support for Broadcom VK Accelerators"
>> +	depends on PCI_MSI
>> +	default m
> Need to justify default m. Normally we don't add drivers as enabled unless
> they are required for basic (boot) operation.
Will remove default m as not needed to boot.  Interesting other offload 
engines misc/ocxl/Kconfig and misc/cxl/Kconfig have default m.
>
>> +	help
>> +	  Select this option to enable support for Broadcom
>> +	  VK Accelerators.  VK is used for performing
>> +	  specific video offload processing.  This driver enables
>> +	  userspace programs to access these accelerators via /dev/bcm-vk.N
>> +	  devices.
>> +
>> +	  If unsure, say N.
>> +
>> +if BCM_VK
>> +
>> +config BCM_VK_H2VK_VERIFY_AND_RETRY
>> +	bool "Host To VK Verifiy Data and Retry"
> 	                 Verify
>
>> +	help
>> +	  Turn on to verify the data passed down to VK is good,
>> +	  and if not, do a retry until it succeeds.
> No timeout on that retry?
This is only enabled for debug purposes or fpga workarounds - no need 
for a timeout.
>
>> +	  This is a debug/workaround on FPGA PCIe timing issues
>> +	  but may be found useful for debugging other PCIe hardware issues.
>> +	  Small performance loss by enabling this debug config.
>> +	  For properly operating PCIe hardware no need to enable this.
>> +
>> +	  If unsure, say N.
>> +
>> +config BCM_VK_QSTATS
>> +	bool "VK Queue Statistics"
>> +	help
>> +	  Turn on to enable Queue Statistics.
>> +	  These are useful for debugging purposes.
>> +	  Some performance loss by enabling this debug config.
>> +	  For properly operating PCIe hardware no need to enable this.
>> +
>> +	  If unsure, say N.
>> +
>> +endif
> cheers.

