Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7170662A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjEQLHv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEQLHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:07:39 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C07ECE
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:07:15 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-783ef1c0cfdso4972920241.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684321633; x=1686913633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRJu1jGUGVvN1msspqaaI+U+uIwWZBeNHHb9010WYe8=;
        b=RnSAUQ/u0BGBozFqRY7+BMPrw+/kY1IXb7omVM6NyRmJRrDt+5xQotUfVjUjPH5yiA
         5do8vIH95frPNz2ENpOZ8/pf8Q0S0BHXKcVPYPV7OOwOOyDGk55kuEA6n97tJUBs7kwU
         fE/J8D6F/sWA8yxw5viujajOXti+IA/i6m08t6Z90EYI3sde3eo0e3awXUb0DfvGuXqm
         kkZa3yUgYNVx9CieG2jr6Wk8s4fR4s44ApacxfdcoSvDf6h7Ko+av6B5x06U4rWvZRxk
         r2JMxVJ8RRC3Hm8MLeWmORnuGhlrsZ5jS/SB+CXHFe6hlggjChTjaltzYYc79IQ4Z9BV
         H2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321633; x=1686913633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRJu1jGUGVvN1msspqaaI+U+uIwWZBeNHHb9010WYe8=;
        b=Mk98n1wWHKPEJA/Ep7e95sR2bz+sw3NnKBY2Q00ugLoT6ZbvuwxzmYEtjNoX4jgSEh
         nxqXF5M5p4g5N8nfAQzFN2nGconVeiwQbQZIXSh8Jmb+wW+oTsaaYi6ntjErafdudvsr
         mfKvY62UQF+olkz/+teJOM6e6pCGMyePICJybVrwzrDzGkz/75gGKohKG+iRE5moNTUN
         EIRl983ktN7EhLCY8mPASZgeRhQPE/gAbn7ZkcK93bJ7LXOAB3Ps2IKyC8zY91C/3WN3
         5uKtkv2reaYI72rEx2Z0i7HA+zH+NlFLaz3NaROq9633Z0Zl4Wcc/W8cEHj2ofXP6ODU
         17tw==
X-Gm-Message-State: AC+VfDz5cAqGlD3ebvU79tCYX7EY2+mrgUOadkJT0mf1azNXs9RfnHD/
        vvp5PfSHsTG6EdDXWYesXremCtku8QQ27ihMa1XvHg==
X-Google-Smtp-Source: ACHHUZ7NGWDwURvS+B/o20Pj1OlKKl8DdgirNwoFFAASL3RFJKZSpkMAoFKJJ0fqdOUdcBhe5ub9s9qt5fz41p672YQ=
X-Received: by 2002:a05:6102:1506:b0:42e:5b08:ec71 with SMTP id
 f6-20020a056102150600b0042e5b08ec71mr540575vsv.11.1684321633590; Wed, 17 May
 2023 04:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-2-jeffxu@chromium.org>
 <6cb7df56-0479-30be-5389-b4b819572deb@intel.com>
In-Reply-To: <6cb7df56-0479-30be-5389-b4b819572deb@intel.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Wed, 17 May 2023 13:07:02 +0200
Message-ID: <CAEAAPHYBEEbWu7kGVSi+TDQWypc+dNFKWBw9Y_LNf+nEL+Pf-Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] PKEY: Introduce PKEY_ENFORCE_API flag
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ad6d0105fbe1b01b"
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

--000000000000ad6d0105fbe1b01b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 1:14=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -20,7 +20,7 @@ int __execute_only_pkey(struct mm_struct *mm)
> >       /* Do we need to assign a pkey for mm's execute-only maps? */
> >       if (execute_only_pkey =3D=3D -1) {
> >               /* Go allocate one to use, which might fail */
> > -             execute_only_pkey =3D mm_pkey_alloc(mm);
> > +             execute_only_pkey =3D mm_pkey_alloc(mm, 0);
> >               if (execute_only_pkey < 0)
> >                       return -1;
> >               need_to_set_mm_pkey =3D true;
>
> In your threat model, what mechanism prevents the attacker from
> modifying executable mappings?

There are different options how we can address this:
1) having a generic mseal() API as Jeff mentioned
2) tagging all code pages with the pkey we're using
    (would this affect memory sharing between processes?)
3) prevent this with seccomp + userspace validation
If we have pkey support, we will only create executable memory using
pkey_mprotect and everything else can be blocked with seccomp. This would s=
till
allow turning R-X memory into RW- memory, but you can't change it back with=
out
going through our codepath that has added validation.

There's a similar challenge with making RO memory writable. For this we'll =
need
to use approach 1) or 2) instead.

> I was trying to figure out if the implicit execute-only pkey should have
> the PKEY_ENFORCE_API bit set.  I think that in particular would probably
> cause some kind of ABI breakage, but it still reminded me that I have an
> incomplete picture of the threat model.

--000000000000ad6d0105fbe1b01b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
2DeNJUdew/schvbvw4wolIIwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAEWztMCBdTNW
CGPLcNM/ovJHsl+VF/BsKdiiwJoodyWO9fmhOgEVex1vfc+njM0bkWC0b4U08iUPP91eksCFGhhi
cCchsXpkAzfcKPJ7OsFd7J4xQUQPpi02r1P7Y9UKLa8nsNChf9ck1GAz1Skb77r1JWgSlHOcyuVZ
UQ/JuUVMf/XW7flFfNybswGgFmfnBvDW1qrqBPHpEFmWeNYXISpFQj0UWyGmykQGKi8q44IPy5Qg
uId+alGaBDlL5OAZQtmhRyh1MVd2wtgvGEfNGDGq603urx17nwEvM1gjSmOgnhEigOhhHH7DOeyt
5zPYLaKguxLWPGXlZ0UUjA7lH3gxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAGkX4MOebzHzp8Y/d5NuOkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IMYb5TzgLLmy5EG6JB7gXi85H2/8tKyDlwIITx9Ez1Z7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDUxNzExMDcxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAVLvtya17hISoD6P9X
fnV4fODrLsXCkUWrRL5dQJKIVYjYsqY6np805kYAgnltdEM0bkHoqt0Y+4yixCGMzMejZwR38kSH
+A5o8Ps5Fu8L1lM8Erk/vFjSNsdTm+yv4xmRk7F4plDUfD+kQASe/MSg9x58SSw9yj6egW9PhprA
hb6GCxdx/6ocgt/6j5o9Kvo4U8uEXutFyHD2xdxb/4ZCO2kalMwKaLnz69DumEDDScEjeaKVkRYq
5KKjMWSQVrNGzXsUKAzPqidMBqPqvEegMpw1DIYG7Zax+8hVS2r0kb2wQRJsLndXlwAehbGlpxIU
+gngFFEiubN3TyidKW38
--000000000000ad6d0105fbe1b01b--
