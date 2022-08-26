Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B255A21ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245368AbiHZHbD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245384AbiHZHal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:30:41 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE680F65
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:36 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id q14so291980vke.9
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JzH/yBDiPGSVsvTOboccFU6n8q0C55ZuWOg9ua6bKxs=;
        b=iLd6fz7nmh1CNlltwZT4WYAQcz4I54iIEcVKGzZSAHyfqS2ySPW44/7T6e2R4ttgs6
         lnXGNal8mb6JhdY4H8rEetcawv5W0Rj4qNaTHEFHcIzJFdcH5tV8AM2MpnrkbXyPOKxb
         qKc5KxV/ooDO3LTibFDmGR7P24AontyNOak3K4q3FRqoT5Hkh+nopF5T880jHopSSuyU
         /khtGjI6w2SBl9AARhVJ15vmttXJ5litQbIvhvoMINoZTwQ+OlR3sIjlRl+C70poH/G0
         S5XHjYUcjWu0kwX0BhaLkbv2gKAhodxvLpjOgnnMcaPREP35MgpijuyP+bTomhA2EZOi
         PGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JzH/yBDiPGSVsvTOboccFU6n8q0C55ZuWOg9ua6bKxs=;
        b=cJwoslpzueGop64KzVKCAMiiOfX2KVAhJ5drVg8hBGxBN3Nzi1iHKNnFYg1SyuDo0f
         /BAwkr0qgYYqwFzZtC/JYjaLUgwF8wCfAMoz46wLY7sAeLHa6E8fnYkaa4KsyIWR+hqZ
         BfKPp4j5rGAkAN+L7P4TmjplIoa9uH5SzTn/IO0Gud9xIxuDOPhAY8E+G19nZYd9F5ZH
         tbLtNz61I4pGEdYralmfg6GZCWqE+nWU9gY/xFLLjxzF76joddcVFUu7Yzd4jUi1ndbc
         68S0BrfS6l66wnSiBaGmML7gMatmNbHR9Le0oYgpwLZOEEXjmlmexjGZ1zyO3Sctydb8
         VZJw==
X-Gm-Message-State: ACgBeo3WZ0WIMACVwibEgLpCU/2VsVvBwYDd1UNMjHutcnDgh1Z9G90O
        A4KQ+PgYhKFrbnF2Gu7/nTQnxqnZKdw/cwqd729csQ==
X-Google-Smtp-Source: AA6agR6+hMVRSBVwb1X5RxsUTb7998H3zRB+TNRJlKgaL3GMrJjUWnK1MlcyJ9doAB9j4TB/lS0il6sWtJsws5Y3m44=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr2815228vkf.37.1661499035088; Fri, 26
 Aug 2022 00:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-7-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-7-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 15:30:23 +0800
Message-ID: <CABVgOSkSMY3ek=5xQL-jPkP53vUCyQXGYmJbwK527fePEEiSxw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] Documentation: KUnit: update links in the index page
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cd717905e71fe3ae"
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

--000000000000cd717905e71fe3ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 10:30 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Replace out-of-date external links with references to the kernel
> documentation, replacing TAP webpage for the more appropriate KTAP
> documentation and the UML webpage by its documentation.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

Thanks. These links are definitely better.

(I'm a little sad about losing the link to the TAP page, but it's
linked-to from the KTAP page, so it's fine.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/index.rst | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-=
tools/kunit/index.rst
> index d7187282ba28..f5d13f1d37be 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -28,10 +28,10 @@ KUnit (Kernel unit testing framework) provides a comm=
on framework for
>  unit tests within the Linux kernel. Using KUnit, you can define groups
>  of test cases called test suites. The tests either run on kernel boot
>  if built-in, or load as a module. KUnit automatically flags and reports
> -failed test cases in the kernel log. The test results appear in `TAP
> -(Test Anything Protocol) format <https://testanything.org/>`_. It is ins=
pired by
> -JUnit, Python=E2=80=99s unittest.mock, and GoogleTest/GoogleMock (C++ un=
it testing
> -framework).
> +failed test cases in the kernel log. The test results appear in
> +:doc:`KTAP (Kernel - Test Anything Protocol) format</dev-tools/ktap>`.
> +It is inspired by JUnit, Python=E2=80=99s unittest.mock, and GoogleTest/=
GoogleMock
> +(C++ unit testing framework).
>
>  KUnit tests are part of the kernel, written in the C (programming)
>  language, and test parts of the Kernel implementation (example: a C
> @@ -45,8 +45,9 @@ internal system functionality. KUnit runs in kernel spa=
ce and is not
>  restricted to things exposed to user-space.
>
>  In addition, KUnit has kunit_tool, a script (``tools/testing/kunit/kunit=
.py``)
> -that configures the Linux kernel, runs KUnit tests under QEMU or UML (`U=
ser Mode
> -Linux <http://user-mode-linux.sourceforge.net/>`_), parses the test resu=
lts and
> +that configures the Linux kernel, runs KUnit tests under QEMU or UML
> +(:doc:`User Mode Linux </virt/uml/user_mode_linux_howto_v2>`),
> +parses the test results and
>  displays them in a user friendly manner.
>
>  Features
> --
> 2.37.2
>

--000000000000cd717905e71fe3ae
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA5
ZDKaDUwVMj1tl9wyLinlP3j9YrShiwQUlSVTa2k1ujAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNzMwMzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAnpZKHveGGwup1DczYAhp
380hJmwlJG48XK0hGqKIEDaPYOFavzstbt/uh1guK8IFksHkfFt+IERpRgJ0em754KGj07YhmdY4
W3Lgh9rF7vI6icv4WJqSSZjFV5cMtisizjaYO/vkU6b4KVlKtYrY0oMYk4PsKYVxUg8zlWaYQv1m
A04vsvkBAVc73azlqz3J/gLEt6LOEXst/cRhcErL6HaOzgKlqKfLBRzV+WuvKcw8zHScy0QODK2+
GnceMqvvLtgPMPmE2uzu1+pnhaVlB6NklRLB7E/AmLTXZC0EoPht5fLU4NxJsgwUR3A0EfWx2gIx
G5+q/mNJ77x3LiXNHg==
--000000000000cd717905e71fe3ae--
