Return-Path: <linux-kselftest+bounces-47725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BCCCCEF74
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD5D30BD9CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194C284B25;
	Fri, 19 Dec 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dM/Ig9hn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F430259C84
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132517; cv=none; b=lpnNVrjKpJRcBBbkfwjXDlS1gh6dK43lPi/TWpcBrCFb6bRzsOuXPj5ltDZmBI7ldrDlLHjOeZsbHGCdxtVsMAvoXKPALYF1PBysQCqgSplpvgOAhIdcPq+6yPWJQ8NFZ9iySWK5qcCbm+LU3PzZpc8hRZcU51dWRNp7i8av/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132517; c=relaxed/simple;
	bh=OrvRfhfryZG+6+6mDdsYMKIGLUim0+AuvimkKved9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNOXoKKy90g2b4O7iUKwPSkOGnJOren8AKveqwqZ5hoZ5vs3kFZVNUf/j9xo6/ktfBkaiNiWa0MLYu9S+yupxLwcBes9XCYfrfYZI8S+CezAE8nvuTEtFXM6uk3jEoZtIx5R6cQ53JKdrOKyDP5LWkgZbtUXlLViD5g8qapsGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dM/Ig9hn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso10949065e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766132514; x=1766737314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VUtVpOxIQtJSHunjlcJZL/6HNtYU2HLn2Q8Om4G1wRQ=;
        b=dM/Ig9hnvkptD2AtJk+9vYs+t9Lre2hvTr7UBD0dzZIsDgemfmyx4N+EVnDSaiHC+K
         mUxv1AvVoc5ZdSdIAXZ9Iua9TwCaMM8UHywFVR5o76CwcQEpWetbSnYNxXwv3pCxmBsi
         yErAK9NypOs7y9/EDJZUzSXo94lh0sSuZXXGIuHJRJ1/BUfbLCz4TWZqEqhWpQIohl0n
         F8NDQuvvkgEdsgQpdHU1KIVSdw4Evus5JwJK0ROgsooatdd4TwxeOAaf1aK+c83oBkli
         bwICo7+0ePCP0fDgU4BTZQXzMjqsTZ1wt7aAKAvZZBe4TI92rgfTSYjx3ryBUrtYhefw
         hDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766132514; x=1766737314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUtVpOxIQtJSHunjlcJZL/6HNtYU2HLn2Q8Om4G1wRQ=;
        b=crYMujsZoUEk/krurqSQnleBVh91ANOTL0loueODPcZOcFq39U4ydf4brR6M9fjbSx
         8H6JWeD3jtC6VzHOVdZOZuEzfupSGhfgPRmwqan9v+xk+fApMU0X/QDXGYqMGRVoKAHr
         YBdw+MqvGLWPFnS2naHadht1UTU13UDPzLr3ZttfyOJFM+mDFQicKsh0Se7fTVYCyk65
         o1gQytsc6NGnc7vnUZrZd5vVVF3iLUA6Y6YJRquBwSsv1Gd5dtqwpslRaM/NwblsCVbs
         Br8CuJxs+vpfmacipmENvXIR+NsiYbzftIKcIrpOetcR5RclQHdUb+osHmCyXyg3ALzU
         DuHw==
X-Forwarded-Encrypted: i=1; AJvYcCWalgtyuAydxbJRiqRUSwYoxtgBRijJF8DUaOASnrPG2nuk6WSyFpGzKLTTeg9uvvdT4HQWnVijI7AvraabuVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1IIeWa9azNyo6+tN4Y4neXxyF+yF3+vODoBk9Zw1QC0Jw9Mv
	hBcEopPzFfzVbSljGYf/dn3GUW4dZNPKNF+l8j6ljo4+Cn9esCwh1rfEFImRR5BodU+J6AeHoX4
	m8MohBCHAxqWbavs5FheJs6UJYCpRU2Dy7v+q8Tco8cl3iDp+dyFWGp2c
X-Gm-Gg: AY/fxX6kB37D7BxFxuPorKm+B/38GYEPz6bkGkRbM8EHgJGMWLyM0CwdsEsMcd5Iz2V
	ZgiN9emLE+52TzFQFYpFxKEibI55blB3te5I6IkRY+xmEkvJ8iq+nyavm0Y9tCR/uKY31bCuIFY
	79jcbrfZ8tizsoIdC/MI7IKGEFhZvf5ysLkF6Nd36Iyag1+E5Et241mPyrpW6tEAdMk9MKzMuhS
	j3lHIvUZWeY55DWxr0mJk2FII+VzS6bh5X5pR22TRsBg+c+I2E4U4197fnRw836JybNJg==
X-Google-Smtp-Source: AGHT+IHxTdC9V8O6n7IYLZv60erp2gB8lfd4LmdV7QyQgoA2Y/jKqv9DH9JZUdDjrZgACJupPmo8GdsrJn995agH3Go=
X-Received: by 2002:a05:600c:4506:b0:477:79f8:daa8 with SMTP id
 5b1f17b1804b1-47d1957da6cmr16152035e9.17.1766132513403; Fri, 19 Dec 2025
 00:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720063937.2311958-2-davidgow@google.com>
In-Reply-To: <20240720063937.2311958-2-davidgow@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 19 Dec 2025 16:21:41 +0800
X-Gm-Features: AQt7F2p5ci9Yg5TO3WO7ee2KDqvGRaPvG20Xpj--wKihkCJK1pBvZPtOevPNdsw
Message-ID: <CABVgOSk7PbvaFhuJzVaHSAtn9Wp=QKHo+_2TxaiwS7fQhgc0QQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86: checksum: Fix unaligned checksums on < i686
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Noah Goldstein <goldstein.w.n@gmail.com>
Cc: x86@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000021a971064649c56f"

--00000000000021a971064649c56f
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jul 2024 at 14:40, David Gow <davidgow@google.com> wrote:
>
> The checksum_32 code was originally written to only handle 2-byte
> aligned buffers, but was later extended to support arbitrary alignment.
> However, the non-PPro variant doesn't apply the carry before jumping to
> the 2- or 4-byte aligned versions, which clear CF.
>
> This causes the new checksum_kunit test to fail, as it runs with a large
> number of different possible alignments and both with and without
> carries.
>
> For example:
> ./tools/testing/kunit/kunit.py run --arch i386 --kconfig_add CONFIG_M486=y checksum
> Gives:
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:267
>     Expected result == expec, but
>         result == 65281 (0xff01)
>         expec == 65280 (0xff00)
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:314
>     Expected result == expec, but
>         result == 65535 (0xffff)
>         expec == 65534 (0xfffe)
>     not ok 3 test_csum_no_carry_inputs
>
> With this patch, it passes.
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     ok 1 test_csum_fixed_random_inputs
>     ok 2 test_csum_all_carry_inputs
>     ok 3 test_csum_no_carry_inputs
>
> I also tested it on a real 486DX2, with the same results.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Re-sending this from [1]. While there's an argument that the whole
> 32-bit checksum code could do with rewriting, it's:
> (a) worth fixing before someone takes the time to rewrite it, and
> (b) worth any future rewrite starting from a point where the tests pass
>
> I don't think there should be any downside to this fix: it only affects
> ancient computers, and adds a single instruction which isn't in a loop.
>
> Cheers,
> -- David
>
> [1]: https://lore.kernel.org/lkml/20230704083206.693155-2-davidgow@google.com/
>
> ---

Dragging this back to the surface as it's the last remaining test
failure on my KUnit test grid.

Is there any particular reason this can't go in as-is? It still
applies cleanly here and fixes the tests, but I'm happy to re-send it
/ make changes if you'd prefer.

If you'd rather it go in via the KUnit tree, that should be fine, too.

Thanks,
-- David

>  arch/x86/lib/checksum_32.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
> index 68f7fa3e1322..a5123b29b403 100644
> --- a/arch/x86/lib/checksum_32.S
> +++ b/arch/x86/lib/checksum_32.S
> @@ -62,6 +62,7 @@ SYM_FUNC_START(csum_partial)
>         jl 8f
>         movzbl (%esi), %ebx
>         adcl %ebx, %eax
> +       adcl $0, %eax
>         roll $8, %eax
>         inc %esi
>         testl $2, %esi
> --
> 2.45.2.1089.g2a221341d9-goog
>

--00000000000021a971064649c56f
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
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg63953arAluwVjk/cNDvt13k8LOn/
1bDvc7xkpnWwOjgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjE5MDgyMTU0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEATfICvWGKNzjkVyBlxwjRWC0krw1p/Ya4OPpACWvn2Xcm+p2ythHvXep1w0o8FQUl
jqsm2uYyVaf80sNPx2/6QPfXfo03T0Bl1LrrQruFBAWo1a740LfBdti5Kcq+NazYAUwRP4jagjvF
1U+aNL2gjsaFXpxg342GyxM0D3Ru3jXeUv4sWg3Nv++bbHMPtCWcgH6NdODtZbMed+7IazLSu9vQ
BPMw2zugLsRiGZb3GQTb7Qk4f+fJ1Br1OkiTti7giXLsMzCxVoYNC/MDFek4BfDJYs8zjaqQ0T+P
l3kOf0kvTMt9tyXz52of44W95KD0SPxze8Q+IYjjV9V3h/kqhQ==
--00000000000021a971064649c56f--

