Return-Path: <linux-kselftest+bounces-18155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F997D17F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F4B22005
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88144C81;
	Fri, 20 Sep 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cf+gOkn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9F3BB50
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816242; cv=none; b=oAxasKK9fr4/pVEGfkW1dRfdEzG7UaHyUElqUbfeXkbMTDPTO/CW5rPcaTIE7ZboBLr3dPROpYalno7FMtp4UC5X/dF5DTq+Zye8KhuUCnIECUdhBm8sNOxh1HdPWuNliyI+6RxIsc8YU8uGb66TIvCTXn5MJX3Jx066Q945Oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816242; c=relaxed/simple;
	bh=S1R0h+w5vkjrXN9bz/6mg5enb0nnqetA5Sxd8kY/f5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJzqZENAE4SbPRDVWT9he6JUqgb7GdD3a252CnCFT+gjXOgwZ9lDKYkcLtEaclHpX6NlknKm1BDs0Uk5afsXyXwAw/Lt03PVrV/NXqHKsiZ1NxCPbLpttmPWWUBN4ogLS68hOfdHMao8OAPiLNboojejcJwUcCQ+MlfhWro9inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cf+gOkn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c51d1df755so12900036d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726816240; x=1727421040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=matHERfOvewU1RyaLnTVpQh5GFSsoYnSdouus4cHcuQ=;
        b=0cf+gOkncIAlRY62/y88Jvdlu8cxW8/Ril3AqBpG2Be1reuJVXfl7P0zFfgchnyiYD
         6YJsa9iccRG1odQhKbckRSBoZPMG4L069OxqjfGVaOWeBRWjnTslOMl3oGLuiGvBl7nc
         pq44PE0jd9kbH9nS7W4kHRvm84K9kQkvzF+txcmypdoFGBOjqlD6cpH1HMtIeTGm3yfb
         fluxDAwFctCnPn3pvExax6QPldkkbsEPab/HgJRC4K1HFsi+Vt76M6dIsFUHI2lTgbwz
         v1ASD3FU/uWTU052to95E3dQ7PwgmQiVpH0RC69b6kBWoLqm1Fiv38YtV9CSPYmRpVHo
         R0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726816240; x=1727421040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=matHERfOvewU1RyaLnTVpQh5GFSsoYnSdouus4cHcuQ=;
        b=L0STR7PnISsTrGke8ZN0LUWjAXW2LKhkZKLgiBqY8aT9TYfjmdqlsGFRJ3Yq72rF1a
         YSaQFYL4VE35jT/SqaODx5WldLw7VJZs1kGkIwB08nEc7D6lQndAxuKMvTTer8PX3lI5
         zajTgrkegaDN3OxHGxtVQWCH6+TDUaXXwD/OiSN0sH885tT/69Eh3XMt0oe6G68lWDf5
         Ykp+WMi0HRC+HBztmQcaxmmxU6dVTgOL+tDpHQFWRp3zphRB1RYaXXhq1f/3rYLC4UPK
         0qlB4+X5CnkhW0xHDKWK197TG9D03C4XGqCFhQESllVarHmXFmFv4JYLP1hZ/QF4ImhC
         mtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBxxzPja5aXVckPzhO3HgBcB3fHZYg7tb6bgg7ehvv9XO5rsn/OZxujQscEPVfjM42uhleWpudPz5fnhU86vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4ZBcuk6+La+7KABHHbvHoc8ZA0Iw+R73tBN9y3gyxUPs6hhj
	DZIIm6RiymeZP0n8tROH7KWlNOmKTqoXIphPC9iE5eB9FnFswi0Pj0jeEnfLn/NYWr20Jgx9hu4
	0KdPM1+ydh0Fr/TPuZLIgYmRkDr7Nb3ZsOKpR
X-Google-Smtp-Source: AGHT+IE/zEqFDw4bxTIHzfHfmbEBCqAfcea8hS6VNlyAN1cEKS3IQ+w2FK3MjrrxzD9urrX9o3ENlOPHhs8Zz3mGrGs=
X-Received: by 2002:a05:6214:5785:b0:6c5:f91d:9d2 with SMTP id
 6a1803df08f44-6c7bd4d1e5amr25521346d6.14.1726816236088; Fri, 20 Sep 2024
 00:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917005116.304090-1-arturacb@gmail.com> <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
In-Reply-To: <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Sep 2024 15:10:19 +0800
Message-ID: <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Artur Alves <arturacb@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, n@nfraprado.net, andrealmeid@riseup.net, 
	vinicius@nukelet.com, diego.daniel.professional@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009abe59062287bc9a"

--0000000000009abe59062287bc9a
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/16/24 18:51, Artur Alves wrote:
> > Hi all,
> >
> > This is part of a hackathon organized by LKCAMP[1], focused on writing
> > tests using KUnit. We reached out a while ago asking for advice on what
> > would be a useful contribution[2] and ended up choosing data structures
> > that did not yet have tests.
> >
> > This patch adds tests for the llist data structure, defined in
> > include/linux/llist.h, and is inspired by the KUnit tests for the doubly
> > linked list in lib/list-test.c[3].
> >
> > It is important to note that this patch depends on the patch referenced
> > in [4], as it utilizes the newly created lib/tests/ subdirectory.
> >
> > [1] https://lkcamp.dev/about/
> > [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
> > [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
> > [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
> >
> > ---
> > Changes in v3:
> >      - Resolved checkpatch warnings:
> >          - Renamed tests for macros starting with 'for_each'
>
> Shouldn't this a separate patch to make it easy to review?
>

I think that, if this were renaming these in an already existing test
(like the confusingly similar list test), then yes. But since it's
only a change from v2, I think we're okay.

> >          - Removed link from commit message
> >      - Replaced hardcoded constants with ENTRIES_SIZE
>
> Shouldn't this a separate patch to make it easy to review?

Again, if we want to change this in other tests (list, hlist) we
should split it into a separate patch, but I think it's okay for llist
to go in with these already cleaned up.

>
> >      - Updated initialization of llist_node array
> >      - Fixed typos
> >      - Update Kconfig.debug message for llist_kunit
>
> Are these changes to existing code or warnings on your added code?

I think these are all changes to the added code since v2. Artur, is that right?

> >
> > Changes in v2:
> >      - Add MODULE_DESCRIPTION()
> >      - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
> >      - Change the license from "GPL v2" to "GPL"
> >
> > Artur Alves (1):
> >    lib/llist_kunit.c: add KUnit tests for llist
> >
> >   lib/Kconfig.debug       |  11 ++
> >   lib/tests/Makefile      |   1 +
> >   lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 370 insertions(+)
> >   create mode 100644 lib/tests/llist_kunit.c
> >
>
> You are combining lot of changes in one single patch. Each change as a separate
> patch will help reviewers.
>
> Adding new test should be a separate patch.
>
> - renaming as a separate patch
>

I think given that these are just changes between patch versions, not
renaming/modifying already committed code, that this is okay to go in
as one patch?

The actual patch is only doing one thing: adding a test suite for the
llist structure. I don't see the point in committing a version of it
only to immediately rename things and clean bits up separately in this
case.


Cheers,
-- David

--0000000000009abe59062287bc9a
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
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAGelarM5qf94BhVtLAhbngw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNDA4MTYxNzE0
MzRaFw0yNTAyMTIxNzE0MzRaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmB/GGXDiVzbKWbgA5SjyZ6CD50vgxMo0F
hAx19m1M+rPwWXHnBeQM46pDxVnXoW2wXs1ZeN/FNzGVa5kaKl3TE42JJtKqv5Cg4LoHUUan/7OY
TZmFbxtRO6T4OQwJDN7aFiRRbv0DYFMvGBuWtGMBZTn5RQb+Wu8WtqJZUTIFCk0GwEQ5R8N6oI2v
2AEf3JWNnWr6OcgiivOGbbRdTL7WOS+i6k/I2PDdni1BRgUg6yCqmaSsh8D/RIwkoZU5T06sYGbs
dh/mueJA9CCHfBc/oGVa+fQ6ngNdkrs3uTXvtiMBA0Fmfc64kIy0hOEOOMY6CBOLbpSyxIMAXdet
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgdxDiv2xiYnKbGDT5DI71k+G5D71P
KVrXH9Q+fnru4BEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
OTIwMDcxMDQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFBQvB71vrs8TBzmmstb722eDNNp5a5OkHYUspMvilwcTYkK
+EF9NaVG8nQVc71vIhoyCtTygPuoPEx8XnIIdPubgemaq5JQkkLRAawxlGgr9JkdhqM0gIUOeoE3
d/xE9qdtJz1qEADqThCEy7N2SIUTWAEugeUh1fQAIBDwI+/kopy+P33n3AHILFASzqBAovyfsamK
z/EonDBgCNcWpfpbYtR/MbTKJ3g9EEHCx6QzGYSCJXYLDFYdp/3boazq3caCwjSjQapkYxRN5hMQ
U2Bh5Ow6kBR2g+0VBFWy78AGy6tE+CDXqXAWPPDdzNLLddaqSFMv1oULGw1XCSFEoJk=
--0000000000009abe59062287bc9a--

