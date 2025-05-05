Return-Path: <linux-kselftest+bounces-32311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D4AA8BFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76417A4A49
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9791BE86E;
	Mon,  5 May 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQqblvQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC521D5ADC
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746424986; cv=none; b=Y2Y9PV8FrCMVFp7h/j6yHrF/TtQim8DrNPpj3eNZREuxxuJ9INKFRcRp4qKkkWraLIGURVD7+nPB+rhSq0deocF3+zikkz0qR80+fLBEd8U1xxuPhNoe78cWn8d1LNrcHa34Z3rfbPczXr4RWKiytB22feo3cOUxhibYAnUx4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746424986; c=relaxed/simple;
	bh=aHjIPREGueZz6fEZpdNwiqzizj//96Z8xOgR7OoPBTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Gj7oaC5u6dklccrOqpVaCfy5z5HpEFIGlRfVd5FAgE1Gh+UE2DpH7COVI77qWpC3WjTFFUt4Xwcl7lYNWgOzxnpxl2pXimWgQkEF9rvknPkOQkSekKbLgaBlUKQKJ1iahXEfgiWgimu3x9vlKf3aC0qmNG5SPdYm2EEAt9SXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQqblvQJ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5b2472969so451279185a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746424983; x=1747029783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h46+PgZvwyUUeTlJAxXagH3xvtCEmzqk/qSPck3wvwY=;
        b=IQqblvQJ8LQIPFIQqWLavp27hdveBEVhmrbUbH897RaO5po+9fqUJulUXYXpGa51Mx
         cg4eop/xDEiriUk/GZ9CDPw50F1TkedPl5FAGpVpudLi3A0Mx8A7DG9vrYXhFavd1eGn
         tr2AEE8yJ/WgkCJsqOIUBbXBe2mYKbpjDxLEZajWYQ+sdq0ExCd/XqEP9jHFOkekE4sA
         3Mg/X6vcGXlnUa5jC4+NKzk6g0wQyx3cD+dA9ZMEcss2ASE16Ylw4vRkfhrEwWdSS8M7
         elzrtJuSr0Zo+uNJ97AK6/1JEK3h0odCMbrftG0O+7Ty9iOv4jsVE49nGBnfumWrw22W
         BYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746424983; x=1747029783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h46+PgZvwyUUeTlJAxXagH3xvtCEmzqk/qSPck3wvwY=;
        b=AD43hsVPpWD4Erp8U0WNvY8p/tQOgKc/CZJM9oLlQB/ISkCsW747Dvj9/UDKoL/mfG
         QIeag9Bqpepw8us1Sv0w2X+3G4bpI0a/zDFzMoDjE5F4C6APSCcMzwDfqNA0GrFTRoO1
         BsnmjA7TUNmFbSjXK+cJRZ2fq92OY1+GS8riDyS9aMzywOH9HT44XVSUzZirPg9OK19s
         nHTGXAXebbDAPbFe4yA2UEv+/C22sD8q297xVkXsGZuCSNnhlXMcE2s2UaI4/sOR4u7+
         EIwh9PpoK4rayW73+trQb4g4HfKPOVq9uduWLOyaXBlhPHVqJlN6MWsga1ECcwO5YDjB
         zfJg==
X-Forwarded-Encrypted: i=1; AJvYcCV1P+o3v+xh53r5+zgmcnzQKVw/7Myu+2pMuCtv+imYBNq+KReHScZsXhDPzTWABny3ZB19gmghMDkiJzwJJQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGIBnMEPVmkLWMyS0KfuYApNODP0cat5S9i5rK+yDjWlj3X/E
	xWWs8onRPTcX6ZZSU2r7fMnBal9MWYTz9LyuMcyQfLmTVf99ndaoZcfF5icEihzT2jEQk+CnfVa
	u6RUVExPqNrVWzIBFLx/Z4LxKP6Gt0u9yZ8qY
X-Gm-Gg: ASbGnct5URplEVCyRF02tirB+TW1lHo0eD74w79bL9lEwfnqt73fl8of/53XM10PGEc
	Rt7K5dDIY51W/wFHB+Prheo33PdHvxpLRKm0FMXoEaLvbl+CS1thL3IzigyLkq/r4IOU3FJjBkC
	jEP1bcDaOO2PBNRD/BR5FS09w=
X-Google-Smtp-Source: AGHT+IH8g7ImerDBSxOboHoBPQcGP9wlwdTQbMMeBILHYZ7QA9s7UXVKzKHRdL1v/6NO8hsad206wvuhez4QMz2l88s=
X-Received: by 2002:a05:6214:2509:b0:6e6:591b:fa62 with SMTP id
 6a1803df08f44-6f523725879mr136920846d6.5.1746424983121; Sun, 04 May 2025
 23:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502172459.14175-1-skhan@linuxfoundation.org>
In-Reply-To: <20250502172459.14175-1-skhan@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Mon, 5 May 2025 14:02:51 +0800
X-Gm-Features: ATxdqUEOFbaKQ5-k-iDPtcXV4ssda5KgtLHNB_FKJVJq9iGd9UirXfm6UpmFVI0
Message-ID: <CABVgOSkUEaGnsCY5g4EJnvJhJ1PkCjfC7dDs41HjWhT-WLdfyg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use ARCH from compile.h in unclean source tree msg
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	brendan.higgins@linux.dev, rmoar@google.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c760ef06345d405b"

--000000000000c760ef06345d405b
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 May 2025 at 01:25, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> When make finds the source tree unclean, it prints a message to run
> "make ARCH=x86_64 mrproper" message using the ARCH from the command
> line. The ARCH specified in the command line could be different from
> the ARCH of the existing build in the source tree.
>
> This could cause problems in regular kernel build and kunit workflows.
>
> Regular workflow:
>
> - Build x86_64 kernel
>         $ make ARCH=x86_64
> - Try building another arch kernel out of tree with O=
>         $ make ARCH=um O=/linux/build
> - kbuild detects source tree is unclean
>
>   ***
>   *** The source tree is not clean, please run 'make ARCH=um mrproper'
>   *** in /linux/linux_srcdir
>   ***
>
> - Clean source tree as suggested by kbuild
>         $ make ARCH=um mrproper
> - Source clean appears to be clean, but it leaves behind generated header
>   files under arch/x86
>         arch/x86/realmode/rm/pasyms.h
>
> A subsequent x86_64e build fails with
>   "undefined symbol sev_es_trampoline_start referenced ..."
>
> kunit workflow runs into this issue:
>
> - Build x86_64 kernel
> - Run kunit tests:  it tries to build for user specified ARCH or uml
>   as default:
>         $ ./tools/testing/kunit/kunit.py run
>
> - kbuild detects unclean source tree
>
>   ***
>   *** The source tree is not clean, please run 'make ARCH=um mrproper'
>   *** in /linux/linux_6.15
>   ***
>
> - Clean source tree as suggested by kbuild
>         $ make ARCH=um mrproper
> - Source clean appears to be clean, but it leaves behind generated header
>   files under arch/x86
>
> The problem shows when user tries to run tests on ARCH=x86_64:
>
>         $ ./tools/testing/kunit/kunit.py run ARCH=x86_64
>
>         "undefined symbol sev_es_trampoline_start referenced ..."
>
> Build trips on arch/x86/realmode/rm/pasyms.h left behind by a prior
> x86_64 build.
>
> Problems related to partially cleaned source tree are hard to debug.
> Change Makefile to unclean source logic to use ARCH from compile.h
> UTS_MACHINE string. With this change kbuild prints:
>
>         $ ./tools/testing/kunit/kunit.py run
>
>   ***
>   *** The source tree is not clean, please run 'make ARCH=x86_64 mrproper'
>   *** in /linux/linux_6.15
>   ***
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---


Thanks very much! This is much better, and has given the right message
on all of the architecture in-/out-of-tree build combinations I've
thrown at it.

Reviewed-by: David Gow <davidgow@google.com<

Cheers,
-- David

--000000000000c760ef06345d405b
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg3X3HoZJb3UQrZ4tNJScQMKXLmJjG
mjxZzzvQklR7xPIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA1MDYwMzAzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAbP/vTr/ysmcXMdSLMw6J9D5uwgh//Tau0tx6k6oF9cAQ9U5vnqt/dwim/cKcUnVj
M5SZyHgmC98dLj2cCKSDAAe4vPSEB1NbjnaRvW+fB2VCWcniQVEr39qCS+a4kKjmuJ9hL7eZJPnU
bmUlfsP0j9WoJBWznbEcTH1xaHmeu1vZwEhEwxxjnMlU72FzY1Q/NbCwQnwvikQ6p/bWxhzvolrO
BbViX4RkQre1oESHnvYZFp4AI7PCuQxrJMhIoBeBI+nKvdObZwPzJYJcNqa6GONmrZ7o0GNa9PiA
WUTqvEDg9PJ/nNxoyJSOjIFbru/UfjNR71oeq2vAiV+COwjayw==
--000000000000c760ef06345d405b--

