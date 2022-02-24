Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFB4C240C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 07:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiBXG1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 01:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBXG1L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 01:27:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AE1F4
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v21so1357175wrv.5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahYwT4mm84FdbgU5PjcKSNY5SL7RiEDiobXuty9qv5M=;
        b=P7az79LqnpumJHMULemau+GDpj01FStQ0TYf503kdD3n3wy15ZiriYFKgWOcKLNrHp
         u7pAzCMMbCHCgWHarH41oFwJNJ1SvWFr2Cj1pSiQ32DsaEsernxtKjPikLZj6cPh4UHU
         /sf/YI/dN0txO1mGahvFO08nW/xo3k38yUNr2+yVqCsLjLDcPz4BJoocko2feEngbNv7
         UwIlX3p2ma71XH82dfBNfaxEZvLZvVdrpyULpYsDQTinmNQFl7zz/SAo0LlnFyrAvBqo
         x/s+UuubOMVLG9sT7beJVQMfZgDTKnnzfEdnjmtlcjS4lwLfK/2XAAb2FwL2Ce2KI3Od
         fjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahYwT4mm84FdbgU5PjcKSNY5SL7RiEDiobXuty9qv5M=;
        b=Vjfg2yy7Cg5Po/J7GqGlzdXZJJ2u3DAQhIo8Nwu4IfSNRj1pNzlOFMK5et1ncJg/3r
         YLvX7R/nabQbVgjyUYSqarw9/lYgKaA0/mCLyCwIeF7SdPLS4qOcXd/s6lxc5wvsXiDQ
         XfamFAWzeQj/VmxHxXr105Tc4YXVFvwHBkTdxXfV7mszHeF0EOVr06j29BjWacLf5hrE
         B88va66bDRn0Mh0J+DKp7uWUflB1UfZXkckj6CapsJ3yOAGoWGlj54tIGo5jwgOgo+hw
         QWihz6JZwlgPARGRTWRXNrfARChEZotMzYWR+sPrdpF9wbkE8aegxnO+cSZRBmo+phdf
         /Maw==
X-Gm-Message-State: AOAM533Py6bjxhjNXD968h5vqXTj6RmZX5f2flylypA1zHL8oyz7j6yh
        p4ApPzgIXc6UEnLhrttAdOcW/wXB4K8d4le/29Aaag==
X-Google-Smtp-Source: ABdhPJx8cWhVzCl6i8kzQmCwJwI+TUxurybcXqvocYLCA0R68XtTuKh+U6FYz9JJxUNLAKJ5dKa/m71dt7MOw7NHgC8=
X-Received: by 2002:adf:a486:0:b0:1ed:9cfe:179d with SMTP id
 g6-20020adfa486000000b001ed9cfe179dmr956088wrb.113.1645683995698; Wed, 23 Feb
 2022 22:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com>
In-Reply-To: <20220217205227.4098452-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Feb 2022 14:26:24 +0800
Message-ID: <CABVgOSkVH9aJ4qU34zVXFA0PfDhemdJyYVc=CkGUVJNSZmQnpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ffc12205d8bda963"
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

--000000000000ffc12205d8bda963
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 18, 2022 at 4:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Use a more idiomatic check that a list is non-empty (`if mylist:`) and
> sinmplify the function body by dedenting and using a dict to map between

Nit: spelling of "simplify". (This is also the first time I've seen
"dedenting" as a word, which I thought was a typo for a while, too...)

> the kunit TestStatus enum => KernelCI json status string.
>
> The dict hopefully makes it less likely to have bugs like commit
> 9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> Note: this series is based on my earlier set of kunit tool cleanups for
> 5.18, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-1-dlatypov@google.com/
>
> There's no interesting semantic dependency, just some boring merge
> conflicts, specifically with patch #4 there, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-5-dlatypov@google.com/
>
> ---

Looks good to me. While in general, I think I prefer an extra level of
indentation to using "continue", it doesn't worry me either way here.
The use of a Dict is definitely an improvement.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  tools/testing/kunit/kunit_json.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 24d103049bca..14a480d3308a 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -16,24 +16,24 @@ from typing import Any, Dict
>
>  JsonObj = Dict[str, Any]
>
> +_status_map: Dict[TestStatus, str] = {
> +       TestStatus.SUCCESS: "PASS",
> +       TestStatus.SKIPPED: "SKIP",
> +       TestStatus.TEST_CRASHED: "ERROR",
> +}
> +
>  def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
>         sub_groups = []  # List[JsonObj]
>         test_cases = []  # List[JsonObj]
>
>         for subtest in test.subtests:
> -               if len(subtest.subtests):
> +               if subtest.subtests:
>                         sub_group = _get_group_json(subtest, def_config,
>                                 build_dir)
>                         sub_groups.append(sub_group)
> -               else:
> -                       test_case = {"name": subtest.name, "status": "FAIL"}
> -                       if subtest.status == TestStatus.SUCCESS:
> -                               test_case["status"] = "PASS"
> -                       elif subtest.status == TestStatus.SKIPPED:
> -                               test_case["status"] = "SKIP"
> -                       elif subtest.status == TestStatus.TEST_CRASHED:
> -                               test_case["status"] = "ERROR"
> -                       test_cases.append(test_case)
> +                       continue
> +               status = _status_map.get(subtest.status, "FAIL")
> +               test_cases.append({"name": subtest.name, "status": status})
>
>         test_group = {
>                 "name": test.name,
> --
> 2.35.1.473.g83b2b277ed-goog
>

--000000000000ffc12205d8bda963
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAFB5XJs46lHhs45dlgv
lPcwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAyMDcy
MDA0MDZaFw0yMjA4MDYyMDA0MDZaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0RBy/38QAswohnM4+BbSvCjgfqx6l
RZ05OpnPrwqbR8foYkoeQ8fvsoU+MkOAQlzaA5IaeOc6NZYDYl7PyNLLSdnRwaXUkHOJIn09IeqE
9aKAoxWV8wiieIh3izFAHR+qm0hdG+Uet3mU85dzScP5UtFgctSEIH6Ay6pa5E2gdPEtO5frCOq2
PpOgBNfXVa5nZZzgWOqtL44txbQw/IsOJ9VEC8Y+4+HtMIsnAtHem5wcQJ+MqKWZ0okg/wYl/PUj
uaq2nM/5+Waq7BlBh+Wh4NoHIJbHHeGzAxeBcOU/2zPbSHpAcZ4WtpAKGvp67PlRYKSFXZvbORQz
LdciYl8fAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKbSiBVQ
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDQ
A+R3zsJcifVogfhxKwXey2l7gbBjkELImCWZzuOFyjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjQwNjI2MzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeyRKvrr8WxJZBoU1el5X
Ke/JNsmT+qVeHN/ho9RI0LqfC2xjcoTxB9x41IXtMBF9fVgjwyg+C0VsFC7ffrurcwz5IBzslkuk
oMHkwp0FbCBCCvZNe/9tofHKcxBnvghDxvm9QcQ62Vm8QWlORuIxvSY3KBK+3ZafXHSB3yhFhLsx
atfjrAH+dXDhJRzBemckcIsV4WR+VGXG+gozpmXr9ZqaFEf+9Vz2ledDUP5e9wi24kG7E9fw9aJG
sEhidKsxbOsDWqHX3LLPFinZ+160rv7d/8zmCRSSWb93wC37brwH7LroHobpfkN2NApIgQ4QcGAQ
wOjZg1uUmokLVqv7zA==
--000000000000ffc12205d8bda963--
