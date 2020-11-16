Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85652B508D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 20:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKPTKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 14:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgKPTKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 14:10:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03CBC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 11:10:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x15so8885996pll.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DGgJquhYYV+Tzh8ZT7w+8c+Lo4mKYMrSfopaj2Mm3nM=;
        b=yF8JpZDrKkv9JICmK1vHZzm4fElvqZ4erpbXNJESXLtUZJXyjhTHjDe7GReFmryXAc
         BCGRKKOFkWPun2+ghcwXfq44o1e1/9d6qwZ103iUN0GeLZnzHU5YTto8mAXs03QGBUl1
         v1X16aHLn9RTF8OgGlYqaJ1DBWhurxAiAc8GqgdTRRQATMhCEH52o++qLHs/erZQV5FD
         XdDi5NofFzy33vjBxiFVCvu1Z5eWRyF0YX1ShlTaFODxuwFYIK3BA0QiyROMT3rLi0g0
         CR4T7BYuAMX80Nhul01Ut0e8XrOAnGjmu+PoIi8mS5e13s78eKSd8MsqWzt5yeFQLtj7
         wfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DGgJquhYYV+Tzh8ZT7w+8c+Lo4mKYMrSfopaj2Mm3nM=;
        b=k+qMNUem1WQsgvamUcYeLpUR23KeHoCoB+WI7rksNKPK6Bwnc6Kyubd5khjMj2b9wK
         z9ABU3O1r4QKy+KKcLsYWniHjuZPscU5wUlH3GakEXm5Lx/kiPdedoUTiS30KABM5/vz
         gddTGWBw2Zu3rMJdZhUTlLRNt4QCT/NdZHzqdgI0ZUEjVkT5Xurv+oJcCsCMzZifgdL4
         od2c+6QSUoSRuJ5G2tdL5KA+/w+PR+o4/CL2VSDcjhPJZsXR9AoDBU7R4zUX7nP4Q4cU
         njqSKaCVC+0hkuoIMNvAn6p6n3nlNXt/7leQ1zkr2aHCx9dvOcWzsorQjNbqGLTdrxqq
         m5qQ==
X-Gm-Message-State: AOAM531mUBb5Rxunc2EQWGutYkG2uMdJAlPM85L6s3/UeP9SKX9FrwFK
        aHZf3fkMwOOt0SP/v15Vg4q8Ag==
X-Google-Smtp-Source: ABdhPJxFw/0Wd5j5UG+u3JOvfHbApC9lykSr3UwfR5lLoS0xR57D19MeWyytsAeWu2fLjcTZQbv3CQ==
X-Received: by 2002:a17:902:c016:b029:d7:1a0:7cf0 with SMTP id v22-20020a170902c016b02900d701a07cf0mr13618172plx.64.1605553844604;
        Mon, 16 Nov 2020 11:10:44 -0800 (PST)
Received: from debian ([122.174.144.192])
        by smtp.gmail.com with ESMTPSA id p15sm143488pjv.44.2020.11.16.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:10:44 -0800 (PST)
Message-ID: <2f3d616bea4fca2f47f8db0564bbcc17169f8cfb.camel@rajagiritech.edu.in>
Subject: Re: checking for "config" file existence.
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Tue, 17 Nov 2020 00:40:40 +0530
In-Reply-To: <d6e1e346-ff95-74ef-7f43-1d2468d5330c@linuxfoundation.org>
References: <2ea637f38be0d03d0e0c545a6d12f36217cededc.camel@rajagiritech.edu.in>
         <d6e1e346-ff95-74ef-7f43-1d2468d5330c@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2020-11-16 at 11:32 -0700, Shuah Khan wrote:
> On 11/12/20 10:40 AM, Jeffrin Jose T wrote:
> > hello,
> > 
> > i wrote a  small program to check for the existence of "config"
> > files
> > for testing projects under kselftest framework.
> > 
> > chmod 755 test_config.py
> > This file should be located in "tools/testing/selftests"
> > This can be run as "./test_config.py"
> > 
> Why do we need a dedicated script when you can do it with:
> 
> cd tools/testing/selftests; find . -name config
> 
> I see that your script also prints if config doesn't exist.
> It is not a failure not have config as config is necessary
> only when a test has config option dependencies.
> 
> What does this script attempting to solve?

according to what  you said  this script may not be necessary
thanks for the explanation :)


-- 
software engineer
rajagiri school of engineering and technology - autonomous

