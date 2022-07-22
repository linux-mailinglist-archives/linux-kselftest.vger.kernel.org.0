Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA257D7BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiGVA1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiGVA1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 20:27:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859548966C
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 17:27:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so5941455ejr.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8LjdHcJfvd8YmhDIih7Ks8me5dObMZ6e8AXUp56raU=;
        b=BsQsfvGgyeYZi82xZDqX+P2W04pN9KR+LTK93LlfoKtMiWdcqitTz7n0a+wzMZnBmX
         0+oJ+HOrxD2UUnQnT56VBQXbsubOZ78EGgbxOpvish0OgPrJwZkbIfVACV8LYP1B34eE
         mmjGM5Jjk7CnvOuki/Rcc5RTGHkkSmK83+qrpnN8ttq7vYZ/XKSHKu6RxSa7yQuwfIXh
         ELGGEfmRamNz7ztRLV9gmbmLWhDRWFrlJCXnKX4EDrzUw7FaK23Dnpsoas6vd0MRDdpS
         b72uXbgecKTKvEREvvKry/SKURjD51wglq4SZDLLzf8tOS9GUopBcbjukjBxnkQQaQYV
         gjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8LjdHcJfvd8YmhDIih7Ks8me5dObMZ6e8AXUp56raU=;
        b=hWNSO3nqMMrQLMejEs378vBjg7aaRplgla9ueCxMtERX7Us2zx7xEd7CkTU3eVq8Iy
         AwGJhm6RNDu0BPdXZRALJkrmzp1lBMm/pZRqTNqKQQCbZfYuwjaddv0yKDLllUDnRAn+
         owTmHo4Wki4ODduGcIKEXFr0MhddpkInzFVrpMM1uATHF9p2yJ4SE9n/1jessUiVziTX
         IykbsIGxGJT1zWMQ84lN/txTSc4gAyuskgHr5NL+8qpfPJmaOjiJMog2eKpZqFYMnHBO
         WWLtb2Zvfn4mA9GqYag+VyK5PcQ5AqSjQ6gPKOkRL6pj5gaOKwQH20cP9nQRXJNRTuD4
         aQEg==
X-Gm-Message-State: AJIora/RWeIzg31IbGuUg4cwl69ZMXcbCUJQZH2ipI9QD0VKJW06iOEj
        z0ERl6HM/Bw7GZG/Q/vWRTz7r/A+DLUxNgnA+vgXYw==
X-Google-Smtp-Source: AGRyM1vq5VWTUYVzBMVm+KUthT2XGD1FCuiW4X+F6LzMCRExEnmP+kSdpX9emtp7LBfHWwPcOPS+QGObA1ckEX9DS50=
X-Received: by 2002:a17:907:2c75:b0:72b:3431:2a0a with SMTP id
 ib21-20020a1709072c7500b0072b34312a0amr1001744ejc.234.1658449666967; Thu, 21
 Jul 2022 17:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220721081026.1247067-1-sadiyakazi@google.com>
In-Reply-To: <20220721081026.1247067-1-sadiyakazi@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Jul 2022 20:27:35 -0400
Message-ID: <CAFd5g47jfm8dZ=3jwdy2Vhy+PgAW8JLAPmikhAUVTc-udKZjNA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        mairacanal@riseup.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 4:26 AM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>

Aside from the small nits pointed out by Ma=C3=ADra and David, this looks g=
ood to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
