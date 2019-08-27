Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7D9DA77
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfH0AO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 20:14:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42557 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfH0AO7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 20:14:59 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so41849525iob.9
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+QMCinwwBEDqKLCmDU4DlJ6py1ELvU6M8qGgkaHN8sw=;
        b=aCPbHhxoXL4tzq4ideSgYvCJLLRssa4FaK69iATvTb/eoxm/kuRpEGKmnnD6Odc/Mr
         LGxjHF2v//lCnJOXFnva7cWO9WtN68CNjU44RYnJAp8Ui+VpTtLqUKrpPix2zZCqoffq
         FcllTBQIKVbx4qt2+lEAud/Xw61AEt6rk9L5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+QMCinwwBEDqKLCmDU4DlJ6py1ELvU6M8qGgkaHN8sw=;
        b=qVQXK35gmioICn/TGnybtU809eXgFHODX8QrY0JNnHJxuOVcySbpLchsqTjtje4ZLw
         ur9bl6AHTDIE5JAYvKVWQpOYLbYtxGliTdFlK6PkJDOxNLaof/dMHR9AVJPLx79ptmj0
         mx0XrifbAIgVdZIwrNFO4FW9uWUJAzBKWo0t2RLVkv+ksTp9NvXyNl/ennEGNKQLrIlt
         FCixEyvb0E0RxLPxOCDnPz2IcY14kvZ3bJRQ3d1fgaOgTLQc1mE4Rnh3KE3h9Wgn1Q+A
         Rf69E5a9h1VcalRxSRL1fvQ4viZKGBrHb9MJZfdqLMhF7VeudZ9ImxjefGiVZyrzKEfM
         Xxcw==
X-Gm-Message-State: APjAAAXuyY3+fkw1pwCLT9HzLqgmTmkwS3XVY9Q+XNsEMwvBCVeqsyI1
        ORTi3sVkytX7bagXMBC+nHME1g==
X-Google-Smtp-Source: APXvYqywJ/qpqys4wO4lLVKl1zfBmSdBUgW1qHv0/O6Bbnm8djpRCLarxiWGQOeEn1FSGc8aQvL6lQ==
X-Received: by 2002:a6b:3784:: with SMTP id e126mr23249715ioa.8.1566864898909;
        Mon, 26 Aug 2019 17:14:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w5sm16657506iom.33.2019.08.26.17.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 17:14:58 -0700 (PDT)
Subject: Re: [PATCH] doc: kselftest: update for clarity on running kselftests
 in CI rings
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20190827000753.25081-1-skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <473cff26-9c01-fb72-12c5-e25535a3c129@linuxfoundation.org>
Date:   Mon, 26 Aug 2019 18:14:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827000753.25081-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/19 6:07 PM, Shuah Khan wrote:
> Update to add clarity and recommendations on running newer kselftests
> on older kernels vs. matching the kernel and kselftest revisions.
> 
> The recommendation is "Match kernel revision and kselftest."
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 25604904fa6e..e55d9229fa8c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
>   
>   https://kselftest.wiki.kernel.org/
>   
> +Recommendations on running kselftests in Continuous Integration test rings
> +=========================================================================

Sorry. I missed the "WARNING: Title underline too short."

Will send v2 with this corrected.

thanks,
-- Shuah
