Return-Path: <linux-kselftest+bounces-47679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB34CCA6A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 07:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1838300F655
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 06:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2031064A;
	Thu, 18 Dec 2025 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4ovaAjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E929DB64
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038362; cv=none; b=psvwkVDFwbDzP8mwv2DvI+IWocfNxldeRobhiSOxXHV7DXzgIk87zzRH0lFZ9iPQu+vS3gjXgIwwqXPdwMgU8ES+M9vNP7tb0ck7KHN3tJjq4Dxq+Zd/E6K+TO+LlTog1MjILqSLB7XaTYThpMiA7TucmQXUObGhggbbNqck62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038362; c=relaxed/simple;
	bh=wEbNfvFLSgpoDTa2CXI6lDz/SA/cQzbA1OpeKCNHwYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUMlOOHTYN8cEvRvUskQZvirc+MP1Ex5v+9iCE5GF3q/H7QXwjKc6xrqonottKnchc/XbNJ1o1UBfo2fMSvdNxIvciPZPrR3+sePD/ya8FYqO79+xa7RdlIhKFSAKtCe4kzmF4JZWaEel2Q/7zxoqzIS837qgpQ4WfeZs1WcKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4ovaAjq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so80423f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 22:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766038358; x=1766643158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4PmGHGys0uk8qtztMxfH3kYm2JHZBgw1rSPx0Wsx0Y=;
        b=W4ovaAjqw554jEX/P3eHKQ2o2+5N9tIexkhq6M2Pq1ck3s9YskaS2zWwpzvP/v5O5k
         vhCchuHzqgwQ1j+6NpfXNw9uiw4jMpZ2BYL70LgvZahaFMBsWrnEo4DcewiTVOufQgDS
         LpmkExvGmqiK7dxV8Dm1LSHVPqAUUQXv5jSqUgzfpfaUX6DibK+GqbfmOZieP3ZANUuo
         MZY56CUJOUsyY4UY2kZpkjKXSTAmLepp8OaUoLBSS2VYDX0mdzu8Fo4n/8aTx32u9fhJ
         2gBNKaBKahrxjNczJdCVc0mvq8/r/YZHhnDzDGwi6pQK+lVmcOUcEPD7z26IxbbE5652
         TyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766038358; x=1766643158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4PmGHGys0uk8qtztMxfH3kYm2JHZBgw1rSPx0Wsx0Y=;
        b=dDwfAc062U3XvOf8u3PQqVV+dagy55rjXyqOd+blbaaZqo5i9dUIjs2+LZLwhvcJEf
         Xb1K7Hg3dL/Uq65g6Tdien1EZv/Q3CsP/mQD440W2u1EoHugYgt/szMpv5/s7jSyLDMA
         piw3qgQllYDIxxoolExs6ERxchV9uKfgAopsLWcF7wXZzxIbRpqQJd61KBqrmj/pN8Gd
         2oMl6V3Se6H7Mb5GZzPwhbPziWgNxnWQ5mpNjOWDsTNKaGtJUMugvSunjEJms/OGPudn
         v9uek5QqRjV7YNwHkShrrIECFNh6FWFs44IPNk8sj9TfLjC0p+1I+VkFQoaQSYdDujtk
         rF9A==
X-Forwarded-Encrypted: i=1; AJvYcCVVQsMQHRXAn42FyHSJMVJTZ4T1DPYTyzrxqurQm9z6RFEiHUqPhXhB0jPlrMi0qq5pYc/j6zXHGvj1926b680=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwujFCpxFyIK+/SJ3UiejXlKTIjVYHuOAjgmOlDYmjY2eXWigq
	Rn7+p5oNM4FDJG4bAmeO9cb/Wa/JECXzwtucFjIPKfpQNEAbR2Fl8kh9W7+cxN40+t44RkmN50T
	CyupGp7ujyQLiV4dRWXMZ5gyzLhgccqR3cYodZ07m
X-Gm-Gg: AY/fxX6ImuJokg6kJdImIziUBddQOPCr2aSYaVf9W7elKKPFnLKjoRPgxQiVrf5WZWR
	QdUebFqFl2hYl//9SAUEKjnwjngRLkcUPKsvh1toYags+YChiEFHoQW54EnTOB+7fSbSq0DlxW6
	uBd2T2MbZyQzwhEPx7cTqFG0Sn2XF+q+IbyHmIFNWg+XnCDunXOpqy++uOTZapfLstFqoVcd4rN
	iz1zCKsQM4DPRBs6Aup1CgGd/IedfG4lCAAqPuRqBIvEX4PeG0JBVXflVu+9zFzOhUSIA==
X-Google-Smtp-Source: AGHT+IEi3WgRpHjL9ia8DcHC8LluJMFP1eF0pFyzzGcebFkpHnDeBDsCdiiT2MpuHsGYeeU9uzxtkmeIXo/3vb2puEA=
X-Received: by 2002:a5d:5d09:0:b0:42f:9e75:8605 with SMTP id
 ffacd0b85a97d-42fb42c1a55mr19581627f8f.0.1766038358352; Wed, 17 Dec 2025
 22:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025121746-result-staleness-5a68@gregkh>
In-Reply-To: <2025121746-result-staleness-5a68@gregkh>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Dec 2025 14:12:25 +0800
X-Gm-Features: AQt7F2rWWSJG6XdNK4n-eCok4GMh893akEyYh2zfEGV0-X4OhWYfyw3u6WJPRgA
Message-ID: <CABVgOSmVk3Jo=fXh4M+vM3KOPqWW6vqxfj_=-NhkbSutc_Spcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix up const mis-match in many assert functions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: brendan.higgins@linux.dev, linux-kernel@vger.kernel.org, 
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000a8f2e064633d989"

--0000000000000a8f2e064633d989
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Dec 2025 at 20:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In many kunit assert functions a const pointer is passed to
> container_of() and out pops a non-const pointer, which really isn't the
> correct thing to do at all.  Fix this up by correctly marking the
> casted-to pointer as const to preserve the marking.
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <raemoar63@gmail.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/assert.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 867aa5c4bccf..4c751ad8506a 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -51,7 +51,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>                                const struct va_format *message,
>                                struct string_stream *stream)
>  {
> -       struct kunit_unary_assert *unary_assert;
> +       const struct kunit_unary_assert *unary_assert;
>
>         unary_assert = container_of(assert, struct kunit_unary_assert, assert);
>
> @@ -71,7 +71,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>                                      const struct va_format *message,
>                                      struct string_stream *stream)
>  {
> -       struct kunit_ptr_not_err_assert *ptr_assert;
> +       const struct kunit_ptr_not_err_assert *ptr_assert;
>
>         ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
>                                   assert);
> @@ -117,7 +117,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
>                                 struct string_stream *stream)
>  {
> -       struct kunit_binary_assert *binary_assert;
> +       const struct kunit_binary_assert *binary_assert;
>
>         binary_assert = container_of(assert, struct kunit_binary_assert,
>                                      assert);
> @@ -145,7 +145,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream)
>  {
> -       struct kunit_binary_ptr_assert *binary_assert;
> +       const struct kunit_binary_ptr_assert *binary_assert;
>
>         binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
>                                      assert);
> @@ -185,7 +185,7 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream)
>  {
> -       struct kunit_binary_str_assert *binary_assert;
> +       const struct kunit_binary_str_assert *binary_assert;
>
>         binary_assert = container_of(assert, struct kunit_binary_str_assert,
>                                      assert);
> @@ -237,7 +237,7 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
>                              const struct va_format *message,
>                              struct string_stream *stream)
>  {
> -       struct kunit_mem_assert *mem_assert;
> +       const struct kunit_mem_assert *mem_assert;
>
>         mem_assert = container_of(assert, struct kunit_mem_assert,
>                                   assert);
> --
> 2.52.0
>

--0000000000000a8f2e064633d989
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgv07WhlbLRfJqKKNgPtLaYcmofG7r
viZhXGLSnToUhi4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjE4MDYxMjM4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAKUmL92rHQzTm8/iBYIDmzoGhLEA6WyJmH8xr8SmRqOHG6tN4FOOT6uzBpmi1aP6v
1ZcfbKzm5R0lH4A/lGC27Pzg5OUXwechSdcxMM6hlSLZZri5iG44LR9pjmnCPSVY9Ge3G/AGc+CM
yF0gU3mYjFNlvu9mjOEe4BpxNcRDI3RAzJxCXR5JHUlx6R1G2GOiauLmypbru+G5zMwjBqaimR0k
+Iqp0UZFJWK+W9jGllq4NqY0Eqftwrauu1NpK0sbsOtCLq8CrWP1h3Yjz1WYChWrLpirkOIVQd0e
5ASYX0EO0xNJtl8eHxGXuWTy9DLXrOEJuOJZ2lJRw3QAUbhXxA==
--0000000000000a8f2e064633d989--

