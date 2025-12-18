Return-Path: <linux-kselftest+bounces-47698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F6CCB0A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEF5300DCA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1B2E040D;
	Thu, 18 Dec 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDKfWnWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723592874E0
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048329; cv=none; b=Y+itEadH8YxetWsbfbbvbH0J46+AkZVDL1TOXQLXUzpRxCsP/zjzSuEFuVqb3K5OFZ6+3UW3BQfiEEjytGGpfFS0stxTg2F/Rg8mlGM37cJENOIHxmJK2cTHYZv1ZfrB8oaOTdSSUa1pqdmlpt22NXJV3f8hZP0pFM5f58GTeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048329; c=relaxed/simple;
	bh=oUyxQTele0TO0TLjylVoie0djB1OfFf1OhReNUUdClM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxRWrDfx0NLK+ZTYAXPplJNuLa47W+O0DjAPpqFmfuXsbHpRzwvPy6i3YQAqfbDxIMKbql2Gsle/zw7yr0euv4Sz19jEl7xuMbNeGtn3+ckNiXH+hBk3ZY2+BU+u171cx5aCpFQ5QYBqBEIY6Txdsy0iNE63HB1J9q7Dvp1+GgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDKfWnWT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d9326so2265565e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766048326; x=1766653126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GKHY9CPjGfOS2DNrL36W3lGAvux7JQslbrISvDvnpJU=;
        b=LDKfWnWTWT/ZaF/Ac5dh/Wq1jVqA0m1t3gDXogK4vwcCgdMQ/oorSVwmOTU+W0SArB
         +tb8MhiJtdztkmBgHsDYhKZRVUnR/wH3WGnd9Gz9qrFFO8KdP7HBB3Qcu85W4IAiEbl3
         zfKEvhvhfqWF765mglLJ9M/4lkCUD7KMPCRga6o0QQehSqMS6bzInZI2gbkmjUluEZ9A
         9zyCFzPN4wn3hs7FdPC1hIv6GLUOtOBsdbmifGP933Depnh5LJ/kVrjh4OJRJpQ6gKnu
         H4gYsOLq5PF9uU5Iaj7IbHcOcxXNUPKM8pLAd32YTs7R6rQ7EwqqXenUBd5e9Vhbs3D7
         n/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766048326; x=1766653126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKHY9CPjGfOS2DNrL36W3lGAvux7JQslbrISvDvnpJU=;
        b=aeX0//jh5ApmfnkgtnV3/zrNNU6cpozgwPsazRPZ+kqc7beOcubX9E1Lc3zS8rMp9U
         PmvG5wngPiAY7KqStmY2GQEirZB9ZWCb3PEr/ld/kWzprtw00azcWi03UzLmYGUnP3mX
         7EEnI4t77Vq3efju3w72XuByvdLvUhZGhI9YMw4TzZQmmbXVx/OA7sUMjpedSJPxM7LA
         85i5YAMnbBYH6syDejmaXN2Z7kvwATgKbVDrH0t6jM23bLhIusnJPeEszYk440IhQs14
         4V9PBsVyGEezBnjT7nI/fUn67h+2C/w/1kzQWH+bVSe+kaq6DW98AZrgIo8hKXrlcuXR
         EmOw==
X-Gm-Message-State: AOJu0YwiA4da4Cq3inPo2PgzjVG5ZPOPglC1lwI5ZPEG8VGAKpbwL6+a
	yC4KxgfBTTJi3qwZKbpfd4mBBpLD03Ekrfmaaese/jmd3BbsnpVeNyEegXSEGwBFGrD/7N2VEQP
	biegppYNRXow2PU1uK5VOUDh0qW9DfGWWfmUVxr46
X-Gm-Gg: AY/fxX7jMQy+AJsE+SZE5mxzcyXAJ/hDvRJV59foI2IP/VfInEvo8JWvJ9Xags/1NuX
	qtZ6qg5WcbhWhpTJ9BwXM+hYEB/c1ajivxkLM7kZuUZ4PVhrkg/X/fCrWLyNayLKBmaHDXavIRb
	QhPvH9XIfq6cr2ppUSAuQQvHwrM1+rDBZ0iUpiAtfZu84TwxKO18MpRLQYX2SB4Tg2xOW4RYyN+
	9jOhBesMYhTleGCyYRG9qIH54zGD8HVF636R+hmRb8Jhhfk0I8sejkh9JtdSeOF/wD90w==
X-Google-Smtp-Source: AGHT+IHk6v+GPETVCouf/W5Vh+LuOXQUcaPGfx2jC4jMJtGGhk7dRfptF8Gn5z5PFl4jKX+nbtXxDgCY36ntDwh5Dvo=
X-Received: by 2002:a05:600c:c16b:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-47be06d18d2mr41207565e9.16.1766048325489; Thu, 18 Dec 2025
 00:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
In-Reply-To: <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Dec 2025 16:58:33 +0800
X-Gm-Features: AQt7F2oeIfxrxsagmy0qCDdPB9QFGLHpbE5UFBAHjpDJUvFMcDMgu5JQ0o3iftg
Message-ID: <CABVgOSk5UJf00=uEsk4chEJpKoPeYqXbk+czM7ipoD_0eWiedg@mail.gmail.com>
Subject: Re: Issue in parsing of tests that use KUNIT_CASE_PARAM
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000226b590646362ba6"

--000000000000226b590646362ba6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Dec 2025 at 15:20, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>
> On Wed, Dec 17, 2025 at 08:47:57PM +0530, Ojaswin Mujoo wrote:
> > Hello,
> >
> > While writing some Kunit tests for ext4 filesystem, I'm encountering an
> > issue in the way we display the diagnostic logs upon failures, when
> > using KUNIT_CASE_PARAM() to write the tests.
> >
> > This can be observed by patching fs/ext4/mballoc-test.c to fail
> > and print one of the params:
> >
> > --- a/fs/ext4/mballoc-test.c
> > +++ b/fs/ext4/mballoc-test.c
> > @@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
> >         struct super_block *sb;
> >         int ret;
> >
> > +       KUNIT_FAIL(test, "Failed: blocksize_bits=3D%d", layout->blocksi=
ze_bits);
> > +
> >         sb =3D mbt_ext4_alloc_super_block();
> >         if (sb =3D=3D NULL)
> >                 return -ENOMEM;
> >
> > With the above change, we can observe the following output (snipped):
> >
> > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ext4_mballoc_test=
 (7 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test_new=
_blocks_simple  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [18:50:25] [FAILED] block_bits=3D10 cluster_bits=3D3 blocks_per_group=
=3D8192 group_count=3D4 desc_size=3D64
> > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/=
mballoc-test.c:364
> > [18:50:25] Failed: blocksize_bits=3D12
> > [18:50:25] [FAILED] block_bits=3D12 cluster_bits=3D3 blocks_per_group=
=3D8192 group_count=3D4 desc_size=3D64
> > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/=
mballoc-test.c:364
> > [18:50:25] Failed: blocksize_bits=3D16
> > [18:50:25] [FAILED] block_bits=3D16 cluster_bits=3D3 blocks_per_group=
=3D8192 group_count=3D4 desc_size=3D64
> > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/=
mballoc-test.c:364
> > [18:50:25] Failed: blocksize_bits=3D10
> > [18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] test_new_bl=
ocks_simple =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > <snip>
> >
> > Note that the diagnostic logs don't show up correctly. Ideally they
> > should be before test result but here the first [FAILED] test has no
> > logs printed above whereas the last "Failed: blocksize_bits=3D10" print
> > comes after the last subtest, when it actually corresponds to the first
> > subtest.
> >
> > The KTAP file itself seems to have diagnostic logs in the right place:
> >
> > KTAP version 1
> > 1..2
> >     KTAP version 1
> >     # Subtest: ext4_mballoc_test
> >     # module: ext4
> >     1..7
> >         KTAP version 1
> >         # Subtest: test_new_blocks_simple
>
> So looking into this a bit more and comparing the parameterized output
> with non parameterized output, I'm seeing that the difference is that
> output via KUNIT_CASE_PARAM is not printing the test plan line right
> here. This plan sort of serves as divider between the parent and the 3
> children's logs and without it our parsing logic gets confused. When I
> manually added a "1..3" test plan I could see the parsing work correctly
> without any changes to kunit_parser.py.
>

Thanks for looking into this!

There's been a bit of back-and-forth on how to include the test plan
line for the parameterised tests: it's not always possible to know how
many times a test will run in advance if the gen_params function is
particularly complicated.

We did have a workaround where array parameters would record the array
size, but there were a couple of tests which were wrapping the
gen_params function to skip / add entries which weren't in the array.

One "fix" would be to use KUNIT_CASE_PARAM_WITH_INIT() and have an
init function which calls kunit_register_params_array(), and then use
kunit_array_gen_params() as the generator function: this has an escape
hatch which will print the test plan.

Otherwise, as a hack, you could effectively revert
https://lore.kernel.org/linux-kselftest/20250821135447.1618942-2-davidgow@g=
oogle.com/
=E2=80=94 which would fix the issue (but break some other tests).

Going through and fixing this properly has been on my to-do list; with
some combination of fixing tests which modify the gen_params function
and improving the parsing to better handle cases without the test
plan.

Cheers,
-- David

> >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-tes=
t.c:364
> > Failed: blocksize_bits=3D10
> >         not ok 1 block_bits=3D10 cluster_bits=3D3 blocks_per_group=3D81=
92 group_count=3D4 desc_size=3D64
> >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-tes=
t.c:364
> > Failed: blocksize_bits=3D12
> >         not ok 2 block_bits=3D12 cluster_bits=3D3 blocks_per_group=3D81=
92 group_count=3D4 desc_size=3D64
> >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-tes=
t.c:364
> > Failed: blocksize_bits=3D16
> >         not ok 3 block_bits=3D16 cluster_bits=3D3 blocks_per_group=3D81=
92 group_count=3D4 desc_size=3D64
> >     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> >     not ok 1 test_new_blocks_simple
> >     <snip>
> >
> > By tracing kunit_parser.py script, I could see the issue here is in the
> > parsing of the "Subtest: test_new_blocks_simple". We end up associating
> > everything below the subtest till "not ok 1 block_bits=3D10..." as
> > diagnostic logs of the subtest, while these lons actually belong to the
> > first of the 3 subtests under this test.
> >

--000000000000226b590646362ba6
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgwnbydAc/rnop6U3uDVlUC7xJ4UQw
yOunfoDVPr2yztkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjE4MDg1ODQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEADNu0rk5jtd7QSyUMubzbycDEexiNNWs/1wczO51KA/uI7EvdVHnwGOH00a/AQf+j
X1g2igk9luRDukWW4BhOTM/1ARg1evpl+us8s+boRiRbEhO4hLHOV8pssVoU5n2RJ1AaXZ9EDddB
qUU7Z7CK1K6IpDgAvYFR/vbTzfW+c82BhfRUUKo5liyyrYPfDXjb4GH3RKyxH6ydL425gAkYC6wj
GM5rCz8rcrARV3fcgE2zr2yjMlixOgw5+gaRimvulPhAGVUlRmlWKRKgHlYnEx3i8vYOUViyEW66
N2cI0ftTMP2KRpyUToHec3VvACryVEH7qGhu7+OXvaYWHNjapQ==
--000000000000226b590646362ba6--

