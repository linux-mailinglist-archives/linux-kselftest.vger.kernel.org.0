Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D992CCA2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 23:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbgLBW7Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 17:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgLBW7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 17:59:25 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F214DC061A47
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 14:59:09 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so180958ilb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mseZ6HqpOaxIPoGJwt8mt2yChrOXFzD/3kFw06Juct4=;
        b=hfu1TJ5/FWuZCgIbvtJbzPxMZUMTTPpCYUSRixRQIbnINFXc+KpyD55xVuCveLb/td
         yej/IbMTjxZ/+aR2ZBJPoSU8Q8wtyCXRC+dBnJBZrqokm9Cqggv2UhGAdTaLRrKpLoCr
         MLWrXRhiiUthOFX06zAb50sRGusEmZ43pMd1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mseZ6HqpOaxIPoGJwt8mt2yChrOXFzD/3kFw06Juct4=;
        b=ZxiCVvOswpyLaHQTPWqnSIqNP4f7u1Kx6wUOyGfT9E5yuAkszAf9ac6akbdQpLteBY
         RCLQ/vDl0g8ddOVmFefd64cERfSsjiKT/ynqSeextmlTFBAIdsU3G0LdnE1JE5SlN6oE
         PDe7nzCpJQH/upIl2bOKfSmaTbzOQYj/7t4adt9FpTpfzoc9BGe6KE6QoFecugsJysk/
         ldZ1RPcVwUDFyLnDL6KsTOF74cRQnug3KR7aX9/0RkypsxDud2h2B9+hW2NcLKxlABzg
         URNPDb8HBiwCnvcuAl6I6vTAiR+O22IsLzVfpwg3wzkr1DczT4/0PDoW6gPHDW1uqliu
         SAgA==
X-Gm-Message-State: AOAM533HqcKdVGOv+AWPbs+VWJYO5+kmrg7z9puTaE8sJehaiZFWP2Fj
        ZvAHdy+f9NVd+5MEMwj1Okq/ew==
X-Google-Smtp-Source: ABdhPJziJ8mfyelB2fg3kxZvhv+Eul+12x9D5wfaeHlaNRok6QkYABL8vvJerFHYvi2rxcNcHGQECQ==
X-Received: by 2002:a92:6410:: with SMTP id y16mr312945ilb.126.1606949949439;
        Wed, 02 Dec 2020 14:59:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n77sm98392iod.48.2020.12.02.14.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:59:08 -0800 (PST)
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, elver@google.com, yzaikin@google.com,
        adilger.kernel@dilger.ca, Tim.Bird@sony.com, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <20201116054150.211562-1-98.arpi@gmail.com> <20201202160742.GB390058@mit.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <161a322e-e7a0-1b2b-d321-4f2871c31e0a@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 15:59:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202160742.GB390058@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/2/20 9:07 AM, Theodore Y. Ts'o wrote:
> On Mon, Nov 16, 2020 at 11:11:50AM +0530, Arpitha Raghunandan wrote:
>> Modify fs/ext4/inode-test.c to use the parameterized testing
>> feature of KUnit.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> 

Thanks Ted.

-- Shuah
