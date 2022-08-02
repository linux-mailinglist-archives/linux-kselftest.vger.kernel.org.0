Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6316588292
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiHBTgg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiHBTga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 15:36:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88448C97
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 12:36:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r4so11173758edi.8
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aaD1/id7gyKouJVmQNJY9f6188MpOysssLKoUbqq4b8=;
        b=nA/xg0vsdX5YrdNIYVmC2C7Xh/mXbe1P7sJxymX2VUq3fyoCewB0e1URLTDKnK3fYm
         NxUPE+J079dmSmZG5KpJY1CS53LeGiQYBt3jcfyoHxAHIw/iPGKZvstFc89NodQBkXYd
         yQUtxta7axgaXWT4YsDO6gRm92NNX8y6jXOOI1yH7Hs92IuuBjfbrlW2udNBYNGBl1wh
         b7sfnlKUL64mlH1yHLrnFd32bb7w+ovNJnIb7IjZBS9AofHGgbnI2aqCQW3HArseQJOz
         dsa+1DOmO2sPFyY28RyKYJOHKvW6uMVGcrmo/tIy6Yi8xjHaLTz82vtqiQotKXWIPfDA
         Gj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aaD1/id7gyKouJVmQNJY9f6188MpOysssLKoUbqq4b8=;
        b=kBY6LFfXyXlSsSyQmLYzZfwbODpO0VBgl9YFz1PR2a8y6xdfqD5ZkIEM4CMAz6c4Db
         mbQ2jt1icWqypK+1VwbgpG0NC6dktW/mQcD3jRlHP7PLo2E24caNhMNfVYlDOwwcW/EN
         jVYDocMRfEZ96ZKGHfP2R8CPyCIpkPerHd/qMziP4pQiHh+g5/OdRrFVZCZ1pvnIg33F
         /gK1tk3HU6RnpvjhBUZbSeNurMDM9ar2A2/9GqxJz42yt9UsHaQkdTaPlk+vJf3oYXSY
         R+oTL+0DAtDa5XJLLVbtxY2B3kPKlr/qYT1JCOCJYLPkBLNGpAc8Q6tJxPTjBmlnFCTg
         YzvQ==
X-Gm-Message-State: AJIora/jtJYMuK5OwHcOQcuL6ZGusr5/UNTBD4xNKEB3Zv7LT5bCqqfz
        MVTev0mQMEzhGdQ/Mt/l7dPQZxIAlb21nS7HEoEluA==
X-Google-Smtp-Source: AGRyM1vpKpXO8pOZ5GjGvjcvRwqaS15bgJIcxy2epC3XA7mXS2FyFU/8y3yLjhmGvFNRmmv7VhRXpdOW9OO2Ni5rS94=
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr22449354edq.378.1659468987456; Tue, 02
 Aug 2022 12:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <CAGS_qxoAc934AwB7SZ34PpoVxvF3Eua-g+aO77kjJf6d1m0+Qw@mail.gmail.com> <2a0dcd75-5461-5266-2749-808f638f4c50@riseup.net>
In-Reply-To: <2a0dcd75-5461-5266-2749-808f638f4c50@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 12:36:16 -0700
Message-ID: <CAGS_qxpYYC+k7b+-txWxEgE-VTwCF5R+WVf=qwbf3yFurcLK3w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 2, 2022 at 11:43 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
> > But perhaps we could instead highlight the bad bytes with something lik=
e
> > dst =3D=3D
> > 00000000: 33 0a 60 12 00 a8 00 00 00 00 <8e> 6b 33 0a 60 12
> > 00000010: 00 00 00 00 <00> a8 8e 6b 33 0a 00 00 00 00
> > result->expected =3D=3D
> > 00000000: 31 0a 60 12 00 a8 00 00 00 00 <81> 6b 33 0a 60 12
> > 00000010: 00 00 00 00 <01> a8 8e 6b 33 0a 00 00 00 00
>
> My problem with this approach is that the bytes get slightly misaligned
> when adding the <>. Maybe if we aligned as:
>
> dst:
> 00000000: <33> 0a 60 12  00  a8 00 00 00 00 <8e> 6b 33 0a 60 12
> 00000010:  00  00 00 00 <00> a8 8e 6b 33 0a  00  00 00 00
> result->expected:
> 00000000: <31> 0a 60 12  00  a8 00 00 00 00 <81> 6b 33 0a 60 12
> 00000010:  00  00 00 00 <01> a8 8e 6b 33 0a  00  00 00 00

And yes, that's a good point re alignment. Handling that would be
annoying and perhaps a reason to leave this off until later.

Perhaps in the short-term, we could add output like
  First differing byte at index 0
if others think that could be useful.

I'm quite surprised I didn't notice the first bytes differed (as you
can tell from my example), so I personally would have been helped out
by such a thing.

>
> Although I don't know exactly how we can produce this output. I was
> using hex_dump_to_buffer to produce the hexdump, so maybe I need to
> change the strategy to generate the hexdump.

Indeed, we'd probably have to write our own code to do this.
I think it might be reasonable to stick with the code as-is so we can
just reuse hex_dump_to_buffer.
We'd then be able to think about the format more and bikeshed without
blocking this patch.

But note: we could leverage string_stream to build up the output a bit
more easily than you might expect.
Here's a terrible first pass that you can paste into kunit-example-test.c

#include "string-stream.h"

static void diff_hex_dump(struct kunit *test, const u8 *a, const u8 *b,
                          size_t num_bytes, size_t row_size)
{
        size_t i;
        struct string_stream *stream1 =3D alloc_string_stream(test, GFP_KER=
NEL);
        struct string_stream *stream2 =3D alloc_string_stream(test, GFP_KER=
NEL);

        for (i =3D 0; i < num_bytes; ++i) {
                if (i % row_size) {
                        string_stream_add(stream1, " ");
                        string_stream_add(stream2, " ");
                } else {
                        string_stream_add(stream1, "\n> ");
                        string_stream_add(stream2, "\n> ");
                }

                if (a[i] =3D=3D b[i]) {
                        string_stream_add(stream1, "%02x", a[i]);
                        string_stream_add(stream2, "%02x", b[i]);
                } else {
                        string_stream_add(stream1, "<%02x>", a[i]);
                        string_stream_add(stream2, "<%02x>", b[i]);
                }
        }
        string_stream_add(stream1, "\nwant");
        string_stream_append(stream1, stream2);

        kunit_info(test, "got%s\n", string_stream_get_string(stream1));
}


static void example_hex_test(struct kunit *test) {
        const u8 a1[] =3D {0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0xde,
0xad, 0xbe, 0xef};
        const u8 a2[] =3D {0x1, 0x3, 0x2, 0x4, 0x5, 0x6, 0x7, 0xde,
0xad, 0xbe, 0xef};

        diff_hex_dump(test, a1, a2, sizeof(a1), 8);
}

It produces the following output:
    # example_hex_test: got
> 01 <02> <03> 04 05 06 07 de
> ad be ef
want
> 01 <03> <02> 04 05 06 07 de
> ad be ef

It doesn't handle re-aligning the other bytes as you'd pointed out above.

>
> I guess the KASAN approach could be easier to implement. But I guess it
> can turn out to be a little polluted if many bytes differ. For example:
>
> dst:
> 00000000: 33 31 31 31 31 31 31 31 31 31 8e 31 33 0a 60 12
>            ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
> 00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
>                        ^
> result->expected:
> 00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
>            ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
> 00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00
>                        ^
>
> I don't know exactly with option I lean.

Agreed, it doesn't scale up too well when pointing out >1 buggy bytes.
