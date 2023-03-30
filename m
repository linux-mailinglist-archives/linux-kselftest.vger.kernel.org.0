Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7456D0BFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC3Q4L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC3Q4K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 12:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D44C14C
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680195304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzDUaKlZ7WQPwjdZQNbRvPgMn+panp3snOTIhScDlD8=;
        b=L1hcuHZln+6dh+uy8Eync7b4xU1V2S0mpygwcZrncFHOh5HcH/U4z1iiwjVjKT1+359EUJ
        Rbxlv+puztc6tWFkPzZQrdX7H9X4tqHXgw26q4DipY5HHz3VTm+03jRHSMut9NfJrmi+Ia
        yjuHKWhQGcVmXcvjfZGu3MRbhXs8TAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-u8gXzK1yMcC40Av2I6KH5g-1; Thu, 30 Mar 2023 12:55:02 -0400
X-MC-Unique: u8gXzK1yMcC40Av2I6KH5g-1
Received: by mail-wm1-f71.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so10128308wmo.7
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195301;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzDUaKlZ7WQPwjdZQNbRvPgMn+panp3snOTIhScDlD8=;
        b=RLIzW1PF3DgDGqr9HKqf4PYnWbgYjxvFnEWo8HiHID5g0e5IHDZMIdURHwo9uAtwsc
         OIoes1WOsl+FPG9cOjkUn/iuNEw/dYMcPN0z4ABYIQ7lPZdRufgsTDOK4gnpY0MUyZgR
         vr5m+rdoMBKqv49H6vWA/NGBKdgLJmxZnlQKn4JBpBKBwZDepk0CnVO5xzfY3L6qR04b
         9Ocl7Y9t79pKqCM8wNl05wqtxBLspdJxMYGcfPvd7C/PhsVgj6O2xugPZCD8t0Hkq0yM
         EiFMHYtlQsxVT8XNa5hkMfs2ci4Z49EbZhF1GltwulOiN6o5pOYd3nVUXNYW69dejCfh
         A5ow==
X-Gm-Message-State: AO0yUKVtIej+Ta3fFvdOchyKlRvyCUWK1lJr3Jv1WS5l0u9UYErXH1bU
        kJaCr7+2ufSPgnVv9cGjwFxPslwBme/8Jojh7Xt2PtJvcN190/K/WIb5LXXJgmRR/NSF9g2CsQf
        ROseq1OIFEuDXBoh6+m38ClvX0fNJ
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr18547180wmm.32.1680195301672;
        Thu, 30 Mar 2023 09:55:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set8k3a1ANSNZU1JWwGMmHT0TPjW+p0jaezeK+am6PpOZ0zh8xcps80GbOxDf7XVIgpME55DQxA==
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr18547159wmm.32.1680195301383;
        Thu, 30 Mar 2023 09:55:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z14-20020a1c4c0e000000b003edf2dc7ca3sm6408235wmf.34.2023.03.30.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:55:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] .gitignore: Exclude KUnit config dot-files
In-Reply-To: <CAGS_qxptBcUQByWAd6JHAxWb08czOiGnx0_uSvMKdhzTVwv=6w@mail.gmail.com>
References: <20230330112743.2331141-1-javierm@redhat.com>
 <CAGS_qxptBcUQByWAd6JHAxWb08czOiGnx0_uSvMKdhzTVwv=6w@mail.gmail.com>
Date:   Thu, 30 Mar 2023 18:55:00 +0200
Message-ID: <875yaifacb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Latypov <dlatypov@google.com> writes:

Hello Daniel,

> On Thu, Mar 30, 2023 at 4:27=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> There's a rule to ignore all the dot-files (.*) but we want to exclude t=
he
>> config files used by KUnit (.kunitconfig) since those are usually added =
to
>> allow executing test suites without having to enable custom config symbo=
ls.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> FYI, Andy has a version of this patch from back in Jan here,
> https://lore.kernel.org/linux-kselftest/20230127145708.12915-1-andriy.she=
vchenko@linux.intel.com/
>
> I don't think anyone was adamantly opposed to it, but it's just been
> sitting on the list waiting.
>

Thanks. I missed that there was a patch posted already by Andy.

Masahiro-san,

Could you please pick that? It would not only facilitate adding new KUnit
test suites but also avoid existing reports sent by the kernel robot, i.e:

https://lore.kernel.org/linux-input/CAGS_qxot1_+J3YCykkk0H1fZM6Cn6Pv4SFT6iC=
f9J7td1aH9HQ@mail.gmail.com/T/#mfcce95444b2df1c8242b03b7434e7730a6087663

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

