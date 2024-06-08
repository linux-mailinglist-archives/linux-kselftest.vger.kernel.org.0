Return-Path: <linux-kselftest+bounces-11490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E190111C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AB01C2172D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29166176FC9;
	Sat,  8 Jun 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2sxenVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC0176FC6
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838448; cv=none; b=MaRhHK2pFIOiLSCP6U1HBpmcjErHsmuyLAHH95/owLTKDWwmjaB71kB4k07ahhWUkyqgeHgCZYcMDmkb9p8SgaucDA3LjwDlVj7nTSJDNtDA8/rnTFaoQmv8Yu5hEBDqrkqwB9YSeAOfL63of8qW3iL/1Kru5L4wOR5gllTB+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838448; c=relaxed/simple;
	bh=XHTiiMU8Dn9RHfxbnfw+gr2xxqddY57jd51BbhxDSxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcMzlmYGDUQF6zFOqhxIzUrB0SDT5CPGGkMvkzZmXzUYpi5aHmD9dbVxF1AmQGxXDOtVue37ZRSElEI6alxeqWG3vdnosBX8QHYgIHrCT4UL1d2MH7gjAqqFdJnOpE7pO2XwxQi00ZXMb2+11ENyiWgA9QQvXTspzwf4kBwlmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2sxenVH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4400cc0dad1so215941cf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jun 2024 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838445; x=1718443245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmJXfvJYKc09AI9QzY5AQiGxwM+K+KqbhH893O3NisU=;
        b=z2sxenVH4ED8JSxSXt0SvriT5Mxbxhf19M0SW8kdppB2gplvjkgNbFYG2mdyeGBee3
         gkN8WJNqhfRVrTiwzQs5wL0vKEGO182tESxGrS4SRzbjL3XzQC59NkgTTfhtE+wNsmlX
         52ZAN6t40L6uBsnWRjFWUUZBzzxkUeqtKm6NrO0RwaSbkp+i4A6xC1/2xYP+oTFFQ6yP
         Bsgtmc5wccFL4rJNSKEhNswQMpapNpjosE7r+eKYQILQ/qeszEhjvIOIgAZDeEwhpG1a
         rzMJSPXpedxnn5fqqvaiiHQTmrqncMzledx+EhTN7hVmWEFcJC8iIF5+wJRixYn93gTe
         z+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838445; x=1718443245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmJXfvJYKc09AI9QzY5AQiGxwM+K+KqbhH893O3NisU=;
        b=K48FYNOo6xfyQY9ClKlXMqvm5i/auGw+NjQ+KFZ/Rg5k7l+LVZcX8oe4LuugmmMZ+J
         AGzffSuf5Vw1s1camwvjtXevzHBnvwY+HrvyqqSttHOOc4mrosRQsXvGhL4aEYnu4cSo
         jMxryJyYOhYvG59twCHvlhzF7RVnvmFT+ino9Idyg721ouTx5SJaN+3fsTp6aXHOVtw2
         4/RCGWwzGJTgmrDI3+MHn+l0p94zVRsUKqabUTkaiKK2LEVqNSWENzYgnWB/liaDleck
         rttlCmyi3egLKbyCHcd3LvUF1n1BoLrgytCycL60FF28BK1YeStvX7ZoenScFtv11ddc
         XNNw==
X-Forwarded-Encrypted: i=1; AJvYcCVsZz8OXHyef+eykQ3mc0YT4SybImauqkx4ctqV+mNmGaRI1w8m1kzN6ngCbhyBIZBPyt/cXBjgWSYdFgtKN6nydn1qMJxwr1FI1IrGK2Dq
X-Gm-Message-State: AOJu0YwMHaFvNZxYukW+sGs57AS1hOiocQ4KxnWmv+veTli1Jojxs/oP
	l+LCo/hbonU5PAGZ4sj6cqVUc28PqNLsqUyv46EY7pksgPNYFZLoWK7rZOVAYYANXxhOXKg8thw
	BxAWAfWAkLopReuybKjLcpTqLGe1VOZI1Zyml
X-Google-Smtp-Source: AGHT+IGrgwjRbQqe6L3dL9eB0TpHrKbIRHkqP2DO/QNgWX+bB3tzzJGyRY0yPu74Wzabgooqd58vk4NtzhxS4uVcQW8=
X-Received: by 2002:a05:622a:228c:b0:43f:f92a:bdb with SMTP id
 d75a77b69052e-440578d42c7mr1079781cf.13.1717838445384; Sat, 08 Jun 2024
 02:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-5-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-5-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:34 +0800
Message-ID: <CABVgOS=8S4QqAdNHs7hLXfD7HGq+eQNUqVbLkTu94-BUDTxOWA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: assert: export non-static functions
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000058982f061a5d6e52"

--00000000000058982f061a5d6e52
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Export non-static functions from the assert.c file into the KUnit
> namespace in order to be able to access them from the tests if
> they are compiled as modules.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

I think this could be merged with patch 5, as it's not useful on its
own. Also, a few of the symbol names might be a little too generic to
be exported: maybe we should give them a 'kunit_assert' prefix?

Cheers,
-- David

>  lib/kunit/assert.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 867aa5c4bccf..f394e4b8482f 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *message,
>         if (message->fmt)
>                 string_stream_add(stream, "\n%pV", message);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               const struct va_format *message,
> @@ -112,6 +113,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(is_literal);

I'm a bit worried about having such a generic name exported, even
conditionally and to a namespace. Maybe we could give this a
'kunit_assert' prefix, or put it in a separate, more specific
namespace?

>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
> @@ -180,6 +182,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
>
>         return strncmp(text + 1, value, len - 2) == 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(is_str_literal);

I'm a bit worried about having such a generic name exported, even
conditionally and to a namespace. Maybe we could give this a
'kunit_assert' prefix, or put it in a separate, more specific
namespace?




>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
> @@ -232,6 +235,7 @@ void kunit_assert_hexdump(struct string_stream *stream,
>                         string_stream_add(stream, " %02x ", buf1[i]);
>         }
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>
>  void kunit_mem_assert_format(const struct kunit_assert *assert,
>                              const struct va_format *message,
> --
> 2.34.1
>

--00000000000058982f061a5d6e52
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIFZW3ZZqfOiqQvETl56Re8uP/Jgaqm3H2kZr3NxMcJlOMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjA0NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAg+ui9
EtrYptJ2hbQwJG8ktKZv+tIRQKgiOSZrl38Gk7kHjAEUptBjL2/+rmFUMwqoulolcX6hs4dyZOsJ
RBOxUd5qvqeEo8tDX1HLAj3Y8cm0O3/SSeEC+UEQQqYDM9svvaQejEfhh2f8wZKcjzPA8Ec4iqeC
gozYtfzAllvKZ+5pG+7GPPuSJJGgY7OSoJedvHT2sKaYxbwjOPLdrxC1qBx1lqYO8HnicqB5hRDF
2jydK7SUMRF5BhdwzuTzC52v+/5eYFkCiRMN+07AEfDzZdfbGr08hYqOfcKeE/+nNiMTjLRO0QII
9h4z92VZTViLCDWU2df7Du/Yyey2bP8Q
--00000000000058982f061a5d6e52--

