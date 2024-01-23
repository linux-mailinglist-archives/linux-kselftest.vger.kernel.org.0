Return-Path: <linux-kselftest+bounces-3395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EB83886E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 09:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C738B1C232CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723125674D;
	Tue, 23 Jan 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM+5RFUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2355E6E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996928; cv=none; b=g9RQx2hD97EH2BCf5u/ghDFkEkG1eh6YIdkpMsEwMXEAFY+LSGVc5C0qbJxFeeeUvA7Rqk7MA+mYjoCMnewmvwNd3Eox4Cb/g0wY3i/Vv55y/vKR+Huy3Vo12/L8mSEnMYXBUqlocrL0Qrgkw3FjyVdYHMgsUhy7ot22IikpDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996928; c=relaxed/simple;
	bh=FxUEr/1RGCm1+WC7FpsD/bGnraRNSkF8YH6yB8eCFXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjGxuD2wvTAe6zm9hn2Dyj7kWLjjuCa4Z25Am8+L+mka4zOc8xXz/GkA/pcwAOF2aLgR/dmL+3himfGD0hodjB62buOJQ7QWZ82+pAiPxeBfhS8X/AA/zFEjGN2sXZcFxJtfdoPv4bckirmO4IVB7nCSAQn70xppeexE3aP2E8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM+5RFUa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a62fad701so5895a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 00:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705996923; x=1706601723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q46GqOJkwminVQqHrMDPSpOLHHYfm1+xjDtBHx114aY=;
        b=rM+5RFUaGp7D7O2A0gjG/kO10BUiA6o/KPar56Hhsz+Z5RFBBvgaF2bgQoVIPTCttu
         rnnvvt2gPavrh49BRsyeUKFujr22lJN4QgXZFRyfDccKnX1eukrUchkD0CwLat0PtKQQ
         5zhxZaqL4q/puw6jV3ZuQ4DFNCuH/yQnCVYs/mnYmD3bwCSh5cl8FUq8CddBvJf8bhCJ
         ESJuKKSbLzJY5NB0Glk/m7fJBtO8/h1F6rZuOehoPT1DnjtXDh439xsnLcxD7cJW2J8n
         FVmCpGA1x5yoDkyCR6gwPoe3+zLdm5q4hwZ6lA50CHHqa/7EKmuJU0MDfmUqf1fgTGpb
         MZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705996923; x=1706601723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q46GqOJkwminVQqHrMDPSpOLHHYfm1+xjDtBHx114aY=;
        b=j6bztGDSvEwCuGtyyDMe9A5BXMNV6Pi31YTlLhK8ujRQXt6Nuugo5X6UY4Utiikr5E
         lOHo3cFPK6IexBKG9z5TNf9BYi0Qlmn/V2AsKjsquzi73UyLTDId+5vNXlzxUu0xC7lp
         0iSewh7/RvZg5V51/iJgYxaYstbjW26WO6LoTSRDzRdI6XM69F0/UK/4EKrO3Jeet4+/
         ppYbkgZeE0XU+tQgN09DsLu/IAO3op7gtpl5ygbsenkEq4ZGUGUAfw1+789W1hZVhfPp
         30MfUxGVi1l0FwScq37SlIMfsMJg4IBrwX/pHzakm22Nhb6T8fV1jTdmN12v+2wbvLH5
         vQSw==
X-Gm-Message-State: AOJu0Yyazi4ASnHMYpA4N63K1MQKOSZctTYU/Yew7w/ivuuC50WNhhUJ
	QzgudtyycHGzRJINdhychOaDcwUBPB3tVqDf7azjZgbHhabiXmyWVUpAXIRMS0U9ZHu9owCkiBp
	loNRQNx/KqgG7Ru91vQ0MCG/0bK9ghjQcGb0s
X-Google-Smtp-Source: AGHT+IHw+fcWf7cNiJ+13QPQH9ZjygRjYR9ob548YlDM75BXxArIprInyXSl1NW0smBFdBmu7LEbRQZd31KHJfPsTQ8=
X-Received: by 2002:a05:6402:1ca6:b0:55a:e42c:f5cd with SMTP id
 cz6-20020a0564021ca600b0055ae42cf5cdmr104627edb.3.1705996923416; Tue, 23 Jan
 2024 00:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122171408.3328510-1-lucas.demarchi@intel.com>
In-Reply-To: <20240122171408.3328510-1-lucas.demarchi@intel.com>
From: David Gow <davidgow@google.com>
Date: Tue, 23 Jan 2024 16:01:49 +0800
Message-ID: <CABVgOSmjyCf5DSh+LJtaLubHN3F_mrFo=ZRk23u2PEmmkLBUjA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Mark filter* params as rw
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, 
	"Krzysztofik, Janusz" <janusz.krzysztofik@intel.com>, Rae Moar <rmoar@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a25921060f985c97"

--000000000000a25921060f985c97
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 01:14, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> By allowing the filter_glob parameter to be written to, it's possible to
> tweak the testsuites that will be executed on new module loads. This
> makes it easier to run specific tests without having to reload kunit and
> provides a way to filter tests on real HW even if kunit is builtin.
> Example for xe driver:
>
> 1) Run just 1 test
>         # echo -n xe_bo > /sys/module/kunit/parameters/filter_glob
>         # modprobe -r xe_live_test
>         # modprobe xe_live_test
>         # ls /sys/kernel/debug/kunit/
>         xe_bo
>
> 2) Run all tests
>         # echo \* > /sys/module/kunit/parameters/filter_glob
>         # modprobe -r xe_live_test
>         # modprobe xe_live_test
>         # ls /sys/kernel/debug/kunit/
>         xe_bo  xe_dma_buf  xe_migrate  xe_mocs
>
> For completeness and to cover other use cases, also change filter and
> filter_action to rw.
>
> Link: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcbne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---

This looks good to me, and works here.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>
> Rae, I kept your r-b from v1 since the additions are just what we talked
> about.
>
> v2: also change filter_action and filter to rw, testing with the xe
>     module to see if filter=module=none filter_action=skip produces
>     the result expected by igt
>
>  lib/kunit/executor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 1236b3cd2fbb..371ddcee7fb5 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -31,13 +31,13 @@ static char *filter_glob_param;
>  static char *filter_param;
>  static char *filter_action_param;
>
> -module_param_named(filter_glob, filter_glob_param, charp, 0400);
> +module_param_named(filter_glob, filter_glob_param, charp, 0600);
>  MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> -module_param_named(filter, filter_param, charp, 0400);
> +module_param_named(filter, filter_param, charp, 0600);
>  MODULE_PARM_DESC(filter,
>                 "Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
> -module_param_named(filter_action, filter_action_param, charp, 0400);
> +module_param_named(filter_action, filter_action_param, charp, 0600);
>  MODULE_PARM_DESC(filter_action,
>                 "Changes behavior of filtered tests using attributes, valid values are:\n"
>                 "<none>: do not run filtered tests as normal\n"
> --
> 2.40.1
>

--000000000000a25921060f985c97
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIMfQcCEL9e2gmY7qF3gejMzl7bNZf08vMviHlTomVfmVMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEyMzA4MDIwM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBCZc+G
ZDLNPLNo9+QuP3a4EFEknDYCeohu/zAlHDdGa4mCL0ExsQxR5iWW71PDBw2jACWrtdwTqJwOFexl
yxFCxyERvhkhTH0ID/4i2txxbAAd2fS22KmlheuMxHjJ00586m64rhdKI87fbkcXYcu+bqKZbIi/
9aNpuPOaAy5QlSGdWw7Xs1yD/YI4IQGpGmWMFamVVKhtgj5J9ejghoGpzMaphlRbTb9WFB741pEE
YT5vctto4mOG/MjqiDb+LPp9l+H1l+bLcgKAFouSB6jehb4tjCq02iv/JBjzL3bpHqucB7iRzh/T
OLJHehLrr6hjdasrc9nkEHUoUTu/paxE
--000000000000a25921060f985c97--

