Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC4470CA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 22:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbhLJVmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 16:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344301AbhLJVme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 16:42:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C628C061746;
        Fri, 10 Dec 2021 13:38:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CF48A2CC;
        Fri, 10 Dec 2021 21:38:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CF48A2CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639172339; bh=GkTPyMdU37Yf9DEqk90Dfhc6gc5RhcnhAIN6wRj3kzI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J7V3CbS2jwuy0F/6/2aG5q6hUoySFPBDqe210B9y16hZqDhEpOm9tvs2u86cxbgNQ
         stWK+TN+OVIn3OMIacZXR3oOLphSGPrEyP62OeiBbAnPgoKLp/Se/TVygLqaJqod+v
         mfIzTiJENBpxL4mEmjRoYkhFbNlJAFsVg73i3PYcbAHNPz58XHEBd+VH42raWMJfnY
         R6tR5QBKMK70m3a+GVbaErU9z0JcYk9HS1RRaETcprJltSWW5YgEB5mJLHhhRa8Snr
         5zpSamvZKTq5++6yJNOCweoTw97HPbr9q4pLJBcKdV6IDM29+X53LpxFWDoukC0QAQ
         DzwtW2UJExDgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
In-Reply-To: <41323fe3-3f73-4681-7d75-2301f9982a25@linuxfoundation.org>
References: <20211207190251.18426-1-davidgow@google.com>
 <202112071358.E8E6812D@keescook>
 <8c06e715-a83e-e8c6-74c3-836831b85cdf@linuxfoundation.org>
 <87mtl8qifu.fsf@meer.lwn.net>
 <41323fe3-3f73-4681-7d75-2301f9982a25@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 14:38:58 -0700
Message-ID: <8735n0qgwd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

>> Would you like me to take this through the docs tree, or do you have
>> other plans for merging?
>
> Please take this through docs.

Done.

Thanks,

jon
