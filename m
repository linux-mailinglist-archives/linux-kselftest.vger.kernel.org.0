Return-Path: <linux-kselftest+bounces-371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B776C7F2A8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 11:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B902B2195B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C862F2F;
	Tue, 21 Nov 2023 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPLe+9Bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D6F4
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 02:36:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so11461a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700562984; x=1701167784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gp/v5AFbBt9Ng8k/oCp31FjRW30MUFLcDPERh0LrzKY=;
        b=HPLe+9BfWbbK9HEcWfUzpo+UcodcVi9gWyqu0jCcBcRAY3Uz2xirY1jeqPDYnpIjf4
         OCcmm0Jf0scAhKmB5XF7UkxiyM/91kBOoxPgGrFAoX4pxeGZSCZkMfOi1gPxsy/6KQEG
         HGTxZafHM5PDQER5MW9w+uhARxBAOrZCI7BXN7BE/bGVRYsQTl3rIfVTWeCS9oZLJhxI
         gF/SvwMLvHV0EdwL7WYtRyoT57i4lulTqoUxrLTsrdJ4Q8L1ghd0MfzfwL8RTt3ndR0z
         5YCx10l4k4G1BEr1WvCmgVZMdDX2GgbyArhpt4pc6DhGTkI5WP84i4holXbQOMWazYZ1
         AyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562984; x=1701167784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp/v5AFbBt9Ng8k/oCp31FjRW30MUFLcDPERh0LrzKY=;
        b=tox/4lwYSSe6V/Q7LebGlQr6zY/XppoCTKfugH8wzbYwN1wPFpO79RAbqc70enO6T0
         zst0rwjrn7jIiEEo4wx77feCfoPdMSopEjjrWB5+5OQFMkHUgps4c9/mbUUuY2Ju0Ohi
         u37myovyGp7hwd5pGAUj3ZXu7Ui0ylkf8bdQwXbX2e3CgQQH72yfDq4B35Tdi5jUbizN
         fpSDDm+9M14ccK8uXUXzQX/YLAmqo79mRZdoL7hX75+S+kBV6k3zAYhWTpFWNcNxuWt1
         OflWnIuqIL5teGN9atVE/1Sb9ircWOFAk0RGfhG7MK59gbuw3/Aq2cWAHTZtPxkjtRnW
         JlMg==
X-Gm-Message-State: AOJu0Yx6bdl/2gTSxu9xWUthE8VS63UxuDMPK/wasyZuQTuglwmQg9Wl
	0NtUZo+Z2S2Y5Km2TYX9hA0siNIvv6tU97WxP+a+wg==
X-Google-Smtp-Source: AGHT+IFlfYxhc1wYiwZZD+5VzZiy6eFom+SNf0ddy/txlFD9FuUOH500t2rQeDi2yBvvLHFaya9UYf+ebVtWVdG1KFo=
X-Received: by 2002:a05:6402:1a32:b0:548:b26f:9980 with SMTP id
 be18-20020a0564021a3200b00548b26f9980mr223690edb.5.1700562983628; Tue, 21 Nov
 2023 02:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com> <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
From: David Gow <davidgow@google.com>
Date: Tue, 21 Nov 2023 18:36:10 +0800
Message-ID: <CABVgOSkRpL9KC4FDMrQ-g51b0_BB-=m71LzaQNG8UsqHJ7VrkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>, 
	Andy Whitcroft <apw@canonical.com>, "Theodore Ts'o" <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>, 
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009618c6060aa72c45"

--0000000000009618c6060aa72c45
Content-Type: text/plain; charset="UTF-8"

Thanks so much for doing this! I think everyone agrees that we need
_some_ way of documenting which tests to run, and I think this is our
best option.

In any case, this patch does a lot, and I'll comment on them
one-by-one. (It may be worth splitting this patch up into a few
separate bits, if only so that we can better separate the
uncontroversial bits from the open questions.)

On Thu, 16 Nov 2023 at 01:52, Nikolai Kondrashov
<Nikolai.Kondrashov@redhat.com> wrote:
>
> Introduce a new 'V:' ("Verify") field to MAINTAINERS. The field accepts
> a name of a test suite which is required to be executed for each
> contribution to the subsystem.

Yes -- this is exactly what I'd like. (As much as I'd love 'T' to have
been available. Alas...)

The other thing discussed at plumbers was to include this in the
'maintainer profile', but having it as a separate MAINTAINERS entry is
my preference, and is better for automation.

The question for what the tag actually contains brings us to...
>
> Each referenced test suite is expected to be documented in the new
> Documentation/process/tests.rst file, which must have enough structure
> (documented inside) for the tools to make use of it. Apart from basic
> data, each test can refer to its "superset" - a test suite which this
> one is a part of. The expected use is to describe both a large test
> suite and its subsets, so the former would also be accepted, if a
> subsystem requires only a subset.

I think this could work, but is a bit complicated.

My initial thought was to have this as a more free-form field, which
either contained a:
- Path to a command to run (e.g. tools/testing/kunit/run_checks.py)
- Path to a documentation file describing the test.
- URL to a page describing the test
- (Maybe) freeform text.

It's probably worth also looking at this proposal to auto-generate
similar documentation:
https://lore.kernel.org/linux-kselftest/cover.1689171160.git.mchehab@kernel.org/

The other question is how to handle outdated results when a new patch
revision is sent out. Personally, I think this is something we can
solve similarly to 'Reviewed-by', depending on the extent of the
changes and cost of the tests. I suspect for most automated tests,
this would mean never carrying the 'Tested-with' tag over, but if
testing it involved manually building and running kernels against 50
different hardware setups, I could imagine it making sense to not
re-do this if a new revision just changed a doc typo. If a URL is used
here, it could contain version info, too.

>
> Introduce a new tag, 'Tested-with:', documented in the
> Documentation/process/submitting-patches.rst file. The tag is expected
> to reference the documented test suites, similarly to the 'V:' field,
> and to certify that the submitter executed the test suite on the change,
> and that it passed.

I'm also 100% for this, though I'd considered it separately from the
MAINTAINERS change.

I think, in the ideal case, we want this to link to the results
somehow. kcidb would seem to be the obvious choice there.

Again, as a fallback, a plain text field would be useful to describe
cases where a patch was tested by some means other than a formal test
suite. This might not be ideal, but I'd still rather have people
describe that something "builds and boots on <x> hardware" than have
to guess if a patch was tested at all.

Of course, it'd then be up to maintainers to decide what they'd
accept: I'd expect that some would require there be a 'Tested-with'
header which links to valid results for the tests described in
MAINTAINERS.

>
> Make scripts/checkpatch.pl ensure any added V: fields reference
> documented test suites only, and output a warning if a change to a
> subsystem doesn't certify the required test suites were executed,
> if any.
>

I'd definitely want something like this to run at some point in the
patch-submission workflow. I think that, ultimately, we'll want to be
able to run some tests automatically (e.g., a git hook could run the
tests and add the 'Tested-with' line).

Personally, I'd like to require that all patches have a 'Tested-with'
field, even if there's not a corresponding 'V' MAINTAINERS entry, as
people should at least think of how something's tested, even if
there's not a formal 'test suite' for it. Though that seems a
longer-term goal


> If the test suite description includes a "Command", then checkpatch.pl
> will output it as the one executing the suite. The command should run
> with only the kernel tree and the regular developer environment set up.
> But, at the same time, could simply output instructions for installing
> any extra dependencies (or pull some automatically). The idea is to
> get the developer into feedback loop quicker and easier, so they have
> something to run and iterate on, even if it involves installing some
> more stuff first. Therefore it's a good idea to add such wrappers to the
> kernel tree proper and refer to them from the tests.rst.
>
> Extend scripts/get_maintainer.pl to support retrieving the V: fields,
> and scripts/parse-maintainers.pl to maintain their ordering.
>
> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> ---

The questions I think we need to answer to get this in are:
1. Do we want to split this up (and potentially land it
piece-by-piece), or is it more valuable to have a stricter, more
complete system from the get-go?
2. What format should the 'V' line take? If it is simply a test name,
do we use a doc as suggested (or one generated in part from some other
process), or something like a command name or URL? Can it just be
freeform text?
3. Should 'Tested-with' be a test name in the same format as 'V', a
URL to results (any URL, or just kcidb?), or freeform text? How does
this evolve with multiple versions of patches?
4. How should this be enforced? A warning (not an 'error') from
checkpatch? A separate script?

Personally, my gut feeling is that we should land the simplest, most
minimal version of this (the 'V' field, as freeform text) now, and
build on that as consensus and tooling permits. I'd probably also add
the 'Tested-with' or similar tag, as freeform text, too. I don't think
either of those would cause major problems if we needed to change or
restrict the format later; I imagine there won't be a huge need to
parse old commits for test data, and even if so, it wouldn't be too
hard to ignore any which don't conform to any stricter future
convention.

But I don't think there's anything fundamentally wrong with the full
plan as-is, so if everyone's happy with it, I'd not object to having
it.

Cheers,
-- David

--0000000000009618c6060aa72c45
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAq
IB8+6lHgjYlH3l7w5GObmRl/iEGqJKNCiDrN+bekZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzExMjExMDM2MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoXUNJNXhyXyoRaJmBbSg
GqRPt686O54xamh9ZUcaKhUbRO1tWX6b6SwnKGgxN7AUmdb9CBsPafYeTjoseY9gLZBbTIlxx1yF
koFY3/59W8BwT5EMbpqAWbJXCpAsXx1tDlmgG0/9L+uP7lDLlKQ5/i1RcLQBy/mGINosD+6iXpnS
fitRM1Zc8IURT3uK+PIVqBWXm44YPnBNyINbOg+eG1AYy5NZ8LQdDWUFO9ZtfTkaOlBEimdV0a0G
t66OeY+MC7edN8Xpfdi2FlLDRXoogVZ1aCLGpBw56txPfWKU6B/4F2sy2NFlECJzYR1RxfLDtckN
hvPsprjtb90mPzVufA==
--0000000000009618c6060aa72c45--

