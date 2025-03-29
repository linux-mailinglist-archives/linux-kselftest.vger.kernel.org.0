Return-Path: <linux-kselftest+bounces-29910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D774AA75513
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 09:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D198C18939D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5141A315A;
	Sat, 29 Mar 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Tny+8gs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E01B4153
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743235459; cv=none; b=ujbvV5xIUzo6N8vOFI4fKc6trJGkeB3N9Chw5mGxrJE9n/h34pSvIgVHLRNTL/93HtN3uNPlyokOH1eBqO3+eXMSgy3kvna8HlAfg4HFUH3ptvHd/9Y6u3VW9r26yUdbMsLhXLoiMR0svUvTp/y+Nkr1IcY30B9p1ofJ7SS2plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743235459; c=relaxed/simple;
	bh=dCypkDPmK7+YA4kDTPlZPhaDAJOhOWPEFEaA2lhRfLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLCpbrR8S4GtLrOI8/rE5xSqG0mA74m8a0QUoKUzdi9y0i5jsWKq7uvedVJOfi0Q0uJ5yJFD3tCDCXhMvlfb5tJ5UG18sU80Y6zBRgeS652GFJ/W3De9wGTlIGawvA4+agEchkCzNGgFT3fbACZ/vX5697a3E+uJgql+9HlSaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Tny+8gs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5e39d1db2so174290285a.3
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743235455; x=1743840255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+XPSx9TRJ9I8Hy+mHE53N2z2Q8yHcaLeX4w/ZexuY1s=;
        b=4Tny+8gsYw3gx7smUXMHHAGWaXZS0H63Mik2TQsP5BRIqx12hLw1v4JBUx0+f9dn1r
         Z4npN1r+uuFsos/ZYmu1ocz7Fki9TGlSRdyOy2eamZ46HHXEU9L5jbcDu95+x/Tgeo/v
         +CDmMTpcay4ZLQ4/yV0snQfMFYJ/vqO6yvPuk7tpd5MPgtvgiYgJG17F52VjgECVkF8U
         PiwKdNe8jhiWETiqKzRq888cJDlB9CRIDhm7n9fp5wHFlsHAv6MAKtAwA8FFM6G78VX9
         gRHqchgZnjvP7dEzWKZ3dLKCnOl3qT9o05hfODP1JpmWfGePf7aF4dsAUV6QMPo/M4+y
         k4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743235455; x=1743840255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XPSx9TRJ9I8Hy+mHE53N2z2Q8yHcaLeX4w/ZexuY1s=;
        b=msRSek5KzvtkhlHQTRtgBLmQyuRuSW6fYpMJBi0VbcIJb4RJ+Mt44ghOKV0Uzgg3S6
         CtA/cZPbsGLAI/GfPkz3JM6AFlCSmsTV8uVdgHulwm/V7xsguv/6uhp+xTxEtV3vpgEq
         MT1PX45JGpfd2DHVj+lYnvoRplzDTRIK2xT/RLT4gSg+eM9COMQ3RjMnYzLQqsBe+Hrz
         RpVqCmF1afDxKrbeuKWNkB5svD9Htbdg2wrdYvg8TDR+mCvqIldcy9I4glFa/Wv/wXTR
         eWl0SQ0FNsMGe0Drp1I8LGGCdSMUnkg7UN47I6ufgHxW0d7168YXxOXk1hwX11Qnilmp
         KssA==
X-Gm-Message-State: AOJu0YzJHcjpMXPN87bqmsZTG7HqIeDbZPm83T0xQ4Ld6ZiXAlKWoiZx
	VxOwHgRc9IK0vEegSlx5Kai1tVd8pOo+9rs/qiGddUdU4Qa7sPnmezw0ioAHUrImCEAkWUpzhen
	dD6b7mHWOdLhL1fJ1HBXVPN1bSpSea+tgLYR4
X-Gm-Gg: ASbGncsQ1Hh72AHr3QUV7px2KG0PTugEHd5uFyLmapPEQIU4bgJszyPGabG9U9i4A8Y
	LuBPD6Sk0cKZ54oXHYrqFijhJNg2Cn5+Ha0C0VOLGZJ/ZhwR8HokdqFEekdZh90iLu/78RVR8Mo
	zb8JMGhMWgXU9hYzEt33YH/jijz5c=
X-Google-Smtp-Source: AGHT+IEc78D847LUde3+5bswzdf1ixUrsSY5twv855UuX9+/F9K0OsF+VDrVmnty/ImwqqAtDRcJZXHHN5I0PSHwDjI=
X-Received: by 2002:ad4:5c42:0:b0:6eb:1e80:19fa with SMTP id
 6a1803df08f44-6eed5f6164cmr22680736d6.1.1743235454901; Sat, 29 Mar 2025
 01:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313114329.284104-1-acarmina@redhat.com> <20250313114329.284104-7-acarmina@redhat.com>
In-Reply-To: <20250313114329.284104-7-acarmina@redhat.com>
From: David Gow <davidgow@google.com>
Date: Sat, 29 Mar 2025 16:04:01 +0800
X-Gm-Features: AQ5f1JpT-aX1aghV5CTNaG4UuLzzr7X5SV4zHe81kzrsiyK5QNGcvsu-jzq-6nI
Message-ID: <CABVgOSmofN-jw9AWpOTAvhE-d-oLW_MBnPx8QQ1GVLZb-sMEhg@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] x86: Add support for suppressing warning backtraces
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, x86@kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000019320a063176a2d9"

--00000000000019320a063176a2d9
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 19:44, Alessandro Carminati <acarmina@redhat.com> wrote:
>
> From: Guenter Roeck <linux@roeck-us.net>
>
> Add name of functions triggering warning backtraces to the __bug_table
> object section to enable support for suppressing WARNING backtraces.
>
> To limit image size impact, the pointer to the function name is only added
> to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
> CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
> parameter is replaced with a (dummy) NULL parameter to avoid an image size
> increase due to unused __func__ entries (this is necessary because __func__
> is not a define but a virtual variable).
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index e85ac0c7c039..f6e13fc675ab 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -35,18 +35,28 @@
>
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +# define HAVE_BUG_FUNCTION
> +# define __BUG_FUNC_PTR        __BUG_REL(%c1)
> +# define __BUG_FUNC    __func__
> +#else
> +# define __BUG_FUNC_PTR
> +# define __BUG_FUNC    NULL
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +
>  #define _BUG_FLAGS(ins, flags, extra)                                  \
>  do {                                                                   \
>         asm_inline volatile("1:\t" ins "\n"                             \
>                      ".pushsection __bug_table,\"aw\"\n"                \
>                      "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"   \
>                      "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"       \
> -                    "\t.word %c1"        "\t# bug_entry::line\n"       \
> -                    "\t.word %c2"        "\t# bug_entry::flags\n"      \
> -                    "\t.org 2b+%c3\n"                                  \
> +                    "\t"  __BUG_FUNC_PTR "\t# bug_entry::function\n"   \
> +                    "\t.word %c2"        "\t# bug_entry::line\n"       \
> +                    "\t.word %c3"        "\t# bug_entry::flags\n"      \
> +                    "\t.org 2b+%c4\n"                                  \
>                      ".popsection\n"                                    \
>                      extra                                              \
> -                    : : "i" (__FILE__), "i" (__LINE__),                \
> +                    : : "i" (__FILE__), "i" (__BUG_FUNC), "i" (__LINE__),\
>                          "i" (flags),                                   \
>                          "i" (sizeof(struct bug_entry)));               \
>  } while (0)
> @@ -92,7 +102,8 @@ do {                                                         \
>  do {                                                           \
>         __auto_type __flags = BUGFLAG_WARNING|(flags);          \
>         instrumentation_begin();                                \
> -       _BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));   \
> +       if (!KUNIT_IS_SUPPRESSED_WARNING(__func__))                     \
> +               _BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));   \
>         instrumentation_end();                                  \
>  } while (0)
>
> --
> 2.34.1
>

--00000000000019320a063176a2d9
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
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg2//D/Xyyvi5/ruv5pLyZ3Rv3y1HE
7fNAKkTKrh5hWNEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzI5MDgwNDE1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEASVlVFQXw4S3LvkoUEZJTR42uF61UnTKRZ1Lgt9fykLsQjDZijEnIOpMeJYkmZXyu
7QcD+Ra2/VA+DA4I4QWkaSB0j7LwcrPn8LNP2wU66CUhrecq0speJgnRJyIkA0otoc+ER83dnzmH
6bfJg20kfVB0h9LCjFXs5lKkV+4t6KuuqOcY/8NPt06C9aYf5Dwk2T1WxpNaORrGAEFflYWarP00
r9guI0DFa/bKju/HEwOR1Tlhvz0kGdXggqfTm9F16r49EBBwyZO1aWjJ0/0ErT9jrLwUMOJmY1Xd
W4bgW3fB7adVI0LPodpz2ViCEEios5AmV+rb2cKlmUfMzI3gCQ==
--00000000000019320a063176a2d9--

