Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266C949E99D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiA0SFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 13:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiA0SFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 13:05:40 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF6C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 10:05:40 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y84so4664675iof.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 10:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y6t/HLJoZRMAq0YMzTaHPBGjeHGV6rmgV1hXLsNEaXA=;
        b=LHvGtJfXMpZK44WF9ZY005FpCS0vJoSKvY/Yhz1zaVSMBWug4MxCWXqoeyn6IBVnMe
         A+cT1RvoyL5cCH5d4vEPFVJDcGfznTASOTOh3uiJuWQ7aPAd9prAsIJcSU4dPJhk1sTc
         TZKgn3WDfohEglxJIr40gILapE9RdgW0xW41A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6t/HLJoZRMAq0YMzTaHPBGjeHGV6rmgV1hXLsNEaXA=;
        b=hnPmZvO6hiBlvLwRJokzX1T8srpWJk8wDZGbjHZHGUXlA1r+03xQr67m86l30OAjOR
         6PDM5QBGFoGfulOmvnF2i3TEP255LAXQRMOV+f4+UnTJArVhieEYXCaeq64uV0pWd6w/
         SJW/RQ8Yn5zqsZg8cDOJgel1JEROvfSHh+wQuCAUWMxtYgVONPtT1Favu8LidTgYPTUy
         kUgue3tL+XDhsTjI8yZM/26oE1X5aL25IpZtq/l3DH071TmGqFccJoO+gONPt811XyqB
         rbF6Ch4dhEdHD1QBiEfwB10s6Kn7AW+RHNzZDFmPRFW3JbUSztZEjXBfcsW6urGc+6h/
         QgOw==
X-Gm-Message-State: AOAM530KwU5dg/ZhKO192sdJYBGFdZkA0nVRqtD9lVWf+dAh7xsfX0PS
        hSe5dThP5gJUuwXp3X10FW7AuDzeCBrYAA==
X-Google-Smtp-Source: ABdhPJyy3ckcWni8fxqVjws57TQznsXqmVAuFW5XVh2tNilQYn6vCrZg3TBfS5IFonuSZc3+ohw7VQ==
X-Received: by 2002:a02:a519:: with SMTP id e25mr2431138jam.315.1643306740176;
        Thu, 27 Jan 2022 10:05:40 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id w10sm4115625iow.44.2022.01.27.10.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:05:39 -0800 (PST)
Subject: Re: [PATCH v2 1/3] selftests/zram: Skip max_comp_streams interface on
 newer kernel
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        pvorel@suse.cz, Shuah Khan <skhan@linuxfoundation.org>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c3410567-7d69-9020-8477-a8ba957505c8@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 11:05:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/22 2:11 AM, Yang Xu wrote:
> Since commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram
> has switched to per-cpu streams. Even kernel still keep this interface for
> some reasons, but writing to max_comp_stream doesn't take any effect. So
> skip it on newer kernel ie 4.7.
> 
> The code that comparing kernel version is from xfstests testsuite ext4/053.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Thank you. This and the other 2 patches are in linux-kselftest fixes branch
for rc3.

thanks,
-- Shuah
