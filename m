Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3051E590
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 01:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENX02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 19:26:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39432 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENX02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 19:26:28 -0400
Received: by mail-it1-f194.google.com with SMTP id 9so1590667itf.4
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hAH8vKz0SbQIdYNHsX3PVV+sy/lDevsJ/oN8uqEq6yw=;
        b=I8ZpdsRXDFIYfpwTIovojf2MqVTACOwVs8NPzhyQ3cT6+XLE6pCDc49kf1DxgNkDcM
         Qxra2yyjtj5UJ6+Oy+FxmLZ4tt9bMzPTyxVqhDWSAqs+48nK/c/+wn9KXSlL5ByTCqI/
         3Oa2/DpHvuerMiZgrzfb1DE9FYEXtBa6MnGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAH8vKz0SbQIdYNHsX3PVV+sy/lDevsJ/oN8uqEq6yw=;
        b=N+0upZXOOVjfj/msi2qbc52+WmQbDonNx5ccWPKUT7CI6Fd6I/2WjzJLVWX38UTfBG
         SoXNkRLoJ7KfvMbkH2E9lB2Mu910V9E2rVNb76msIAiu3FSmeAkVEb0ApcBoHn7+/+EW
         0uWewI3qXLLMBZbpjdRDwbJRS2pZeWnYg7zToaQir+szQqHCDv3dBqc0vfq57YWUz1Tj
         qiswfpqS2RmVdL8DJyR+64Ka6lXs0Q+MO/bOgw+9u/7MALvNk52y8EEMo3f2c2eV4nFR
         MdwEogVCVXMTog7MBMahFhKRUctc2husoWfgT+dxFE5Xn6AQZuzqL6172hCxQF55rkZh
         OyjQ==
X-Gm-Message-State: APjAAAWlb+NiuZSThzBjg1kqqD+1qi3AynxPeDdJuxMaXa4ctOUTKapT
        BVV87nr0JAjTR7vB1rcmZzlDpQ==
X-Google-Smtp-Source: APXvYqzz6wjr9rR0dcKYuIVtWRoyozIhVyv4pYB/pl9MYSqdpK8hRSYr6da+BpfHKegAj/ZOi72jzQ==
X-Received: by 2002:a24:5fc2:: with SMTP id r185mr6436229itb.43.1557876387377;
        Tue, 14 May 2019 16:26:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s10sm126380iob.29.2019.05.14.16.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 16:26:26 -0700 (PDT)
Subject: Re: [PATCH] selftests: pidfd: Create .gitignore to include pidfd_test
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0f3c65d-2b1f-3633-ee18-7d49d18eb7a5@linuxfoundation.org>
Date:   Tue, 14 May 2019 17:26:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kelsey,

On 5/11/19 10:57 PM, Kelsey Skunberg wrote:
> Create /selftests/pidfd/.gitignore which holds the following file name
> created after compiling:

This patch generates the following checkpatch warning.

WARNING: use relative pathname instead of absolute in changelog text
#85:
Create /selftests/drivers/.gitignore which holds the following file name


I fixed it and applied the patch. Please make sure to run checkpatch
before sending patches in the future.

thanks,
-- Shuah
