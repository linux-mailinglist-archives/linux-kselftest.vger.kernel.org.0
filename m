Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CC49BD39
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiAYUdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 15:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiAYUdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 15:33:45 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4A5C061744
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:33:45 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e8so17867914ilm.13
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GYCFncPgYl3SoVjZnns5KEtsVlP567DHGfNxuW8K4kw=;
        b=Hc1P4b/gWjLpCURFYVjujcUxnxI0wWkKO0yj+cfeYFBoyi8DMulUx58sUN0MjgfSO7
         tw6NdG1uphhO7Ocse99bj2q9CTdC4YAyLpCyRMQGw0dzKJ5YL/ijOLuadWfJYSQloPVd
         PZupg09hfZYyAARLLnI/u1SJfg3XQ55YA0ZyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GYCFncPgYl3SoVjZnns5KEtsVlP567DHGfNxuW8K4kw=;
        b=y3Pb4eYQVU7chnHPCNm6EHa0Ows9ORkdtzWcI571Xd++89m8uY3LCiE1rmh8YZ4fjz
         GIVslBcO2ZqHdueOyUNSs4vRYS7sv1hhAQK7GqnswGI4qw5GU/KfEI6ykEOSjf2o3eVQ
         +srsMLlHSKmF33FUYgkgNDTi9F/MZSCFT5ji8JhXb10SeOc/p7mDn6Yfc6VAnSmwL5At
         q+OMOs+eFT9Ndayu9NIhsm5bhfAFFFSHztTjBD8AcL5tJU137nX5OaeitTO5a26yGST1
         UVQaEay7sfcXyejMyl0rBlk+tJROBV89LJCQvQGnkgbRSA/MvViDRv6gFJR6Y6uU2e9e
         DY4g==
X-Gm-Message-State: AOAM533Zc3DryQPZ5dVj3Xp1egB2wkaw5PNiwZXAq5RiMhJpCabj/3XD
        I3aBchPNe+77N072eSkUCa8mDA==
X-Google-Smtp-Source: ABdhPJyfB6b289YGq9EGRzqRfBCZt22e/mN2fm3fqvsJooN89OJeLhEOc/K25j/9oWYLCq05wGWvtg==
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr11569936ili.219.1643142824570;
        Tue, 25 Jan 2022 12:33:44 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id r189sm5099311ior.2.2022.01.25.12.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:33:44 -0800 (PST)
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        aleksei.kodanev@bell-sw.com, Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/21 2:56 AM, Yang Xu wrote:
> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram has
> switched to per-cpu streams. Even kernel still keep this interface for some reasons, but
> writing to max_comp_stream doesn't take any effect. So remove it.

I get that max_comp_stream doesn't do anything since this referenced
commit. Don't we need this test on older kernels since older kernels
still support max_comp_stream?

thanks,
-- Shuah
