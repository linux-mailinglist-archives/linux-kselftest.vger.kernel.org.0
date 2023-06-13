Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509372D697
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjFMApc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 20:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbjFMAp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 20:45:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53EE52
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 17:45:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7e4953107so22015e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686617124; x=1689209124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8vT5KUdtuQu73+eBhZn9tJbok4WdeQ5IRcDeE1gJzkQ=;
        b=GkFHzJvk7Wyeo+YZJZVusFDJAWzK4h9zhAMemtMXVf5fXNino91F3Cr8ivpQd9Adfk
         I3mXV+2Z+5BEMkX4dYPdflxiA/t8RHY83BILdWpCtQ1xW+eW7I8fiQu1WDwA4G2TyYX5
         EJAW1PQ1lskjpyjRu+66CW51sN20Pso0PqYAFERzuwrCaYmFBVOaYTTzm1e0OCn3L0aN
         zw+RHIuWLHSTJPab4dMt82/t1X0n4uoo++5JLpCXPjyrMj8rT4b7oPRAgLLWC1hIWEWF
         Jeqw4ZOKr/KvbzA8tYhjkelrs9LMmDh04AhsBOTIxi/ZqyuEt5MolHUg3iA1mksOl/AA
         Z4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617124; x=1689209124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vT5KUdtuQu73+eBhZn9tJbok4WdeQ5IRcDeE1gJzkQ=;
        b=RHJOYgiFoo2bWHkKruFZNGWjztA6yGGKE5PLx7XuyobBP0+yCtLU/9b7UFAsdeo9z+
         NdLT6cRKQvzQkm8MM+6oPREuXBw2zEdiXBa+abtyICRF2dBbb7pz4Qy2YuMl1Vy2GrtJ
         P+SFAnUNBD2tpoIevofVJT26qJG0C2DAxyqMKU5Kwl1sGoMgO9BS+GFmdBuHpsDCg0yt
         1zngS9bsDjTDjPfMc88twHyBHESCv0bgrigng1wlSRwVpmjNXwmg+jLSETZwYUVq3aVY
         VCncrEtt92DsIq/GkJpldO+OdTF13gcarbbBWl7sKcbV4ErObnaM9rRx6xV0FZHw/rky
         ClLw==
X-Gm-Message-State: AC+VfDzBzjBLAK4ZGwrjbolowS2e/Bnhh3U2WAqROWp3cdsbmZ3OMXvc
        W+ftt89S9slHJJhYco9uPerrISuTbu8qn5eFI2pljQ==
X-Google-Smtp-Source: ACHHUZ5WTyrKxziSHoWNuXKIdm51hYH6mMm4Obd5cB1SpLcdXb9/uE7Zx7lyq0jR2Hq7bKjB8sLuousPm56XJp+7hls=
X-Received: by 2002:a05:600c:4f94:b0:3f7:e59f:2183 with SMTP id
 n20-20020a05600c4f9400b003f7e59f2183mr7255wmq.5.1686617123959; Mon, 12 Jun
 2023 17:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgOS=HpS9g+YwLth2xpY9i2u3DxLzbbPoqnJshhAhU2fB_pA@mail.gmail.com>
 <20230613000130.85038-1-sj@kernel.org>
In-Reply-To: <20230613000130.85038-1-sj@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 13 Jun 2023 08:45:11 +0800
Message-ID: <CABVgOSkLDSneCiTqz7fD4sCJLJ_cnZkHUBSL2B67-HGc_Y6kmw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add source tree entry for kunit
To:     SeongJae Park <sj@kernel.org>
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000091b16505fdf82623"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000091b16505fdf82623
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jun 2023 at 08:01, SeongJae Park <sj@kernel.org> wrote:
>
> On Tue, 13 Jun 2023 07:54:01 +0800 David Gow <davidgow@google.com> wrote:
>
> > [-- Attachment #1: Type: text/plain, Size: 1120 bytes --]
> >
> > On Sun, 11 Jun 2023 at 02:05, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Patches for kunit are managed in linux-kselftest tree before merged into
> > > the mainline, but the MAINTAINERS section for kunit doesn't have the
> > > entry for the tree.  Add it.
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> >
> > Thanks very much.
>
> My pleasure! :)
>
> >
> > Given KUnit work happens in the kunit and kunit-fixes branches here,
> > should we note those as well?
>
> That makes sense, I will add those in the commit message with the next version
> of this.
>
> >
> > -- David
> >
> >
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ce5f343c1443..8a217438956b 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11327,6 +11327,7 @@ L:      linux-kselftest@vger.kernel.org
> > >  L:     kunit-dev@googlegroups.com
> > >  S:     Maintained
> > >  W:     https://google.github.io/kunit-docs/third_party/kernel/docs/
> > > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> >
> > Should we also mention the branch here:
> > git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> > kunit
>
> I think so.  Would you prefer having only one 'T' line with 'kunit' branch?
> Or, both branches like below?  I have no strong opinion.
>
> T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
> T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit-fixes
>
>

Let's go with both, assuming no-one else objects.

Cheers,
-- David

--00000000000091b16505fdf82623
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB+
QFLI7KyZbcis48Ch0hKHaJKiCJzscsjZMMx0Ode+VzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTMwMDQ1MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAc8JCxni/WQOKRy4BnsDb
y9n/ww4EE30RwuO2kuEQmy9nenlcKBB2PtqJ/RLw9FYZEbPJ8W9PHzD5bvnPOlhEXG0IZmAuZWl9
WNIavcNj+v8P17WVyarA5LkRWTGXZ8+vhHsi/4Ljzua4iDAKRaY1Ovb5EiIPbvwAeAYq3YR3JmfG
FnJDm3OYLGmN3aDhMTpGd6noJSVU6RPww5YsBqd4w2K0e4PAxUzl2Tyn2QfHwWPFlqfEd+0u2BTX
wk74npHf7aCWaMvLgnTRke8OYoTV6keq+IX5Fi7+QK1mAfh6dQaFzum1EqAZhKdu+Z+Ivorq2ZyP
J3kbvhXKx/e8xnxQcw==
--00000000000091b16505fdf82623--
