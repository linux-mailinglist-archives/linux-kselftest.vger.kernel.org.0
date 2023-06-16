Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3A732649
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjFPEo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFPEo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 00:44:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8082D60
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 21:44:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7e4953107so35395e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686890693; x=1689482693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMFTyYpDhe02h6zqRBcNOLQgrG+39PW2kTyx/lH9zFs=;
        b=c1suV+5wdjLre9OVPmGTW2w2qkCAQPUMx1Mocox291QMT37D8SZPz3fXUTC61DYDde
         VpXkoRIRsLLSEfB8y5Pw5Mcm3BO5sKLDUB9tFiPhHbpwx8bDdKUJVOVvT+pY3M66+3qO
         ZEc/xjfDzvrPX/G3ZIfcCrLmbwbYUg754+p5yEVQY6a/wB2vvT3Oei6H9yRt/IhFEqyO
         8GD/LnkxCL0XxfXsg3UPppqeKMNzYkx+eq5Uj4cop2J6nWDIzih/9784XQbj28gGPfZ8
         z0Jg8u3A6Tz4rYrOepSDbZmp0d74H1Ad3by+CU5NVRI4Ivepy+jYrTE+N8BsQ/+VdBLA
         5ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686890693; x=1689482693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMFTyYpDhe02h6zqRBcNOLQgrG+39PW2kTyx/lH9zFs=;
        b=D2uOa46uSzGAAgh/sSjJMcdFPhlqPskzBgRcd4z9lfWO/Dzumu3ylTWDYySmmhRm0s
         wNBz08Y+0YMBslfJa90nWIvPBmcAmy9T/HjWcryS4OJnoR0XXAUZrw8O3WOhgk8lvt1S
         zdqhJEGzfA7kpgy+rFsXJef/N+zGIHLauXLFKb2+VD+sIBVdlYWxKyXCkfBxbz5L8ghx
         XzV1Dp0PKtMhCSO18Ev9vX1W2mXHlTOaS3Ds+wcXNdCuAT8dM2FA0/6t3WafYaHx7jgu
         xNThtfogOAd+ooP8hDivYOYyVpDSIytJXWk0tjW7PVhu1jQVYgBTSZLiaS2wRFlW+ot9
         jI/Q==
X-Gm-Message-State: AC+VfDxo968PQUnYFx0L5GG653OWEav/t3ocSNapg7znEEgLNhKs6iqD
        CQgC321Mr7miOH3oScRi9abH2UP+wYocpKk+gKPzJg==
X-Google-Smtp-Source: ACHHUZ43T5o0/QcnCpa8gkggBRo9TYwSRv+3WKVupAW34Bzg40C99N9GCRCSwIj91wqKxc5fZjUj1tZiPKO3LcVPVIQ=
X-Received: by 2002:a05:600c:2255:b0:3f7:e463:a0d6 with SMTP id
 a21-20020a05600c225500b003f7e463a0d6mr355264wmm.0.1686890692987; Thu, 15 Jun
 2023 21:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <ZIps86MbJF/iGIzd@boqun-archlinux>
 <CANiq72kHEddR-D17Ykr3xtU20rDJn517fqHRUX+-kWHjYqu9PA@mail.gmail.com>
In-Reply-To: <CANiq72kHEddR-D17Ykr3xtU20rDJn517fqHRUX+-kWHjYqu9PA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Jun 2023 12:44:39 +0800
Message-ID: <CABVgOSk8bK-xzp-681t0E4j3+tjuraCysD+uUaLaC5otPZzRCQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] KUnit integration for Rust doctests
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008db85005fe37d8c9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000008db85005fe37d8c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jun 2023 at 16:20, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jun 15, 2023 at 3:44=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > Great work! I've played this for a while, and it's really useful ;-)
>
> Thanks!
>
> > The assertion warning only says line 35 but which file? Yes, the
> > ".._sync_lock_spinlock_rs" name does provide the lead, however since we
> > generate the test code, so we actually know the line # for each real
> > test body, so I come up a way to give us the following:
> >
> >         [..] # rust_doctest_kernel_sync_lock_spinlock_rs_0: ASSERTION F=
AILED at rust/kernel/sync/lock/spinlock.rs:61
> >         [..] Expected e.c =3D=3D 11 to be true, but is false
> >         [..] [FAILED] rust_doctest_kernel_sync_lock_spinlock_rs_0
> >
> > Thoughts?

I like it.

A part of me would like to keep the
kernel::kunit::info(format_args!("    # Doctest from line {line}\n"));

If only so we can preserve the line information when the tests
actually pass. This is something that'd probably ultimately fit as a
"test attribute":
https://lore.kernel.org/linux-kselftest/20230610005149.1145665-1-rmoar@goog=
le.com/

For C tests we're not bothering outputting line numbers now (though
again, are considering if we can do it with an attribute), but those
tests have much more searchable names, so I think it still makes sense
for the Rust ones.

How about printing something like:
    # source_line: {}

kunit.py will hide this when the test passes unless the user
explicitly passes --raw_output.

>
> Sounds good to me. However, David/Philip, is this OK or do you really
> need/use the actual/compiled source file there? If you don't need it,
> does it need to exist / be a real file at least? If the latter answer
> is a "yes", which I guess it may be likely, then:

I don't think there's anything automated using the file:line in
assertion messages, it's just for human consumption.
This may change in the future (and there are probably some text
editors around which will turn a path like that into, e.g., a
clickable link now), but we're not currently doing anything which
would actually open the file.

>
> > +        let src_file =3D format!("rust/kernel/{}", file.replace("_rs",=
 ".rs").replace("_", "/"));
>
> This would not work for files with a `_` in their name, like
> `locked_by.rs`. I guess we could still find the real filename based on
> that information walking the dir, which is another hack I recall
> considering at some point.
>
> Otherwise, if "fake" filenames in the line above are OK for
> David/Philip (I suspect they may want to open them for reporting?),
> then I guess the `file` one may be good enough and eventually we
> should get `rustdoc` to give us the proper metadata anyway.

Personally, I'd think a "fake filename" is okay (especially if it's
temporary until we can get the right one), though I'd prefer there to
be some indication that it's "fake": maybe leaving the _ separator in,
or wrapping it in brackets, or something? Unless the whole
walk-the-filesystem technique ends up being worth doing, so we don't
have a significant chance of the filename being dud.

-- David

--0000000000008db85005fe37d8c9
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBI
P+O6+dazwqrc99kmjSiKXG19WMYN3V8rL7GAvD4E+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTYwNDQ0NTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACxnsFaji0414XS7qtM7N
uqz+d5OLI+GKrv4wlG/1kcK20DsR5CbqeGZqFsAkTw5QTgYaXCVSBXrzrNKJ9He2e5pTJsvnDbv7
/KrT4qBd+0e2ECpB82eMnM9E2reOzgULuiurWKi4btSP7vgH+VLwxlk7oY2tSSkEvngvsWblTw94
bAcbxoXP8J9TWH3oDQYjlaS3kMu6U++2HSda5GjFjsPzNSf/1X+0CqzgdOnMMxPYyXpyn6x1Ofmn
CS5maYnM8guZNT2lU9KWytFWCyPxogp+W+lND2xhNSgkeEjc6IJE3RhzpKU3A0g5TRkgd157YD5y
ppLj1PbSJLUw1yWw6g==
--0000000000008db85005fe37d8c9--
