Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079881998AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgCaOhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 10:37:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37551 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgCaOhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 10:37:07 -0400
Received: by mail-io1-f66.google.com with SMTP id q9so21944823iod.4
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Mar 2020 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xcYSe7+W5XBsRVk1odBd6yYO30OBCGBeOkC3qcfJ1ws=;
        b=dhGPwewuQRSMAnqIV6kTDUrdfW5Sk7f9JU2o/igGLUfK4BghM6VjQJzHLtoCAoSyB7
         mAU9BOaoahXk6+UGvuVa5LAVtJOb4NhCgqMynAWtxX11uxrWfPJKJwWIvfsez+Bv5h5X
         EDJOh146C6KH+PMVyLUz74D4hOdiq0JFA9u1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xcYSe7+W5XBsRVk1odBd6yYO30OBCGBeOkC3qcfJ1ws=;
        b=CWjMpEIEIuwsBdt3Mci7lXeVB8DJh/S1UyUecJT4Sl2Su47IMLXkEVPJKONd6DhMaa
         IjRfB5cJdieizEvhXWghyH1zsMzgBlFsHurjzKioogrEPemn5uWdxh0ImYYC7Xpi2XGK
         kZKOdCW2jQExDlzkxXI3F/5oAULJsINdivPID9bN6tp4+nO9R8cVu5AN3+KHpLbxbWfp
         Aw7fqZvMZF0E1Lqd+qBDOa6Ajr14XVeXFV3Qb0IdQR2W0/3AltgDrYu1ah0XzSck5MPx
         cbQOQIo9turW2SlNO5WiR+TLSwJKuy56TzkwOns1b5NQp101N6hMM3n9Ca4kkVcB22Xp
         I3Ug==
X-Gm-Message-State: ANhLgQ3C4EYuPgevYwH/fB5zXuszoUA+VjrAJ8fh2fsZwHnKYLiwjYsa
        WS63Phsiah4ZBkvUCSpwb5WiHg==
X-Google-Smtp-Source: ADFU+vvFo0K715WJDvf8EpTyd0A6KVqGqaygop9ZkRGtQb9RlqEE1CvDKrsTNtWfNl+U5m+LhTFmzw==
X-Received: by 2002:a5d:9648:: with SMTP id d8mr7030743ios.115.1585665426753;
        Tue, 31 Mar 2020 07:37:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d70sm5972625ill.57.2020.03.31.07.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:37:06 -0700 (PDT)
Subject: Re: [PATCH 0/2] selftests: vm: Build fixes for powerpc64
To:     Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhiramat@kernel.org, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, kamalesh@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1580367152.git.sandipan@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4837525c-c078-0e33-614e-103514946ff9@linuxfoundation.org>
Date:   Tue, 31 Mar 2020 08:37:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1580367152.git.sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/30/20 12:01 AM, Sandipan Das wrote:
> The second patch was already posted independently but because
> of the changes in the first patch, the second one now depends
> on it. Hence posting it now as a part of this series.
> 
> The last version (v2) of the second patch can be found at:
> https://patchwork.ozlabs.org/patch/1225969/
> 
> Sandipan Das (2):
>    selftests: vm: Do not override definition of ARCH
>    selftests: vm: Fix 64-bit test builds for powerpc64le
> 
>   tools/testing/selftests/vm/Makefile    | 4 ++--
>   tools/testing/selftests/vm/run_vmtests | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Michael,

I see your tested-by on these two patches. I will take these
through kselftest fixes.

Sorry for the delay. I assumed these will go through ppc64 or
vm.

thanks,
-- Shuah
