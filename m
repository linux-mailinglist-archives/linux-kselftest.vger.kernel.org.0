Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE52940304F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhIGVbE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348635AbhIGVaF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 17:30:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DEC061575
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Sep 2021 14:28:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n24so369970ion.10
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Sep 2021 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQ1QKlOMUxMJjspXpCNHZjX329YTQj9Uc23PyYscxxE=;
        b=FbO+pDJXDBkBjC1rlKAdQfQgfh08Xa3kp6kg4kr7w0Y5RfqJlJsZJaWhpbBQz8nQqc
         keSp3KjF48yyjtGYzivaNDwdC5pmNPDMlXgcahzEhY/BtqEdJRNRPSFOYLUsZ498FeFY
         NucFj/hNQX432SYJKtlG1bl88o+Q4HvaC23zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQ1QKlOMUxMJjspXpCNHZjX329YTQj9Uc23PyYscxxE=;
        b=BjKD/I3iQvvaBhVklAia5GQiuUu44Affon/+acY8N71Sr26Jch6c1Po578+y3AcpnO
         0xUeVCgA782F7JI3bP/ozaDI2p+PlhxYPxfSdzPpqkam4AOR9e6a154ncOaIS1oeu5UN
         vEdaU1vqPq4vqTHMuA/afi2JE8SIyRI9tJzjdujgp4kHqG4ztBoPahfcXd44Ugu1vhD4
         6q8hZMNPKo8Hrs5msXPPU9M4Sf+SrLyISCpvroVJrPfGKvFolhPF4ZyvXyHbax6hoZh2
         iXL7FFIMPSELVUqSTwrLOJDXpS7CVwKj2uqPd5g/Z9qGjI3KcvYSfDLEbAG8uAXqnDxp
         LDcw==
X-Gm-Message-State: AOAM530ODxxoj3NnjwNN4xm5csah1m3gLmK+7/zJ6Ie1de0Q96VVR/zt
        ou+Pczim2WbOO4WXVMAm3qx4eA==
X-Google-Smtp-Source: ABdhPJzq6xHc9ICyXPhNWoqmW3TFqPqfpQwhKPYhzkwAjJos1JLP7WLlq4mXoHgNUL0MH3n/iMByWw==
X-Received: by 2002:a05:6638:4104:: with SMTP id ay4mr397781jab.10.1631050134251;
        Tue, 07 Sep 2021 14:28:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m13sm140087ilh.43.2021.09.07.14.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 14:28:53 -0700 (PDT)
Subject: Re: [PATCH 5/5][RFC] selftests/pfru: add test for Platform Firmware
 Runtime Update and Telemetry
To:     Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Dou Shengnan <shengnanx.dou@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <1cef405de3484eef108251562fbf461bad4294c7.1631025237.git.yu.c.chen@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <82889db2-1927-582d-c27f-b1f0927ca903@linuxfoundation.org>
Date:   Tue, 7 Sep 2021 15:28:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1cef405de3484eef108251562fbf461bad4294c7.1631025237.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/7/21 9:40 AM, Chen Yu wrote:
> Introduce a simple test for Platform Firmware Runtime Update and Telemetry
> drivers. It is based on ioctl to either update firmware driver or code injection,
> and read corresponding PFRU Telemetry log into user space.
> 

A few things to consider and add handling for them in the
test.

What happens when non-root user runs this test?
What happens when the pfru device doesn't exist?


[snip]

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd_update, fd_log, fd_capsule;
> +	struct telem_data_info data_info;
> +	struct telem_info info;
> +	struct update_cap_info cap;
> +	void *addr_map_capsule;
> +	struct stat st;
> +	char *log_buf;
> +	int ret = 0;
> +
> +	parse_options(argc, argv);
> +
> +	fd_log = open("/dev/pfru/telemetry", O_RDWR);
> +	if (fd_log < 0) {
> +		perror("Cannot open telemetry device...");
> +		return 1;
> +	}

Is this considered an error or unsupported?

> +	fd_update = open("/dev/pfru/update", O_RDWR);
> +	if (fd_update < 0) {
> +		perror("Cannot open code injection device...");
> +		return 1;
> +	}
> +

Same here. If test is run on platform with pfru test should skip
instead of reporting failure/error.

thanks,
-- Shuah
