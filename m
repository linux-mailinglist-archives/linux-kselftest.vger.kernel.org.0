Return-Path: <linux-kselftest+bounces-35425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C8AE1829
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAF816BB34
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8849285411;
	Fri, 20 Jun 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mldIF50X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4A284B39
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412903; cv=none; b=L07TnDZtAtCmuJj0YTP/c36PZoH9N3hg5Mmr2ygp6TI7PhCL7Mimm/xIR9Zq9tFBLH7XzpiyjxD1mi7TzFTAlzTGrjT/mnquNH6f/AyEr8vXw6C96Xb/Q/U6WCRbx/IWBBmEhUBHQhrwckbqrGNV64UQCwSw2Cw2nbO+AF612P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412903; c=relaxed/simple;
	bh=7+O1/RDp+78MH7IgDGGYi5VirrEEW28+woJ+2sWut4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WROkSPwN+STEstqbm41tZ0Dqf92lW8rGn3M1omYsJex2fSGEpDmVfXpilrCQK5bNJjJ6aB/MNb1+WJVNaHhufVHfg6A9kJVoQqX63QQFxEaj1g4Gx4h3a+yMHUDLfcCLp/FDihGmSuWVtyhaTt5FZZ5EW7BUjljB3eKd2geVDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mldIF50X; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fabe9446a0so17171326d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750412901; x=1751017701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UN12GxgcsmXEkVA0pFrK8rn2aOOu5khuSCnYXvkIyy0=;
        b=mldIF50XogrW5mMtMfSHOoEiW03ZkMC5b8w6HcqsgsdDVHJHxVBZozKQvEOEz72YA7
         69qidY8LzDbl2uyOw0aLu/9KLZDRkn/ovu6CXoh6bJ/8gupLompDLZ1npje3i+4gIdGr
         XwRyJhEtltQoRaki8oG2Reae5FwcwuY/60k1EOiF9+jd1cPBJQSH7faJzpl3XktBfmiK
         WWTGu9L/TsPJHNqIgs5UaY2b+EeNWEPssfUveD8rLR7y7NoPwVoC2zXtaAHwuk7BZiEA
         Ft1YE8/Q7bZHzMXWSQWRZ6s8K1rAP3f8RJgMBIKxqR9DQUxGVWAnxInAR7vSGbE8ZYXH
         dwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412901; x=1751017701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN12GxgcsmXEkVA0pFrK8rn2aOOu5khuSCnYXvkIyy0=;
        b=HJJc75SBMbbRbIyVT+mhuioICIjtMpgwhC0QI9VdE8w3LLsJQoXnjkNJ0QZI5onEIZ
         kiCSDY4plExWxslB+lU3aD3aUP2iOymI3coyI+xBFx5XDB3pYzg+fYjfb4JAoA1Uy3Cq
         xtHRyXE2/5l0MRI3lK4jzw8E/VPHlZ7P3KzDTZm0n3SgdsZX4Aq8ZpkBsE3DCtSsVkGO
         Nuxcum65Tb/DLxaLqjOtgeHDrYm/gsuE86dVEWaqwg/3wPecCmf1bTv9XWkeFjh43o+h
         E/d5cfhYtkuEcnGCLjb67S4aqcjRBIt5qQms6ffh3JELMEubuddRmgqIm5tY06lZ0ubh
         am8w==
X-Forwarded-Encrypted: i=1; AJvYcCUdOl1Y7jlz1neUW31FHlw714Zzvd5Wf8rxLTXWOUD30EbY4hrX56J10zNY970ZYtqskk2KYVP5/3P3GnLCHyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5WZTQEJAAQ8YKueNw8YUkwjCiaiem+beqyghu4p6/fRF9CHW
	CqOMDS7LRCakODLh7AxuIcs/RlbCY7lfSE2QDjO4a4Itoz3F2tgWm34m8U0XBEifGlY8dKBOuH+
	QhJUxaYyxb1qS3JJGef5gjJiDrAqF3bmdTiJ6k9Kt
X-Gm-Gg: ASbGnctYLTyKj5GL9XY8gTU9I/sJLcnlnOIT465j/T0o1K6FDFDtKw5mGR0d7f984M9
	jkT1aK4qSejg+DP0ZEIxksOAXeGmFSL6ODDQz6k6reGWmiG6HrAhFVB3nDr3M38vXR5c+wEf8fJ
	QxLe3korRziOllGHQHTvuavIhaIFMn3hmhbgyvuvjpjN8NcMnsscbKqQGcUr+KQ0AMrZMX9IGVy
	rq0yQ==
X-Google-Smtp-Source: AGHT+IG9l5kxV+1Ma4bC/Ch21pNSqqetHy75BeA92GPqCkiA+bQJbD7IsIRL0I1y9bQPx2uEdJUuoJ0+0CcL4GfInSI=
X-Received: by 2002:a05:6214:d65:b0:6fa:fbb4:6408 with SMTP id
 6a1803df08f44-6fd0a468d1bmr39369366d6.7.1750412900984; Fri, 20 Jun 2025
 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-16-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-16-55e3d148cbc6@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Jun 2025 17:48:07 +0800
X-Gm-Features: Ac12FXziy84ZitrRyNjPJ5X18Rn5RbIW_PxLqeeotLRQa3GNSMkRr034RqGPbsU
Message-ID: <CABVgOSkzpY8327ePSjuLcbz2jWZkavJvJfF7eehCsS0uzkB65g@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] kunit: uapi: Validate usability of /proc
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
	boundary="0000000000003556600637fdc389"

--0000000000003556600637fdc389
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 at 15:38, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Show that the selftests are executed from a fairly "normal"
> userspace context.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

This is good. I'm not 100% sure the example test is the best place for
it, though.

Would it make more sense to either have this:
- in the main kunit test (since it's really _verifying_ the KUnit
environment, rather than documenting it)
- in a separate kunit-uapi test (if we want to keep some separation
between the UAPI and entirely in-kernel tests)
- in a separate procfs test (since it tests procfs functionality as
much as it's testing the KUnit environment)

Personally, my gut feeling is the main kunit-test is the best place
for this, even if it means spinning up a separate file is best here.

As for the actual implementation, though, that looks fine to me. A few
small comments below, but nothing particularly important.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/kunit-example-uapi.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uap=
i.c
> index 4ce657050dd4a576632a41ca0309c4cb5134ce14..5e7a0f3b68f182c42b03e6675=
67e66f02d8c2b86 100644
> --- a/lib/kunit/kunit-example-uapi.c
> +++ b/lib/kunit/kunit-example-uapi.c
> @@ -8,13 +8,45 @@
>   * This is *userspace* code.
>   */
>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +
>  #include "../../tools/testing/selftests/kselftest.h"
>
> +static void test_procfs(void)
> +{
> +       char buf[256];
> +       ssize_t r;
> +       int fd;
> +
> +       fd =3D open("/proc/self/comm", O_RDONLY);
> +       if (fd =3D=3D -1) {
> +               ksft_test_result_fail("procfs: open() failed: %s\n", stre=
rror(errno));
> +               return;
> +       }
> +
> +       r =3D read(fd, buf, sizeof(buf));
> +       close(fd);
> +
> +       if (r =3D=3D -1) {
> +               ksft_test_result_fail("procfs: read() failed: %s\n", stre=
rror(errno));
> +               return;
> +       }
> +

Do we want to use TASK_COMM_LEN rather than hardcoding 16 below?

(And, if so, do we need something more complicated in case it's not 16?)


> +       if (r !=3D 16 || strncmp("kunit-example-u\n", buf, 16) !=3D 0) {
> +               ksft_test_result_fail("procfs: incorrect comm\n");
> +               return;
> +       }
> +
> +       ksft_test_result_pass("procfs\n");
> +}
> +
>  int main(void)
>  {
>         ksft_print_header();
>         ksft_set_plan(4);
> -       ksft_test_result_pass("userspace test 1\n");
> +       test_procfs();
>         ksft_test_result_pass("userspace test 2\n");
>         ksft_test_result_skip("userspace test 3: some reason\n");
>         ksft_test_result_pass("userspace test 4\n");
>
> --
> 2.49.0
>

--0000000000003556600637fdc389
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgu2eBGmuTuVNQyj0fEcKWKy+6sQHD
prtlLXAqTM7vqCYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjIwMDk0ODIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAA8GMaESfCverlSr922Cc5gnmckCdXsyPkEv7ljJqN+lbIVNc8Gt8do9EWyJMrQC8
gv2CUVxje2e1g66VViPK/1BmnyRZjGBVtpA2dNSj7JT9Xn9yVl/klYtfJXT8kpvPbFVIXO74733i
phaosOZ/b4D9HibxoNGOnaUzh/A7j5aX+qgRpOaDTlh7Ps5t+iD/38tTW4IhXvNn1RYgNNcfA1x9
QHVEsV4Xu2R9nDJMov0lX+uHigF8nob3+3VAmjoMSCgn9atjOLnfkGLDbbQlvFdWBgjgATig2aFv
5npsXmRQ+UDFLV+mq1hNPthR7D5/HxENELLX+JzrN77msd5lTQ==
--0000000000003556600637fdc389--

