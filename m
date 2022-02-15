Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECA4B7B13
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiBOXPH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 18:15:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiBOXPH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 18:15:07 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F265F8B85;
        Tue, 15 Feb 2022 15:14:56 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ED242385;
        Tue, 15 Feb 2022 23:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED242385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644966896; bh=0KRd24qYWSdMi+ZRf6iF24wWMW4EA6JvT/Fg9LWsjdE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ENlbIfdVmDWTe5fUIeoHrd86rrkUdZzWvfe4BBZSzdgdTXV81zlyQSR9ru1XXTTF7
         Ik/sevhTvj30Lxhpw/FMt/sYCArI1Secylip9j6X2JlRzw12N/vt5CshautChBgrqu
         jujivMWJV7sKE6kg8OOReaU7M5dD1O0XIWO3wQK+mIbM/rp5zNTF7C61L+O9LDedkP
         NcjiJEhnecjQQQEXhURBLYWdpkYcUcfRVTfPFHuX04tlOOBLPqy4CL3UP0hJKoMS6C
         2g8Y6h7rb4XHYsavU8M0A27K0RDkiOqBMkEO2VRMQDksYdanCAS2tcmgx58rpxuz69
         fr4eNr4tQymRg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     frowand.list@gmail.com, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
In-Reply-To: <20220210233630.3304495-1-frowand.list@gmail.com>
References: <20220210233630.3304495-1-frowand.list@gmail.com>
Date:   Tue, 15 Feb 2022 16:14:55 -0700
Message-ID: <87sfsj7mds.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> Add the spec version to the title line.
>
> Explain likely source of "Unknown lines".
>
> "Unknown lines" in nested tests are optionally indented.
>
> Add "Unknown lines" items to differences between TAP & KTAP list
>
> Convert "Major differences between TAP and KTAP" from a bullet list
> to a table.  The bullet list was being formatted as a single
> paragraph.
>
> Reviewed-by: Tim Bird <Tim.Bird@sony.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

I've applied this, thanks.

jon
