Return-Path: <linux-kselftest+bounces-1957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8ED81396B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 19:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C955C1F21652
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6314675DF;
	Thu, 14 Dec 2023 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHcbyVNy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA0CF
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 10:07:15 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f5b3fa323so353308685a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702577235; x=1703182035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBFEMZ0EiYazwa3jnrIIxK8Q7gEaYnbd4WqoVYL33x0=;
        b=YHcbyVNyHIEjwfEqPFHEBqmqCVyliYcErJvE11jzGHI6mLzS/TrpUwtGkFWpCgoA8D
         LhWZu1z09zegN/VXu63vvv/p0Kw3l41sSoK6fMbffOHprNtdskq2oBlGPe366oSc4WH7
         zO0E8DNE+LiC3j6hBWf4I3gxStS+/Q4/vQcJ2NLj/GFUQjJHRRlcxkU2aBVPR+FcrrJm
         3u0dKwz/jyIYm5NBiiDBQTm8BcaVPjmVkn4T9v9PkKKmDhy8iibwSop7HeaQqe8XGWxT
         MmCytBaabIYE/T73RlqBIyEQxxJQwFyRbrk3S8QSYQu6PG2g9um+Hh14sZwSv1RccN7X
         tlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577235; x=1703182035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBFEMZ0EiYazwa3jnrIIxK8Q7gEaYnbd4WqoVYL33x0=;
        b=ZqGOx8IaOf2Nq4xtkCJwnso9Bql5YWuc/1HUVxKzsgMt8ivCYfkTLBCVOUD0hcxmXS
         0L4JViiisGOKq2JbOwwRJ7KKmYNbXpWX/SQcYHseuOf2MuYcjBAYlmtf/CLTB4inp25u
         EoPmqprcNl26IaK9HurvqNV8VLpTSUM9D2xu2vTvg6kDJc92jFxOI4b2SKsr/97tBE0C
         UIqGw9hk0Tey7xnT4I4iozkJ7mI6XA1y2t3L8N5PomTxNk8kIgSK1dMxI7xi1REoa2DU
         5lqXswaMfYFDZT1dnR6OoAQdak2dKJa5jkf4dnnXuQFYEhWjUljz2KKILYe8f9lK8yrP
         UF8A==
X-Gm-Message-State: AOJu0Yx9eyfmC1KDeq5ok1W4mwXawCS5XqyVULj4ATIX1ajccziLsE0I
	thdmt8yvGMyDkKNcvhoKT8UAEQ8C187/sY7UVyE9TA==
X-Google-Smtp-Source: AGHT+IFwNSzZ0G7xHpcJXHZ4FRw8EVTJygkGWuFoYiSzxK7sPEYUVi0cGsOSRNLzHPbCptg0JCTAkZol4v5CgRSez9Q=
X-Received: by 2002:ad4:5e8a:0:b0:67f:13af:385b with SMTP id
 jl10-20020ad45e8a000000b0067f13af385bmr381360qvb.66.1702577234734; Thu, 14
 Dec 2023 10:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com> <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
In-Reply-To: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
From: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date: Thu, 14 Dec 2023 19:06:55 +0100
Message-ID: <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004e7fdb060c7c2791"

--0000000000004e7fdb060c7c2791
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:31=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 13 Dec 2023 at 16:36, Jeff Xu <jeffxu@google.com> wrote:
> >
> >
> > > IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is =
ok"?
> > >
> > The MADV_DONTNEED is OK for file-backed mapping.
>
> Right. It makes no semantic difference. So there's no point to it.
>
> My point was that you added this magic flag for "not ok for RO anon mappi=
ng".
>
> It's such a *completely* random flag, that I go "that's just crazy
> random - make sealing _always_ disallow that case".
>
> So what I object to in this series is basically random small details
> that should just eb part of the basic act of sealing.
>
> I think sealing should just mean "you can't do any operations that
> have semantic meaning for the mapping, because it is SEALED".
>
> So I think sealing should automatically mean "can't do MADV_DONTNEED
> on anon memory", because that's basically equivalent to a munmap/remap
> operation.

In Chrome, we have a use case to allow MADV_DONTNEED on sealed memory.
We have a pkey-tagged heap and code region for JIT code. The regions are
writable by page permissions, but we use the pkey to control write access.
These regions are mmapped at process startup and we want to seal them to en=
sure
that the pkey and page permissions can't change.
Since these regions are used for dynamic allocations, we still need a way t=
o
release unneeded resources, i.e. madvise(DONTNEED) unused pages on free().

AIUI, the madvise(DONTNEED) should effectively only change the content of
anonymous pages, i.e. it's similar to a memset(0) in that case. That's why =
we
added this special case: if you want to madvise(DONTNEED) an anonymous page=
,
you should have write permissions to the page.

In our allocator, on free we can then release resources via:
* allow pkey writes
* madvise(DONTNEED)
* disallow pkey writes

--0000000000004e7fdb060c7c2791
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
miiwZhqbFo3H+sN+36dVsCIwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBABDOrwE7xhhZ
KPffKFRtuggfC0sfh0EHmrCzCXlyiQFmTpjm73me7rw+ibiPUnohQxkeqC9KvwDd/gF7OAY3un01
f8y5iEmwoymOLIzkTKIMHDp6qOul60jFrAWe8EQMuBMEc9TQbOiXB4jFgLuDZX7AspyVvnmLA5sw
msq0yrGgxTsEeZniQpdOP/qZNS2TJmvNH8a8HuQfHH/pd20lRWfTEuhSRN8cTkKihK7iO8wjCmrp
EXefUessFdMqMUSfGI6rUaZTfU0SRfdrVHW4IE8onI30/UVurbGlFiugNF3LbDMXdqzs2/eTsLiD
8Dv1+pt7SJqI4zNhzZFOpvBPVIkxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAFp/vXw/R/y8Lw9a5440YEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IM8/A9cP2NNPis2KNHiRb446CfrNa20wSpXiVFfLImAvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIxNDE4MDcxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBdKqebtGmCYqfk8i92
Tbih5wr2OCj7bSuhQ30OLyYtZkEZJuiAuU1sueW5itmExb93/oy7vM5xG8RxQHmH6Rs1fO/S4b4N
ACsB3vvwONkaOWsb5SvgwS5aMM1SQRH3p2YfIsfmo/vENC4N6q0euP7+l9ld8Q8cOHml/qvACu3c
mv4VQtj6Hzo652oV3maIJ6gtt43Gi5K3L9POz1+4ZyDSGajnHnur5tKAH1XDKQBjAro6YCE6BcXd
LyTjJpMJ5lgQ6obKw83+qNV5vmli6bVRU1SwKZ7sO2vDR3ovIESUzjBR36QEt5XVDaOEdi6Os3ln
97V+qbMt63pzVda/e2eS
--0000000000004e7fdb060c7c2791--

