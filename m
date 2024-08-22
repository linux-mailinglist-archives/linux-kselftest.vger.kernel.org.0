Return-Path: <linux-kselftest+bounces-16000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD895ADA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6151F230A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3113BC3D;
	Thu, 22 Aug 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BchYpjVn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F313B5B7
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308642; cv=none; b=DSo3JwIdhuViDI2XUERiCJnqnj5t7qUlcnktpee4OGDaLcFriSdyVz29oBWgbyuhh1GzUb4lHBkZqn5peryV9IdGr1Biix4YoX0N/nBGph0M9jBdpj8AJ30x55dRcNbemlr73KpGa6Sd242yWsW2qV+CIx8zSyDS+Fh8bxOCPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308642; c=relaxed/simple;
	bh=USkWhxEYZ7D/MXDfPMML3ec+RI9pvxAbzMaKUhzg68o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgVnmyUOFx+TwvN4wQeYfC/X5q5BELw1xd9vkaOpQ0+fBfoChZKjDggl9RVIOy5Gh1bI7QkuQ6GBdAF9N0DbbcpOB6GodkM855JAYs6r5J7Gx6+NlF5BJ8TFSKNxnDbwxFRIP1Tc20rVg1eMm5IyGRzfF+EwxOEDzcLKMUxZOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BchYpjVn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso1991596d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724308639; x=1724913439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xje2LfKDStpUg7XfnQ12gi6fbBgUpLLeGbcTGCcvlzs=;
        b=BchYpjVnPojZR4D+iXHjdD8nICI44ZzWyNTXb0ICAbICr5v0WbMjwEqDAtiPsJlJD/
         YyYvJu4sWdYCmRbUb1ZuqAB+3D1m2wrpmgb9Q/OvgQ2J1VYSs9VAMoepjmqsZNqssa7c
         doy4P+G2J+wUj0rIbC4DuinKuO4UB44SugmwBuYcSQfQMuZEAVZahcreGjsO8u7goEt8
         Q8TwQ63bFWqnzWomV0+mYzf6W/Y7OWZIjG75xzWXT0VLaFhhK8laSXMLhtbL+PCI4IbO
         zUftIZoh0ePXUKNDqsZ1mOjsbgwMfGCEtbt+pITvnXhKZSUL628wdsZrYlcWQtYqttuV
         EfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308639; x=1724913439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xje2LfKDStpUg7XfnQ12gi6fbBgUpLLeGbcTGCcvlzs=;
        b=NgGjhg7NxPwcI0pP2EsOxitkAtlhvmd5teNbsr0LsRObg+kxggBNZiPqaMB/Xrdlz4
         nd0DpfURR0h8iVAyDS+bnmYAiVMrIfW74accmbFh6OiQ4r1TZu1zBiJRV2pHR6OfGHdm
         piNDfMVQuS/se1BGG6/wWKk5UVgBBUe/25RvTV1Ph7NFWXveoudP4Y4lVO8iwQTWgb9c
         apxbDWJ2+ETMd5/CNL0q4zOtO4s7B02r5SU/Z3pdLXtYZATBABmtMBG4Enh7qhtR6KMc
         1YwAYVLeREOFcTplKmrFbt2A9Gv2SwH3HADC/Tc8rnzzreiB1uEpHkSnFJ+cq5TbAVW6
         lH5g==
X-Gm-Message-State: AOJu0YwI8QRjdB3zC/lnxCA93XIO/oM4dPPM/agE9bOdU5s1/bVRRVFy
	CbBZUwpSQN36wlrCdxspmUmhAJd0r3dPH+05p/us02PgSRYZhNnDU/seJGw/RHCaE7jN9FTYSfR
	lf63lIMm2EEzGxL71ty2T4dfk29IsHBYTX6s56RAPNJO/hRCm5L6k
X-Google-Smtp-Source: AGHT+IEo7/0lUeWaK/KkipNvCqatmEROADMoZXKnf2ym/MY4xBRHgRsnW3exEIYtRaKPJDHsaYK8tK9Jvhg8YxfU4g0=
X-Received: by 2002:a05:6214:5f03:b0:6bf:8ccd:a38 with SMTP id
 6a1803df08f44-6c155e25acamr53118626d6.57.1724308639361; Wed, 21 Aug 2024
 23:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821191412.2031-1-michal.wajdeczko@intel.com> <20240821191412.2031-4-michal.wajdeczko@intel.com>
In-Reply-To: <20240821191412.2031-4-michal.wajdeczko@intel.com>
From: David Gow <davidgow@google.com>
Date: Thu, 22 Aug 2024 14:37:08 +0800
Message-ID: <CABVgOS=ScU-9YYunz686zVwmrt+yebxB+=z8U-Qm3s-E=QnreQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Improve format of the KUNIT_EXPECT_EQ assertion
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f673b306203fe391"

--000000000000f673b306203fe391
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:15, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Diagnostic message for failed KUNIT_ASSERT|EXPECT_EQ shows in
> case of integers only raw values, like for this example:
>
>   bool flag;
>   KUNIT_EXPECT_EQ(test, 0, kstrtobool("dunno", &flag));
>
> we will get:
>
>   [ ] Expected 0 == kstrtobool("dunno", &flag), but
>   [ ]     kstrtobool("dunno", &flag) == -22 (0xffffffffffffffea)
>
> but we can improve it if the value is within MAX_ERRNO range by
> using more friendly error format:
>
>   [ ] Expected 0 == kstrtobool("dunno", &flag), but
>   [ ]     kstrtobool("dunno", &flag) == -22 (-EINVAL)
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

I wasn't sure about this at first, but looking at it, I think I like
it, since the numeric value is still given. _Maybe_ it'd be nicer to
include both the hex and the error name, but I suspect that's just
going to clutter things up more.

So,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/assert.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 8da89043b734..9dec0551d0d0 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -128,15 +128,35 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
>         if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
> +               if (IS_ERR_VALUE(binary_assert->left_value))
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%pe)\n",
> +                                         binary_assert->text->left_text,
> +                                         binary_assert->left_value,
> +                                         ERR_PTR(binary_assert->left_value));
> +               else
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
> +                                         binary_assert->text->left_text,
> +                                         binary_assert->left_value,
> +                                         binary_assert->left_value);
> +       else if (IS_ERR_VALUE(binary_assert->left_value))
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
>                                   binary_assert->text->left_text,
> -                                 binary_assert->left_value,
> -                                 binary_assert->left_value);
> +                                 ERR_PTR(binary_assert->left_value));
>         if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
> +               if (IS_ERR_VALUE(binary_assert->right_value))
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%pe)",
> +                                         binary_assert->text->right_text,
> +                                         binary_assert->right_value,
> +                                         ERR_PTR(binary_assert->right_value));
> +               else
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
> +                                         binary_assert->text->right_text,
> +                                         binary_assert->right_value,
> +                                         binary_assert->right_value);
> +       else if (IS_ERR_VALUE(binary_assert->right_value))
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe",
>                                   binary_assert->text->right_text,
> -                                 binary_assert->right_value,
> -                                 binary_assert->right_value);
> +                                 ERR_PTR(binary_assert->right_value));
>         kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
> --
> 2.43.0
>

--000000000000f673b306203fe391
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgxx7TFDlODuQ6h5lhLNiHXdpYeISi
Rik+84Yvk0KVFmEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
ODIyMDYzNzE5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBANnjeCnS5ujEmwQuTmEkxkmodqVBSsyD4RwvPSVu1+FRywyI
6bVJFheMwXFYkenS6RqzPyJaNqQioxnV+OtkDeV1aRnF9Yh5wg3QVJANytuiBvRFsKM4lB1DNOsp
ZO/Wj74KK+e3B3COdlraVqB5o4t1u9mWuJ6cpUx3nYFXRges51QmGNA/H4uPLUHKqqTqS8IkzHMP
5iD3wXedPEzZ1DOMUiwf5l+/yMhr+HanBmTmMgJmlcbxTlB9FYonWbLyBtv4il4e5bEmxvbwo/rT
HLe5c8kDSQarWODryCvNJ0ap5OGrd0rXrJ6drNNO11OuR7/md0yblcFdc01MMxwcYsA=
--000000000000f673b306203fe391--

