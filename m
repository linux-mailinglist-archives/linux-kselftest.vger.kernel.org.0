Return-Path: <linux-kselftest+bounces-15996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493D95AD41
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C10284882
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B957136350;
	Thu, 22 Aug 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QjhCYz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70A249F9
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307259; cv=none; b=YFF8XYa94QMz56WEeVUGBN5w8oW7Har8H1574wyBksq2NKAiYAVHsHS0C+GEl7Iwp7t0FM78KNY/Bsd/LUsnUQcnDbJR1JoC6ItJAgMgEgEF3OnEoQoa6qQtfY4pHfAKMbvpCSBIzUEtBabu+uQ4SIX6e05RVMvuuALlq60Lbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307259; c=relaxed/simple;
	bh=p2UjyKzVAm2J+nlW58eXRm8vSNTOgfov4H58hZwTjf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PagUDQsadF2k338ZG37hm5VY8tknhyX7kL1QadbfJu+f7YfGE01C8umPGJYsc21JpQKYyTS3vTzm4wU4f/pJR6ffw7mMY3deD7VFeAm/EzVLDWpMyO3pPJTgFw5beivfNkNa6581ip7LVnuSvZBbDB4sCzZCwzDGgvQ2jKcfEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QjhCYz9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44ff50affc5so2429291cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724307256; x=1724912056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=men7b6xXIDpdEnK0m1Mcv+oefdkSASHhy3vIrbTaTZo=;
        b=4QjhCYz9KCxGYt2OyXCWRAWe8Dhk6L+GuZNwI3e0LFE23RjD9k9FMo/+Ga4WDMyg5H
         db9wSW30NObBSmnb3YKAA09L+dkURfgbacD2t/bFbAKEK1oEdfJJDIUeosRMyrHt8Ofb
         /Iv73RJqEu25+g8kHdnBHl89iqECmKMAIF4laIzuRUTGlmwAYwOa2zOjtX6bNSBWg3Im
         4GCiiJ16s9bOtHx77DiT0iHE4oRX38hjmucoeCkUSRXjtddkCWPzNDjulTFVO6Y93vLo
         zT0/NFFE2yUqgk0Pb2MRb897hKzHJ8hQUO4oIwHaRCPeqMkRrQux21QFTPsHSBdofamn
         BB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307256; x=1724912056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=men7b6xXIDpdEnK0m1Mcv+oefdkSASHhy3vIrbTaTZo=;
        b=A9NlsVarrnt8+IuFUd0HXrSgAvprkC8V8yqBzibALrXYQqCwPlcS2f+kV8hvAMTUFY
         sOkZkXtrTLdemO1u3PCqbtOJfhszzzj0O9Cu1Cws57/1Tf0SkpBs/lM+cmp4JrRHI5o5
         p31CT1E4pLpYdPaffx78/9kwcCMlVrMF2jKL2tTI3SHZAtTWC/GPdYqvtzwiOqR+9bRH
         EphkL3Kn2tVqzZT6+onQMJUWjlcgu8ihfgIQblYt2Ig6VgxKByn/zZQwAvbGnF04twYh
         k8UWX99mDn0/uvzjbZt1jn43HLETSTJOQixCsmMH8Ew5VHXVlZXp7qQF1vHyXlX7Ku6Z
         lc7g==
X-Gm-Message-State: AOJu0YyjJyN5jnyqL4FrQdhCpR+ylu4h40RIprARjPmMfQJ8AN1r0zH6
	qGYetmWLePQvDvHf5Z4yUHaGwCzauMi74GiQrinXQfBROAMz/5vn6/WirII8LiewBzmNI9+5Xan
	cqMXy2jHP3ms1OOY50QPFt7sSxrU2nZrr27eQvpfZCy6iIlmhsHSc
X-Google-Smtp-Source: AGHT+IEFP6IxZjI6ef/fqRIlume1VA3FUd8xTaI06tPBiOwxOWdW9uh11xFAoxit3r+jnbLI+Ah/L5OVFaJpMC2aRkE=
X-Received: by 2002:a05:6214:43c8:b0:6b5:58e8:8f0c with SMTP id
 6a1803df08f44-6c155d58af2mr62818026d6.7.1724307256270; Wed, 21 Aug 2024
 23:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-5-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-5-michal.wajdeczko@intel.com>
From: David Gow <davidgow@google.com>
Date: Thu, 22 Aug 2024 14:14:04 +0800
Message-ID: <CABVgOSmhtY9=m+F7gcCLk_yxXrVL+pv_4JH_uU6akYhwN9Eh3w@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Add example with alternate function
 redirection method
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Daniel Latypov <dlatypov@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000868bf106203f9192"

--000000000000868bf106203f9192
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 22:43, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its
> usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
> DECLARE_IF_KUNIT macro could be helpful in declaring test data in
> the non-test data structures.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---

This looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


>  lib/kunit/kunit-example-test.c | 63 ++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 3056d6bc705d..120e08d8899b 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -6,8 +6,10 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <linux/workqueue.h>
>  #include <kunit/test.h>
>  #include <kunit/static_stub.h>
> +#include <kunit/visibility.h>
>
>  /*
>   * This is the most fundamental element of KUnit, the test case. A test case
> @@ -221,6 +223,66 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>  }
>
> +/* This could be a location of various fixed stub functions. */
> +static struct {
> +       DECLARE_IF_KUNIT(int (*add_two)(int i));
> +} stubs;
> +
> +/* This is a function we'll replace with stubs. */
> +static int add_two(int i)
> +{
> +       /* This will trigger the stub if active. */
> +       KUNIT_STATIC_STUB_REDIRECT(add_two, i);
> +       KUNIT_FIXED_STUB_REDIRECT(stubs.add_two, i);
> +
> +       return i + 2;
> +}
> +
> +struct add_two_async_work {
> +       struct work_struct work;
> +       int param;
> +       int result;
> +};
> +
> +static void add_two_async_func(struct work_struct *work)
> +{
> +       struct add_two_async_work *w = container_of(work, typeof(*w), work);
> +
> +       w->result = add_two(w->param);
> +}
> +
> +static int add_two_async(int i)
> +{
> +       struct add_two_async_work w = { .param = i };
> +
> +       INIT_WORK_ONSTACK(&w.work, add_two_async_func);
> +       schedule_work(&w.work);
> +       flush_work(&w.work);
> +       destroy_work_on_stack(&w.work);
> +
> +       return w.result;
> +}
> +
> +/*
> + */
> +static void example_fixed_stub_test(struct kunit *test)
> +{
> +       /* static stub redirection works only for KUnit thread */
> +       kunit_activate_static_stub(test, add_two, subtract_one);
> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> +       KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
> +                           "stub shouldn't be active outside KUnit thread!");
> +       kunit_deactivate_static_stub(test, add_two);
> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> +
> +       /* fixed stub redirection works for KUnit and other threads */
> +       kunit_activate_fixed_stub(test, stubs.add_two, subtract_one);
> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> +       KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
> +       kunit_deactivate_fixed_stub(test, stubs.add_two);
> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> +}
> +
>  static const struct example_param {
>         int value;
>  } example_params_array[] = {
> @@ -294,6 +356,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
> +       KUNIT_CASE(example_fixed_stub_test),
>         KUNIT_CASE(example_priv_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_SLOW(example_slow_test),
> --
> 2.43.0
>

--000000000000868bf106203f9192
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgP8XdLak/pJkVMoHMfz7q2LrfVi7R
OJwSrt0ti2ZaYSEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
ODIyMDYxNDE2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAF6ijIGwrL6P3DLKVkVhBNL5AYAdXx05vP+bPobDuRST9dJC
z51UmuRQCqNfZpdULKIz35aOZ15zSvhOgtIt/7RZlTSP+bjDXpNLs7g8wVG51FmcMh+58ZIqbv8G
MKjWeyKCtl4j9sDqLP9bdfm9JEVY0JJGJyXjPV6YERJn8+99hJa/cMab+TfDoXML5b0TkFcwUl1j
dlnpFEXX2LSeT5wRYgjbL5m54Dr5LmYozZaXVJM+U2YjE9xqXMnTtcwGg+3Sz4LbiNjsRuoEKI2G
L/eDhiHxZLJSCTjt0o/j2Frk99ulhoTX4SZ3AaQmZu7A3XyQOXHGs8hzRtxmcBAK2as=
--000000000000868bf106203f9192--

