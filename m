Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7490C3F392C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhHUGsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Aug 2021 02:48:10 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:37382 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHUGsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Aug 2021 02:48:09 -0400
Received: by mail-io1-f53.google.com with SMTP id b7so15100065iob.4;
        Fri, 20 Aug 2021 23:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MFQgpf1PdJLzQmbAlkrK/uGob8admy1gscQgGsZ/WqQ=;
        b=BJQ3jnrMu5OqkDxkITo/yZqbaC+7C2bvbd8Xf6gzrPzdjm/e2LauFwpZx8thNPjfQQ
         gzkt7xLpiTD85WLywUV+StJ3wN3Ty3a4OsFr+LBhr8a6FN9zGyqq3Qidwdq5GOTKyoqm
         m3GHCu122aY02oBycUugQBOK7SV4r9AQ+4JxLf4Ea5n3mSL3METI5VTNQr30h6WE15qZ
         PLALtuEOrZPLgD8eIbe3WAkZpWVhydh09nGm1weroASX1lw8ozZJ2ZBFjeLNvknLPPkN
         BWN3XqbOGFkW9bStYKIR15427Xi2+Dq8zJYSglKilzDDaWQtSwfWuW3VokfCiKQPSaMo
         zdIg==
X-Gm-Message-State: AOAM532TjGFGHtfBbOdw4L+G6+xoCMhi+krIl/23u/dYdmg4eGM1p0VK
        1w3fhWWjZg3waYSciwMHruE=
X-Google-Smtp-Source: ABdhPJzwkH0+4yF1fbYJhpS6KccSYk/Av33R1JX/S79NofCckFDBdKpsE4Z9nN6wEdtTVSEVGztcxw==
X-Received: by 2002:a5d:9304:: with SMTP id l4mr19365033ion.167.1629528450347;
        Fri, 20 Aug 2021 23:47:30 -0700 (PDT)
Received: from [192.168.1.109] ([213.87.152.233])
        by smtp.gmail.com with ESMTPSA id a2sm4633765ili.40.2021.08.20.23.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 23:47:29 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
To:     Joe Perches <joe@perches.com>, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
References: <20210818154646.925351-1-efremov@linux.com>
 <20210818154646.925351-2-efremov@linux.com>
 <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
 <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
 <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
 <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
 <ac2587d3d4b7ce87e8922380e36d7864bfb54262.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <7eda27d1-9e9f-dfd6-3a54-6c592a797ea5@linux.com>
Date:   Sat, 21 Aug 2021 09:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ac2587d3d4b7ce87e8922380e36d7864bfb54262.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/20/21 1:17 AM, Joe Perches wrote:
> 
> And I'm not sure if this particular ERROR is that useful overall.

I find it useful to check commit-id and that it matches a title.
It's easy to make a typo in commit-id and get an invalid one.

Denis
