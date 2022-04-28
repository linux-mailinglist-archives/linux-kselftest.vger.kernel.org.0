Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB2513BA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351125AbiD1SjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351173AbiD1SjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 14:39:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E42B247;
        Thu, 28 Apr 2022 11:35:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 058662BD;
        Thu, 28 Apr 2022 18:35:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 058662BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651170946; bh=9IIGBlboau/zQf/QWoBV5Td7htGubCcvMj6JuOI5Muk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CiRmNdmZR8iAq8WrObjx7wftNIkJ3jR+I0vx1wmI4OYrQ4NfOdj8NfeyeerNF9wNT
         NMKQiHNWKg53eE9qOsRFt3vE/iL5/3FA8wx6JGt4smYYF0ut04QLUWN782BCXAm7Dy
         sK2VeZKVeCCucMwYSeh839UZJCCV7rzFqyXOvIQUIqV8Hw0fMEvj3uGXquUiMkyJev
         oKxDW/JxQzxB/vA0p4yZoP76b8HwqN3AJ/rWiZqvje9ZkkX8hcdV31QSIdCmH2EoSC
         9Io215IN4/QOfaJHSwrho8sHOvUh9LLdYAIniV8pa5KG49J8o+I6v6mjDMcwi78hmF
         sHcpICD40eIFA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] Documentation: dev-tools: use literal block
 instead of code-block
In-Reply-To: <95dcdcd3-fb48-6e5c-3262-7aacaac71e78@gmail.com>
References: <20220316202622.324866-1-frowand.list@gmail.com>
 <20220316202622.324866-3-frowand.list@gmail.com>
 <CABVgOSngfB41BVoEvQ1JX+2oFvS7Mik58VfPm9pydmiC_GSD6Q@mail.gmail.com>
 <95dcdcd3-fb48-6e5c-3262-7aacaac71e78@gmail.com>
Date:   Thu, 28 Apr 2022 12:35:45 -0600
Message-ID: <87tuad5a4e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Frank Rowand <frowand.list@gmail.com> writes:

> Hi Jon,

> I got distracted with other tasks, just now returning to this.
>
> There has been no other comment in the last month, so I think it
> is fair to go ahead and ask you to pull this patch.
>
> Can you pull just this patch (patch 2/2) or would you prefer that
> I do a version 2 which does not contain patch 1/2?

I've applied it, thanks.

jon
