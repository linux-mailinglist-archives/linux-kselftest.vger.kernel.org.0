Return-Path: <linux-kselftest+bounces-15995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E895AD40
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8902845CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9671386D8;
	Thu, 22 Aug 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMkQeWjr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCB13633F
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307255; cv=none; b=GSDyyNvJ5thKTaTKlD02SHTFvMBsl+rWgLOzKBOVt54FlGTZ39am/A7yGZE8WbpPYuviR+GgJ/NlnttVJiJPLQYcdgpzM1hy03mHDGxeKgEBXhfQSSt1CoRk7CbVj7vApKMKE1PS7QDq+j/gUdGTk7jvqBuNv9ot+W/LWSgnhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307255; c=relaxed/simple;
	bh=MgrAhIa+Jo9fuXVUZ0lJbCXqfmxt+HXHIy/AsLb6Lhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeT8LHvIfOaDVxMVJpavnuvD0+1RxiIpHC7eVwr/jmzs+ry2ZikHLxq+XL5bxH7YZKrc82tWaablIQQULRC7AY4XWRbns3b6lePw/bTOVpacYD4HvNJb8hUaHD8Q3H+6D/NpXcRgHMN8tJLYEix8uXdDV+1g6nd63SRo8CXhhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMkQeWjr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf7ec5c837so2141776d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724307252; x=1724912052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MR2Di4uYWcBb7/JreCRw7sZJX0Tq+F23/wxxP/C/mQQ=;
        b=eMkQeWjre4R2ZCUZAI6X9Txl97C7WrXFYRTMtL6rHszoiH9oRCC4oGFJ3jS16itC4b
         Ra0HcgthAXY+QZl6CKUgjW4CCM51U7AUWNbPXNkCFeH62IR/9kjeLznczOuwHTUTxxYt
         DI2zl9fmGfe+jO1EBjYTWyztXevXCCToEgb5b59VqeRK+dyq5DR167RlfpueQSrOwzy1
         FDXbozohWi/aFjxqIZSBQD/pXPfkwcPvrGXCBfK7UBaz7rp7CNyJU/U/0Td6nUv7NpKo
         65C0TDgzLlk+hVLpAfGXf8PYu+9D5ceCWMJ99JLOea8hqIwOe1GIdW3+Q+FmKmORDRQg
         eAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307252; x=1724912052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MR2Di4uYWcBb7/JreCRw7sZJX0Tq+F23/wxxP/C/mQQ=;
        b=vcTqe/ip/cc8KucGSd674n2XRO+mLhfb7qeGCC3ILPZ2jLn8otxsWgxJw4YxNKTbom
         RwzBRdGYbeNaINArzoK4NTac7UWrbBFxR4F0uGVt7wTv0iaavZU+X1NPMZND8b1V0/Gf
         qATojo8AURo010INHjNLK+cQKWH2CjrePFjhSCIoI3FyVBn+jDSar+r9rm2ClGmCNXCn
         oxYHPFeselbQxDgvxCXcsu0sjQzp7mDWv/XGE5F7ShZjff5Wc9PtZP9L5jzYeaVUuMAe
         f09sqPy96UZPwiMxS5bXNVAcvbuPJEK7AN8Ut77v98yN72QzsgpIr61Y1c8s9TiLC7aq
         fybA==
X-Gm-Message-State: AOJu0YwLCN9Wk1qsbnj4zzhrq1mDxnyiAFsYBW/8lJ8D0C9DG7CR3IbY
	CUIOdzs0qIvAyx0E/i6MERKfFJMwK9oC4+48zpA+7obpHCjB2trwbvL+1i7HNg3OgQ4v+XdPNmS
	CfB7lsc1UVaiVAIhDv7xPSxIKprHqLqp1jmof
X-Google-Smtp-Source: AGHT+IGCXmONJ1wHsD9ozbsmPS6eejCwU1mQFbcGqJCl48J4eEaD5XN5lAmLIr90tTZGuKok/YR2zK9xKRseOXcLoZo=
X-Received: by 2002:a05:6214:5b87:b0:6b0:71c0:cbaa with SMTP id
 6a1803df08f44-6c16471ee7cmr10444986d6.33.1724307252032; Wed, 21 Aug 2024
 23:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-4-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-4-michal.wajdeczko@intel.com>
From: David Gow <davidgow@google.com>
Date: Thu, 22 Aug 2024 14:14:00 +0800
Message-ID: <CABVgOSkdCh9qXYRyJ1mMBzj_-e5_p-8HM8C7XtcJyhnmcibq=w@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Daniel Latypov <dlatypov@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000045bfc406203f914e"

--00000000000045bfc406203f914e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Aug 2024 at 22:43, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Currently, the 'static stub' API only allows function redirection
> for calls made from the kthread of the current test, which prevents
> the use of this functionalty when the tested code is also used by
> other threads, outside of the KUnit test, like from the workqueue.
>
> Add another set of macros to allow redirection to the replacement
> functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
> affect all calls done during the test execution.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---

Thanks for sending this in: we really do need a way to use stubs from
other threads.

In general, I think there are two possible ways of implementing that:
- Make a version of the stubs which don't need a KUnit context (i.e.,
this patch), or
- Have a way of extending the KUnit context to other threads.

Personally, I'd prefer the latter if it were feasible, as it is both
cleaner from a user point of view (we don't need two variants of the
same thing), and extends more easily to features beyond stubs.
However, there are a few downsides:
- We'd need to find a way of handling the case where the test function
returns while there's still a background thread happening.
- In general, KUnit would need to be audited for thread safety for
those macros (I don't think it's too bad, but worth checking),
- We'd need a way of passing the KUnit context to the new thread,
which might be difficult to make pleasant.
- We'd need to handle cases where a thread is only partly running test
code, or otherwise doesn't create its threads directly (e.g.,
workqueues, rcu, etc)
- What should happen if an assertion fails on another thread =E2=80=94 does
the failing thread quit, does the original thread quit, both?

In short, it's a complicated enough situation that I doubt we'd solve
all of those problems cleanly or quickly, so this patch is probably
the better option. Regardless, we need a story for what the thread
safety of this is -- can you activate/deactivate stubs while the
stubbed function is being called. (My gut feeling is "this should be
possible, but is probably ill-advised" is what we should aim for,
which probably requires making sure the stub update is done
atomically.

More rambling below, but I think this is probably good once the
atomic/thread-safety stuff is either sorted out or at least
documented. As for the name, how about KUNIT_GLOBAL_STUB_REDIRECT()?
I'm okay with FIXED_STUB if you prefer it, though.

Cheers,
-- David

>  include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
>  lib/kunit/static_stub.c     | 21 ++++++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> index bf940322dfc0..3dd98c8f3f1f 100644
> --- a/include/kunit/static_stub.h
> +++ b/include/kunit/static_stub.h
> @@ -12,6 +12,7 @@
>
>  /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>  #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0=
)
> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
>
>  #else
>
> @@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit *test=
,
>   */
>  void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr=
);
>
> +/**
> + * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if activated=
.
> + * @stub: The location of the function stub pointer
> + * @args: All of the arguments passed to this stub
> + *
> + * This is a function prologue which is used to allow calls to the curre=
nt
> + * function to be redirected if a KUnit is running. If the stub is NULL =
or
> + * the KUnit is not running the function will continue execution as norm=
al.
> + *
> + * The function stub pointer must be stored in a place that is accessibl=
e both
> + * from the test code that will activate this stub and from the function=
 where
> + * we will do the redirection.
> + *
> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
> + * even if the caller is not in a KUnit context (like a worker thread).
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *     static int (*func_stub)(int n);
> + *
> + *     int real_func(int n)
> + *     {
> + *             KUNIT_FIXED_STUB_REDIRECT(func_stub, n);
> + *             return n + 1;
> + *     }
> + *
> + *     int replacement_func(int n)
> + *     {
> + *             return n + 100;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 2);
> + *             func_stub =3D replacement_func;
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 101);
> + *     }
> + */
> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {                   =
               \
> +       typeof(stub) replacement =3D (stub);                             =
                 \
> +       if (kunit_is_running()) {                                        =
               \
> +               if (unlikely(replacement)) {                             =
               \
> +                       pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub =
%ps\n",        \

I suspect we want to at least make the logging here optional,
particularly since it doesn't go into the test log.

> +                               __func__, replacement);                  =
               \
> +                       return replacement(args);                        =
               \
> +               }                                                        =
               \
> +       }                                                                =
               \
> +} while (0)
> +
> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, voi=
d *replacement_func);
> +
> +/**
> + * kunit_activate_fixed_stub() - Setup a fixed function stub.
> + * @test: Test case that wants to activate a fixed function stub
> + * @stub: The location of the function stub pointer
> + * @replacement: The replacement function
> + *
> + * This helper setups a function stub with the replacement function.
> + * It will also automatically restore stub to NULL at the test end.
> + */
> +#define kunit_activate_fixed_stub(test, stub, replacement) do {         =
                       \

Do we want to actually hook this into the struct kunit here? I suspect
we do, but it does mean that this has to either be called from the
main thread, or the struct kunit* needs to be passed around.

> +       typecheck_pointer(stub);                                         =
               \
> +       typecheck_fn(typeof(stub), replacement);                         =
               \
> +       typeof(stub) *stub_ptr =3D &(stub);                              =
                 \
> +       __kunit_activate_fixed_stub((test), stub_ptr, (replacement));    =
               \
> +} while (0)
> +
> +/**
> + * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
> + * @test: Test case that wants to deactivate a fixed function stub (unus=
ed for now)
> + * @stub: The location of the function stub pointer
> + */
> +#define kunit_deactivate_fixed_stub(test, stub) do {                    =
               \
> +       typecheck(struct kunit *, (test));                               =
               \
> +       (stub) =3D NULL;                                                 =
                 \
> +} while (0)
> +
>  #endif
>  #endif
> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
> index 92b2cccd5e76..1b50cf457e89 100644
> --- a/lib/kunit/static_stub.c
> +++ b/lib/kunit/static_stub.c
> @@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit *test=
,
>         }
>  }
>  EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
> +
> +static void nullify_stub_ptr(void *data)
> +{
> +       void **ptr =3D data;
> +
> +       *ptr =3D NULL;

As below, does this need to be atomic?

> +}
> +
> +/*
> + * Helper function for kunit_activate_static_stub(). The macro does
> + * typechecking, so use it instead.
> + */
> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, voi=
d *replacement_func)
> +{
> +       void **stub =3D stub_ptr;
> +
> +       KUNIT_ASSERT_NOT_NULL(test, stub_ptr);
> +       *stub =3D replacement_func;

Do we need to do something here to make this atomic? At the very
least, I think we want to READ_ONCE()/WRITE_ONCE() these, but even
then we could end up with torn writes, I think.

In general, though, what's the rule around activating a stub from a
different thread to it being called?  I thinki we definitely want to
allow it, but _maybe_ we can get away with saying that the stub can't
be activated/deactivated concurrently with being used?

> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_=
stub_ptr, stub_ptr));

Again, we probably need to emphasise that any work done on another
thread needs to be complete before the test ends on the main thread.
This isn't specific to this feature, though.

> +}
> +EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);

> --
> 2.43.0
>

--00000000000045bfc406203f914e
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgUoovgDkims/v1hEy1EeQDnvMZBiD
sf509Uy0FAgN7fkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
ODIyMDYxNDEyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJ0xP4v6LuBzg3PDzpYoMqIVy4yefe7nNjxjc4wzb6QR7SeU
+3jjcqk5duaXMmJDgBcvIIDXSXmtTxwFkoNkRq+XPnRhXwJpNTdWOyaJP2iWJBmai5w7fSnjlh/L
hHYbB20qOqYgRwDiIPkxri80/GG9hFzECMEFwdEfJ5U8JfEayHaWkzPn0Z3tVCaCGbIS0obdD4KH
DitSFvvkq+0PwqvqWEZVaqcDLUWtBZf/S1J/hYh0rkgVhqhbq+8UEGr//hA4VFW74458cvPsy8ir
X2pclTTLoqXOqnng7Cf96SBJBll4ulk8M7jmRbnzcGNJ03qwhFiNyY5XcMEl8pqIPo4=
--00000000000045bfc406203f914e--

