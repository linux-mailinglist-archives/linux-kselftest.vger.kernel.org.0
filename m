Return-Path: <linux-kselftest+bounces-47700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD5CCB61B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6843E306AA0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90733D4EF;
	Thu, 18 Dec 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJbqWjYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E133F8C1
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052979; cv=none; b=TCbjca7F1nvs1AslsMIzjwPKaVo1BnwfMjUDFtC/wpWmO+Rj1CK48pRaebEVWHeobE1M+fW4TO3qG7ScyGu/7UNGzOPUcvzckKR/+io4KZ2UsU6mshnjJqmSfnnx+E9DWIj9BS5eaUAMSd+NtEj4tLoeUp9DthLSKQTfC1/TgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052979; c=relaxed/simple;
	bh=ozwVoMVYspTJP51oRiXPhj0nKJqL43vQtrcTaxjElFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVAuUT+v11KwN6Pwf0j3UBoBXqWhhjNARsoiG/fUUP4Y5JkbcwpQZoXMJBDELqZln5bc5Mwgm1SvW5Y7yuezbZHjldkhlowachjmyKsFL2BHfltNru8D0Lj2a4zJCHQ6RNjHYvbcfhs4B6AHBSNnkhog4j3CobBH4vF2YRVet4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJbqWjYk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso3284455e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766052944; x=1766657744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNB4pt64k56xcAY3XAWG426eNfy1NFZCPkyKc70W+Bo=;
        b=bJbqWjYk8JJBU+qHon8XO502qBeemNn2lFkLlzJQzcSCqXvzmwKEBMoMb9IQJgrcIj
         42SG8nFvqf3mVWgwuxbCwsiNeT7CTRSgZF2QYEh3493H9dVGVbtLDWvkTdRO3gPjV3DA
         Fcj2Bkt4taHJoZZrYWF9orY091HqY3Y2flnQAJcBZDM97e9OWsbhAbNQRgkHkTonPOrE
         VpxCld1r/63S2ofX5R4rkVzs0LJw6mxL70JLwhs03RerL5xiHfWL5MvtNVywpFKgZFkS
         q1BPC/e74xFrStm1TbCWOjLdkYcnlHvXtygJ9t8mbnAuhh7IsiyJIOywUvsbS9O0oEIR
         7KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052944; x=1766657744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNB4pt64k56xcAY3XAWG426eNfy1NFZCPkyKc70W+Bo=;
        b=o3TI3U82mcgr4+Jq2K+FJXYHi64KefdBkVAmdwlClHkellt8FKXaNzAMgvs0wCtEPN
         0u+zNXrCTUn3iNFFeadx8fJp4o5KRyW6zpIWeMf+IEOKgs8rqJlqQJ7VX9ArJlfZxPsc
         o4JphFp9zp+lICRMMIEhMRUknYBj1uuMUMsu9cWgv3uGX+doMVBz49aOvLq6tokWkali
         1dr2C+0KBXkLZvpjZcnV1q9VQiIABapRJmVbCmRHENx72tt5mZ2JSRelQ8HG79quZKkY
         1lMw/M6QeL1TpIt29FAXZUkHw+1tVlwTx48TFJbjM483VuKpavyo/473mbl3Dr3P/NU7
         7Itg==
X-Gm-Message-State: AOJu0Yx2DqlhrhLUyMuB+QzwsHfQhTdwiTHsrW5dyc3RDBssBJI9GbJv
	PyY3qIgMcXWiEKcnvM6Zq92UpaJcOf184zky4mUXT3havaJf3Ik4slTtbTVE1VULlBeDueqnBsA
	pQyWy9mBC3llCf9QANMZN+XUGs6XVGuIWeV/UDzOo
X-Gm-Gg: AY/fxX4t5Nl6HbOEg1AQlPUJX0sMyBPqlbLe52M+ivjlUh2PwVjwXMpUSIxRN57wKxV
	aDRQfoq1ycM9PiR89ZrsYhBMPRTqaV0GAMecvYG0Do2SEt1nd/rXS0ycgVgLwI8dwEwV7ilG5as
	eqU+WGUb6HbJ11XpeUZCebffbHAAikpC6loHjE/I9FdNQOermhdkZqyNmsyZVXZt1D9Q/Zgkele
	y1BB5ltXPhK7bGjSAUMYiJTLXEy1KnkKpPKJ04VXJe8/7cnnmdmgEtUt+bJN0VMbfIZFQ==
X-Google-Smtp-Source: AGHT+IEXLJdjTQLxSPa0mEfJGEjTkrCq8XKr4soVXhHxwMfaUZFsKGlb96H4Z+EkPtHcaHJ1+NrpVA/oXIpGfxArhBA=
X-Received: by 2002:a05:600c:1994:b0:477:952d:fc00 with SMTP id
 5b1f17b1804b1-47a8f8c0a28mr206010575e9.12.1766052943616; Thu, 18 Dec 2025
 02:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <CABVgOSk5UJf00=uEsk4chEJpKoPeYqXbk+czM7ipoD_0eWiedg@mail.gmail.com> <aUPNpGgj3hmA3aZL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
In-Reply-To: <aUPNpGgj3hmA3aZL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Dec 2025 18:15:31 +0800
X-Gm-Features: AQt7F2oS52wW4Z1sKMd0adnkyCJGKWVWJldrRy9rtb9zfrvkaGN3GLYkSRM5RB8
Message-ID: <CABVgOSkmd2K83WqvRZePzVEbB4kZmBdLO-yTuqoZjz-+YdmaAg@mail.gmail.com>
Subject: Re: Issue in parsing of tests that use KUNIT_CASE_PARAM
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000066b3bb0646373ea4"

--00000000000066b3bb0646373ea4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Dec 2025 at 17:47, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>
> On Thu, Dec 18, 2025 at 04:58:33PM +0800, David Gow wrote:
> > On Thu, 18 Dec 2025 at 15:20, Ojaswin Mujoo <ojaswin@linux.ibm.com> wro=
te:
> > >
> > > On Wed, Dec 17, 2025 at 08:47:57PM +0530, Ojaswin Mujoo wrote:
> > > > Hello,
> > > >
> > > > While writing some Kunit tests for ext4 filesystem, I'm encounterin=
g an
> > > > issue in the way we display the diagnostic logs upon failures, when
> > > > using KUNIT_CASE_PARAM() to write the tests.
> > > >
> > > > This can be observed by patching fs/ext4/mballoc-test.c to fail
> > > > and print one of the params:
> > > >
> > > > --- a/fs/ext4/mballoc-test.c
> > > > +++ b/fs/ext4/mballoc-test.c
> > > > @@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
> > > >         struct super_block *sb;
> > > >         int ret;
> > > >
> > > > +       KUNIT_FAIL(test, "Failed: blocksize_bits=3D%d", layout->blo=
cksize_bits);
> > > > +
> > > >         sb =3D mbt_ext4_alloc_super_block();
> > > >         if (sb =3D=3D NULL)
> > > >                 return -ENOMEM;
> > > >
> > > > With the above change, we can observe the following output (snipped=
):
> > > >
> > > > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ext4_mballoc_=
test (7 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test=
_new_blocks_simple  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [18:50:25] [FAILED] block_bits=3D10 cluster_bits=3D3 blocks_per_gro=
up=3D8192 group_count=3D4 desc_size=3D64
> > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/e=
xt4/mballoc-test.c:364
> > > > [18:50:25] Failed: blocksize_bits=3D12
> > > > [18:50:25] [FAILED] block_bits=3D12 cluster_bits=3D3 blocks_per_gro=
up=3D8192 group_count=3D4 desc_size=3D64
> > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/e=
xt4/mballoc-test.c:364
> > > > [18:50:25] Failed: blocksize_bits=3D16
> > > > [18:50:25] [FAILED] block_bits=3D16 cluster_bits=3D3 blocks_per_gro=
up=3D8192 group_count=3D4 desc_size=3D64
> > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/e=
xt4/mballoc-test.c:364
> > > > [18:50:25] Failed: blocksize_bits=3D10
> > > > [18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total=
:3
> > > > [18:50:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] test_ne=
w_blocks_simple =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > <snip>
> > > >
> > > > Note that the diagnostic logs don't show up correctly. Ideally they
> > > > should be before test result but here the first [FAILED] test has n=
o
> > > > logs printed above whereas the last "Failed: blocksize_bits=3D10" p=
rint
> > > > comes after the last subtest, when it actually corresponds to the f=
irst
> > > > subtest.
> > > >
> > > > The KTAP file itself seems to have diagnostic logs in the right pla=
ce:
> > > >
> > > > KTAP version 1
> > > > 1..2
> > > >     KTAP version 1
> > > >     # Subtest: ext4_mballoc_test
> > > >     # module: ext4
> > > >     1..7
> > > >         KTAP version 1
> > > >         # Subtest: test_new_blocks_simple
> > >
> > > So looking into this a bit more and comparing the parameterized outpu=
t
> > > with non parameterized output, I'm seeing that the difference is that
> > > output via KUNIT_CASE_PARAM is not printing the test plan line right
> > > here. This plan sort of serves as divider between the parent and the =
3
> > > children's logs and without it our parsing logic gets confused. When =
I
> > > manually added a "1..3" test plan I could see the parsing work correc=
tly
> > > without any changes to kunit_parser.py.
> > >
> >
> > Thanks for looking into this!
> >
> > There's been a bit of back-and-forth on how to include the test plan
> > line for the parameterised tests: it's not always possible to know how
> > many times a test will run in advance if the gen_params function is
> > particularly complicated.
> >
> > We did have a workaround where array parameters would record the array
> > size, but there were a couple of tests which were wrapping the
> > gen_params function to skip / add entries which weren't in the array.
> >
> > One "fix" would be to use KUNIT_CASE_PARAM_WITH_INIT() and have an
> > init function which calls kunit_register_params_array(), and then use
> > kunit_array_gen_params() as the generator function: this has an escape
> > hatch which will print the test plan.
> >
> > Otherwise, as a hack, you could effectively revert
> > https://lore.kernel.org/linux-kselftest/20250821135447.1618942-2-davidg=
ow@google.com/
> > =E2=80=94 which would fix the issue (but break some other tests).
> >
> > Going through and fixing this properly has been on my to-do list; with
> > some combination of fixing tests which modify the gen_params function
> > and improving the parsing to better handle cases without the test
> > plan.
> >
> > Cheers,
> > -- David
>
> Hi David,
>
> Thanks for the workaround, KUNIT_CASE_PARAM_WITH_INIT() did the trick!
>
> So I'm just wondering if it makes sense to still have a placeholder test
> plan line in cases we can't determine the number of tests. I think someth=
ing
> like 1..X should be enough to not throw off the parsing. (Although I
> think this might not be exactly compliant to KTAP).
>
Hmm=E2=80=A6 that could be a good idea as something to add to KTAPv2.

One other option might be to use the proposed KTAP metadata's
:ktap_test: line as a way of delimiting tests in the parser:
https://lwn.net/ml/all/20251107052926.3403265-4-rmoar@google.com/

In the meantime, I'm going to look into if we can update all of the
tests using KUNIT_ARRAY_PARAM() with modified gen_params, so we can
get the correct test plan in most cases.

Cheers,
-- David

--00000000000066b3bb0646373ea4
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgacyzOdXmYhtGMkxn568MnAJpDKyZ
t3haIcXEA+yUkFkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjE4MTAxNTQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAa+eNf62/o9CRiOZPm0nGPBfQBXpu+ucpVJDiVAk5rMQQiwJZqhpbXfiErLLdrLMn
pZ6YgExuS4e1qEDjdO18sKZMDeqoUhXb/sCTG79uSIKCPfVjpmZlLKG9wipOjAF/ZzylfB5DL6+4
Kbd+nMVcMIN5ip4ruBUaRWCrc7hDMywpzKy8GVQVu3XBj+3/gFxqBYmM2CdTfU0WU5dTSGUhDkp9
zU3crqzYdxerbT63tdXW1ROQD6Woa5pISEz+DoMmUApxrFzNAARsRdw1P1hMBCYnUE1ZQMt9BFzv
Os9h3cxqNcB43W23nLVipAnOLRL14VoKpzEwyAo18A2AXwN0mQ==
--00000000000066b3bb0646373ea4--

