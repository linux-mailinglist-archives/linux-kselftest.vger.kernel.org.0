Return-Path: <linux-kselftest+bounces-18952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33B98E9D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF62281993
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238584A50;
	Thu,  3 Oct 2024 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdYL7i3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FB83CD2
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938330; cv=none; b=FNo55w1LbDqaifnHKct6j99heL3ABd2rFtva3RRBa+cqNWjb6GoA/S+m46gdg2UUPOywkCqchRl5ZDYMHK3iEJVuPxxrZPDseFI59T24/0jHq9USing6RqRn0ElLzHoub7Nfzt0sHLn1SLQA5f65T8+j0Eto+i0EaNCUOFZi1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938330; c=relaxed/simple;
	bh=ZkCIN7PFUBkdFJLDl4r4m4gnPqI6aWM9zPaR1UDVDLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp+YCrhZ4Crd2T+pkFbn9eGHxLYQ8Gc1esb8Nt9TR8vnIMvP53S02VETosG97JPU3ZWkUIZTWFQ8DVbxyRfCaJazr0Ih3GyvnO9eEa/+J3rldYYQwB84wVvN0XgNTReC1808VhfTCBi+I5fXldu7D6VuHh/cZJ2k40w2FvEGMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdYL7i3w; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cb37b34a87so4572076d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938327; x=1728543127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txr3hXa5OXXWMyejT/XDzT1KzVrohpG6QoPrichld1Y=;
        b=cdYL7i3wwC5mOpRXzy0R1BH7OvddpqGlkzq1SA/YkGH+iCdBpac4R1h4v9/jBjHN8E
         Lsoa7WYyYXkzX/+ImuyHNQGNUToU1cMac+EJhPf85or8GUSflxT1Ra6EOK5h+Lhq0N3Z
         2X1vdxYHiN8ClLi/VcsDpLdWqISJR7o15hVwXHbOupavoQZRXXld8YaTUh+VxF20AmxJ
         Oc1lYp6GFcBhjMjOnfrydrDwSRKDoPPS09Qxr2t+yxw161aJkzdIDZ9upsK4XrtjACh3
         2LJzHdgou6v3DLWPYutijBXFlwfQ+F5v5Tfp7/j5SUvg/VaEXute3zZZMcSy+fca+pyd
         FZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938327; x=1728543127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txr3hXa5OXXWMyejT/XDzT1KzVrohpG6QoPrichld1Y=;
        b=j6JMZ5OJwXwhcOhaTSKAnJgrCUBFkGcB5MMzfcZ1Orp6ONPar4JFjBEQl9lNwpVdBL
         z+/aHqYAs6r7YzkVYJSH6rxP/uwlwfGUm9ml1DSzmwVXifTftHraMMGWI/hNjOOcjHbd
         CZm+3b+KNLYdK4sD+UXkaxaTvM6dWOdaaUH+Bafud73UdkCMd/hAZ5wz8cBEp2lenQQg
         B+p0BNkxzhwGLikKR7HDfBJv/u5CbDyMBmaAy3+ZK/Xgb/sL9NsbkQrl5Xsg+k7E6H21
         boSGYeZjc8zZRZS+ok9UKiF0hXcBCrA3djQe0l1yUiLtWU7UB2wjPUz05lK/Y8cNkdIM
         w23A==
X-Forwarded-Encrypted: i=1; AJvYcCXbQeDLh13f+j7RLmsaDYI7QfSwBCztnX0+4oJb6pX+OS84OVqp2RVXvockNRCYzrKOlmVi3EUnDbw8NT4CL1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7yYlDQR8s2JJFgG67gAKYi3FcTHQXzEf5rTYcPx5IgayuZBj
	9NU9O/0ozqLyQ8SeAKySCSv4hmzqH4Y3GkRQ9qfdTdVRfHRg0jQC9P7Q2SpMdWAlUkAAULIjcXl
	hjg/IZLygHJnzwP57PeGImmB6O1+MbnP6vMeT
X-Google-Smtp-Source: AGHT+IH8Dw9neEJ7yDMdU5jY9GrBpdOG3e7mQ5tQGwaFgsFCt5Imzv3sSEJg57yGMBuBKuVSHZjKP9eEVpD2VZ1GgO0=
X-Received: by 2002:a05:6214:2f87:b0:6c5:997a:3f63 with SMTP id
 6a1803df08f44-6cb81b99014mr65889066d6.46.1727938327149; Wed, 02 Oct 2024
 23:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922150507.553814-1-linux@roeck-us.net> <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
 <6b46f75a-cfef-4426-bab7-68959d044978@linuxfoundation.org>
In-Reply-To: <6b46f75a-cfef-4426-bab7-68959d044978@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:51:56 +0800
Message-ID: <CABVgOSkoHLysgbeCr=7LfL+vhFdZFNNdUj0=nAr1cQMh9jQ8HQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "list: test: fix tests for list_cut_position()"
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	akpm@linux-foundation.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	richard120310@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037e88a06238cfe69"

--00000000000037e88a06238cfe69
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 04:39, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/30/24 17:18, Jacob Keller wrote:
> >
> >
> > On 9/22/2024 8:05 AM, Guenter Roeck wrote:
> >> This reverts commit e620799c414a035dea1208bcb51c869744931dbb.
> >>
> >> The commit introduces unit test failures.
> >>
> >>       Expected cur == &entries[i], but
> >>           cur == 0000037fffadfd80
> >>           &entries[i] == 0000037fffadfd60
> >>       # list_test_list_cut_position: pass:0 fail:1 skip:0 total:1
> >>       not ok 21 list_test_list_cut_position
> >>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
> >>       Expected cur == &entries[i], but
> >>           cur == 0000037fffa9fd70
> >>           &entries[i] == 0000037fffa9fd60
> >>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
> >>       Expected cur == &entries[i], but
> >>           cur == 0000037fffa9fd80
> >>           &entries[i] == 0000037fffa9fd70
> >>
> >> Revert it.
> >>
> >> Fixes: e620799c414a ("list: test: fix tests for list_cut_position()")
> >> Cc: I Hsin Cheng <richard120310@gmail.com>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >
> > I ran into this as well.
> >
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> >
>
> Please take a look and let me know if you are okay with this patch.

This (and the original patch which was reverted) were both picked up
via another tree and have already been applied to torvalds/master.

A re-work of the original patch is in
https://lore.kernel.org/linux-kselftest/20240930170633.42475-1-richard120310@gmail.com/
-- it looks fine to me (modulo the description being a bit confusing)
and should be applied as a new patch, ignoring this and the previous
version.

-- David

--00000000000037e88a06238cfe69
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgt8gSVIJMD+L5e7tjGyE8ZnoTG8vT
SEgwGMv5deZ3SkAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDAzMDY1MjA3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAMhnL72jVukmuNR1fO4N0j6gTI6A21YB+dRxXl3MS1Rvf8ZN
wSm+9DcsLx3cEY3Iclu2vMY0XNqe+Bhl/fR2srAqMcOeKy54cJ6urunAYfTxQu7hs9Vvtd77ZrQN
wEHSIecIajVzhn6HAd7QBew0FBwOB+rCnFdq7BH79RBYeDql73UZ1DysvKL32vtNrvune4Pmqije
I8jDepVyZpEbijME2o+yOFvccJKjHT7bEm4orRjjtep0A8Lo+XFxbXSay0dcicbjLhLIU+UlB7iM
JMHAyKH8Tbe7TV49Ocrjmrwlq00DMYX2XMLKM3DCYJovROnj2rhqHQ1w4ohsOQ/6QRg=
--00000000000037e88a06238cfe69--

