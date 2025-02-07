Return-Path: <linux-kselftest+bounces-25977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABBAA2BC4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A301885678
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5B1A239A;
	Fri,  7 Feb 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+MHfGCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D119047F
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913622; cv=none; b=lmBRyUHbHCW9fmo7YxSKVNq3zHSIKG617twb5IccKXvR375TBG5vt4SmTUYNmZXcJsd+zLCy1bazKQv0MorT+inFaEoNWbVkSwQ0XRN0uuQxIUWwCSJV0fwCjDhzwJL1DH0eR6uqYQl0zKIgte+UMBzyRwY0GN7iVLna9GMcF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913622; c=relaxed/simple;
	bh=MJPlq8zX4niTlFB3XlJUYeccqXBxcHUUp68CVkS/Gjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSR7oHs+IKaWcC2ce6d0rR0ZHUWbpZXXofshfsDXiUiaTlsA8o0FWRiPwFBXd8SDUqKcHySpeCF8ZAuKC+ZrkLyP+kMi4iZr1M0XE/fO70IZj/Ro0c2H71N4vcTww5twmiOiN6BujACXHew1iXIbJjZzCg4pPoUX8bLnr1U9eWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+MHfGCn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e440e64249so13496036d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 23:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738913620; x=1739518420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vT3q8hNmw7zcihVpJADV1tVNJlAA5ANT/yG3/UNqfiA=;
        b=K+MHfGCns7iiqVr72wb5w2LTepYxq9gxrG1S3R3VZMdLNe0PMLZzvhrtvueXde3TUB
         Om3zkhteBQktk6zuuntwomT/TeuMskDXjMQACgqOOSEba7QmeJvHKW8WfrDnQwbukUAy
         67kllNZf38AeW83vbkX2VaWXBkwI9XUNp9aIhtKCtkgoRqhfqwujXk29ECoItY+xd7qK
         NTY6kg0MO8pCfsvHESxfQq2kVegSM+4sZSmP/eq2yZSDg0Uoh9pZReuvryMzUM5F3ktI
         CBarASc+YPUFesqs6ehYRkPKNwN+0+qkjuLLtBWTp3xdn4p7MM0dmFNpKIpbVmsgHccD
         ystg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913620; x=1739518420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vT3q8hNmw7zcihVpJADV1tVNJlAA5ANT/yG3/UNqfiA=;
        b=TxEozTOIDgnAv/L+4s5KBFDZ6EZWgvsnTMq+wF07ynZRMX2x6L/TubllQESPdyq52Q
         dsoivU0rTzY6RwGyFG05cn1cSsC0lTA3tPaqB6oz1hfK5OSqCJczwJpOPsJR7LZJvrW1
         4HletGxLMUoqQfKfxi2li/DPEV6deVeEHxeXBX6b0jzv/6UNsx0WMg+rdIs4shl6rKGF
         4BbkkrdQvsWrsolv1XF4FUBz5/AvFeLaaS34XPcEmmRns6jUigPJLU/4YMNIU+NoBtWA
         hqYkoaN45pInBiWIch0YXbqAAf08DGxjEHV+WdriB9zFuWfQlGwSPaeiLEktDaop4pvK
         +fiw==
X-Forwarded-Encrypted: i=1; AJvYcCVIqKm5QZpOBvVg1T/4c0N2hWtvB4Hspy/avKUa09r+u3sRaciyA4oYWSFPz618UZXdZa3Y7/nghiDE3S3KMdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZZHOA6dPhTRDtOP85T7ycNYMVN4U2v13DLRW2JN4RLkHspcM
	WCh9M07A6igwrDCjAomtXcoPiga27jW9I/+FYm8Eahr/09Up4AyBM2rWexDPXO1HS8PCusULi9Y
	Ms5tES2NVzQ7nXOYyyiUioZOmVc9dFFbBR9fX
X-Gm-Gg: ASbGncsvGYHMsIhtag7zeDmU1X9gojTOTTZ1WgNZl3wg69yhoWVHUbBw256ygf+GeZP
	W/7KStU6M1RfcBHPk2oISZGtOOGIWi/vt4+6eoq4XViCG8LzNk3bULLSrfhmuwyIn30SC75mIzg
	==
X-Google-Smtp-Source: AGHT+IHgTgeXdrpmrEIfYpukgFE/6op+gd1mFPkQLarnMmS9esXF4wFTASYA5cUHaMOHFsn3NyK8V8Qlj0eoHsN/cfY=
X-Received: by 2002:a05:6214:76f:b0:6d8:9e16:d07e with SMTP id
 6a1803df08f44-6e4455bafabmr29752806d6.4.1738913619802; Thu, 06 Feb 2025
 23:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
In-Reply-To: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 7 Feb 2025 15:33:27 +0800
X-Gm-Features: AWEUYZmyi3m2bJuIfHVGvSGU-VmWgBaBptd14l3all7cVlQlB4GKR7ukiBxgtqQ
Message-ID: <CABVgOSkZRage0UhVV97j=4XEV=Rg0rAAwkt_Qa=ie_K3_E6KhA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] scanf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a267d0062d886093"

--000000000000a267d0062d886093
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 03:26, Tamir Duberstein <tamird@gmail.com> wrote:
>
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
>
> I tested this using:
>
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Thanks very much for doing this. I'm happy with these changes from a KUnit POV.

Two things I think we need to be careful about:
- This and the printf test are both changing the m68k configs. This is
fine, but could lead to a (harmless) merge conflict, so we should make
that clear and try to avoid having them go up in separate trees. (And,
if one gets merged first, rebase the other.)
- There has been some pushback on some kselftest->kunit conversions in
the past, especially if the test is being used to debug live systems
(which typically don't have CONFIG_KUNIT enabled). I can't personally
imagine that as an issue with scanf (though my imagination isn't
perfect), so I'd doubt it's a problem.

I'm assuming that, as mentioned in v2, these will go in via printk,
not ksefltest/kunit. Either would work for me (but, as mentioned
above, I think this and the printf tests should go in via the same
tree).

This series is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Changes in v3:
> - Reduce diff noise in lib/Makefile. (Petr Mladek)
> - Split `scanf_test` into a few test cases. New output:
>   : =================== scanf (10 subtests) ====================
>   : [PASSED] numbers_simple
>   : ====================== numbers_list  =======================
>   : [PASSED] delim=" "
>   : [PASSED] delim=":"
>   : [PASSED] delim=","
>   : [PASSED] delim="-"
>   : [PASSED] delim="/"
>   : ================== [PASSED] numbers_list ===================
>   : ============ numbers_list_field_width_typemax  =============
>   : [PASSED] delim=" "
>   : [PASSED] delim=":"
>   : [PASSED] delim=","
>   : [PASSED] delim="-"
>   : [PASSED] delim="/"
>   : ======== [PASSED] numbers_list_field_width_typemax =========
>   : =========== numbers_list_field_width_val_width  ============
>   : [PASSED] delim=" "
>   : [PASSED] delim=":"
>   : [PASSED] delim=","
>   : [PASSED] delim="-"
>   : [PASSED] delim="/"
>   : ======= [PASSED] numbers_list_field_width_val_width ========
>   : [PASSED] numbers_slice
>   : [PASSED] numbers_prefix_overflow
>   : [PASSED] test_simple_strtoull
>   : [PASSED] test_simple_strtoll
>   : [PASSED] test_simple_strtoul
>   : [PASSED] test_simple_strtol
>   : ====================== [PASSED] scanf ======================
>   : ============================================================
>   : Testing complete. Ran 22 tests: passed: 22
>   : Elapsed time: 5.517s total, 0.001s configuring, 5.440s building, 0.067s running
> - Link to v2: https://lore.kernel.org/r/20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com
>
> Changes in v2:
> - Rename lib/{test_scanf.c => scanf_kunit.c}. (Andy Shevchenko)
> - Link to v1: https://lore.kernel.org/r/20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com
>
> ---
> Tamir Duberstein (2):
>       scanf: convert self-test to KUnit
>       scanf: break kunit into test cases
>
>  MAINTAINERS                          |   2 +-
>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -
>  arch/powerpc/configs/ppc64_defconfig |   1 -
>  lib/Kconfig.debug                    |  20 +-
>  lib/Makefile                         |   2 +-
>  lib/scanf_kunit.c                    | 800 ++++++++++++++++++++++++++++++++++
>  lib/test_scanf.c                     | 814 -----------------------------------
>  tools/testing/selftests/lib/Makefile |   2 +-
>  tools/testing/selftests/lib/config   |   1 -
>  tools/testing/selftests/lib/scanf.sh |   4 -
>  21 files changed, 820 insertions(+), 838 deletions(-)
> ---
> base-commit: a86bf2283d2c9769205407e2b54777c03d012939
> change-id: 20250131-scanf-kunit-convert-f70dc33bb34c
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

--000000000000a267d0062d886093
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgxoCOdLtz3v6F8srqh1CrczGoConm
S2MakUmYZmu90+IwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjA3MDczMzQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAB2xJaoBzVlLtiYqzcbFNNzR1RXwra47/MK29pfFiP9zJFJo
v9aJJ6aTYDIPrQaHYzTqvIJH9k73x+Ot/LBAW3AteihAhfsAm53Vh+m7Va64Uyngs1E5coyL9EBf
J0foJWFHvbhaQkhRTFiTlfXHwUDi2fXfOLVe9gaPlMS1yJTm1qP7txn89SyRdGUzWI2/1Wh6l5oY
3koB4ZIiN0J4EPH+jCLj1hZOSaEXg8zmRPqfRij6dpIniZw4Qkio3P4JyZqViJTXqlAzHJt3Qc0e
2sS8TRPBbq/N/8Q7IUUfzpwLb/kZa3Olr/CuRl3Uz1XAoZeSnpaF51gbqAPwwYbhWTk=
--000000000000a267d0062d886093--

