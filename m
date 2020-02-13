Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2825415CC5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBMUZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Feb 2020 15:25:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMUZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Feb 2020 15:25:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so6367578wrm.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2020 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYU7K19Hqtiw3fxG+0bFd1qNUKm263pOaYfaAxc6hpM=;
        b=TcHXD8FErmY0j5Ks1AE2DladhbHuIzSy82IrQnKtihLC+RFDXWVeIC7yCY48m9vT89
         0w5NHKyQ3vOyCdZ+e04HADXfO/xGAKkY4W9Gp22TBZGmL4HaUXSJQ29CGs4PXcmBADg2
         4aUdbYcGnrXz1IOX7pcAHfa8dI1+S15BOFQiXjNJvLZOeX4ThH+TnZv+xVxxBuEOLnLT
         RamqLQwmnemtplsqA1ee0ptpBgUNPavqEDXBbt7fSy/JbwYRf9mgW7mNNaUGLpA6Qo58
         jHmUn2tEtN4EaBfweFtRtn6A3hBsHnwjUwD+tHgfKl6XZ3VB4p8qrX2NAAtbN/JLCSwj
         rerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYU7K19Hqtiw3fxG+0bFd1qNUKm263pOaYfaAxc6hpM=;
        b=AwbpN9efb2hAqGQl/LAT3SrW2yka8NhZxQt9bWTrvLZ8A+AB+Aq2gqSE/0WIzZTtbt
         fZeE8BWglEVejAxaJPTa/2aM1B9gwoAr5f1Ag6SSCDLUr/IhSD3bQlh9bli6r9kOzmL2
         WJxRfjDPoFP1Xo3HKAfa5olPz7GhyY9zcdjKNI1h9Npw8M6aW+xML3Eg0FVI8uOJ0dz2
         24S9xCuaj2dVOtEM7eRszP84vv25k+5g+NCtM8HcBCOysuMkzlglj1u5bQtwyhdtjnf6
         0UCspAO0bifxRXJ/QodE3wP3j8RWYLM+g/1BUrjZQv4dyWkfuOQY6C1QE81WQx4rQCkW
         sjKA==
X-Gm-Message-State: APjAAAVeVTekWCfyDNa5B6Arg7bHTk5uJQ+/ymKWzTr7gATeAMndy6h9
        +w61kS0CpaOvOC3gNY9eMmIYOA==
X-Google-Smtp-Source: APXvYqyIcrjHC0V1ObVSzKK1O+oFquBykb9wkqmiTtpRb49YjwQlFdnjV3D9CdqM+jtvVeLpIVz5bg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr24701152wrr.226.1581625536927;
        Thu, 13 Feb 2020 12:25:36 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f11sm4210674wml.3.2020.02.13.12.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:25:36 -0800 (PST)
Subject: Re: [PATCH] selftests: use LDLIBS for libraries instead of LDFLAGS
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, avagin@gmail.com,
        linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
References: <20200212140040.126747-1-dima@arista.com>
 <db01c4e9-c236-3847-f812-943e4442f048@kernel.org>
 <c9b248a3-8df5-a76d-b472-9e65d837cf5c@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <074f7494-e01f-1654-c771-27e2b6d3cddf@arista.com>
Date:   Thu, 13 Feb 2020 20:25:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c9b248a3-8df5-a76d-b472-9e65d837cf5c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/13/20 8:24 PM, shuah wrote:
> In the interest of getting this fix in, I applied it to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> fixes branch.
> 
> No need to do anything.

Ah, thank you!
I was on other issues - sorry for the delay.

Thanks,
          Dmitry
