Return-Path: <linux-kselftest+bounces-2709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2E82688E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 08:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D91F21CB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA2849C;
	Mon,  8 Jan 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZTi/P5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A4B657
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jan 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557a615108eso3380a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 07 Jan 2024 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704698870; x=1705303670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h3jK4NFDggVvNQOELANdw9OSDeVXrYUDxm7bInuJzRw=;
        b=bZTi/P5P7XgQDiekL+Wncq1XVFixM8OMfWGRN1bdgVEX6+vWgU0HE7w/AiMucZbhJA
         dc7w+hL9rGFQYOntGhuekojURwOd5RGyp9Ggokwd1gJWqj9r4a29VZ8huRE6sZgLorT5
         WY9SHnkw0RZDsPAOJyAuAUqcA9iQ66gdC6feaD46F6DltYfwH2xy7FYyQwV4L560ethN
         DTSjxv4U1ZbE6LuydoscFe1EsZPuem5p25pwQaEYnWd82pigO2icTwKwBHDD2H/V9tz7
         bfpjS6we42Kg0d/aNz/vR0EDfdGSIjQBBKF8FyQItc/EJmKaKn+wIaCkYMUBbvIwzzke
         HKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704698870; x=1705303670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3jK4NFDggVvNQOELANdw9OSDeVXrYUDxm7bInuJzRw=;
        b=VZCqruOo8EIDnZlDIsQrY+PkoyAC2B8CPMXWt97Qxpmts6GaxK9mrGrQ3Bo1qnIwgf
         jLplcCrTAIAm8+Wvb/xkZDYJty+fbabvW47pwfLBNllGXTnJSEGWT7Qs7WSKqSBKtIts
         +e/ZRyklTLNfS8THMphQDgBpdTRYx0k4PbzqOE+/HnZhQMpr5HkERyK7+tRhc1bhorQI
         JTi0qKAUl80i0LVBerJ3fYp/v2hT3j9HtavV3K8OTnIiU3cvB9G5YsKjcP+FqTU0CZCT
         JIUj+nJtw6FIa/Jlv3jXhQx7faVmhOBw7+gNqGWxHaumv7q/523nJ/X1cORr2QCUnWyh
         hIZQ==
X-Gm-Message-State: AOJu0YxemdCJXvu5ARSMXZG2WRI80myuZhiATeanZyBAaz/TY0XgHq3B
	gT+h+u0CRLCGCSV7BlKZkpCQdtxAfk8cRVbrDWfGdQbQxdfq
X-Google-Smtp-Source: AGHT+IGo8qYamOBr/SIC/RUrheMOYr/AMLjM0qBOsfKYXZ4g5n/M6cTlzmAE+bvOFfU+9VeZuB6dq8Adlr8mGNPF4jQ=
X-Received: by 2002:a50:8a93:0:b0:557:15d:b784 with SMTP id
 j19-20020a508a93000000b00557015db784mr204034edj.2.1704698869895; Sun, 07 Jan
 2024 23:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206150729.54604-1-marpagan@redhat.com>
In-Reply-To: <20231206150729.54604-1-marpagan@redhat.com>
From: David Gow <davidgow@google.com>
Date: Mon, 8 Jan 2024 15:27:37 +0800
Message-ID: <CABVgOSnbBzjcb_zt=YJ8p8Rm97s2ZYp=YvjThB_NCZD9BJQaSg@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: run test suites only after module
 initialization completes
To: Marco Pagani <marpagan@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Rae Moar <rmoar@google.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009d2484060e6a22b4"

--0000000000009d2484060e6a22b4
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 23:07, Marco Pagani <marpagan@redhat.com> wrote:
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
> happened during the loading phase of test suites built and executed as
> loadable modules. However, it also introduced a problematic side effect
> that causes test suites modules to crash when they attempt to register
> fake devices.
>
> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
> MODULE_STATE_COMING states before reaching the normal operating state
> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
> MODULE_STATE_GOING before being released. However, if the loading
> function load_module() fails between complete_formation() and
> do_init_module(), the module goes directly from MODULE_STATE_COMING to
> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
>
> This behavior was causing kunit_module_exit() to be called without
> having first executed kunit_module_init(). Since kunit_module_exit() is
> responsible for freeing the memory allocated by kunit_module_init()
> through kunit_filter_suites(), this behavior was resulting in a
> wild-memory-access bug.
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed this issue by running the tests when the
> module is still in MODULE_STATE_COMING. However, modules in that state
> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
> module attempts to register a fake device, it will inevitably crash.
>
> This patch proposes a different approach to fix the original
> wild-memory-access bug while restoring the normal module execution flow
> by making kunit_module_exit() able to detect if kunit_module_init() has
> previously initialized the tests suite set. In this way, test modules
> can once again register fake devices without crashing.
>
> This behavior is achieved by checking whether mod->kunit_suites is a
> virtual or direct mapping address. If it is a virtual address, then
> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
> pointing to the original address that was set when looking up the
> .kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
>
> v3:
> - add a comment to clarify why the start address is checked
> v2:
> - add include <linux/mm.h>
>
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Sorry for the delay here: there are enough subtleties here that I
wanted to double check some things.

I keep feeling that there has to be a nicer way of doing this, but I
can't think of one, so let's go with this, since it's fixing a real
issue.

I'm a little hesitant about our use of the suite_set.start address as
an 'is initialised' flag, and depending on it being reallocated via
kunit_filter_suites(), but since we already depend on that (by always
using kunit_free_suite_set()), I'm okay with it.

My only request (other than this needing a rebase, probably on top of
6.8) would be to add a comment in kunit_filter_suites() noting that it
must return a virtual address. That's probably something we should've
done a while ago, but I can just see this requirement getting
forgotten.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 7aceb07a1af9..3263e0d5e0f6 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -16,6 +16,7 @@
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> +#include <linux/mm.h>
>
>  #include "debugfs.h"
>  #include "hooks-impl.h"
> @@ -775,12 +776,19 @@ static void kunit_module_exit(struct module *mod)
>         };
>         const char *action = kunit_action();
>
> +       /*
> +        * Check if the start address is a valid virtual address to detect
> +        * if the module load sequence has failed and the suite set has not
> +        * been initialized and filtered.
> +        */
> +       if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +               return;
> +
>         if (!action)
>                 __kunit_test_suites_exit(mod->kunit_suites,
>                                          mod->num_kunit_suites);
>
> -       if (suite_set.start)
> -               kunit_free_suite_set(suite_set);
> +       kunit_free_suite_set(suite_set);
>  }
>
>  static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
> @@ -790,12 +798,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>
>         switch (val) {
>         case MODULE_STATE_LIVE:
> +               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_GOING:
>                 kunit_module_exit(mod);
>                 break;
>         case MODULE_STATE_COMING:
> -               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_UNFORMED:
>                 break;
>
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> --
> 2.43.0
>

--0000000000009d2484060e6a22b4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIBiYDyCC/O89ptU6ntT70LtGso8A7nzhLj2fqsxf1IpSMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEwODA3Mjc1MFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAkZ5lu
9MZY53R0aUdPmlanDJnrqB3PJdfG0OygtakjXPRt5Mzaajv14/QVg8A4iiSsaRYV4cg6vuKWT593
fASVidbtzF/rN2J3glPR39Lbtb6Ye6TURS4n3GtQhm7S8Hd/LZaNcHPKMmWffnhTGtDnikTC5ZIU
3qFXic3dDpQ84O4XZfShVlsoUeltjRspFjargAMbI7VAIjBKKIiSR7IPFmRMACoRbObIDhlJUcOA
SaiO3BgAmYNzFGgYcyJP15sOHdoM+CwN3Vg0wbr7JNK6dAqf7XTFtBG8q1q369qR2Gkuhqpxb83g
d0qAac+3mu2LExo1NWC+UvcGSWK3iUOs
--0000000000009d2484060e6a22b4--

