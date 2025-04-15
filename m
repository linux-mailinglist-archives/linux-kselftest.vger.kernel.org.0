Return-Path: <linux-kselftest+bounces-30828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C1A89692
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98023189D8E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2927F75F;
	Tue, 15 Apr 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQaRk84I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146C27F4F8
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705608; cv=none; b=pc+d8971WMwJMByBEcAVacCXAYPr8fSWx3UiMOnG8zTLu71ARi5CXTJ2Vg1VEmmVrrTkOAapA90i/Tbr8AJvxogMBuMJuOMnJd8WLbr5cpWzg4sWEsh6IAd5GsZombCZTmlyOnCYqvsIcBqpLJY75CPHqCugffdHiPHuH6wVEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705608; c=relaxed/simple;
	bh=JqUHo5m6uAsUCbPz6JVbbipOGAm43LbLZfTVV4EsYZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo4PPXHySFd4QjVFvQAq0BRnX/1n5l/GVBlMQ9LKRr8en2E9eyEoBak9Lb3k2yUUvFGhLfzpptWyEMei4EkjSYuX2GOG8Kc24vecBZdVs3tisxGLp+/w1PEMzBlpL9CGDkavwlKH+QwErLaYW69DqfRGAhHVpV8D1jxk+Et1+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQaRk84I; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso55370236d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744705605; x=1745310405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3koRfd3ugatzvnWcvcrU6PQCuYkY/YImNetRNUo2Jk=;
        b=rQaRk84Iy/TmZEp+mke2SIQ8aAFo/NN20dzFC7Gh0geLfJUD5CWe67O5IcEq/vynOd
         4NQ1gDZoQPhxPfSeKToq0mD6McSO1qj5Vh3smFkaWCEmWYzz+rI6cqBGOuXzBwO0UCEz
         P59llxqekLMkevu0Y/OgMm9KfWhvumC6VPaJODk3IXXmwo7/4R/vYVQWgEuV6/S3PjTd
         h43V1I23Pd1a6N3ZysCY9JtHlCFjV0Y7rKbewP5529hfd97MkajFdOT2J0/hWMG8ZIvv
         8YfysyTFrTqYlRiSPlVxugL7GgI0nnNRpqJdmwskL35TleLKSTT1/nxU+XNrUeRzoI0Q
         /IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705605; x=1745310405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3koRfd3ugatzvnWcvcrU6PQCuYkY/YImNetRNUo2Jk=;
        b=iEDqmCba/tHqhPsQR0VGASukNyo7RPakGDJE5f+av8vGKcSXVnTmD6u31OqfuFfOt5
         mBEVO2EBewC3xkf2tBhifnMyhEmTqKj7uFgmdUESQRR/acgC50w3CN7f5zlYS9KH4APZ
         Lnl7wV5uM0jrjAJi0t8PFepom4ZPWq/SBn5E3CGOA4C6RVwiFR8Y/zJhgiDYY24OOZwk
         elT43ObtiWOHoEei6I8sKqWq9F5LMzb7roCTjZG5qGiJbMN0A8OBhXHevOIu12HbEaKi
         ozkDNU8NIncnXRqEkfNI88bhuTj81fOHxQq2pvewUiLzu/Vs9tbVS2R6deRe+C8bnx7f
         XWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV89M1a++Ay8LBFuYIJGuiDiKVF3gxdpRgZyWOepPzUM9f3JcxJ9AxWaxAl9bsOQd3fqdql3gz0ve4J3qihVPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLvODdNN7g0skBEmwcN4l+8KVhdyx+KNtjdnoQrhvEE3CGq1T
	eUMIbN11y6QR+60GFTvoVChIikBkqNdFCoWxnPL2fFkPWG0CbhhUNZIuEWUlO2j7h0AitOvM1HP
	3cK//R5yzyqt5enaAPqqpz7X6MpgfJPlSStXP
X-Gm-Gg: ASbGnctxUJK+/zT8T0H/63LPddYnFsoc24bmPkbjE/iwD9HcXFzIrlPtceC7uCZW3WJ
	nXV62eW6DEjT8G17X0b9QK903Et77J+2Bj0sWYErFZIkxc+y80l3mJTRI9dPfgty31oOyoW0+/L
	cEp23ls6WxfAPXXLsJ1ineFg4=
X-Google-Smtp-Source: AGHT+IGyUvg0Xg67n9AJGe0enuLQqWHs6UNth8HvvFAW0sChxeMCdkfk5Sb0kgepq+R9c61fibX+NjS/8UHRLWHj3Yk=
X-Received: by 2002:ad4:576c:0:b0:6e8:f905:aff0 with SMTP id
 6a1803df08f44-6f23f13293emr217868226d6.35.1744705604638; Tue, 15 Apr 2025
 01:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de> <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
In-Reply-To: <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Tue, 15 Apr 2025 16:26:30 +0800
X-Gm-Features: ATxdqUHShNA4ncH0WdvjCIFdWJT6j9Qm-Ubzv0Zw8BR9PO7gR4hhrZVuQIibV-E
Message-ID: <CABVgOSkd4v7EE2YSVVb9pezYdhZvY+6=8mbHex+CtFCp8FjGDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d41cdd0632ccede2"

--000000000000d41cdd0632ccede2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Apr 2025 at 15:10, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Not all tasks have an ABI associated or vDSO mapped,
> for example kthreads never do.
> If such a task ever ends up calling stack_top(), it will derefence the
> NULL ABI pointer and crash.
>
> This can for example happen when using kunit:
>
>     mips_stack_top+0x28/0xc0
>     arch_pick_mmap_layout+0x190/0x220
>     kunit_vm_mmap_init+0xf8/0x138
>     __kunit_add_resource+0x40/0xa8
>     kunit_vm_mmap+0x88/0xd8
>     usercopy_test_init+0xb8/0x240
>     kunit_try_run_case+0x5c/0x1a8
>     kunit_generic_run_threadfn_adapter+0x28/0x50
>     kthread+0x118/0x240
>     ret_from_kernel_thread+0x14/0x1c
>
> Only dereference the ABI point if it is set.
>
> Also move the randomization adjustment into the same conditional.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

This looks good to me -- we've hit what's effectively the same issue
on other architectures with this test, with similar resolutions.

Reviewed-by: David Gow <davidgow@google.com>

I'm happy to have this (and the following path) go in via the KUnit
tree, but if you'd rather have it go via MIPS, that's fine, too. (The
qemu_configs won't generate any merge conflicts.)

-- David

>  arch/mips/kernel/process.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index b630604c577f9ff3f2493b0f254363e499c8318c..02aa6a04a21da437909eeac4f=
149155cc298f5b5 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
>         }
>
>         /* Space for the VDSO, data page & GIC user page */
> -       top -=3D PAGE_ALIGN(current->thread.abi->vdso->size);
> -       top -=3D PAGE_SIZE;
> -       top -=3D mips_gic_present() ? PAGE_SIZE : 0;
> +       if (current->thread.abi) {
> +               top -=3D PAGE_ALIGN(current->thread.abi->vdso->size);
> +               top -=3D PAGE_SIZE;
> +               top -=3D mips_gic_present() ? PAGE_SIZE : 0;
> +
> +               /* Space to randomize the VDSO base */
> +               if (current->flags & PF_RANDOMIZE)
> +                       top -=3D VDSO_RANDOMIZE_SIZE;
> +       }
>
>         /* Space for cache colour alignment */
>         if (cpu_has_dc_aliases)
>                 top -=3D shm_align_mask + 1;
>
> -       /* Space to randomize the VDSO base */
> -       if (current->flags & PF_RANDOMIZE)
> -               top -=3D VDSO_RANDOMIZE_SIZE;
> -
>         return top;
>  }
>
>
> --
> 2.49.0
>

--000000000000d41cdd0632ccede2
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
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQghb+VzZWx81ICEkcx9VbFn/r17HxM
Tr7MWoi9iLPSc6gwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NDE1MDgyNjQ1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAFy1GJHzWJZ2xO7qz2kbnRUHFS/JRcAr9jaUvAxWdqBIZj1s9y6mBV36mFongOyMt
HsyL/VJR2pb570nVTD0hON7FvF3OUZMk+8ux2GVlEHTcq00fbiQerxYbl7g8TVlif7TyHTj6ey3Z
HMub5/ZaHKCm9//Ot0D+1qsW28QNZqrrSQICFo30dIW+pC1u48DD/e2XgVeVuzeylmOtAAF60dii
OzWhINQJi8y1ZSqET/zvMpWfsruV8pXw/+rMRmS9C70lbwdEuj164L+rUosD8utsxUGGfgcmK2nQ
MjYa0E+CX218iBBrqFYMgPiboa1zwhz54ZatO1vurQCVBcElHg==
--000000000000d41cdd0632ccede2--

