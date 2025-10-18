Return-Path: <linux-kselftest+bounces-43481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C37BEC921
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BF19A6156
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2DA283FF8;
	Sat, 18 Oct 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gpqj/yLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8726A0C7
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760771905; cv=none; b=SkA4h5SBfQ4Q6WPO/dPBaeK6VGLiqvm2pDIh4FpbVPEy2K0lWOkStWe1Gbc+qVvuosRBA0+scWwoQHUTnyRNI9KLYmPMZWZJ2zOhLW7PQbnCw616ZDpKnksA74JGp7fttjpkDgGFV6e8L9gQfB9eJAd2fwWKTEYOPPTHY+tCMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760771905; c=relaxed/simple;
	bh=l5lp+WR/ExoUuJC3SDsHMIYL6+zeZKxEHYHtD524sjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czJ+xO9yHIM88/oMw3p2FazIRk/+eiyzhgCicK8G/mi2E6XlAO24ojijNjFM+9p0R8sdZ8XaP6zcdbyslMoCu+oGqefElDR0ho9Oty6UZMwN408FtNvITn/6AZpqkd7/cLBiTV4qt4JJvmbNzM037+lGY3v887GozjxenTD72PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gpqj/yLw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so38202966d6.3
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760771902; x=1761376702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VlQT7N0Q9tQzTHPfEmEDHgUhYxX9aM0NJshDuxR5aE4=;
        b=Gpqj/yLwsZvvW9yroNsE5vYwlURCeteJ0oDhn7IeUzu57LWUxqsQzpcdKqltH524hH
         BJdY0r9jcSudzjsnmNFOiGIGDHuvEgz/FXGz4H9UjeZJvHOjU7Ylw0HummEGGDy/CLYh
         szXF3l07YX8odJwUObtchHjb/HK1S4+2auMeS9+z/gQWFPC6405pg4Gz8FSALkvtOFEw
         E2LvUn6nTrRTw2ioAwLDiwTbnM108lPGaqKLc71U8pF1eaWj1ZuTjRgNUF7+4ZPzQI47
         j84CGZ+zDpd2MRIDckpgCAff7XJmn+Qk/b+yKP1VHCiUGZqHDR/pA3lnRrmvq22mTbNo
         P3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760771902; x=1761376702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlQT7N0Q9tQzTHPfEmEDHgUhYxX9aM0NJshDuxR5aE4=;
        b=KHeKdjoLcANQrpdK9X//RL6JcCkyXLjXshBM/XgiOEEeSz4fW0R0foymyo1or3etJb
         s4xlpfxevOXcCeQ8UWXyqKgtvhhvkH8AARkGKtGJKbu1/7Et4Iu4HDWVPPpk9GZO9s+p
         Ydzh3MSzVpfiUWVI67EffDewP4f/Q5fHFcrKo/ULteOiyfB4vISGW2SF+XjYQpOjlVP2
         1UvyihZng7ejdDVOVGvSADLx+f3eNE4pdpjsMN7fxp3IK1FoO7csh/LiNNemCZOU8nfj
         ChcgvUrFPhbVxAvNDMNhh8c06/V9rEeumy3/oSBZCwdX3BodQ0fAENZwtYHIr1Oc+btf
         Uqag==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6KCLYY7Aakq5ZUqgp9CVCLX/PVStePjKr+otPoukYfeaCown5WaJt8gpdU1uX0V4iBBKMS/J/5nJbFqAY5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENyE/DA2l7M6ivVC0Pq58BlFJuIiq0m3yh+cValU2ibdf2me+
	O4+aCDrBtOLdJHBWEpJ3Q4dy5zSHQUnKzp/xrjgoDD5rmhx8z1g6ZByFw1aL5djqF/2wW218zEU
	Uk6F8PK2biQCe5NayJtd4RcxEW9DgLTCW51jXE6Cz
X-Gm-Gg: ASbGncvQcZobcZBc1ddd8QNOFgsIHlF7T0EOwX0rxNPTw8saG88t/fS64YiafnlA4hA
	1FwKaWnVF7K8reazvi3zqopRV255spAIbXnw8ULrvNadSGuv19P7LkFgynNpqjI8HY547y0vrUY
	qJMd8RgK56f5+os/GUlZkMOAxkC/WzHL7dgBTHRucw9O26BzCEgONNenFADNyBIiUdebthlPyX/
	dzvKP5qTWSy2R05yruU5Gdco9U4iuD4ontUhFLVzjo0S6CUGUGF6mTpvww=
X-Google-Smtp-Source: AGHT+IHSVr6bICKymhk+Fe+8/osBoZ7sUGGS8Phz+Q+7igSJ9Tq8EDG137Urhe9Luyfy2kpYkNQVo1G9aHUe+ohtxH8=
X-Received: by 2002:a05:6214:f63:b0:87c:182f:613d with SMTP id
 6a1803df08f44-87c205ed060mr96973776d6.31.1760771902038; Sat, 18 Oct 2025
 00:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617140032.1133337-2-guillaume1.gomez@gmail.com> <20251009091410.756800-1-ojeda@kernel.org>
In-Reply-To: <20251009091410.756800-1-ojeda@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 18 Oct 2025 15:18:10 +0800
X-Gm-Features: AS18NWAaaOAQ7iVCB2kwSglFiza-4WK3mUv_IHd1gtCuuE3VDXf34jgCI4GJo48
Message-ID: <CABVgOS=UN2AEnkTTdbMKmsROk19-r2SkokxcC2ps7i1t8ocXQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command
 line flag to improve doctest handling
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Guillaume Gomez <guillaume1.gomez@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cb05dd064169a774"

--000000000000cb05dd064169a774
Content-Type: text/plain; charset="UTF-8"

Thanks Guillaume, Miguel.

This is looking good to me.

On Thu, 9 Oct 2025 at 17:14, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> On Tue, 17 Jun 2025 16:00:33 +0200 Guillaume Gomez <guillaume1.gomez@gmail.com> wrote:
> >
> > The goal of this patch is to remove the use of 2 unstable
> > rustdoc features (`--no-run` and `--test-builder`) and replace it with a
> > stable feature: `--output-format=doctest`, which was added in
> > https://github.com/rust-lang/rust/pull/134531.
> >
> > Before this patch, the code was using very hacky methods in order to retrieve
> > doctests, modify them as needed and then concatenate all of them in one file.
> >
> > Now, with this new flag, it instead asks rustdoc to provide the doctests
> > code with their associated information such as file path and line number.
> >
> > Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>
> > ---
>
> (Procedural bit: normally we provide a changelog between versions after
> this `---` line so that reviewers now what changed so far.)
>
> I finally took a look at this again, so I rebased it and got:
>
>     thread 'main' panicked at scripts/rustdoc_test_gen.rs:92:15:
>     No path candidates found for `rust_kernel_alloc_allocator.rs`.This is likely a bug in the build system, or some files went away while compiling.
>
> which brings me to the bigger point: the main reason to have the new
> output format is to avoid all these hacks, including the "find the real
> path back to the original file" hack here. More generally, to avoid the
> 2 scripts approach.
>
> So now we can finally get rid of all that and simplify. That is, we can
> just merge it all in a single script that reads the JSON and builds the
> result directly, since now we have everything we need (originally I
> needed the 2 scripts approach since `rustdoc` executed the test builder
> once per test so I had to somehow collect the results).
>
> i.e. no more hundreds of generated files/processes, just a simple pipe.

Yeah, this definitely seems the right way -- even though outputting
the generated rustdoc.json to a file is sometimes useful for debugging
it. But unless this actually breaks often (which hopefully it will
less frequently with this setup), just passing things around directly
in a pipe is neater.

>
> Anyway, just to check we had everything we needed, I did a quick try --
> please see the draft patch below.
>
> I gave it a go -- please see the draft patch below. The diff w.r.t. your
> patch would be something like +217 -341, i.e. we get rid of quite a lot
> of lines. I added as well some more context in the commit message, and
> put the right docs in the unified script. This also improves the sorting
> of the tests (it now follows the line number better).
>
> We still have to preserve the support for the old compilers, so what I
> think I will do is just have the new script separately, keeping the old
> ones as-is until we can remove them when we upgrade the minimum for e.g.
> the next Debian Stable.

Agreed: we definitely need to keep the old way running for a little
bit longer. Whether or not it makes sense to have both versions
running in parallel, or just delay this until we no-longer need the
old implementation is a matter of taste, I suspect. Having just one
"active" implementation at a time has a bunch of advantages
(particularly in the case there's some inconsistency in, e.g., test
names between compiler versions) -- it's probably what I'd go for
(mostly because it's easier), but I've no objection to having both
running in parallel, assuming it doesn't cause any more issues than
the code getting more complicated. And I personally don't feel that
having both is likely to be a big enough burden to be worth bumping
the compiler version alone.

>
> Cc'ing David and KUnit, since this is closer to getting ready -- please
> let me know if this raises alarms for anyone.
>

Apart from the fact that it breaks the older compilers, this looks
like a definite improvement. (I was a little worried about adding a
whole json parser in, but it's nicely small and self-contained, so I
actually quite like it.)

So I'm happy with this from the KUnit side, so long as we either don't
remove support for the old system/old compilers, or delay merging this
until we can drop support for those altogether.

Cheers,
-- David

--000000000000cb05dd064169a774
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
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAGEC3/wSMy6MPZFqg/DMj8w
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTEwMTMyMzQ3
NDlaFw0yNjA0MTEyMzQ3NDlaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7T8v6fZyfEDlp38NMe4GOXuodILGOFXh6
iVuecsKchx1gCg5Qebyxm+ndfb6ePkd2zzsBOkBJmYrx4G009e+oyTnynr5KXvucs+wLlgm53QU7
6pYikvqTM2hezoWz48Ve/6Jq/6I/eAzKGhn4E/3zG15ETIeMpPFy/E7/lGqq+HFRCb6s0tl/QWhC
BiR+n2UvmXbVWPSR51aRAifsKqiuraeU5g9bGCcbuvdbiYQf1AzNDilkvA6FfUaOPTzVj3rgMyZb
mnZpzWOV1bfib3tYXd2x4IvUS3xlvrap0g9EiDxJKUhCskOf7dPTjaS/kku768Y6U/sDVH5ptgvP
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgkfSIEFGz0m+xJ5pp+WLRqEAIWHfP
1AtJVRegth7BqvMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MDE4MDcxODIyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAM9+JBlwwh93752MIgo3nmiWLr7JFFmpgQrCrex2iZNa0iyPUcBDIV05lSawYcOXW
xe0Pg+JGkAuUjrBrsytaAIV+i+5kVo5o+IDPQoU+8L1hvFbvsPbCUXpn+qDdUQaBu4ZhEluPQWsR
4kIUdjhXFjrd4OBBvK0VYLssuDZod+dwfrkRKFrLRVUzuwQCkt6/7QmmjwRdgyHcUchT/3Z+/MQo
atIc7e3IYV4G0FlVqlCLWp1QN7xMleu76ExtjxOmCU4Os2KN8GKqI2n8NA76pIxrG3h4986m472I
WUIgizwZvbngTsN0ZmZq7fQBCisM8M8WNglGWfrXgtaJ15KrfA==
--000000000000cb05dd064169a774--

