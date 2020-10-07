Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CE286765
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Oct 2020 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgJGSaQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Oct 2020 14:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgJGSaQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Oct 2020 14:30:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09EC0613D5
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Oct 2020 11:30:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so1784288pfo.12
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Oct 2020 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEnx/MaMTPdV1sePaMjyGodsEMsS+Pwmt60JRHi/cE0=;
        b=Oi3QTMD9IkaHxDQu21atk/izzNy05UEr29GvBeVD/aPrPFrwP7zFn/Z0ocm3YCp4/G
         MYj2vvs7sZheVYuugoADfNAzk9zrHJIcbQC6vQqHeZhqwKwGZCaiXL8Vmhwm+mooYfyf
         NVvspGSkmv/96/hUy7UhO+Bi6+iB0pFbMjf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEnx/MaMTPdV1sePaMjyGodsEMsS+Pwmt60JRHi/cE0=;
        b=nvGbmcBVxDTtDxdDwsY6mdaY5Y1/KDn+wcfS1WU+sema5e8BvZwqKAfzPMs8gTYFN6
         gpVwQbxsqh/NJaPrk0d5Ka/EYalXT42oWV3tmV9QGde7gqBg8zEiFEccRMDfBhmS9fIG
         by15rbijnyvSvo2LHbAfMRVKHnHN4X0aj/Ppri+sQ09+CNou5ccwxDw571gRbvXUgyGW
         UivG4TB6A8Aws/ViqRL6NRn6cEDolrIDcOJktXqu8b/2NWqZRZ7DMac3KRwMusiO4tUl
         ae7yM+9QEgHkPVHhWYCwAk1XkaDLKokne0P9vHnIk56ecHFydrftQvWOXCEyqxuRITVm
         RRRw==
X-Gm-Message-State: AOAM532cp1aW76Q9gjYitjW7TTnlYh8q7i5zaiUnqVF1x4Tc3FJoFcuu
        BNF41wrcMok59npPDKM7MNN+Og==
X-Google-Smtp-Source: ABdhPJwANFS6YYncg0hxvWSF1CAR8KRQ83VHR0P39mH0uwrUqNSGUcIFT7Lpzw7MABy1uBVF3jVVDw==
X-Received: by 2002:a17:90b:4c90:: with SMTP id my16mr3717046pjb.27.1602095415557;
        Wed, 07 Oct 2020 11:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm3411877pjq.42.2020.10.07.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:30:14 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:30:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Introduce Simple atomic counters
Message-ID: <202010071128.0772BDD6@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:31PM -0600, Shuah Khan wrote:
> -- Addressed Kees's  and Joel's comments:
>    1. Removed dec_return interfaces (Patch 1/11)
>    2. Removed counter_simple interfaces to be added later with changes
>       to drivers that use them (if any) (Patch 1/11)
>    3. Comment and Changelogs updates to Patch 2/11

Thanks!

> Kees, if this series is good, would you like to take this through your
> tree or would you like to take this through mine?

I think it's very close! I've sent reviews. Why don't you take this tree
for now? (Originally I thought this was going through Greg's tree since
it was touching a lot of drivers.)

-- 
Kees Cook
