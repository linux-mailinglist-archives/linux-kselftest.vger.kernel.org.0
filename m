Return-Path: <linux-kselftest+bounces-21721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E89C2B67
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 10:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C31D2818EE
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369C1474A2;
	Sat,  9 Nov 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbLhh453"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423848C07
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144799; cv=none; b=TdTMKSEIrNkKmYyKQI5qP31N5KJOE8RMgd3/qLfzOkKxkUHXC46vOkDcU+TMzvSmgQZjOVOlz216As7AWtohHwcRCpoPxWYlHeVxvZN2k+uCuhxP8BrNyDVqy1ZEotNBMkT37z8z2VInwwn1f26D+a4Y/TpOFpYaJnT+d2hZ2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144799; c=relaxed/simple;
	bh=pQAlvGYTTZCKoXSbwgqqnoNtgjWCIFq02J24+jC/G7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDoPeDIy2wWBn9Kw+QtsG19vzR2aDMen+jfVHcqg9+729122NIqmLpwxRV/1VBmmIdErDc/FPc3wVyrtZvW6ofjk4WtYTSaAq/XELoDy1ioxfpwk1NNaW1FpEfZ8bd3bghtZeGeOcl/e3Q8L3L93SUr84F0iDd2KNHnrxVmhn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbLhh453; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b148919e82so171662985a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2024 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731144795; x=1731749595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KsHdsvAOw2mzOKSwr6BdqRHgvojg6vOQuP489fyU/w=;
        b=SbLhh453ftDPm8Gbo9BL1xl3kHdD6I+GPlJ37y1AhlDlt0KmvIfBZ+GJRPeQ5vZbPW
         1wfZ3BwiegAPZSX6kH1qmQorbM2fjZHtOqqlgWlQydUVdgrYnYMEyRScRAeTxp034niz
         SCU8/j8NrhL1tF4UJZVQTA1h4Tnqh0G/pRphKfbE8jiIFCWY13E2IEv+NJ4gAAssA56G
         d87VI4GNAzcAIO1xqxRtmj42iXWUYUOy9vBJJWj9wLmWCrQjijKBQ4cHHb+/BayM4lZ1
         GQ4O5Vihnti1zsIDCtWmBn0mN2iapux+VTupDn+dbB+sFKe2KibqVDEOfiBn8pI171os
         0OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144795; x=1731749595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KsHdsvAOw2mzOKSwr6BdqRHgvojg6vOQuP489fyU/w=;
        b=CPfoGDiWdgYv67zb1S74Nin+t1854dO5O3iBp7rsXHSGafhLbKz9VimRsFunMrXiaE
         WyPufoVqgca+s7lPVt4XBx5Y6trjqpvZDB2IUp63S6dX4n5saO10xK6XYFx0m6wcUfuH
         911Zaa+hBfKMuiu10mEgk8GFmi+xK25sYAkSbjFw+ogr59CHMXiypZEWbsInHCzJmPeb
         Htk93aocD0mYgOQ4+yvA/zeuP7RfDCM2maE26isa8ZymFHDDKGXSZGRCWqDaSb3NnFGD
         kdB5RnngxZ982vt18HkRo20UmEAwTQowJoA2hhUR9AjtSf5guOpTZACn3K6RyCe+B+To
         gNsA==
X-Forwarded-Encrypted: i=1; AJvYcCWVY50DLK4MaHGApjhsF4SfKOpJrH3+LF57UKBM7H/4uuIzNxhRIVtx2bAeCQju+dwulDgq46Fbb4x6zUgIMW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kHwgvYqsDjmZW+PrJdWCYIt6dme/t7O7qXwGR0YhoHCRcjws
	JcmLyKd3QFENinrrQpBTJVH6T2VtvK3o3fsrB+/y2sKgXlqJy1cR6M+sRX43duEelO3xKI5RwPa
	O/BywQBQHpQiBIthGLq6GXYL4K8cjYV7/TR3W
X-Google-Smtp-Source: AGHT+IHUcEsDlJBv3itPrfi9+R0AfrPnmXgv8CaQq14fMVDkx/hJpZQMVDeCIrfueKHlWC4tuAk19egp9RRdAbImbVs=
X-Received: by 2002:a05:620a:c41:b0:7b1:4276:ea4e with SMTP id
 af79cd13be357-7b331db7d5amr802597385a.13.1731144795086; Sat, 09 Nov 2024
 01:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094303.1531810-1-ruanjinjie@huawei.com>
In-Reply-To: <20241024094303.1531810-1-ruanjinjie@huawei.com>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Nov 2024 17:33:01 +0800
Message-ID: <CABVgOSkBnO2pfo_wWyUiek-XVEEahB9druaTv3BeqK-WiDjMZA@mail.gmail.com>
Subject: Re: [PATCH] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, skhan@linuxfoundation.org, 
	rf@opensource.cirrus.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000098aa360626778e99"

--00000000000098aa360626778e99
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 17:43, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
> kunit_suite_for_each_test_case() loop, the "suite->log = stream"
> has assigned before, and the error path only free the suite->log's stream
> memory but not set it to NULL in string_stream_destroy(), so the later
> string_stream_clear() of suite->log in kunit_init_suite() will cause
> below UAF bug.
>
> Set stream pointer to NULL after free in string_stream_destroy()
> to fix it.
>
>         Unable to handle kernel paging request at virtual address 006440150000030d
>         Mem abort info:
>           ESR = 0x0000000096000004
>           EC = 0x25: DABT (current EL), IL = 32 bits
>           SET = 0, FnV = 0
>           EA = 0, S1PTW = 0
>           FSC = 0x04: level 0 translation fault
>         Data abort info:
>           ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>           CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>           GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>         [006440150000030d] address between user and kernel address ranges
>         Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>         Dumping ftrace buffer:
>            (ftrace buffer empty)
>         Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
>         CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
>         Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
>         Hardware name: linux,dummy-virt (DT)
>         pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>         pc : string_stream_clear+0x54/0x1ac
>         lr : string_stream_clear+0x1a8/0x1ac
>         sp : ffffffc080b47410
>         x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
>         x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
>         x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
>         x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
>         x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
>         x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
>         x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
>         x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
>         x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
>         x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
>         Call trace:
>          string_stream_clear+0x54/0x1ac
>          __kunit_test_suites_init+0x108/0x1d8
>          kunit_exec_run_tests+0xb8/0x100
>          kunit_module_notify+0x400/0x55c
>          notifier_call_chain+0xfc/0x3b4
>          blocking_notifier_call_chain+0x68/0x9c
>          do_init_module+0x24c/0x5c8
>          load_module+0x4acc/0x4e90
>          init_module_from_file+0xd4/0x128
>          idempotent_init_module+0x2d4/0x57c
>          __arm64_sys_finit_module+0xac/0x100
>          invoke_syscall+0x6c/0x258
>          el0_svc_common.constprop.0+0x160/0x22c
>          do_el0_svc+0x44/0x5c
>          el0_svc+0x48/0xb8
>          el0t_64_sync_handler+0x13c/0x158
>          el0t_64_sync+0x190/0x194
>         Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
>         ---[ end trace 0000000000000000 ]---
>         Kernel panic - not syncing: Oops: Fatal exception
>
> Cc: stable@vger.kernel.org
> Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

Nice catch, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 54f4fdcbfac8..00ad518b730b 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -178,6 +178,7 @@ void string_stream_destroy(struct string_stream *stream)
>
>         string_stream_clear(stream);
>         kfree(stream);
> +       stream = NULL;
>  }
>
>  static void resource_free_string_stream(void *p)
> --
> 2.34.1
>

--00000000000098aa360626778e99
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgdtonxaq+kJCquO3ma3zEta119NtP
7fiBwqC57cds1cwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTA5MDkzMzE1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJmJBqgl32sCucDkkhFuUI7N/EtiKIUhShN4IfkNemYESyTp
OJpkpH+06q5zswGxk+k/G0VCe5JJRewDdUhdUQXj+IrLLnVjWZVmDKtw3kCmqmLidIVSi8MpNMyI
Jisx3VzmYvY7GfPyWLzhWZ/pFIGakvDXa+6B48oWXHuPMaJTIBDI0GccZ8GE7hJlK6W7uM7BQP3/
HGsPIywNr4+22ilO7pHY2lOFXasChwV16Azzwg3DIe1n8EqLyjnrgDZSE3ffq1i2ud0ZZtoHlbii
vWCaRp3XF5QhlWk8R1ER9oeR9Tug/jV+AHv0u1wvCUe0OsmiquKzSKbhj/WP2EOAH9k=
--00000000000098aa360626778e99--

