Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D47032F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbjEOQb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbjEOQb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 12:31:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3C10F3;
        Mon, 15 May 2023 09:31:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-306281edf15so12324816f8f.1;
        Mon, 15 May 2023 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684168276; x=1686760276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xj0LlUHkMs1f/PPwjZMnEi9vur/RUIxqtgTnxaH1HHs=;
        b=Tej0A0SVFNljYQvApjPnFcxl/jMGuS4pY5Ha2t/wxklAj5BDMFqwnWeo4iWAqBlEBf
         flToiFDTEQLXIJsENh8Gf373G1RY7yWUx5xsP4ZebDJjJkJT3BEbUrjeiC1EV1VHoTtF
         /vKy/iZcG6d6Rdg3n+pmWu5HJm1lxcR3HU9LTMU2/KGJe7i608OmKmkfACFMxxMcmjkp
         MLxFXOQdKOXqMH72A3hPIlD5zGkpGbmpK9X5IWL1MQsp+xmaGaPDP7CdJiAlfQTsn0Ow
         lSIR0hJqBtxJLzIH4aQEGQxKRF78gqRo0lU4f6b6fXixUcI0UfN9u1hUykmqsiX4dQPe
         dIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684168276; x=1686760276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj0LlUHkMs1f/PPwjZMnEi9vur/RUIxqtgTnxaH1HHs=;
        b=iCUKK09LkbZ77epxwirx5UD4NLwh6QbwVBFu885VyO7T1ke40bbZFEdNxxe806ZzuD
         7umEbc/IF3q6m+3V6V0Wlxuk/CDo6kKF2Mm66doulSBmzemxmIC/XuGjUd4sJV4uqf9f
         7vpUaw8kUDCaAxHjAOQLItJsPEag42ZHU5iiyyrHdggLKK25WyDltJiBj+E9RneBv910
         B6QPmin+NsMA0Jt+YC/2hgs7BKi2s2z0csBPQVdusMD8cSY5eB4vzQzgFkMgAN111RFo
         SVI+ciyZOY6WS96eWwGSwKY8Z2FTbHq2f96emaMJRXZtM74gFU8sT+Ad4CD+1/Qmf8ns
         s5zA==
X-Gm-Message-State: AC+VfDxzKSrRT9Y4U2d8wh5q+GbSwhd3UQZ1glbhT9NfUgwoxJOJaOTb
        Z9scVndsOJMWKRMDpktPfMc=
X-Google-Smtp-Source: ACHHUZ4exiePmSzMSaub/V47LjNfg6KE9x175cxCNihSkCYAUDOuWxIYk+H2LH/BQb2PrKb5025TYQ==
X-Received: by 2002:adf:e351:0:b0:306:2eab:fb8c with SMTP id n17-20020adfe351000000b003062eabfb8cmr26143380wrj.42.1684168275652;
        Mon, 15 May 2023 09:31:15 -0700 (PDT)
Received: from fedora ([94.73.33.248])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c028300b003f4e4f51f64sm14756542wmk.7.2023.05.15.09.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:31:15 -0700 (PDT)
Date:   Mon, 15 May 2023 18:31:13 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Modular KUnit tests should not depend on
 KUNIT=y
Message-ID: <ZGJeUd76XaFqHhN0@fedora>
References: <36ddf432f0f46530875fa15f002012c921a380a3.1683022021.git.geert+renesas@glider.be>
 <CABVgOSmYapFcpnrC60o4r5LznT92TpjteNb=1MQejvMDWC+2vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmYapFcpnrC60o4r5LznT92TpjteNb=1MQejvMDWC+2vw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 04, 2023 at 02:04:18PM +0800, David Gow wrote:
> On Tue, 2 May 2023 at 18:09, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> >
> > While KUnit tests that cannot be built as a loadable module must depend
> > on "KUNIT=y", this is not true for modular tests, where it adds an
> > unnecessary limitation.
> >
> > Fix this by relaxing the dependency to "KUNIT".
> >
> > Fixes: 08809e482a1c44d9 ("HID: uclogic: KUnit best practices and naming conventions")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> 
> This works here, and I definitely agree we should get rid of these
> unnecessary constraints.
> 
> Let me know if this should go in via the kselftest/kunit tree, or if
> it makes sense to take this via input?
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >  drivers/hid/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 4ce012f83253ec9f..b977450cac75265d 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1285,7 +1285,7 @@ config HID_MCP2221
> >
> >  config HID_KUNIT_TEST
> >         tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
> > -       depends on KUNIT=y
> > +       depends on KUNIT

Tested here as well with different configurations for the UCLogic
driver and it is working.

Reviewed-by: José Expósito <jose.exposito89@gmail.com>
