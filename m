Return-Path: <linux-kselftest+bounces-26451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0CA3220C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1826E3A5371
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0E205E13;
	Wed, 12 Feb 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2anpmFO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B6205ADD
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352353; cv=none; b=O5Jru7eokb7ch0Xg57vnDgWJN+HvgRkGmqsFVQnfxzrqEp5MnsTWTYJ/z/PEfo66QcEnvJjfig2YOns+0uVZWPSB6rtb0yEkjsJycI10OHIcN4RKcGD+2m/zU3DpJQsuo55vJ3DUGPZl3EcarrZPVK1SPATulZOdbRYW6sXxyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352353; c=relaxed/simple;
	bh=wrZeDnoTOUaX3MWt7VTrG+emQeIpNJxC9TTW/F1FH2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOgAXeZgP0FcB1Pl+RlZCEfMXezuqDmD9EKK0Wo2HXCsCIl5MZ4yOzUEzccRFCAqLrH5+Iy+1tnr5Xuor2GQ6rbrXe1od+UvY/tuWrxWX1R9efCWe2k6LT6OUFqoYKtzD9pUEwOBhJf/ys5iGvK/YIO6PUu20CGr3oxjueGqApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2anpmFO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be8f28172dso391321885a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739352350; x=1739957150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrZeDnoTOUaX3MWt7VTrG+emQeIpNJxC9TTW/F1FH2k=;
        b=h2anpmFOISzLDF4MjOjAdnrsGpwurAVteB2cvg/2pb1rop//prgrtFNjtAcdfW03on
         uhjAdHO49MYdbJGhdQy3IJCz5p5Yb8FKtdkcnkrozRRhSV82CXLGCNqTDO2L7ATN+gi8
         oWRukA0sBbwb2c1UE7b+woq6wsTeJ94Hyd2R1jsl5xFG6rpS49+5snyP9yep2ygiZKT2
         pi6E4foewJLGz6sbOAo5CY0GYj1hcVuE0tMa8CFqjRpTwtsmjJssrXcQOgIwbDq6JHMv
         6XwAnsSb3CUSpts2u/TXTZ67yy1FflRVdYrHDMLPfdRtr2rfTlf8V02FtGwC0K0qTvDj
         V8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352350; x=1739957150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrZeDnoTOUaX3MWt7VTrG+emQeIpNJxC9TTW/F1FH2k=;
        b=fH2UvxtKTF1K4KYhGCM4uuwlsgAsoQdO6KRnHYWFysMwCHYSenpjf5agWs0S7VUbjY
         QltS7prXg6iwVzYF9B9pEBUEUTogeENUl59uge6arZQc4GLMNH0DSycilVy/4Kpv+H68
         zaBeH2mUDtL7XnnCVD39kUl96RfLSg58eJ4fvQMYW19vcE8ZVV66BcOkdkj7f4U34+dv
         o2+B/nNAroZsmM53BD/kQURzHLkTWANNsEn8gpqZkmDax5ZHrXPgoXu1w4aqvd8Ov1z7
         uub0YA0JcIcmqWpTZwxbjmEUcUsH53ljzbiRQN9BJhL+eQg8TBfkkrlDQJjplojm0Mt0
         JrTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+tEo//EBP5Thjk2Re7P7DbPSuEPiNZB24B1stjb66hCwQyl1wDt9kehWzLwTB1QlL2jnu1UklLzNXGrlzYko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsYIAMz2+qqtThcbfivL29ThU2ncLcvCYWu+Qok3LiXW6gJ/G
	YsU2/zXUZ2w4MeoCriR8mnQMbc3ExumfpvyK+62jWbE2n1C1DNgJfCcfXOpx9ILX5rxZLv3dn58
	oxFD/C96nK134P+/MW2WSAVN/WlWgtO2uqrwN
X-Gm-Gg: ASbGncu3XBCbQtbqVsBvXTVvKJNG6UxgJvA5Ji7u/5SRl3Mj8eKSyEyxGTTOZgwQPKE
	Gd9DWMf8f+adkKAZMJuUeeyiFL3xt3bSWe53B+puhsa37zV1ehah0hUIxAmWIT0L23ce+heEkxQ
	==
X-Google-Smtp-Source: AGHT+IHNw5Y6ZLhPcYI0G0gzS0F6tvxdjsua0+vnRUKJTjhBZmFE1ueNugZ0Ss95vVCX9IcOJe/oYyu1umapjfUpgxw=
X-Received: by 2002:ad4:5ba7:0:b0:6e4:3e5e:56d5 with SMTP id
 6a1803df08f44-6e46ed77e88mr37961816d6.5.1739352348834; Wed, 12 Feb 2025
 01:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
 <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
 <87bjvers3u.fsf@prevas.dk> <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
 <87y0yeqafu.fsf@prevas.dk> <CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
 <87h650ri08.fsf@prevas.dk>
In-Reply-To: <87h650ri08.fsf@prevas.dk>
From: David Gow <davidgow@google.com>
Date: Wed, 12 Feb 2025 17:25:35 +0800
X-Gm-Features: AWEUYZldKbrN14Agxv1vRTC_XGHvqdcjfs3enScjV9pDCmX3JjPjR-hnndI-xPY
Message-ID: <CABVgOSmYWfBPod8Dq=vdYvmOUE31Nft1Ad-0nRHZ9J2W_f-q_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Tamir Duberstein <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000002641c062dee87d2"

--00000000000002641c062dee87d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 at 16:40, Rasmus Villemoes <linux@rasmusvillemoes.dk> w=
rote:
>
> On Tue, Feb 11 2025, David Gow <davidgow@google.com> wrote:
>
> > On Mon, 10 Feb 2025 at 19:57, Rasmus Villemoes <linux@rasmusvillemoes.d=
k> wrote:
> >>
> >> On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >>
> >> > On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
> >> > <linux@rasmusvillemoes.dk> wrote:
> >> >>
> >> >> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >> >>
> >> >>
> >> >> I'll have to see the actual code, of course. In general, I find rea=
ding
> >> >> code using those KUNIT macros quite hard, because I'm not familiar =
with
> >> >> those macros and when I try to look up what they do they turn out t=
o be
> >> >> defined in terms of other KUNIT macros 10 levels deep.
> >> >>
> >> >> But that still leaves a few points. First, I really like that "388 =
test
> >> >> cases passed" tally or some other free-form summary (so that I can =
see
> >> >> that I properly hooked up, compiled, and ran a new testcase inside
> >> >> test_number(), so any kind of aggregation on those top-level test_*=
 is
> >> >> too coarse).
> >> >
> >> > This one I'm not sure how to address. What you're calling test cases
> >> > here would typically be referred to as assertions, and I'm not aware
> >> > of a way to report a count of assertions.
> >> >
> >>
> >> I'm not sure that's accurate.
> >>
> >> The thing is, each of the current test() instances results in four
> >> different tests being done, which is roughly why we end up at the 4*97
> >> =3D=3D 388, but each of those tests has several assertions being done =
-
> >> depending on which variant of the test we're doing (i.e. the buffer
> >> length used or if we're passing it through kasprintf), we may do only
> >> some of those assertions, and we do an early return in case one of tho=
se
> >> assertions fail (because it wouldn't be safe to do the following
> >> assertions, and the test as such has failed already). So there are far
> >> more assertions than those 388.
> >>
> >> OTOH, that the number reported is 388 is more a consequence of the
> >> implementation than anything explicitly designed. I can certainly live
> >> with 388 being replaced by 97, i.e. that each current test() invocatio=
n
> >> would count as one KUNIT case, as that would still allow me to detect =
a
> >> PEBKAC when I've added a new test() instance and failed to actually ru=
n
> >> that.
> >
> > It'd be possible to split things up further into tests, at the cost of
> > it being a more extensive refactoring, if having the more granular
> > count tracked by KUnit were desired.
>
> I think the problem is that kunit is simply not a good framework to do
> these kinds of tests in, and certainly it's very hard to retrofit kunit
> after the fact.
>

I think I'd have to disagree on the whole (though I'm admittedly
biased in KUnit's favour), but I can definitely see that the printf
tests do provide some unique challenges, and that either way, a port
would require either some code churn or bloat, a need to reinterpret
things (such as what unit a 'test' is), or both.

Ultimately, I don't want to force KUnit on anyone if it's going to
make things more difficult, so it's ultimately up to you. My personal
feeling is that this could work well as a KUnit test, but due to the
churn involved, it may not be worth it if no-one wants to take
advantage of the tooling.

> It'd also be possible to make
> > these more explicitly data driven via a parameterised test (so each
> > input/output pair is listed in an array, and automatically gets
> > converted to a KUnit subtest).
>
> So that "array of input/output" very much doesn't work for these
> specific tests: We really want the format string/varargs to be checked
> by the compiler, and besides, there's no way to store the necessary
> varargs and generate a call from those in an array. Moreover, we verify a
> lot more than just that the correct string is produced; it's also a
> matter of the right return value regardless of the passed buffer size, et=
c.

Ah, that makes sense. I suspect with enough work and some friendly
compiler developers, this could be make to work, but it definitely
doesn't seem worth the effort to me.

> That's also why is nigh impossible to simply change __test() into
> (another) macro that expands to something that defines an individual
> struct kunit_case, because the framework is really built around the
> notion that each case can be represented by a void function call and the
> name of the test is the stringification of the function name.

Yeah: it may be possible to do something with KUnit's parameter
generating functions (you can have a function which generates a void*
test context, as well as a string test name: this could be a struct
with a format string and a va_list), but it's definitely getting
complicated.

> So I don't mind the conversion to kunit if that really helps other
> people, as long as the basic functionality is still present and doesn't
> impede future extensions - and certainly I don't want to end up in a
> situation where somebody adds a new %p extension but cannot really add a
> test for it because kunit makes that hard.
>
> But I hope you all agree that it doesn't make much _sense_ to consider
> test_number() and test_string() and so on individual "test cases"; the
> atomic units of test being done in the printf suite is each invocation
> of the __test() function, with one specific format string/varargs
> combination.

I think this is -- to some extent -- a matter of interpretation. I
don't think it's wrong to use KUnit test cases to refer to a "thing
being tested" (e.g., a specific format specifier) rather than an
"individual invocation": lots of KUnit tests already group very
related things together. But given the way there are several "checks"
within each __test() invocation mirrors this already, I understand why
it'd make sense to keep that as the "test case".

I don't have any immediate plans personally to work on the
printf/scanf code, so your opinion here definitely matters more than
mine. But if this does end up as a KUnit test, I'll definitely keep an
eye on it as part of my regular KUnit test runs.

Cheers,
-- David

>
> Rasmus

--00000000000002641c062dee87d2
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
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgb1zoE/wizLmGoZEFHGUQJzGXwMBH
h+l1jjmgf8uy9ycwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjEyMDkyNTUwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAC6lMU/ZmndCSHYX+A+wlv3xrji1Axo4q+aWIVRAOwT+/OEw
FJtnsk85e8g3IsATNVHtlMRq7HRQZJ1LEpA0KVDIfrBlWpHEyungq7lFcCBINZD9Fko/zJ8bEaeM
gYeIg4eciE+igmTFlI7e1YZPR0To0O07CaiCgJiXbV0fSa5qNZaFUV1hIbCnhMIxDa0f2JPLBGfR
TT54EaC3tl9XIIn8jM4Ydy0jWFwo8DUOmMot/Ao7wpPiihmS8XKcJn3HMJpBI1MzzOwIKRUqkXh8
AtgowBr+I5VbyRQwS9+Upwl1WI+5weHpHPs1MMiBkYObGfpPUccgWsmTUdILEtEoyX8=
--00000000000002641c062dee87d2--

