Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174EC52543C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357377AbiELR4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357371AbiELR4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:56:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358BBCE98
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:56:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k27so7186377edk.4
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qf/cKy/vzkmiMQPaxcYazd7i7GNGNfcW6oongi1e2pY=;
        b=aBk5ImdIj1iisdv/vbNTJ1oIW/fNvamlu+XDItZ0rJaeajo2BApQRQskjVOPMKIaEu
         cpPumuTa0f4i/GtGm1oEaClBbVL3sLpOiBx6zHO4feYYBwk1insiqs+5v0HEPJBlRETC
         9CUUoAzrNwa1Hbu+awusjyUUa3WZ1h65kMohgppGpXuvLjOzz2mw0ei8Hnj09wBOiIoG
         lBURzELdyT8X90Mji49/bAyBAzLwoR10ZAMHfl3i9ZFtO6uMVx6/Dg7eI5HoFgU1Ayqt
         8dbKVQZ4RSgPWt9x4SqmSMZBEomhHvkVPrXZPY+zRjbPIkiOdR9LdpjGYgcn+tBVK7xV
         /5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qf/cKy/vzkmiMQPaxcYazd7i7GNGNfcW6oongi1e2pY=;
        b=Euw7FYK4/q3NGlR/gAq+TXguwRY3aOmsqCUjtb+UxBUqPYcFvpCzB0kqrA2Oec/gWv
         M8pSPYbNNdyjskgwxWBW9XpGiplHgscYS2JjaAfxhFxhY6pPawxX9UykpABNujpSI48v
         9VDg0k9dK0MLJF4NXAC00u3c4D0aHaoitlCBPxwwxcuAAbgjGX+K1yuNw/xUG66UpOzi
         uhZeOe19ckSi2BEr4u8FrN7kderolXTFrWhUiWmVBgUPzQg1g/dKjuataWy/F2vlM1Hz
         VHiKkmo7txOvmdTVWP8yaIHSeSLNulJOd5d7hX+PTwHE/3r7nHWjjXQYsES2eylGR2cO
         xDrw==
X-Gm-Message-State: AOAM5339ceFneEIem/cPqKvA7zyPLjYhv53b/EAtrgQJpmZCAZeyHnkh
        OKCCzeikgoT+gDoiq+alcZBwdg338vHRLjDFpGoZ/g==
X-Google-Smtp-Source: ABdhPJwhgwFV6BFyOwYx89UMqKZLAh/Gm3/1LRZTEnXL3E7WSv0RNG+EnONBKrBGzScs2UFKJksJ0yRhpTPtmaqlLR8=
X-Received: by 2002:aa7:c54d:0:b0:425:d8c9:efc6 with SMTP id
 s13-20020aa7c54d000000b00425d8c9efc6mr36388495edr.48.1652378175132; Thu, 12
 May 2022 10:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com> <20220426173334.3871399-3-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 13:56:03 -0400
Message-ID: <CAFd5g45E6KYNv=ZACtBpKg45KOS=D4=7FH5HDbZAXSjA6+g6Zw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: minor cosmetic cleanups in kunit_parser.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Tue, Apr 26, 2022 at 1:33 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> There should be no behavioral changes from this patch.
>
> This patch removes redundant comment text, inlines a function used in
> only one place, and other such minor tweaks.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
