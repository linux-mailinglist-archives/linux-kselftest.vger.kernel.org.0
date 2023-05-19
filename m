Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E770965F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjESLWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjESLWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 07:22:35 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DF180
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 04:22:34 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-77115450b8fso1956791241.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684495353; x=1687087353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRr2hCKdfQvq261UXO6uz33JY5ejzmTKmw65c8AVgWQ=;
        b=d54VHoiA5CVoGdYCJ5j4xSSyk06crdCwXJMaVEpil0KPeMo6UQ65rqHlHxJq6kT7Aq
         CYx4+htplxB2TlgkfaD+DuttP82pYyk2ezTgWWwjgkJZ/vdoOUHaz1W5YOOwudVMx3u5
         7Pvv+cDx0u22dm66NgZTlx4Bw3zfwIjLeMNU9V1PzKFJ7RBQTiEuY0YZK49a9BNPv85W
         FNzdsOICv707v1Dne4HaKW828PCWKWDI23Eo+/CevQPnq6xCCof5Mk+SLyGNlUNqSi1m
         KnV7yxHUj/Q8jNygS/XSfE+HnmanLbGhyZqAkoxdpR3Zjo9794MIShaajjaK1scgCtAe
         e7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495353; x=1687087353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRr2hCKdfQvq261UXO6uz33JY5ejzmTKmw65c8AVgWQ=;
        b=CCWKDQdiuCu12EGO54nBVbo2TuDI4iouUbesV+rrZ4hwptHAkMrSvVtVPpXVVRFzRE
         SSiYXyR16tc9lVXSmIr/b/8GttjP9UHijOgNhjrnz2q1if3rPGdL9GdmQ+vluKmCA2qm
         TJTJNdIe1vDlVx211exsUBM67UPkjpxaIjJUlB5NFGK5K5mIVRbHA/bhDBWPoRbqxekZ
         i89B5z9aTz/LmoY6CBkMYpsYC6tMJQFshzOQK/swD/RZz9vr/26FSE4bxtd/d9LXTuR2
         n07gtMW0LFtM4kfGLeRVGX82c7cuVgVGHG0Reza7nBYmBHfRm8vM4aRyvQKFXadzM2nr
         guGA==
X-Gm-Message-State: AC+VfDw6t+M7j5U/w/xIVLPvJYRPtqIFhpSyO1wA4P//lvYVHtcLFFzC
        zAi3KCM7dBrZsw9OIpy5X9H66Txa6jjt8fhJdRvfcw==
X-Google-Smtp-Source: ACHHUZ7m3qaP/XE7vb1368EreQjFE2cU1V3DCULqQOCIm46K9tyTtrCNoT9GRM8U6EPOAVWlCCXig+GTn2cUepThfS0=
X-Received: by 2002:a67:ba03:0:b0:42c:543a:ab2a with SMTP id
 l3-20020a67ba03000000b0042c543aab2amr584690vsn.35.1684495352840; Fri, 19 May
 2023 04:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-3-jeffxu@chromium.org>
 <6dbbc3da-78c9-8101-d52a-0be47da9d67e@intel.com> <CALmYWFtu-WzOTEs2aWU3zMW=KZUjaaL7OTE7hQtHjfwQfQNyEA@mail.gmail.com>
 <c53c03e8-529f-5b72-42ab-f32f50aaab35@intel.com>
In-Reply-To: <c53c03e8-529f-5b72-42ab-f32f50aaab35@intel.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Fri, 19 May 2023 13:22:21 +0200
Message-ID: <CAEAAPHb5wzn6=9sL92-wq7mwT0-iu7NVmzpWM7tSiN85kZYO9w@mail.gmail.com>
Subject: Re: [PATCH 2/6] PKEY: Add arch_check_pkey_enforce_api()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, luto@kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000026e4df05fc0a23f2"
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

--00000000000026e4df05fc0a23f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 2:00=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/18/23 15:51, Jeff Xu wrote:
> >> Do you have a solid handle on all call paths that will reach
> >> __arch_check_vma_pkey_for_write() and can you ensure they are all
> >> non-remote?
> > Is this about the attack scenario where the attacker uses ptrace()
> > into the chrome process ? if so it is not in our threat model, and
> > that is more related to sandboxing on the host.
>
> The attacker would use *some* remote interface.  ptrace() is just one of
> those remote interfaces.
>
> > Or is this about io_uring? Yes, io_uring kernel thread breaks our
> > expectations of PKRU & user space threads, however I thought the break
> > is not just for this - any syscall involved in memory operation will
> > break after into io_uring ?
>
> I'm not quite following.
>
> Please just do me a favor: have the io_uring maintainers look at your
> proposal.  Make sure that the defenses you are building can work in a
> process where io_uring is in use by the benign threads.
>
> Those same folks are pretty familiar with the other, more traditional
> I/O syscalls that have in-memory descriptors that control syscall
> behavior like readv/writev.  Those also need a close look.
>
> > Other than those, yes, I try to ensure the check is only used at the
> > beginning of syscall entry in all cases, which should be non-remote I
> > hope.
>
> You're right that synchronous, shallow syscall paths are usually
> non-remote.  But those aren't the problem.  The problem is that there
> *ARE* remote accesses and those are a potential hole for this whole
> mechanism.
>
> Can they be closed?  I don't know.  I honestly don't have a great grasp
> on how widespread these things are.  You'll need a much more complete
> grasp on them than I have before this thing can go forward.

I don't think the remote writes are a problem for us if they're initiated f=
rom
the same process. It's a case of syscalls where we need to add special
validation in userspace.

--00000000000026e4df05fc0a23f2
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
IE0nAq+EvotYtTh7dWzvuIiOrnYIYYo0wWDwWWRq+Z+QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDUxOTExMjIzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCcv6CjSuln+N+w7eq5
XdOvXNuVF5J/89mVYERuinaf71Cf7CZJaemRjWsIr08MT/piZsGiaD0HF9k1KTkTH8H7pKiI5mMR
cu5PFlFAjOoHNJq243lZuZTWBqhVn/cKiPhrhcKhwblvOgGRZYF8BHQLO2D9GsKpp4m7PY2DgdYN
tjhBimMLr09QKDanxV1LUXzwFWr7bEkefhU8F+zYBpsZF3f3uE7gg0dQ9X2DxdCksOkP22D2w1Pd
mquscqxelRuU2C8fIjyfP1kzSsK5F65Pr9gY9w0o205YuV9NZWDBi5qrgysIt5vod+60vQBDaKDA
5MnKZXDoAREL0OWXHoXT
--00000000000026e4df05fc0a23f2--
