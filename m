Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86065682247
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 03:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAaCim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 21:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAaCik (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 21:38:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD21285B
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 18:38:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k16so9372279wms.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 18:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYaDNu+9KzxbMh0Dbvao1nHBdpDDG8sP7IKWelOHQ84=;
        b=T9+OD8sJzc8s26tCIMcdQMr0nYUiHAiyIBWitTckpjXkVUQcuqePGILmAF++sv2B7e
         oBh6+PIscsz7aL2cgU39pkHeI13/C6W5ipbiaRBlumTOQpUxnrw2PAM4JxFBymS8CGkM
         NrdmF+uasmqBbiYiS9JHN+WxiKMMXZifKI7O17k+aFbKalvdYTuJ0LQuy1l1qY1XTdOz
         p2AOb0x01AhFbhC20VWU0Ko3+g1GKZmYLH2RqgWbihzADbRyWLzwMmMmTmiAce8rdyAF
         pMtmVCva2rJc01fpJH38hYYh8oqf8aCKuAkGc+ALydcLAYSs1mH8cI05qJtS41I8X9en
         tL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYaDNu+9KzxbMh0Dbvao1nHBdpDDG8sP7IKWelOHQ84=;
        b=bTNeY+u87ebOzIWDRWsboE0/5lNYbLAS8mXzR33EBLqMrWc6H/TBsi8XwswofK5fqV
         XzLQPPfT5LtQ6AB8Uws1QODKuecEVfMTS6xwe0Rr1KMmqWUzsBNsk1nV3so9ASlWvff3
         gHftxsHDUgnq2ayaT7SRDocHJoOIV95rtAxmaXJ6ruezhIx4/wb33eS1PgLkPAgTxgAG
         tHkW6vESAQbWDBR4RlaDhf5dpfOyAkuBhACjUolQW6mxUZcorMnQtASYbzocM3PDrf2z
         TqbbctO/s5erCxbfXEWKjBz8TKIdSm1zEW1E/NJ2RahNUOx3iUgCVs6C7tgMEwodDmFo
         Ru1Q==
X-Gm-Message-State: AFqh2kqUlZ7/KQfxR/qvazlADBkr4k6xE0RPCjPDQyRAFpN6Du1LQDVz
        pJpQtKPVZLcPwYkYnVwPJM01hJh+ZnpIE8qfEIrivw==
X-Google-Smtp-Source: AMrXdXuC1hAAE0czNXWYE8UAVNO0QRlt/WvvlF5K5TJnmJ92XOQ0j2wIcbVSWRzQFcOImZZrlkDBuAu/mpFRIo0/QfA=
X-Received: by 2002:a05:600c:1d8e:b0:3d9:ebe0:f7f8 with SMTP id
 p14-20020a05600c1d8e00b003d9ebe0f7f8mr3755969wms.99.1675132716624; Mon, 30
 Jan 2023 18:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
 <CABVgOSmZsAQcf6Ou_tyZL=hpiJcxMxXzmMfV5wRyCPBsb_d0UQ@mail.gmail.com>
 <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com>
 <CABVgOSnRC3AuUo4Qc2K3pXEcj3Wbt9LE2DTbejGrPOCKefxB2g@mail.gmail.com> <CAK7LNAR8D6E_md3=1dLAc-o73xmKXDRXv9Fi_hiav1VhPSW58w@mail.gmail.com>
In-Reply-To: <CAK7LNAR8D6E_md3=1dLAc-o73xmKXDRXv9Fi_hiav1VhPSW58w@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 31 Jan 2023 10:38:23 +0800
Message-ID: <CABVgOS=sS7Dx+N3agbAGQ2BfwDuTT1JyApGaw4kZE5e9HrMuFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] .gitignore: Unignore .kunitconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008b15bd05f3863a59"
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

--0000000000008b15bd05f3863a59
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Jan 2023 at 10:11, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Jan 31, 2023 at 9:01 AM David Gow <davidgow@google.com> wrote:
> >
> > On Sat, 28 Jan 2023 at 22:37, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Jan 28, 2023 at 3:56 PM David Gow <davidgow@google.com> wrote:
> > > >
> > > > On Fri, 27 Jan 2023 at 22:56, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > There are almost dozen of .kunitconfig files that are ignored but
> > > > > tracked. Unignore them.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > ---
> > > >
> > > > Thanks! Only the original root-directory .kunitignore file was
> > > > intended to be ignored, and that's no longer as important, and is now
> > > > in the build dir anyway.
> > > >
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > >
> > > > Cheers,
> > > > -- David
> > > >
> > > > >  .gitignore | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/.gitignore b/.gitignore
> > > > > index 22984d22d29e..e4f2ba0be516 100644
> > > > > --- a/.gitignore
> > > > > +++ b/.gitignore
> > > > > @@ -100,6 +100,7 @@ modules.order
> > > > >  !.get_maintainer.ignore
> > > > >  !.gitattributes
> > > > >  !.gitignore
> > > > > +!.kunitconfig
> > > > >  !.mailmap
> > > > >  !.rustfmt.toml
> > > > >
> > > > > --
> > > > > 2.39.0
> > > > >
> > >
> > >
> > > Why is this a dot file in the first place?
> > >
> >
> > In short, historical reasons.
> >
> > The long answer is that there are two places "kunitconfig" files are
> > used: as a user-provided file with their preferred test config (which
> > is kept local), and as a recommended test config for a given subsystem
> > (which is checked in).
> > Originally, no .kunitconfig files were checked in: one was either
> > autogenerated or manually modified and left in the root source
> > directory. This eventually moved into the build directory, and a
> > number of features which de-emphasized it in favour of command-line
> > arguments and the (new) checked-in per-subsystem configs, which
> > probably shouldn't be hidden.
>
>
> Do you mean there are two types for .kunitconfig - auto-generated ones
> and check-in ones?
>
> If this patch is applied, is there a possibility where
> auto-generated .kunitconfig files would be accidentally
> added to the repository?
>
>

I wouldn't think so -- the auto-generated ones live in the build
directory (which is itself '.kunit' by default). You'd have to go out
of your way to do an in-tree build, and then add generated files.

-- David

--0000000000008b15bd05f3863a59
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC1
xMmWMVUlvWM/r5vpKX8z81FClR9i+WmcEZtjhjRDZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMzEwMjM4MzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAuFvogl7VwDeHBljPsTMs
kQEyFOicaZDkO3ePeP6QvovBgzdUDTKqDJ5qkienlUHsjgHq9gmLGXCAnm+ACPlMKp/AS1uWMOPj
E0uabpqy9l2jA26CAgBM+Rxc/5jAJA3ANFVd9sGq4UczwgDfjQWhrj+Ke+SPHRbFj9Twu9Ay/hmy
Lp15P2x2DZiYloBhivq3VxFaUr5h8hpRUKlTC1lMQXIt1trKWkH9dzitMx/o1Z/gFmdSNwcieRXm
+MEYzyv3JXFCeoD/9Kid8TqI4jmUt5Xozw7cR455A7hqS2B1ss4bGP8uTrwO/xHxOqXGF5sn7APv
su6fQh2NjGjZ3F9MZQ==
--0000000000008b15bd05f3863a59--
