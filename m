Return-Path: <linux-kselftest+bounces-15999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53095ADA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F996B22DC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94F13BC02;
	Thu, 22 Aug 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zi+lRiKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4913B2B1
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308639; cv=none; b=JlxQ8e6rKp21GvJPfglUrKvbQgR8j/3tIudrqmDviHqjOrj/cNwdT3Dw0sfTczsNOnszh7YWqZhEWUCZJZAGyRt+7i9MCFf/zzZ4pHaTilEYaNiSdMdEIGwPxHmqDzHcvr5AxcOOV5goSecyGg7zOggF1NVKYpOjpl1ZATOUoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308639; c=relaxed/simple;
	bh=5v/gBHD9pxz1KSSIQmGU87+M9B67zWpZk5yfHq+gOqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkaGtrXuYlmzgF1WO6F0FKL0+OZm1l1jPOHAS2g8NRUsGiEJU8IgSSuqY3/eRMKsQwZyX8Qmxs0KBpWx8su1hV1HVZBVTmjzewT4f3YidNw9EtLr5TAgdHDVovaeZOEabPQvdzd+IKSgBD2cIWnBpX3u0pXAa31lHuiHClP+OEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zi+lRiKV; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf6ea1d34aso2182736d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724308637; x=1724913437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDfKXZnCA9wdp5ApzzaavwO41/f/IucvNZ5e2FnUAqw=;
        b=zi+lRiKV61M451oIsiX4O/rhMrO/BudS6ML8x9dOb1OpG31FfHU4WkOhL9dlBoWayk
         y5F/Kie3P+0360hAtFGbSYJebfmnw7vhNja0rfBJl6Ai6rEb529w+7JTQjJel8Ku42Eh
         u9npw7olQ5rk5Fw0/VsiIO6HhalbIW/iOK86B58NyDjrnUrVmhIw667JysDp2EMMI7Kd
         hbMX3nniWj9QpcxjeriyvFailpeWxJeVXy+cRdhmh8VN9xRuwWOvzgMn6l98Xf43ATrc
         12WK4BPlZ3iOXT04eNgS9lSA9bVwOfzhO656kYsb7krL7j5eiQQpCcIVOWMrG/QQrNuW
         8WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308637; x=1724913437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDfKXZnCA9wdp5ApzzaavwO41/f/IucvNZ5e2FnUAqw=;
        b=U2QqmimHpAbBSfTm5kc0vgO2a4EqaIBgS8P5Md8QeTx1lYP/ArZDtoFrvHk/FakpeR
         cGtu6nMW7rllt0LZjZI9GEmFSm2UuVR5j9UNgymArdZ5qO8W8zHMPLFWiN2q5FMLV4r8
         d7gsMUuLLuPaAtBty+VoseIkiH4Ia2jVzmhbU4TRGRELXnR7jKArrSVsVzizbn6bRZO6
         PbbkCDslwD2Bty+Y1mIiYR18AZe6zNzfjrSHqbE8CL1n3QqOkz+obfxCMY6IL/O0y1hj
         FCzpCLHH/1IS4Ru7bt6cLqFq6y4z7ju6IqYqAk4Ul6eMMlSMamTfvJdouX24JC7bHsJj
         KEkg==
X-Gm-Message-State: AOJu0Yy5EO5xlGQhBRE6PrkrmcTbBA33OW1J1OfWzlMNiba07enxRaa+
	aPN4pmaMJJBAcl8/B6jKhtHgv9R/6pcWYXTSoItqReCB1AmoS+kudqR6dlYIutUBTk3to1WIqo9
	zVbeqNLI/5SKRe0F1Ftk4hS2U+iRxNtHp2ydG
X-Google-Smtp-Source: AGHT+IEjEe4WVoXsDP2NRYtwcXmq97MhCUkRny0ePeDGZ321iKY0WKCi7jnKKO4DH4zDcszZJjHtTOsN4lzzOD+Cqf4=
X-Received: by 2002:a05:6214:4293:b0:6bf:8bf8:658e with SMTP id
 6a1803df08f44-6c1567fba8bmr64881786d6.27.1724308636498; Wed, 21 Aug 2024
 23:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821191412.2031-1-michal.wajdeczko@intel.com> <20240821191412.2031-3-michal.wajdeczko@intel.com>
In-Reply-To: <20240821191412.2031-3-michal.wajdeczko@intel.com>
From: David Gow <davidgow@google.com>
Date: Thu, 22 Aug 2024 14:37:05 +0800
Message-ID: <CABVgOSkcJtx+n_6isH=H6enUj7CUvbpLWjUSe35T0Nh_75D45A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: Improve format of the PTR_EQ|NE|NULL assertion
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cb4b3d06203fe307"

--000000000000cb4b3d06203fe307
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:15, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Diagnostic message for failed KUNIT_ASSERT|EXPECT_PTR_EQ|NE|NULL
> shows only raw pointer value, like for this example:
>
>   void *ptr1 = ERR_PTR(-ENOMEM);
>   void *ptr2 = NULL;
>   KUNIT_EXPECT_PTR_EQ(test, ptr1, ptr2);
>   KUNIT_EXPECT_NULL(test, ptr1);
>
> we will get:
>
>   [ ] Expected ptr1 == ptr2, but
>   [ ]     ptr1 == fffffffffffffff4
>   [ ]     ptr2 == 0000000000000000
>   [ ] Expected ptr1 == ((void *)0), but
>   [ ]     ptr1 == ffffffffffffffe4
>   [ ]     ((void *)0) == 0000000000000000
>
> but we can improve this by detecting whether pointer was NULL or
> error, and use friendly error pointer format if possible:
>
>   [ ] Expected ptr1 == ptr2, but
>   [ ]     ptr1 is -ENOMEM
>   [ ]     ptr2 is NULL
>   [ ] Expected ptr1 == ((void *)0), but
>   [ ]     ptr1 is -ENOMEM
>   [ ]     ((void *)0) is NULL
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

I have some mixed feelings about this one. Personally, I'd rather this
continue to use '==' rather than 'is', just for consistency in case
anyone wants to parse these.

Equally, I'd like to have the actual value printed for error pointers.
The PTR_NULL assertions are not intended for use with error pointers,
and the PTR_{EQ,NE} ones may or may not treat high pointers as actual
addresses, or as errors. (We often need the exact value in debugging
some of the usercopy tests, which do horrific things like rely on
pointer wraparound, so have non-error 0xffffffxx pointers around.)

I'd personally go for, e.g, "ptr1 == fffffffffffffff4 (-ENOMEM)".

Thanks,
-- David




>  lib/kunit/assert.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 6e4333d0c6a0..8da89043b734 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -155,12 +155,28 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
> -                         binary_assert->text->left_text,
> -                         binary_assert->left_value);
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
> -                         binary_assert->text->right_text,
> -                         binary_assert->right_value);
> +       if (!binary_assert->left_value)
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
> +                                 binary_assert->text->left_text);
> +       else if (IS_ERR(binary_assert->left_value))
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
> +                                 binary_assert->text->left_text,
> +                                 binary_assert->left_value);
> +       else
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
> +                                 binary_assert->text->left_text,
> +                                 binary_assert->left_value);
> +       if (!binary_assert->right_value)
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
> +                                 binary_assert->text->right_text);
> +       else if (IS_ERR(binary_assert->right_value))
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
> +                                 binary_assert->text->right_text,
> +                                 binary_assert->right_value);
> +       else
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
> +                                 binary_assert->text->right_text,
> +                                 binary_assert->right_value);
>         kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
> --
> 2.43.0
>

--000000000000cb4b3d06203fe307
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg5lTn+6JQlxyYDWYwziNUVEt0aqIa
8D5OFVyAZHGgZY8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
ODIyMDYzNzE3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBADnNTiJoweibptsjXfOeS6H2cWKGN19YsIaMxLN2wbCzCRWA
Ycjxhfi5NXi3FEP35Xx2IdP+NHcogzOPFyi5LbTUuR+GEY6v0ubjVYmQ1qw9I2lIykwKWwmMTHe0
FH/BhCqAH8SnKpZ1HGMwviNebl39Qhz6Ip4/jU93cbmEn3OVRaeE3k1MfwiAYvWagnNupCBVVa7T
fABhBD/qaSLZsFlFzkNLoWq+Wsae/rqvZxetZalQQTU3NZRjqUK0ensKAIZl+HduoeM+mbFSraSY
sivIClF4QWe3wVh2V2UIvBDtkijv/mDZrtKY39IjTXyezvNDZLJ4tzpHktxIHJy1ZbQ=
--000000000000cb4b3d06203fe307--

