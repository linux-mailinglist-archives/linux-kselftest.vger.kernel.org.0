Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDE706594
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjEQKtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjEQKto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 06:49:44 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44CA97
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 03:49:42 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-43604f20944so361789137.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684320582; x=1686912582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwwiIHK9a1q2/ndO+HC+apozq4JcPQFF2zphJTS39b0=;
        b=U1sWVLPQrshiP+vt1IViX6+QsGL5mx1diAOWY9Ivb07ItxJ5Ydn8VlXsmuZdl5ZNw1
         9BOEYWZqKO4LZCa91UwR91GXEJNMKNjaYVknM63TV6rmQa7dKPX07xHLw04cm80+71xm
         UHHHLQ0aAuztrx6AT+W9kdb4YiC50u7/dIP3dcDP4gZJ/X7iC6XNgAKAPmkbqcMpZNee
         uqxuD/fso697VTAdDL7rLYVEasK6mrBPNx5Ltsxzjslk/i49fbQXS1cbXHi8HrR5i0xY
         wq9SaGvAZtVxO0aMEV29nXl5tyuV62tHk8VGd/oAqtjMdQFWzwFIuRiCZgFAUiLolVtA
         /uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320582; x=1686912582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwwiIHK9a1q2/ndO+HC+apozq4JcPQFF2zphJTS39b0=;
        b=NDWivdac2qVkkVpnlyvxq0AtENaZIhLAftJ55jLim1z81FBfLQ4837TBsJ5C1sl5Y/
         4gfHeJQQIqfBLVMj9YLUAOS3EKiZnn/NqMbQAdNN+92KeITb+Jc9i4EBxFRwnbG0ZKow
         fuPaIQPMasMYHmJjuJFM0z3vrN5eG9aVwxeSBim5UrLVb74fr8Auhf/IJ5yfqoqGZHks
         xkgSdSKkSWV6KhlfRoUxd5vmBe/DFlDf3aqnenDcTHiDk1UfAoqZ3m4DXTFCZKLK0FjX
         XDNeVOUYTe5vVgY0vqrA9eR7eTh4jkNOvAAbzO7ezP6XXrYV1ejmjfLAoC6IuxQkndq4
         apHg==
X-Gm-Message-State: AC+VfDzfWycK7W8ZlXrUYEW1czEhfpuCPxYdOLE1Q8xMl+djeRI+XOjd
        NL/xyVr9/8vy7G4Gb7gTAkvc3kiW/+lVbNQ8q6iq+g==
X-Google-Smtp-Source: ACHHUZ5XIVB9cSnyGkPwnNROE+X+rE6yITb1RkOAokMaOKl5265EQa54Etj7fujoMW0JpCmqvEkAbitPcHPrjKVM9lQ=
X-Received: by 2002:a05:6102:384:b0:42c:3457:6718 with SMTP id
 m4-20020a056102038400b0042c34576718mr15375115vsq.5.1684320581922; Wed, 17 May
 2023 03:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <202305161307.4A16BB6A47@keescook>
In-Reply-To: <202305161307.4A16BB6A47@keescook>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Wed, 17 May 2023 12:49:27 +0200
Message-ID: <CAEAAPHZ2qv9hwM5p=UgieGND_52_GP-cx2rnXCzM9cJNgB1pow@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fea5f005fbe17147"
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

--000000000000fea5f005fbe17147
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 10:08=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Mon, May 15, 2023 at 01:05:46PM +0000, jeffxu@chromium.org wrote:
> > This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
> > function. When a PKEY is created with this flag, it is enforced that an=
y
> > thread that wants to make changes to the memory mapping (such as mprote=
ct)
> > of the memory must have write access to the PKEY. PKEYs created without
> > this flag will continue to work as they do now, for backwards
> > compatibility.
> >
> > Only PKEY created from user space can have the new flag set, the PKEY
> > allocated by the kernel internally will not have it. In other words,
> > ARCH_DEFAULT_PKEY(0) and execute_only_pkey won=E2=80=99t have this flag=
 set,
> > and continue work as today.
>
> Cool! Yeah, this looks like it could become quite useful. I assume
> V8 folks are on board with this API, etc?

Yes! (I'm from the v8 team driving the implementation on v8 side)

> > This set of patch covers mprotect/munmap, I plan to work on other
> > syscalls after this.
>
> Which ones are on your list currently?
>
> --
> Kees Cook

--000000000000fea5f005fbe17147
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
IAsDym7QVgBaFxPG4GvyOQtpPwYKLTA60kllYbOQJ1vsMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDUxNzEwNDk0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCf85LtV9budX9oqTK1
kOVGxm/TmBb/4NS1ZOkwvYTEuYKL1fuj/Hyc3CYoLUSq/81Xkbm6kv8VEXzEBj8o0Ke2zgqlYJ2D
phxgbe5qK3SX2Pj45cf4uT+SDuptuu/lQkIyOeILy/U35e9JfzP2TCOW9ciEAGFhUh5MeHgs15K+
j9ezortF6HzAUGxSQhKNr/hfEEu46L0pgMBB7lofJfX9tDWKtHvtoxW+GIK1HBCGQRmOZQfT4bdB
M3G/8sD3zg8HT+Qf3sZrI+3KqbEr6G12ZFDRz4XqWhHGPD8ETVv6F1Vwpg633u9tDRqhnsJzjMMu
m3y+2aaWHroATh5t7d64
--000000000000fea5f005fbe17147--
