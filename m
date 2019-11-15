Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDBFE483
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfKOSFH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 13:05:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38757 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOSFE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 13:05:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so11942898wro.5
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2019 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOXjNNeCtQ+lF2siPsU4NOqPx5nwcrVpqsgiIr1ERlU=;
        b=BVbeT8kdVPOVqBkOsFlrgHnmFOEjgO5MZCrjWWnScwbPWZKroVa9Krq4bmtgkLVtXM
         6sqzzKfs/NEhO/zAL5M3f5V9P4bkvB9w5owKUIt+J9UNmaBUyA5oN3pWQQ1WhRAXkMwi
         mN2irghb62NfsDo1DMvvT6MHqSS5biIjRuvFM/ZuD4NTQlvWpgpo1D66KfKACmuTTjVw
         Ima2ajWSyZ7qU35wsKXceu4M0vlTAY3Z1hBcMoQ03+A8MU0hY4oB9dN3LVm9ZWH9pZGk
         jtBz6X/uESamqf03Xj40zd2l9o4nONjtodaw9U30YLySpvglTNzQXXoBa+RnlTy8OVcU
         KnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOXjNNeCtQ+lF2siPsU4NOqPx5nwcrVpqsgiIr1ERlU=;
        b=ILXvM1Nj41VKL2226Zt/3beuc1RUjSQivvZtf8wk36TLYPds8OYyeH0085vo9oDIQz
         X4eWdm4OCcIfdLPiGq0HjycQaow8sWBQtYP0qHx9weXhDVfENIfTM7jzU5IRyWQ35q5k
         0I04ATDjlmjeMkbnI4H1n//FKcHs6AmWeSM9o3HYEumShfO8TjfPlhfTH4aDZ7B88IZL
         0rt7dEHZtmauC0taRALKxPvUU7MuDN+Ape/62H//ZOW6G8Gfw1XvR5292YOjzLWZaQ0a
         SF9A/I88Gyb2ViwmwKp/MHs/yRXcNpVJnUMWb5ZrrWi1Bevn/yJ6z/h9PoeVmtZZI+4/
         VpRA==
X-Gm-Message-State: APjAAAWEFAtbclopthUUi62MLhJpUpnwzMCVgaxrwhFL+52+zbxnfgTl
        Kuq64IH0KSTw7dRyCoxpGJI8xjdVHGOg+qYRsqxzRQ==
X-Google-Smtp-Source: APXvYqyCiXMXUf6usCff17snMpxkYcJg2knHlsu6BGxO9gcLgKysYhJxac9RCcngPe7WIGs5lhqr0cFv37TJFf5KI6U=
X-Received: by 2002:a5d:460b:: with SMTP id t11mr17485139wrq.185.1573841100898;
 Fri, 15 Nov 2019 10:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20191114224240.77861-1-brendanhiggins@google.com>
In-Reply-To: <20191114224240.77861-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 15 Nov 2019 10:04:48 -0800
Message-ID: <CABVgOSkLM8bGxAYJ25J+nYfPScTBu5__oiZG_9qoTGiNEOz6kw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] Documentation: kunit: add
 documentation for kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ccaa030597666f4b"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ccaa030597666f4b
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 14, 2019 at 2:42 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> Add documentation for the Python script used to build, run, and collect
> results from the kernel known as kunit_tool. kunit_tool
> (tools/testing/kunit/kunit.py) was already added in previous commits.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: David Gow <davidgow@google.com>

(...snip...)

> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index aeeddfafeea20..4248a6f9038b8 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,10 @@ The wrapper can be run with:
>
>  .. code-block:: bash
>
> -   ./tools/testing/kunit/kunit.py run
> +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all` --defconfig
> +
> +For more information on this wrapper (also called kunit_tool) checkout the
> +:doc:`kunit-tool` page.

I feel that the --timeout=30 and --jobs=`nproc --all` bits distract a
bit from the "getting started" nature of this bit. I think this
example is clearer without them (i.e., leaving them as the default):
we can always change the default in the code -- which we probably want
to do anyway -- and the consequences of not having them seem to just
be performance-related. So, minor preference for just having
--defconfig here.

Cheers,
-- David

--000000000000ccaa030597666f4b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPCgYJKoZIhvcNAQcCoIIO+zCCDvcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxtMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0B
AQsFAAOCAQEAwREs1zjtnFIIWorsx5XejqZtqaq5pomEvpjM98ebexngUmd7hju2FpYvDvzcnoGu
tjm0N3Sqj5vvwEgvDGB5CxDOBkDlmUT+ObRpKbP7eTafq0+BAhEd3z2tHFm3sKE15o9+KjY6O5bb
M30BLgvKlLbLrDDyh8xigCPZDwVI7JVuWMeemVmNca/fidKqOVg7a16ptQUyT5hszqpj18MwD9U0
KHRcR1CfVa+3yjK0ELDS+UvTufoB9wp2BoozsqD0yc2VOcZ7SzcwOzomSFfqv7Vdj88EznDbdy4s
fq6QvuNiUs8yW0Vb0foCVRNnSlb9T8//uJqQLHxrxy2j03cvtTCCA18wggJHoAMCAQICCwQAAAAA
ASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIz
MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAw
MFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzAR
BgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG
4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnL
JlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDh
BjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjR
AjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1Ud
DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0b
vDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAt
rqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6D
uM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCek
TBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMf
Ojsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBHAwggNY
oAMCAQICEAERNlkdZYY1imB8Exy7RdYwDQYJKoZIhvcNAQELBQAwSzELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExITAfBgNVBAMTGEdsb2JhbFNpZ24gU01JTUUgQ0EgMjAx
ODAeFw0xOTEwMTUxNjM2MjFaFw0yMDA0MTIxNjM2MjFaMCQxIjAgBgkqhkiG9w0BCQEWE2Rhdmlk
Z293QGdvb2dsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDF0NDirVg0hmjo
6g6oK6C5iPfTWuqgNYUhlc3h5lJdb4nICsOlgVhtto9i8OvirZspNcNsMyzrUR9RJVVPNI9zcIlV
3qSgPvHrqJiBuamUjYey2t+oQhI4BGmznNBJQ8wL1IPenCnll2Q8Vw4PrXMqRvibRi6EQJz1j5zE
3BurAMFTDorU5alUGXIhI0U5FLZJes56QbWrhNCx6P/NuTqeNf9wduHJRIMWrroMPj6lBkkIOmAJ
CduuRHHF/L8LdbPWZ7WCV1ynW51CqWxA+o1f32HipPFOWGqDhcA6gqa5aXkyyurxykk9HdW+qUZH
sGnIzSr+o7dvyjGmDjK1edNvAgMBAAGjggF1MIIBcTAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29n
bGUuY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYD
VR0OBBYEFEO+C8N+XP8f+1QuzSgTVm9SIHBcMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYI
KwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMFEGCCsGAQUF
BwEBBEUwQzBBBggrBgEFBQcwAoY1aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NzbWltZWNhMjAxOC5jcnQwHwYDVR0jBBgwFoAUTLcFidZTzSNAougPeBrkbVxM7NIwPwYDVR0f
BDgwNjA0oDKgMIYuaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc3NtaW1lY2EyMDE4LmNy
bDANBgkqhkiG9w0BAQsFAAOCAQEAJ/zitSY5ytjRHvjJRs//GXSqWUC9k+0tOBStoNWdT0W+IU1B
1LFJELO6cCMS7c1z3KsQoLfLNc/eSYUv/jVWQoXht3qEyYjRS0s/yq8fxvm89uCGbGqtPjygIohU
o4MsxfvqX/0D3LDZjBSQFsM5pzdIj2c+yEsDuTz1ZZONpsYJZ8e+2sd2soqYkQPjgrTw/DC4iLup
tRDKk7xLOvTS4GEcnNBZx8EPg9sKqyP51KSxSKQRKAH+fuugWhJTI582FJI1zXnFXW7CywdhCCfI
nCNqI2fk/FFl6FVqgaJKm30Sp4GZUd2VnH0aGYJq3gYFVph+jvojHGcUqOO5ggMjPTGCAmEwggJd
AgEBMF8wSzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExITAfBgNVBAMT
GEdsb2JhbFNpZ24gU01JTUUgQ0EgMjAxOAIQARE2WR1lhjWKYHwTHLtF1jANBglghkgBZQMEAgEF
AKCB1DAvBgkqhkiG9w0BCQQxIgQgLbkVggbEKW0Y1qlUklb+HI5yd6Waxqt1kcszD2fLd68wGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMTE1MTgwNTAxWjBpBgkq
hkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBALlCISnYSqHmKphDAVo+u5j8D1HkuZTF6/g8RUzA00VNv64JCaIBFd3Q1DZ7Gl9R7uZS
JTiiL2yfyyoeuVY2OU7PzA30i+lLEP8KEYTdRj+xYGujB0BQsOPEGbKuXmm1gH0ZM92BopjNxGv9
E9Ecz1ScRNEf1RGx89h79mTg6JDioACvrH4hPrS+tywnIJCamlWsSynE5unezVs8joBeOcPETubV
1ftFXantoeyYzDFz8CZmfu5Rd8Pa3fSUsBm9R3w/OgMIJf0/4oIQizUKInahbj0omHTJqDzLrmrc
t661XILI1j6mmoWP5IlbpKfnG9DbjqLk3pKubSHbVJAsZGs=
--000000000000ccaa030597666f4b--
