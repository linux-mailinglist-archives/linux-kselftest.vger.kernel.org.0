Return-Path: <linux-kselftest+bounces-35418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAAEAE17C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C43ABFA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113528689C;
	Fri, 20 Jun 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1G1o7KX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC86286432
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412290; cv=none; b=dCNL8VonPsK2KFYvBYrdeWH1GbtDQSTm+R1tNt65vDe3gx2E+B1jZhsVTEniedbQbSq80PWHEAFZ1uQ41vCIx/9V9PLRps0sNEUy7BjMtqoiWZyPOWYC/MSPWF8O/O/7kVWic1V+f97BwNILos4GRPiUN9Ne/YhH9e3yC7iavMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412290; c=relaxed/simple;
	bh=OVYyVU8TnngmNwr6BjCNy7paVmp5d4DRDQi5pYrP9ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOeVehTGBmIsdhIE8z2Xt3/dKSZkOdndz3j/EENhVwaGN5TUUK2+HGSofutYa86OKU26e9fTmYn7BIH9veUeQEkS1lCWDQY2epnlFVaEJO1FsA3eOVSrvQQgTY/mGM69621wiOZME32Q80FWmmsXthaidHO2dZanf6hBXJjEfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1G1o7KX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d098f7bd77so168392985a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750412285; x=1751017085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGTcvicYv/HKI37iBFKAq9yf/CkHx6fV+DgW5Kr0CpQ=;
        b=v1G1o7KX3eGpmFOzVC8W33e9ozbPs4836q3lnMTnkkpYYDXemx0f9eC92WNuKFTKxJ
         dSfVE1ANke1xlJtuX9TEbi5R0/Tm4x9uOepjn5n6LZZRh8TieyRjsnABnfcOpFD+WFEA
         aLHg/OY7+6FOGM/2tD/jzYV6AvoK3Y+vL1ZpfjwwHv2KgCFlkcItiE61j1Bf7wtIRYSI
         4IbPfSsRUy9Y2VUCIiE/1oUjW6gMFt5KXrhj62vux4zYZcyxSGLZGqwO0PZs2CgjnIRd
         2Rs8ls7Jo1weQcEwcMo4nxVrPkmKebQ/wjtRXCiVbzts10rqwiWU9mKW1fPj2MSFwmJN
         RZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412285; x=1751017085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGTcvicYv/HKI37iBFKAq9yf/CkHx6fV+DgW5Kr0CpQ=;
        b=l0UqI2sp8hdrgmAF/FpH3F7TIB0YEog4dUxK4osVc/FQm6zRrN9WMBTRP6zTG0D35g
         0go4dY/YfjM5EXuPL3o6mRZ6KSgsnd6bcDZ3DfrxSdTiCcVJpKO4reE0SjCe3sFUZsVm
         nPpI94PzAlyPyuMAZ21BsORr9enU7sNbHpUgRBcPA46FB1tbvk83VMrVgGdG5F6HrBcC
         fvs/HqzSflN3krtcmaQA7SlW5HmasC7eGfyWdOt7NT0RfE5i/Zx9vIrJOCXz624Bt0ce
         HKHdDntrOEL4JC6g2ghoAcA4gII5GlSlRmhPZ7dRMXmupxddUubJmkpKvRNW/nJI53jN
         RIqA==
X-Forwarded-Encrypted: i=1; AJvYcCX1HKhqR6dbwqLIVcV6yXUV7shmPCby3cYdE4VHTAAZbxFBGYLj6NxqIJpdeZJBEjvXv0Z1G2zsaNQoOAn770w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CD2+r7y22zPrdIM4VhWfp3SFW7K3R+aGm3FI12FjSRsaNi3N
	qZNrwa+JMYWslSeYm12S5IIYxrRHexVeuhaIh0qyaO0ekM06295T9hvcTRV8Y2Pr/ZKjVjlI3CX
	B14Dh9vQbxHw5cGSrIHYrkQQTkrAGUIAo/gO8aZEn
X-Gm-Gg: ASbGncsIQ0c4PCNvq2sqiqXkkT6og5ve9QA3l1sI4GFpQ4FTEW/yRm8OzTKPQgJV6UQ
	rpO/syC2ULNaC7u79IKGQNh2G3wkCjFnehBzH9WQnW+aGywO2z5Gn8w/MIhAQBi3jWKLnNBamgR
	BVhc82+ChjH0UZLRNaf5KB5i86SxJLv9wr7yF9ClUZAVy/QnVg7x6Teef8J9L6YX/8IP9LLnCqo
	VkQCw==
X-Google-Smtp-Source: AGHT+IFIgJtPNCQts/K87Az+Gfj8Ls09sh+yFk1QVyftwxKFWHObPIiGAJ0OO5N6B6kB4hYGw/4/McNKewbriKC2ZJ4=
X-Received: by 2002:a05:620a:1904:b0:7cb:de0d:ba59 with SMTP id
 af79cd13be357-7d3fc02d722mr188483285a.17.1750412285076; Fri, 20 Jun 2025
 02:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-10-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-10-55e3d148cbc6@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Jun 2025 17:37:51 +0800
X-Gm-Features: Ac12FXxDSYdzF8nvRo_Y9mOy6b2ne2WSx9Dq24D16a0Q3u4ZDa0s1yox8-Zeodc
Message-ID: <CABVgOSmRtKnTfCy5SPUiGJpVf_Y_HuAdgihjJ_ZkjeqgZVRnEg@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] kunit: tool: Parse skipped tests from kselftest.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008070b70637fd9e6a"

--0000000000008070b70637fd9e6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 at 15:38, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Skipped tests reported by kselftest.h use a different format than KTAP,
> there is no explicit test name. Normally the test name is part of the
> free-form string after the SKIP keyword:
>
>         ok 3 # SKIP test: some reason
>
> Extend the parser to handle those correctly. Use the free-form string as
> test name instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Nice: this is a great improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit_parser.py                             | 8 ++++=
+---
>  tools/testing/kunit/test_data/test_is_test_passed-kselftest.log | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/ku=
nit_parser.py
> index 2478beb28fc3db825855ad46200340e884da7df1..4599d23c79b79f0e219d655c7=
053c8c3b34f8152 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -352,9 +352,9 @@ def parse_test_plan(lines: LineStream, test: Test) ->=
 bool:
>         lines.pop()
>         return True
>
> -TEST_RESULT =3D re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*=
)?$')
> +TEST_RESULT =3D re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?([^#]*)( # =
.*)?$')
>
> -TEST_RESULT_SKIP =3D re.compile(r'^\s*(ok|not ok) ([0-9]+) (- )?(.*) # S=
KIP(.*)$')
> +TEST_RESULT_SKIP =3D re.compile(r'^\s*(ok|not ok) ([0-9]+)? ?(- )?(.*) #=
 SKIP ?(.*)$')
>
>  def peek_test_name_match(lines: LineStream, test: Test) -> bool:
>         """
> @@ -379,6 +379,8 @@ def peek_test_name_match(lines: LineStream, test: Tes=
t) -> bool:
>         if not match:
>                 return False
>         name =3D match.group(4)
> +       if not name:
> +               return False
>         return name =3D=3D test.name
>
>  def parse_test_result(lines: LineStream, test: Test,
> @@ -416,7 +418,7 @@ def parse_test_result(lines: LineStream, test: Test,
>
>         # Set name of test object
>         if skip_match:
> -               test.name =3D skip_match.group(4)
> +               test.name =3D skip_match.group(4) or skip_match.group(5)
>         else:
>                 test.name =3D match.group(4)
>
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.=
log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> index 65d3f27feaf22a3f47ed831c4c24f6f11c625a92..30d9ef18bcec177067288d524=
2771236f29b7d56 100644
> --- a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
> @@ -1,5 +1,5 @@
>  TAP version 13
> -1..2
> +1..3
>  # selftests: membarrier: membarrier_test_single_thread
>  # TAP version 13
>  # 1..2
> @@ -12,3 +12,4 @@ ok 1 selftests: membarrier: membarrier_test_single_thre=
ad
>  # ok 1 sys_membarrier available
>  # ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0,=
 errno =3D 22. Failed as expected
>  ok 2 selftests: membarrier: membarrier_test_multi_thread
> +ok 3 # SKIP selftests: membarrier: membarrier_test_multi_thread
>
> --
> 2.49.0
>

--0000000000008070b70637fd9e6a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAFFwOy5zrkc9g75Fk3jHNEw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTA2MDEwODEx
MTdaFw0yNTExMjgwODExMTdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqxNhYGgWa19wqmZKM9x36vX1Yeody+Yaf
r0MV27/mVFHsaMmnN5CpyyGgxplvPa4qPwrBj+5kp3o7syLcqCX0s8cUb24uZ/k1hPhDdkkLbb9+
2Tplkji3loSQxuBhbxlMC75AhqT+sDo8iEX7F4BZW76cQBvDLyRr/7VG5BrviT5zFsfi0N62WlXj
XMaUjt0G6uloszFPOWkl6GBRRVOwgLAcggqUjKiLjFGcQB5GuyDPFPyTR0uQvg8zwSOph7TNTb/F
jyics8WBCAj6iSmMX96uJ3Q7sdtW3TWUVDkHXB3Mk+9E2P2mRw3mS5q0VhNLQpFrox4/gXbgvsji
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgx5hZS2f7vGv71nGipu63Ua0b3BgO
THDz28XVxigNWs8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjIwMDkzODA1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAAzfx4qIaMjwZzUXiVeus6srlL8JBWNHeXjoDyXiaNTbkmKxgEZI1GT//SuPGpG2T
kWsEuM8XzJY4x34xXnCaj6gzPINI1NOKYoS3AlDjD3IqXTu+ytjVmjXzqpX9+/V407DzlPLsGgx5
9JfAH22bhVszPegOLEIgzlrGDHQXKRmvRy8OCIwjlVTFLV/FIdS6ktK4hspZ2mid5dieoCb/nd9H
Le3q5Xyh6XSJ3AAapiXmsqMmlskIbNNQcc+3/Wl28Ux3fwae1HQkrIeR8nSu0ymXTSJ3klCvnI3b
ORsKEJfutZXACE4xSVNUjBN0eJAlNkxUK4qAC8IY9e1CUt7NgQ==
--0000000000008070b70637fd9e6a--

