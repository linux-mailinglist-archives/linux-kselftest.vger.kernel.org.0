Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E416F48CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjEBRF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjEBRFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 13:05:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E210D9;
        Tue,  2 May 2023 10:05:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaf91ae451so23346115ad.1;
        Tue, 02 May 2023 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047121; x=1685639121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q1g+BA4N5McbyEIryrpzj1O18ZYchVOkwdif6Y10dy0=;
        b=UFvcJQV7gAUEWAXBSUttHC7lywAX8CT3g4Zb+j2Zrxu0VL3wqzP6qebRIv/fjk/YgN
         uLNPdYZUSyyH2UzHSVZs0bL4IInr8fKfuWBVQNlagkdyG1AUZ9keHAp+tZg7Ys7iPE17
         SwEpcRn1X/sPNj3xbOy1gBzOkXGLv+3E6doEmc8OXNip2DXmbG80/IpFhGjRsz98tIwK
         hVbZOBk2Dc4oDUFfmzXMvEug0tdAo9NFADmwYN22jOZfbBBseggcEMWtBXGVuqLs8QuW
         t4khzOufQePetEVkqrowqX//GBsyGnMgxBr3261BkfXGqstMkYKcH7l77+rqSzt5+D/K
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047121; x=1685639121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1g+BA4N5McbyEIryrpzj1O18ZYchVOkwdif6Y10dy0=;
        b=hDDaoEEQNL+cypE9W3kCv0qjMNTrJztRaxAIMh7uqrBLGR/CopsG1HLukuEMPBRIMv
         KbBNYChsOthibwCBaFg7sFiFMRGl9nssnLxPjzewWQDVmR3LncfxNgrKad5m4yqfu8NF
         aBkhXpfN7qR9tnptsO/Yd9TDatwzDBl3csIJV/b9B/EagIeBf4AgomS2+gihGojs7yyy
         LkeoHZmGsPp8SXCqBvp10xiGpjxP0fZyUKhdcksZNJhsFCFsaE/DvXlT85Csu1Fer2EO
         lFikF1BFYWazbdNLlbqGuEnN9JU8KjiT/f0zq3FKUVCSPeZT9PEaZ6Tj4QqyGFsuK6kp
         y5bA==
X-Gm-Message-State: AC+VfDyKyD9RH0/DJW9wKf6JVJ5dOlH1SyLrZszQUz8Z8tqRG1mgLc2q
        J5yAmgprEvjNs/IearHts4WhEZzOB38=
X-Google-Smtp-Source: ACHHUZ5VxRuSzei+5ZILmWocUZudT43/xS9ZZhhxPL5jZt1a/BO2A27jnlReraJucVA3FwrBWYcTDA==
X-Received: by 2002:a17:903:2352:b0:1aa:ed6f:29c2 with SMTP id c18-20020a170903235200b001aaed6f29c2mr10855920plh.11.1683047120829;
        Tue, 02 May 2023 10:05:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6edf:1ae0:55be:72db])
        by smtp.gmail.com with ESMTPSA id bb7-20020a17090b008700b0024e0d6b219fsm3138744pjb.42.2023.05.02.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:05:20 -0700 (PDT)
Date:   Tue, 2 May 2023 10:05:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: tests - miscellaneous fixes
Message-ID: <ZFFCzHwJqyeXB52w@google.com>
References: <cover.1683022164.git.geert+renesas@glider.be>
 <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
 <878re6y9s8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878re6y9s8.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 02, 2023 at 06:31:51PM +0200, Javier Martinez Canillas wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> Hello Geert,
> 
> > Hi Javier,
> >
> > On Tue, May 2, 2023 at 12:17 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >> This patch series fixes a crash in the new input selftest, and makes the
> >> test available when the KUnit framework is modular.
> >>
> >> Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M2-W)
> >> and ARAnyM):
> >>
> >>         KTAP version 1
> >>         # Subtest: input_core
> >>         1..3
> >>     input: Test input device as /devices/virtual/input/input1
> >>         ok 1 input_test_polling
> >>     input: Test input device as /devices/virtual/input/input2
> >>         ok 2 input_test_timestamp
> >>     input: Test input device as /devices/virtual/input/input3
> >>         # input_test_match_device_id: ASSERTION FAILED at # drivers/input/tests/input_test.c:99
> >>         Expected input_match_device_id(input_dev, &id) to be true, but is false
> >>         not ok 3 input_test_match_device_id
> >>     # input_core: pass:2 fail:1 skip:0 total:3
> >>     # Totals: pass:2 fail:1 skip:0 total:3
> >>     not ok 1 input_core
> >
> > Adding more debug code shows that it's the test on evbit [1] in
> > input_match_device_id() that fails.
> > Looking at your input_test_match_device_id(), I think you expect
> > the checks for the various bitmaps to be gated by
> > "if (id->flags & INPUT_DEVICE_ID_MATCH_EVBIT)", like is done for the
> > other checks?
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1021
> >
> 
> That's correct. In input_test_init(), the input dev is marked as capable
> of emitting EV_KEY BTN_LEFT and BTN_RIGHT. The goal of that test was to
> check this.
> 
> That is, check if matches by the input dev capabilities in which case the
> __set_bit(EV_KEY, ...) would make the match true and __set_bit(EV_ABS, ..)
> would make the condition false.
> 
> But maybe I misunderstood how the input_set_capability() and __set_bit()
> functions work ?
> 
> I'll take a look to this tomorrow, thanks a lot for your report!

Unfortunately (?) INPUT_DEVICE_ID_MATCH_*BIT have never had any effect,
the kernel always used bitmaps when matching (with the assumption that
if one does not care about given bitmap they can simply pass empty one),
so I think what we need to change is:

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index 8b8ac3412a70..0540225f0288 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -87,7 +87,7 @@ static void input_test_timestamp(struct kunit *test)
 static void input_test_match_device_id(struct kunit *test)
 {
 	struct input_dev *input_dev = test->priv;
-	struct input_device_id id;
+	struct input_device_id id = { 0 };
 
 	/*
 	 * Must match when the input device bus, vendor, product, version

to avoid having garbage in the match data.

I suppose we should remove INPUT_DEVICE_ID_MATCH_*BIT from
mod_devicetable.h to avoid this confusion.

Thanks.

-- 
Dmitry
