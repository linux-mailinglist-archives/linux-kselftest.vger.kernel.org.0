Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D295F095B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiI3Kx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiI3KxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 06:53:18 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBA1F89B4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 03:33:39 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id k9so2025170vke.4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YhDF3cOr8D7Gknn7OAwNVBSnIe/CF+77P7Y6PeD+pOs=;
        b=D8lbyaaGoQa+2JfcM9V3nu18BQR6tw3aNyi02xhG1HQDDebzugt67G+o402ta5/OI8
         PsO5B681iF4NTxJsXntgEke2kUJbvK93sAXflruWedYfwi5/nyL6fJx6LK3o0mvfSe2r
         iuETCCj1XVF2ClV7EtOaTWiRU2BTqws4V4atxwXfhkfbByzmkLsy3zA2c7DoaSMW3VFB
         FE/T55FvOP0x+KtECN1obqhFOQDgiplhh5/OB5MeXr+M4VQVsBMmwv8KQ7ETvOhG2IRe
         xumzOpbWnj17EoAIA9UhlrSyqsxMX37Nj2JfBxahKSjYt6KhkE84BjHthZc0l+fOyscd
         +WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YhDF3cOr8D7Gknn7OAwNVBSnIe/CF+77P7Y6PeD+pOs=;
        b=0HaxUjMbCJrLsMgkb3DJxY+jrPaaVj+J5Oz8mI6EFFo7ucZ7um4J+h4RxOMLar+v3R
         cVBGyc+RCMjbiPpggOHPqfOdYsK3c2CCXArxDU64XFt8e8rfPxAGsU8SLAGUrg6Falwp
         2DMiIyDesgBBEmG4kFrCbIAPFHx2ggzLC1Z39mvEbeymUe3FF2tn3L2ie686yDAvXTyV
         eLy1CopgYJliPDC8Xtjxi3JeUvFfDXzqo3vKr4soHnRq3HWQL7oN23wecMNX1yFd4/PI
         KtC6HRWU368+DdwZbu3CfhmqcGeZjd3Wu3IpCb+RPKyGQwLfaGzfpGqXlTP7719sU/Eg
         huKw==
X-Gm-Message-State: ACrzQf0ZTsO+Rl4Lmn5ouxz7iURzT2EKKpyPvxN54cbsBkpwasE1f9tm
        FU8osnoxkOt+Z++DB+0AbMKEyCRXpt66aiKwDnlrxw==
X-Google-Smtp-Source: AMsMyM6nbyoDyz9k2QSdCkYfafBjrmxZjndXf3V764uoqR5K95OCvDu5jdtkDA0XyUGTeQ0oyRfvoRkmY+CTiaf1wnA=
X-Received: by 2002:a1f:2f96:0:b0:3a2:8e31:b066 with SMTP id
 v144-20020a1f2f96000000b003a28e31b066mr4029369vkv.34.1664533947924; Fri, 30
 Sep 2022 03:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220929132549.56452-1-bagasdotme@gmail.com> <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
 <464981b6-d9d7-e656-261f-ef48661deaa2@gmail.com>
In-Reply-To: <464981b6-d9d7-e656-261f-ef48661deaa2@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Sep 2022 18:32:16 +0800
Message-ID: <CABVgOSko6kgA_T3LNgTPxQZS8Ab8E+XhMcOGHFx76nd2HN_RBg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test instructions
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b36ab205e9e282da"
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

--000000000000b36ab205e9e282da
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 30, 2022 at 5:51 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 9/30/22 13:42, David Gow wrote:
> >
> > While I like the idea behind this, the wording probably needs a bit of
> > tweaking. In addition, by describing everything in too much detail, I
> > fear we might just be adding some needless redundancy. My suspicion is
> > that everyone who's going to be writing KUnit tests already knows C
> > (or has access to better learning materials than this), so we're
> > unlikely to need to describe in detail that, e.g., misc_example_add()
> > adds two numbers together when the code is right there,
> >
>
> We should just say "First, write the driver implementation" (without
> describing writing C code in detail), right?
>

Yeah, that should be fine. I'm wavering back and forth on whether we
should call this a driver, given that in a lot of ways it isn't one,
but given it's in drivers/misc, it shouldn't be a problem.

> >>
> >> -.. code-block:: c
> >> +   .. code-block:: c
> >
> > Why are all of these code-block declarations being indented? It
> > doesn't seem to affect the actual documentation build, so I guess it's
> > harmless, but it'd be better not to have it change unnecessarily and
> > clutter up the diff.
> >
>
> The indentation for code-block directive is required, since the preceding
> paragraph is multiline; otherwise there will be Sphinx warnings.
>

I don't see any such warnings on my machine (which claims to have
sphinx-build 4.5.0).

Could you send an example warning, and your sphinx version to me so I
can try to reproduce it.

Regardless, if it's causing warnings, keep these changes. (Though it'd
be nice to include the warnings in the commit message, so it's obvious
that these are being re-aligned for a reason.)

> >>
> >>         int misc_example_add(int left, int right);
> >>
> >> -2. Create a file ``drivers/misc/example.c``, which includes:
> >> +   Then implement the function in ``drivers/misc/example.c``:
> >
> >>
> >> -.. code-block:: c
> >> +   .. code-block:: c
> >
> > Again, code-block indentation?
>
> Yes, for consistency.
>
> >
> >>
> >>         #include <linux/errno.h>
> >>
> >> @@ -152,24 +154,25 @@ In your kernel repository, let's add some code that we can test.
> >>                 return left + right;
> >>         }
> >>
> >> -3. Add the following lines to ``drivers/misc/Kconfig``:
> >> +2. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
> >
> > This needs rewording to add back an article ("a" or "the"), and we
> > probably want to call this a "Kconfig entry" rather than a "Kconfig
> > menu entry". Maybe "Add a Kconfig entry for the driver..."?
> >
> >>
> >> -.. code-block:: kconfig
> >> +   .. code-block:: kconfig
> >
> > Indentation again?
>
> Yes, see above reply.
>
> >
> >>
> >>         config MISC_EXAMPLE
> >>                 bool "My example"
> >>
> >> -4. Add the following lines to ``drivers/misc/Makefile``:
> >> +3. Add the kbuild goal that will build the feature to
> >> +   ``drivers/misc/Makefile``:
> >
> > Kbuild goal? I've never heard of this being called a Kbuild goal before?
> >
> > How about a "make target"?
> >
>
> At the time of writing this patch, I use terminology in
> Documentation/kbuild/makefiles.rst, which the "make target" is called
> "Kbuild goal".
>
> >>
> >> -.. code-block:: make
> >> +   .. code-block:: make
> >
> > Indentation?
>
> Yes, for consistency with the first code-block directive.
>
> >>
> >> -.. code-block:: c
> >> +   .. code-block:: c
> >
> > Indentation.
> >
>
> See above reply.
>
> >>
> >> -.. code-block:: kconfig
> >> +   .. code-block:: kconfig
> >
> > Indentation?
>
> See above reply.
>
> >>
> >> -.. code-block:: make
> >> +   .. code-block:: make
> >
> > Indentation?
>
> See above reply.
>
> >>
> >> -.. code-block:: none
> >> +   .. code-block:: none
> >
> > Indentation?
> >
>
> See above reply.
>
> >>
> >>         CONFIG_MISC_EXAMPLE=y
> >>         CONFIG_MISC_EXAMPLE_TEST=y
> >>
> >>  5. Run the test:
> >>
> >> -.. code-block:: bash
> >> +   .. code-block:: bash
> >
> > Indentation?
>
> See above reply.
>
> Thanks for reviewing.
>
> --
> An old man doll... just what I always wanted! - Clara
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/464981b6-d9d7-e656-261f-ef48661deaa2%40gmail.com.

--000000000000b36ab205e9e282da
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBS
dTn5eM0UwGDZj0G389N+RBLTDS8N0iJafMBRxTsPjzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MzAxMDMyMjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeHYl5f455GYZm48dv0ig
2exg798L5pY03qFsN9sG8tgt2EU43yG5xmm3hUTUf2nfLpTLBvvnuaNoe/MvHysFwlCVlyXhNaic
k3+kC8YrYnBk9t5NUSbqbufsFBJQtCg7qEK2FUStxSYW0kKwxMrD9yx1rYDcFoA3KZMfvzCScCa1
NliSItyf3ksxDE3xTINWuVKT+5rcCo2EsI68iBgkSqTG3nAsE0WW3Ei54uugOilUDVsTRAAFjQPW
05ocyUsgrA3+DP1klXZuQpqTZhI7jvVBP2ae1SL2eWxV0kMHobvRDJF1wA8coXKMYjWZjdgd5cHu
o92QG8xcq2yoMuPypg==
--000000000000b36ab205e9e282da--
