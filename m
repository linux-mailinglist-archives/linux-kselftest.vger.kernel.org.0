Return-Path: <linux-kselftest+bounces-17443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F259397005D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 08:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EB91C2210B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B43145323;
	Sat,  7 Sep 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij7BxhCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17ED49624
	for <linux-kselftest@vger.kernel.org>; Sat,  7 Sep 2024 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691813; cv=none; b=PPpyy73iKRUEZzsi4J9TxcOAlpMTd/vfHUn617U40V621NcXp6B7dI1+KsV47N47BQYoncQPExESn5meBgoxSWUbym90pVXc/LHaiONup/DOTdOLALNVmTto0GkCgQxGTTmLXtrNinVQ6i/296FA5mm8CBs2EnysfTtDWllx2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691813; c=relaxed/simple;
	bh=JIWo0t3I574iSmQnXSvvHUNEgCMARhBrY3dzxSQuH6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB1lNJyN9DHJKCEcTMX8b7erOH1ytAdDoQfVg9s1VUJEAq9LpiprvrML/QrfQ7EjPT7FifVF9IX/4Bj1T0RkKMbHbvTmup1w5BmCptoTCdj9Z+S2THDCWkGyklSmf8pWEZ/CXE9HwzHA6mViz8KwyjSrjSiBka5oHGuu0D7LriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij7BxhCC; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c353f2f954so17587846d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725691811; x=1726296611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e3mM925qNxv0Pf+JM+6tJkzMmYkeYCZ3FsD/bOSe/lE=;
        b=ij7BxhCCebK9kaWeG/0+1TGK8VrV5CpbLYYYvthx0cEa2/ut08FCIVMhckY+vkiYiH
         TcNFvyQcIn6BdQsi02Fgl3Yd+8ZfEX6dIxJynkye+yr74asA3+nzvgdwdp81ze/8eANb
         LeZ939Cu9c3ZrTyGumC0nBIK1lChJszCacYQcrBKiXYYg0xqrqz5BwMoxx1BaBAMtTel
         0eIoF/kRDWKStjaS3erj8S/kloLDSRr1KltFue4Cz1QStLLbYzpoxYWa3TrJORRO7vSn
         hAFMWAH8OLM6KFSspnU8Rme/d6XE2+LpVdNegGSpHaWh9mywN+FssKTrmnufQ4cYNBl+
         h7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691811; x=1726296611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3mM925qNxv0Pf+JM+6tJkzMmYkeYCZ3FsD/bOSe/lE=;
        b=gSke816lfnB7pqtQeQZ2QsIHwhuiwwlzGRo4br7s1FTRQ9LyluOhAfgsAKeXAbfjqo
         HQJS1jp45Cg15yvVX7eP7iH0Y51a3DIKFUP02yVxYnxLpmJgZpSaJRQhnEm0onmQ0YVY
         LO7K6NB1BNuFMyJkECDudOa9Kvuh3QjJu68a4hkE97gs2m9r3F2UN3t+1ErgZOYlXSU9
         CBeu1m815ZqFG8cZ0XTeOqupEkjeAims28mXX/0SK1hxY64JfQGQIl0AX7WdvOx0P4B4
         XbRxJFfg+yRFM06OWxL6BWm59QDdvaNR67Ck4Iyq+zOuQJGBU1Pt0JMwKwhDYb8VXKjq
         Y5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVXk0khdVxv4mTVOl023pp5SM8qf+F8tkHxePuZBTSuIws8pwr6YZuLZSO83+4dvEx6CQ6nlWsXr8UHZBFtsQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaDG4RR9MCGplyH1lRqDNDkNWRaNTVIhbgsevmoa4//dVPVjg
	57x9wuk2svhwAmbkpsjcnnV0RK39zVg7bpLB5MvuomzTWoaxoKDN1fwIwkvkht8szFpgtTM4ZvU
	55lmnNmUyHWGqN93A5RoBGA55VfKzpF4uUBec
X-Google-Smtp-Source: AGHT+IE+5p1I5J4NATlIOgXPM/KvOXZH1P/WhtcoRor4Pe4Cw+LefNUF2lgjTWAOyt8VAkdi9j5fnQkMwNfme1BkRec=
X-Received: by 2002:a05:6214:2c0d:b0:6b7:aed3:408f with SMTP id
 6a1803df08f44-6c5283faf36mr67219076d6.13.1725691810413; Fri, 06 Sep 2024
 23:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904134152.2141-1-thunder.leizhen@huawei.com> <20240904134152.2141-3-thunder.leizhen@huawei.com>
In-Reply-To: <20240904134152.2141-3-thunder.leizhen@huawei.com>
From: David Gow <davidgow@google.com>
Date: Sat, 7 Sep 2024 14:49:58 +0800
Message-ID: <CABVgOSm6taiZpoeTz3Rry-ZU3bY-vS7FtCH98-O+pHMn9jcgzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] list: test: Add a test for hlist_cut_number()
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000064c2cf062181ef9b"

--00000000000064c2cf062181ef9b
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 21:43, 'Zhen Lei' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Test cases cover all possible situations:
> 1. The cut number is invalid: zero or negative
> 2. Partially cut.
> 3. Cut all.
> 4. The cut number is greater than the number of nodes in the old list.
> 5. The old list is empty.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Thanks very much for the detailed test. It's great to see these kept up-to-date!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/list-test.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 37cbc33e9fdb380..3c60a6458545452 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -1172,6 +1172,56 @@ static void hlist_test_for_each_entry_safe(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
>  }
>
> +static void hlist_test_cut_number(struct kunit *test)
> +{
> +       struct hlist_node a[4], *last;
> +       HLIST_HEAD(old);
> +       HLIST_HEAD(new);
> +       int cnt;
> +
> +       hlist_add_head(&a[3], &old);
> +       hlist_add_head(&a[2], &old);
> +       hlist_add_head(&a[1], &old);
> +       hlist_add_head(&a[0], &old);
> +
> +       /* The cut number is less than 0 or zero */
> +       cnt = hlist_cut_number(&new, &old, -1, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 0);
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 4);
> +       cnt = hlist_cut_number(&new, &old, 0, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 0);
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 4);
> +
> +       /* The cut number is less than the number of nodes in the old list. */
> +       cnt = hlist_cut_number(&new, &old, 2, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 2);
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&old), 2);
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 2);
> +       KUNIT_EXPECT_PTR_EQ(test, last, &a[1]);
> +       hlist_splice_init(&new, last, &old);
> +
> +       /* The cut number is equal to the number of nodes in the old list. */
> +       cnt = hlist_cut_number(&new, &old, 4, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 4);
> +       KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last, &a[3]);
> +       hlist_splice_init(&new, last, &old);
> +
> +       /* The cut number is greater than the number of nodes in the old list. */
> +       cnt = hlist_cut_number(&new, &old, 5, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 4);
> +       KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
> +       KUNIT_EXPECT_EQ(test, hlist_count_nodes(&new), 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last, &a[3]);
> +
> +       /* The old list is empty. */
> +       cnt = hlist_cut_number(&new, &old, 1, &last);
> +       KUNIT_EXPECT_EQ(test, cnt, 0);
> +       KUNIT_EXPECT_TRUE(test, hlist_empty(&old));
> +       KUNIT_EXPECT_TRUE(test, hlist_empty(&new));
> +}
> +
>
>  static struct kunit_case hlist_test_cases[] = {
>         KUNIT_CASE(hlist_test_init),
> @@ -1192,6 +1242,7 @@ static struct kunit_case hlist_test_cases[] = {
>         KUNIT_CASE(hlist_test_for_each_entry_continue),
>         KUNIT_CASE(hlist_test_for_each_entry_from),
>         KUNIT_CASE(hlist_test_for_each_entry_safe),
> +       KUNIT_CASE(hlist_test_cut_number),
>         {},
>  };
>
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240904134152.2141-3-thunder.leizhen%40huawei.com.

--00000000000064c2cf062181ef9b
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgJR2gj3fLWjigd2Ws8lFgMoOv3sFA
sJUvXSj94NNj7uwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
OTA3MDY1MDExWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAK+W1m87K4GFVUPW1gUqhlWL6Yg3+09BAzCbkELMN94yuqM
BGhJVt3WPj65KG+XB4nSFAleI0Z44rnyveOqI0KwcLz6CYdBdqFjt5NebTXYKoZEtKFYXq+uXxkh
z39IyI8s9OKFoSK7pPL9IaJWagZz3M4fEC6q22TDgQ60ucpxuRsMChKJTGN49GY5xsQC5/2zbdVH
znbEKGKooMicmeCUoiEf2bOmEgr2Pj4drjnsA1hPTrCe5fYsO+S+59NclQ43yyOrR+O25Slk2sMr
2tWcPCUK4GbK3hg0ZoenEHfMzNzHmV8zHyQ7UNG07Z70knqG/cPJIfMsGzQiO684Sp8=
--00000000000064c2cf062181ef9b--

