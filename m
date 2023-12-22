Return-Path: <linux-kselftest+bounces-2373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2681CB28
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 15:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284D21F21D2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93D1C693;
	Fri, 22 Dec 2023 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYOWNLup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9201C28C
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so58755e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703254383; x=1703859183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MSCCn731zo9UoSqk33bfdXrRPHvsgm5pqpkKkKW2+yc=;
        b=FYOWNLupn8yUoH1zKpXeIh69h0IlXP9/R33xej3Uc72zRu0xGMqeBIuC8tsCUUnMis
         QeRVMBM74D+JD1j/KVE5X3Ec7cL1yDN2zvmxVtdbWo8bO2UfdjpflmSZF3X/CH0D44av
         t41BzaBOGnjxBt4eumo2BokdE0V01sVF0RIUNDcAgl5QRmYFOyuin/TuHtojO/5qm3XD
         z4LQZdZEVhJcFeoCKX+8U5RfOhHgyNGDZiq6JQOXING2HZK6trsdyehxkanDYW4m+uTB
         Nt6z060A0J4l/s+R8whbg1l3/FkZ3NqMr3jJMwuVP/fv+oMGz1dJvzFKaQskOrboxPRn
         m0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254383; x=1703859183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSCCn731zo9UoSqk33bfdXrRPHvsgm5pqpkKkKW2+yc=;
        b=FRHZPrM1m0tjdq+E6NZ2sGuGWWw0ivuAPvs8pWeiVkeeDz0WiOC3iKqTU1ixENegv9
         VDbaHb90vbeTQ82YS7QxlGZDxfu5Z6GSbjnue167mGyZMZ6IQsu1xjMmMtMaEXB1nMZX
         jbwo/LXCF1ESgntxOLO9wpl8sgrdP+/S3amIs6p/w156vzxl5oJE8TQcNA27FDisJVNi
         /UyQfBa+pSRr+IFr9s1tpGgXwNlweQt5cNfbbJL3sMsx1RT57rU6sS1h1hGyUv/vBYAW
         VBN/+KRLoNB69JYKwrnDDh8eFezgNjS4ptEy7FokPjVNp+qQVVWZqodMHMvBDtA6nhgE
         v2jQ==
X-Gm-Message-State: AOJu0YxLNTcg4VTpzBKLWMTs2cMf+lAxhhVa9TWvYNtthGyHxxwBedmP
	N6gy2DZ1PqsZJHOn1kY2MUTUlxpfNQIzvSKHJy5GKt82nSpk
X-Google-Smtp-Source: AGHT+IFcMy1+oVuuHIE+e5KhBTlsTnp0EsiQUCMsYi16qfjRRFioxerV7yS/mezA5uOilIRCFSyU4nI7xocnwp03og8=
X-Received: by 2002:a05:600c:229a:b0:40d:400c:1b1f with SMTP id
 26-20020a05600c229a00b0040d400c1b1fmr90933wmf.5.1703254382865; Fri, 22 Dec
 2023 06:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
 <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
 <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
 <CABVgOSkrhEYXvzjtWfdxmKVGZwGnJTKwbd9+kBSRWxbOfyaRUA@mail.gmail.com> <2a508793563c46116ef8ef274a9fa3b5675cd7b3.camel@sipsolutions.net>
In-Reply-To: <2a508793563c46116ef8ef274a9fa3b5675cd7b3.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Dec 2023 22:12:51 +0800
Message-ID: <CABVgOS=vZzDdr0xxqUgYoZ39i3ADdwKnRyp4hXOSLGwAU0eN_g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, benjamin@sipsolutions.net, 
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Brendan Higgins <brendanhiggins@google.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007a7936060d19d0d9"

--0000000000007a7936060d19d0d9
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 18:09, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> Thanks for taking a look!
>
> On Fri, 2023-12-22 at 18:02 +0800, David Gow wrote:
> > The two initial KUnit patches look fine, modulo a couple of minor docs
> > issues and checkpatch warnings.
>
> I can run checkpatch (even if I can't always take it seriously), but do
> you want to comment more specifically wrt. the docs?
>

Sorry, the 'docs' issue was just the initial comment on the
include/linux/skbuff.h file in patch 2, which could have been more
specific to skbuff and resource management.
The actual kerneldoc comments seem fine to me.



> > They apply cleanly, and I doubt
> > there's much chance of there being a merge conflict for 6.8 -- there
> > are no other changes to the parameterised test macros, and the skb
> > stuff is in its own file.
>
> Right.
>
> > The remaining patches don't apply on top of the kunit branch as-is.
>
> Oh, OK. That makes some sense though, we've had a number of changes in
> the stack this cycle before. I somehow thought the tests were likely
> standalone, but apparently not.
>

I managed to get this to apply locally. The only real changes are to
net/mac80211/ieee80211_i.h  so it may be possible to port this across
to the kselftest/kunit branch if you want, but it doesn't apply
cleanly as-is.

Also, there are a couple of cfg80211 failures:
---
KTAP version 1
1..1
   KTAP version 1
   # Subtest: cfg80211-inform-bss
   # module: cfg80211_tests
   1..2
platform regulatory.0: Direct firmware load for regulatory.db failed
with error -2
cfg80211: failed to load regulatory.db
   ok 1 test_inform_bss_ssid_only
       KTAP version 1
       # Subtest: test_inform_bss_ml_sta
   # test_inform_bss_ml_sta: EXPECTATION FAILED at net/wireless/tests/scan.c:592
   Expected ies->len == 6 + 2 + sizeof(rnr) + 2 + 155 +
mle_basic_common_info.var_len + 5, but
       ies->len == 185 (0xb9)
       6 + 2 + sizeof(rnr) + 2 + 155 + mle_basic_common_info.var_len +
5 == 203 (0xcb)
       not ok 1 no_mld_id
   # test_inform_bss_ml_sta: EXPECTATION FAILED at net/wireless/tests/scan.c:588
   Expected ies->len == 6 + 2 + sizeof(rnr) + 2 + 160 + 2 + 165 +
mle_basic_common_info.var_len + 5, but
       ies->len == 357 (0x165)
       6 + 2 + sizeof(rnr) + 2 + 160 + 2 + 165 +
mle_basic_common_info.var_len + 5 == 376 (0x178)
       not ok 2 mld_id_eq_1
   # test_inform_bss_ml_sta: pass:0 fail:2 skip:0 total:2
   not ok 2 test_inform_bss_ml_sta
# cfg80211-inform-bss: pass:1 fail:1 skip:0 total:2
# Totals: pass:1 fail:2 skip:0 total:3
not ok 1 cfg80211-inform-bss
---

If the failures are because of the missing 'regulatory.db' file, would
it make more sense to have that SKIP the tests instead? (And, if you
actually want to check that it loads correctly, have that be its own,
separate test?)

> > I
> > haven't had a chance to review them properly yet; the initial glance I
> > had didn't show any serious issues (though I think checkpatch
> > suggested some things to 'check').
>
> I can check.

Yeah, it mostly looks like really minor style 'suggestions' around
indenting and putting blank lines in, along with a couple of "you're
reusing a value in a macro, double check this" ones.. I'll paste them
below (but warning, they're a bit verbose).

CHECK: Please use a blank line after function/struct/union/enum declarations
#1142: FILE: net/wireless/tests/scan.c:225:
+};
+KUNIT_ARRAY_PARAM_DESC(gen_new_ie, gen_new_ie_cases, desc)

CHECK: Please use a blank line after function/struct/union/enum declarations
#1330: FILE: net/wireless/tests/scan.c:413:
+};
+KUNIT_ARRAY_PARAM_DESC(inform_bss_ml_sta, inform_bss_ml_sta_cases, desc)

CHECK: Alignment should match open parenthesis
#1489: FILE: net/wireless/tests/scan.c:572:
+       KUNIT_EXPECT_EQ(test, link_bss->beacon_interval,
+                             le16_to_cpu(sta_prof.beacon_int));

CHECK: Alignment should match open parenthesis
#1491: FILE: net/wireless/tests/scan.c:574:
+       KUNIT_EXPECT_EQ(test, link_bss->capability,
+                             le16_to_cpu(sta_prof.capabilities));

CHECK: Macro argument reuse '_freq' - possible side-effects?
#1620: FILE: net/wireless/tests/util.h:10:
+#define CHAN2G(_freq)  { \
+       .band = NL80211_BAND_2GHZ, \
+       .center_freq = (_freq), \
+       .hw_value = (_freq), \
+}

CHECK: Macro argument reuse 'test' - possible side-effects?
#1653: FILE: net/wireless/tests/util.h:43:
+#define T_WIPHY(test, ctx) ({                                          \
+               struct wiphy *__wiphy =                                 \
+                       kunit_alloc_resource(test, t_wiphy_init,        \
+                                            t_wiphy_exit,              \
+                                            GFP_KERNEL, &(ctx));       \
+                                                                       \
+               KUNIT_ASSERT_NOT_NULL(test, __wiphy);                   \
+               __wiphy;                                                \
+       })




>
> > So (once those small issues are finished), I'm okay with the first two
> > patches going in via either tree. The remaining ones are probably best
> > done via the wireless tree, as they seem to depend on some existing
> > patches there, so maybe it makes sense to push everything via
> > wireless.
>
> If not through wireless I doubt we'll get it synchronized for 6.8,
> though of course it's also not needed for 6.8 to have the extra unit
> tests :)
>
> I'll let Shuah decide.
>

I think you should be able to rebase on top of the kunit tree if Shuah
prefers that -- it's a reasonably straightforward conflict. But I
think we'd want to make sure that the various issues above are fixed
(and I'd not want the tests to fail out-of-the-box on the kunit.py UML
setup, though having them depend on !UML or 'SKIP' should be fine).

Cheers,
-- David

--0000000000007a7936060d19d0d9
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHOBX7j6YmdTMbtcPLp
3a4wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA4MTUw
MjQyNDNaFw0yNDAyMTEwMjQyNDNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnYKS3ueVXUlVatkXVQgk8pbgZH4/s
KBKSGW9Z8e4hylAI35vqFf5f5D4U5KhUYUyG0+AYhurwEiUyZUhGcLqRNmSroohx9nbZjXDXjkVV
LXBAr7xaCU3DDQcA1SaxmALxBC7u4zlcVHfUKope2JNJ2xn5kU0Z/kr01tZuJD5/jn+2hp68jdym
tbFd3zzOJmtG6hb4ULJNXSi1qkjtZp6SyDLEsliQGRuI5AIha7GQPeSNsFmIpi+V5UxhrznuAv0y
Uxd27MtO+/mgSMpLmUb4vuSjy2zuftatzVYvFG00pfHldrnJ1od+kW8lAl6gyahVgMp+j3GAlO2M
oGCkihK9AgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJO3Y8Jq
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD+
WKrDFwDyu5+H1+FjzZggUrB1zgjGVwqso2ioUUPH+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjIxNDEzMDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIWHmppYj9PmuP+CZycUk
Dk3aJxslwMwmDEqHmjiwsYt8gHQjqQVLh5ZnIs5s5o4UBzOYtPFCu1mYmMFMQeskZjFZnvIYke9s
1xZNsaBqUwKqkGyUbmqu8GxlXaqRsUnc/ua4xRigye2u+MIzLtsPDgWPvgR/qjG1KqLXOvNjk5WY
9Q83zrYzyYbh+eEl4Nb+dPCsG6D0tsU5vlYTQNNzwH7V2Iy3sPe660P5mrkTMpLL0vNS9PYHvSkM
YINkdNORTdaFpDSeXUJEyMBfFvgApwrRXnyvkuTrnpNTcZIof4MQcp9eOu41wfEBZnY+D2yzpjc3
sBdsY835Hob+xuhVRw==
--0000000000007a7936060d19d0d9--

