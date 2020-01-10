Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E517137896
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2020 22:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgAJVjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jan 2020 16:39:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34681 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgAJVjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jan 2020 16:39:12 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so3665201iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2020 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r4PmeZ/898aGumdPWOcSK9D1hCv5M+BfhsqeoQLug0k=;
        b=ML7g1aGMVB7Qp8hywr4osLv4e9aIFPmirYd1vE8lV2zZG0jw6MHA7xk2G5/1QBpB9A
         lsFCYoibZbW4Yg+U+lVU8nWRGcQlf5nbru+soLWJxXYIFsF/Qg+8PBBOXz4j+XtgtDS/
         zIeEaBxxVesBv1PbkWOCVFJp5lJnAbmVRRK1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4PmeZ/898aGumdPWOcSK9D1hCv5M+BfhsqeoQLug0k=;
        b=D6xDmt7sAkr24hzcATXMDr7HAclhAwdudhu5MjN6n4uVlkdoqRHPcBr7nOeehT4S/I
         Vx9+h0y7NRbzlEFgocugp2GQE8H7i1qsWLFhgkwfEBXdOHqi9M/VcBAROgwu0Lf+FnGA
         GFrSTmdujgPewsb3PYDKje795XeTcZZe3u24Sk0uYDeu03nUVoHsIeB4fUQFLfxO0tw0
         kNismKzDF81YwbW3Ad4Q+6SUTiZ8psC7Vn9LK/0ys04dTED/5Y91Lydoyk8S6o2m+Ku+
         m5Vkqpeph41CuRRwyByg1XTh9yfMcluLMQ6qjpyaY5Ouan8G0g5HILk/f6oMyY5FVX7r
         XHxg==
X-Gm-Message-State: APjAAAUxcnsxWCRQL/fJHgR4cruy+2F17iq3KJw80PM/3MxgS52NQFid
        15Y34tXU/YKki+zPHhWXQGVB/5WqA9A=
X-Google-Smtp-Source: APXvYqzSdoMLMiGIeDogdzlJjB5mKTqBKEmCoffAq0etf1KN36GTMK3ghL0iHprY4NA340RAOTssng==
X-Received: by 2002:a5e:9907:: with SMTP id t7mr4335773ioj.72.1578692352205;
        Fri, 10 Jan 2020 13:39:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v10sm825497iot.12.2020.01.10.13.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:39:11 -0800 (PST)
Subject: Re: [PATCH kunit] kunit: building kunit as a module breaks
 allmodconfig
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, jmorris@namei.org, serge@hallyn.com,
        knut.omang@oracle.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, sfr@canb.auug.org.au,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
Date:   Fri, 10 Jan 2020 14:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On 1/10/20 4:49 AM, Alan Maguire wrote:
> kunit tests that do not support module build should depend
> on KUNIT=y rather than just KUNIT in Kconfig, otherwise
> they will trigger compilation errors for "make allmodconfig"
> builds.
> 
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for fixing this quickly. For future reference, Signed-off-by
should be last. I fixed it and applied the patch.

thanks,
-- Shuah
