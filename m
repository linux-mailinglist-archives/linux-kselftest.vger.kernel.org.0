Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E54B5D59
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiBNV4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 16:56:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiBNV4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 16:56:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CA240AC
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 13:56:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c4so10215612pfl.7
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiSsgbTNNS1PN2vIPffxFK30orCDWpVATmUi7r4Spwg=;
        b=s2HLQSrEt1NVq3FaO+ItzWZFW9EJKI1oCIoU5Jy54OTgfCqR5PwyTzERIxURcgsAZd
         qNUSe36yPkPVXgbpjzQm+FOJExSbbdqleCWn9WzVHNUQI74JuKmsH6WYtdUr+60csGrL
         joRG5DeBZTuH4FJSEDJLdKCPoh8/Fxu1OgBsPlpNJ/QBQIH9warKHhaprmtNcEcmQVEV
         Y5W9UIJDKomuxLj2e3bK1l+yXhvCZX1Yc7TSCy8ZK+TRAya0gWX451cja6JpPA5X8EC/
         SVvCKI+/uomzhGTcd6zMcRwokZzCufOWj/joH1SvK5KptpNnHFx+HGGI3apdLw6jYryx
         BjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiSsgbTNNS1PN2vIPffxFK30orCDWpVATmUi7r4Spwg=;
        b=KuiU2oP6nyWRQeBsv3qbJdy6H0/ovowXkCMo+fheaJuYN3eUtjrNJqvMYPWaELZ4bi
         WZeIE8HwZeyaOkDW33Rvkw5a/FaiLdXyhgb9U1FwvsNdPL2F0pjuiN57MfykEnNhXHe1
         jlr4trVarh3EYmB4oFPH/vSXwlT0R1dEVa99Cnz0vPZkfFDbjQ5IV+QKRwPWw9Is4Y/Q
         FzhkiR8EbCo0cDyxjXghxgNBpmgqWbQze/JdOSS9HiAPdLCFGeJ9IU+4WuSkRJAmJWNk
         MeR9wxh2FdVNZC5Rti7KkfNvI0ICLeBM6RQkT05FFgDCcMyvrvejOlojEPnejf3J0nZk
         oCew==
X-Gm-Message-State: AOAM531huMEWxiFmdQGM06R2iwSb6vNkUFD6bIa6jICbhxcm9z2/CT3d
        dxn+3GDW1qtHqld3TK4UbyHFx6IQ+NQD/Mj+oKkauQ==
X-Google-Smtp-Source: ABdhPJyRoHiuH80bBOXiC5qPysRfk9zG+7MBAT8XtZyduYTj7PVhc/t5GG7c/JUqSnNMFiZOG85ck4R12JWh6AlDJvs=
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr934534pgk.12.1644875797678;
 Mon, 14 Feb 2022 13:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20220210233630.3304495-1-frowand.list@gmail.com>
In-Reply-To: <20220210233630.3304495-1-frowand.list@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 14 Feb 2022 16:56:26 -0500
Message-ID: <CAFd5g46HuUcPggLrUjuXO7XJGSxQK590oK7OCOB9ma+TFCiTdg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
To:     frowand.list@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 6:36 PM <frowand.list@gmail.com> wrote:
>
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
