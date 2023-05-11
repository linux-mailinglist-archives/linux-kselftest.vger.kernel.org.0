Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0D6FF5E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjEKP05 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbjEKP04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 11:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31C197;
        Thu, 11 May 2023 08:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF5364F02;
        Thu, 11 May 2023 15:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53101C433A0;
        Thu, 11 May 2023 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683818814;
        bh=yX+KBh46sRECtS54M5dooUORP+MvkRKDtoQcUIKDYzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HK/bPiVJqW1AVZoDBZcQcpF3C9UZZYF2xCSZQzGAab9P99CPmY3Bw23JY/yL1RNju
         RhX0Wpi+97Xg8oTi5oz17b+B/zkLUSnUsYkMsULkS6H71AuKvMXnbrlVIQKmDxYlN1
         J1AYLBsb2Fb50/01yVioC6S5kKGkHXzwQ2IT8VM6mY2Rbbh8l+2fTD0ag8MQgWi4q/
         sh/+KIJ+VkR8It0P4CHXC2WTm91kaB+Q5kVLg8j39cxEdeu1LWV2G/D1qYi7tY36EX
         kpZ3akhhapolJvQy5zp2dAq9hzaQ5ajrNLIUdA9s4nehfUsHw/aLuTAwp6Yi458/er
         UiDkmqqJ8IKnw==
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-44fd15d6824so3077202e0c.3;
        Thu, 11 May 2023 08:26:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDz9YAVpZlQ4eAHuE6rSVyIDCUt2iuVICvgCPqC40fVAbOACZArC
        mDHAVFaCqRYo6FdfumPzAP7I7QL8glsBbLn8Tb0=
X-Google-Smtp-Source: ACHHUZ6k2Xr7l6KB/m8y+sPvxgkea/KIOkz7DRPfd3A5d1yrCF+9ae9dQBu0mje0wrDXblDj4E1P1R6H0vlAvguAzh4=
X-Received: by 2002:a1f:c343:0:b0:450:17ac:47ca with SMTP id
 t64-20020a1fc343000000b0045017ac47camr6143019vkf.16.1683818813106; Thu, 11
 May 2023 08:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230414193845.2494120-1-mcgrof@kernel.org> <3f5c5c28-3814-3fea-dfbb-a3c7604e0edc@collabora.com>
In-Reply-To: <3f5c5c28-3814-3fea-dfbb-a3c7604e0edc@collabora.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 11 May 2023 08:26:42 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Wx=PQ6n__hdseLzahNdkGoyUXDW4w9B5bBLvg-kVxbXA@mail.gmail.com>
Message-ID: <CAB=NE6Wx=PQ6n__hdseLzahNdkGoyUXDW4w9B5bBLvg-kVxbXA@mail.gmail.com>
Subject: Re: [PATCH] selftests: allow runners to override the timeout
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        tiwai@suse.de, tianfei.zhang@intel.com, russell.h.weight@intel.com,
        keescook@chromium.org, tweek@google.com, a.manzanares@samsung.com,
        dave@stgolabs.net, vincenzopalazzodev@gmail.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 28, 2023 at 1:34=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 4/15/23 12:38=E2=80=AFAM, Luis Chamberlain wrote:
> > The default timeout for selftests tests is 45 seconds. Although
> > we already have 13 settings for tests of about 96 sefltests which
> > use a timeout greater than this, we want to try to avoid encouraging
> > more tests to forcing a higher test timeout as selftests strives to
> > run all tests quickly. Selftests also uses the timeout as a non-fatal
> > error. Only tests runners which have control over a system would know
> > if to treat a timeout as fatal or not.
> >
> > To help with all this:
> >
> >   o Enhance documentation to avoid future increases of insane timeouts
> >   o Add the option to allow overriding the default timeout with test
> >     runners with a command line option
> >
> > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Tested-by:Muhammad Usama Anjum <usama.anjum@collabora.com>

Shuah, just a friendly poke! This is needed to allow me to enable full
automation for kdevops for selftests.

 Luis
