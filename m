Return-Path: <linux-kselftest+bounces-13542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEF92DFAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD001C2230E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097E7B3FD;
	Thu, 11 Jul 2024 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdriyVgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A182904
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676372; cv=none; b=A8okEFEcdTxZNK7h7es5nN0SfocmhrD6m+vJMMKwzf1eh4WO2YkldVtlNglEaYcd41GvLw3GdxNCLCc2/exkG+8DAh8xqBQz3ZIhK9BmZfAyAMOyeL/zNMuxlfqGCllBVaxyjUCQCPWlkUk2VNSsPhgOIsZuWnHq1nrVKS4yGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676372; c=relaxed/simple;
	bh=ZxRkJnrU8mYunFHOlgiL/yPREMffifizs5wfeJ1NRFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBTa1Vtp4rMrHYdIP4/G1Hdw7aEy9jqaC5KIFNL279WcqGBCdZU1X5m7KlLvj2TqZTIrx8KRzOjeOCbi3Bht4uNhUEf0ZyMgYGBb9HgDbDRJ+aIc6oX6IBJiuRwmbgSbuQXjMB+BjHTqB/06CGSNlDHI8Y8MnxOdJ2bd6iyPT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdriyVgz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447f8aa87bfso242711cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720676368; x=1721281168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XcSpbBi81sX79b5+XvmdITVwkSHpMz1JltQMsYWDV8o=;
        b=JdriyVgzTEhzewd35gv+/a+mS6r0aqnWyNKMT/OWcLyYaaY9stO6DUAN+Yk2gcuc+o
         C68Y9byWw7fI0NlU1W/hTz9XKIdQc+Fqc1qyMLvXNRhRl6ouTj4LG48m12F7kUs1yii3
         Q59ZFoaeF5JTprcNp+EOB9YsPInjPaFLX/FsO6idjtuODKkGGCMgzUXHe5AuD6ja1HM8
         wtY5mpdJ3FS2+wdjnvSkfCFToY8vcse3Fwk/BZDiDLCdU23r0tFK0L/YVG8Fv9E3MiPM
         OaOrEvnXc1ENNpBBqxfA3nE/q6mzlYuPF/e0gkP6RVRxOaVfLXJ524PIFXlmRfPz+5rd
         Kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676368; x=1721281168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcSpbBi81sX79b5+XvmdITVwkSHpMz1JltQMsYWDV8o=;
        b=p2k7oWHXee36RaLxrTYzGhri70xtws8jmdcji9THt8oy1fEpVjn7b9YrI5a638ppPa
         QA5mZNN/3JZa761Yn2z+RphZmYgRsxXchQSm4xCsBeMr1jcFGSqtMMJNEBbM0hfb/ZLC
         6m1JHzO69jewNRJEUF328ogdOGWcy8N9cYO802jIleR0NvLALgkgYPzC743353NZwM8A
         1oJaf6sEtWFIUHwPLUvmSsfulDvcyQhL8XM3w5tBiK/uNqQNknPTkYhu4j3/NlgyKYvk
         ZA12wkIxtS4jd6TKAeRYMpC6NNoUs454SHBlMGI3o8D8yfYHOo706yZahzLumJLBxWdJ
         Sx/A==
X-Forwarded-Encrypted: i=1; AJvYcCXga+AiFpe5T/UjZ8651X/+zdnM1a2f2BE6dA/gaKH+5ICp3AGysvv4eFtAl7GXOi1sehzxecPOy6vSJo3LDr3NvJY9l0q5xzLUrGMTVZNa
X-Gm-Message-State: AOJu0Yx/k/VU4TsGDiJxOHcd61em0jnoWR/uLScw7lm19Vpaox7TfjpA
	ftmMkPCgwr8icC9t+purfYKLTHBGW6cVMputcVy4MyQXP0QF03+B5NCE5JIrkFkZcv5+qoityV0
	r9PNW3jRNdNtx5ZeAJoifu9AOkAAc5Nh1wsQh
X-Google-Smtp-Source: AGHT+IG7XvmJKaX301oK5fK/lXy0XU1Sj/+mXbchvIMmc7V7LKM0rkFeVvHuFFfVAFLVkchOyB/nXFmkwAvNyV7Kv/U=
X-Received: by 2002:ac8:4cc4:0:b0:446:405f:81f5 with SMTP id
 d75a77b69052e-44d341f1e21mr1359101cf.5.1720676368059; Wed, 10 Jul 2024
 22:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000220.work.852-kees@kernel.org>
In-Reply-To: <20240710000220.work.852-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Jul 2024 13:39:15 +0800
Message-ID: <CABVgOSnXgA20O9bHTUP8uwcMH3Wggb2Agjpc3MK9qQa0+oH_Bg@mail.gmail.com>
Subject: Re: [PATCH] kunit: executor: Simplify string allocation handling
To: Kees Cook <kees@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7f9b7061cf22f7f"

--000000000000b7f9b7061cf22f7f
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 08:02, Kees Cook <kees@kernel.org> wrote:
>
> The alloc/copy code pattern is better consolidated to single kstrdup (and
> kstrndup) calls instead. This gets rid of deprecated[1] strncpy() uses as
> well. Replace one other strncpy() use with the more idiomatic strscpy().
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> ---

Looks good apart from the strscpy() change, which is broken by the
(char *) cast. Using the 3-argument version worked here.

With the strscpy() fixed, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/executor.c      | 12 +++---------
>  lib/kunit/executor_test.c |  2 +-
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 70b9a43cd257..34b7b6833df3 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -70,32 +70,26 @@ struct kunit_glob_filter {
>  static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
> -       const int len = strlen(filter_glob);
>         const char *period = strchr(filter_glob, '.');
>
>         if (!period) {
> -               parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
> +               parsed->suite_glob = kstrdup(filter_glob, GFP_KERNEL);
>                 if (!parsed->suite_glob)
>                         return -ENOMEM;
> -
>                 parsed->test_glob = NULL;
> -               strcpy(parsed->suite_glob, filter_glob);
>                 return 0;
>         }
>
> -       parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
> +       parsed->suite_glob = kstrndup(filter_glob, period - filter_glob, GFP_KERNEL);
>         if (!parsed->suite_glob)
>                 return -ENOMEM;
>
> -       parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
> +       parsed->test_glob = kstrdup(period + 1, GFP_KERNEL);
>         if (!parsed->test_glob) {
>                 kfree(parsed->suite_glob);
>                 return -ENOMEM;
>         }
>
> -       strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
> -       strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
> -
>         return 0;
>  }
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 3f7f967e3688..7191be9c4f9b 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -286,7 +286,7 @@ static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>
>         /* We normally never expect to allocate suites, hence the non-const cast. */
>         suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> -       strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
> +       strscpy((char *)suite->name, suite_name);

This is broken: we still need to pass the length of suite->name. The
(char *) cast, which is necessary to remove the 'cosnt' qualifier,
stops the strscpy() macro from treating suite->name as an array.

>         suite->test_cases = test_cases;
>
>         return suite;
> --
> 2.34.1
>
>

--000000000000b7f9b7061cf22f7f
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
hvcNAQkEMSIEIJakMhyahna+BOAKQ3F6UlCll3x860YjryN4eeZa68IMMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMTA1MzkyOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQABJnIp
pWhV4aNSyvaRayHpZmHIB0rbVG1qYW6YNyad5eaodjWDK99qaqIDxVdZXujFlYfMncHqknVxgZ3D
wXOCBxoRiVV6gq5BnqNDB4Y4ePaxZL1d8x8R2OxmyvxtRKt/9J4XO7ugEBisbuHXNt4SyZgQYT1d
GRhd8KdUXmVN68t/soUrfEmS3Wopg8X9ws/LyZDasTfXluwnRYpGZn3zeeOUiSmOs1We6568Bh5r
CKZQdIc2D/GbSy8wZwpzM5nCpENoQsJOZq7YrAdy88NkLGUFtVHCOFmi5j/K56aRCI7aYLginnkv
r1M8hLjungm8d7kJCSm0pE87shsVUa01
--000000000000b7f9b7061cf22f7f--

