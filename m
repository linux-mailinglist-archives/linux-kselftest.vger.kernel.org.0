Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2132CB6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 05:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhCDEg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 23:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhCDEgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Mar 2021 23:36:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E21C061574;
        Wed,  3 Mar 2021 20:35:58 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d11so18787303qtx.9;
        Wed, 03 Mar 2021 20:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5ZDSbOSmDJWCd8UPozkSUVXTXAnLCAZLMFl/S0V2rA=;
        b=Nxsy4/8ZuQmZjbjQyS3MOZOjxVgdPNHFGnoZzPpck42X11cegW7QFCcAicctguL7sz
         nFgECtIiMEykoWQDNDlfsEpEYhDbyHYP2BuGrFRd28ynL5ZDAkoUUfDj8r7eQ1k0Qz59
         fxVeaeKHCi+O+2qDkX6W807O+MmtS5P3GMjqwh/RRjCRGriy8i1F+F75AgimI7Qfb+H3
         4jESFV4jbmh5g8M+sZqPtY/KbA9RbV6OVMLquhBRKBr+DeL/IohI9xzJ62jaBFcTv83n
         u5+i7thSvgLMd5pWhobahweA9f1q+x6DtYYKQTnRnxO4Vu23Wspbr5/SsVxgOgbBHKls
         eVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5ZDSbOSmDJWCd8UPozkSUVXTXAnLCAZLMFl/S0V2rA=;
        b=iDc8IdjNwwnI7r4v5ObICqTUTt0mbuWHjVi4ZfCulkdbJxLhPNniEf/sM2S3xLLDrJ
         4I732NDI9SkhnzNmMHWFeEa8+E5TqqWG14M1k8oZro9cvRx65g91GQDfrsHB6j3kjoDa
         gp8vNa9L7364/m4BoupZhOl8ngkLpol7MlCHIx4K4hKU2VcO7Cg3YwLRqaO10ydU0D5f
         KcyqelPBIa0yLqBZ1JJiiR0crHLH4e9IeZ9QDePUbdU/v4J03K2UETdFsWZob6x7BJRV
         PzhPjkTnrfvNWD4a+5p0GNhpcQj6AnUnt3Ohj1qK/eMU/A0zpNmjClswGgqBhA/6IUmR
         yPKA==
X-Gm-Message-State: AOAM530hJ7wCpwC2W9c7kjZstJH201gnr9mH0V9Q5FHdmnXTbnqD7jPX
        EXnaC8VUOnU0ZLC6d2z5e9KKRfKTd9d+f7wC
X-Google-Smtp-Source: ABdhPJyDa4e4BhcLLnLxEyPyyX3AvqaL5olVUOhU2RWEcEQQ5Qf3l6Ht4QKRHiE/2h6mr5gp7pxvVA==
X-Received: by 2002:ac8:740a:: with SMTP id p10mr2426052qtq.273.1614832557787;
        Wed, 03 Mar 2021 20:35:57 -0800 (PST)
Received: from smtp.gmail.com ([2804:14c:73:9e91:8b8:81b4:5ef9:821d])
        by smtp.gmail.com with ESMTPSA id g74sm15468421qke.3.2021.03.03.20.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:35:57 -0800 (PST)
Date:   Thu, 4 Mar 2021 01:35:54 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kunit: fix checkpatch warning
Message-ID: <20210304043554.jysk6qms4h4hue4i@smtp.gmail.com>
References: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
 <CAFd5g47rjt7i7JXWsYarqX_dShHiqSg8StKb7KCqOye3=eyZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47rjt7i7JXWsYarqX_dShHiqSg8StKb7KCqOye3=eyZDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 03, 2021 at 12:56:05PM -0800, Brendan Higgins wrote:
> Did you change anything other than fixing the Signed-off-by that Shuah
> requested?

No, I only fixed the Signed-off-by warning.

> Generally when you make a small change after receiving a Reviewed-by
> (especially one so small as here), you are supposed to include the
> Reviewed-by with the other git commit message footers directly below
> the "Signed-off-by". Please remember to do so in the future.
> 
> Also, when you make a change to a patch and send out a subsequent
> revision, it is best practice to make note explaining the changes you
> made since the last revision in the "comment section" [1] of the
> git-diff, right after the three dashes and before the change log as
> you can see in this example [2] (note that everything after
> "Signed-off-by: David Gow <davidgow@google.com>\n ---" and before
> "tools/testing/kunit/configs/broken_on_uml.config | 2 ++" is discarded
> by git am).

Sorry for the incovenience regarding best practices, I'll keep that
noted for further contributions.
