Return-Path: <linux-kselftest+bounces-48187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D892BCF2E3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51EF6311F24A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBD32ABF7;
	Mon,  5 Jan 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASCDSdgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAB31A551
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606990; cv=none; b=sgL6mNajxITCl8TAywthvmr3aZPguxOTUki6yC0pD/v4Tnx5u+HRTq4dY5kKCe5dZbTgO0ptLKTW0hxRXf2VTdy1WENbGGKKqvX1ydcGKbN7Xev0BkPiPfNSpCucnwkFc+VHN02Mu954zdk938IPz08nPHcq6ibWWcn4AxadCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606990; c=relaxed/simple;
	bh=Jm+KsQ16aLOIIQdAhkLr2lFXIUH7grOQWFJ1jy/VHPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPMZtQQ3KsPBz+hYsL/icLlfZz4jOj/gocl2t2Ddu+dtNrFzA1CxEI9vXPxBZUaQwnAALvzZ0I+KfF6XOFunOLhqVY3kWaa/jFgZSrqAJDlwRjaA1T2Zp+dFAQLB20hyQJsaxSytR0cbe6eeQKCCgjE3C43jXqD40NIR+VrBAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASCDSdgl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fed090e5fso6335216f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767606985; x=1768211785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSbYMAoG1WTKO5rcG6yq+jd/tSn/zv0qNQKj/JbFBzI=;
        b=ASCDSdglCGzRlqDiStVB0rJ4Z2k00uW4QjKlBWhgag2YRh6whiA9kNznaTLFSMVrMU
         bRDCaAvQjcjvIaTgu8BeR7z+mKVcSXpUgWRUgV/2iKvE891AyoBGLHZa8q5Zi04uJryi
         5HYalycixKFrueqJ1kXoLa1VI6WdjMBZIJ1QTGsVzw9heQTjxVgNDeHucPjK3ml0JyKG
         EGadKWYTFGaWag762kSirEeExHwwjlBgLySbKrMw4wIAxaifMzS/Vza3BsbQRjpJAk9O
         t+YvwLwOxiAuiqc38pB+HGkU9X/SeSJKI4Ot8rEyAuBLNoZQ8+W/1+GfR16IjVWdeJ50
         EaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606985; x=1768211785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSbYMAoG1WTKO5rcG6yq+jd/tSn/zv0qNQKj/JbFBzI=;
        b=VgwafOCkQar9obcnrPvc6VmoFf2n2WtzTSBkwHVvH/2D4aITVeE3NW0Od/nk/dnwuY
         9vW822pVpfsyezVXhgwpQ7vBZ+F5J6F6YPRV4J9JSnLFynQaoahI933wd0pzjkqJ8wk+
         kbvWvo3IxIGlMroLXe3vqQ2whxpbO+g0uuOY9cbfPQ6PhDPbnTfNCxsFruWDqyX6h3HG
         iEiGOsEWm1hU0ci1yy9WWPgxP0JaEAN0A2cnCyv97ahHTCKZFsp40sZfxos6sJOm68AT
         tJ04KUhcVbKdDlKoXS3wK2OoUJlaZFrarhsCJLFjwa+WW+XoQH44TpXMHXIJZX+rzfs7
         RoFg==
X-Forwarded-Encrypted: i=1; AJvYcCVaTbyFp9dFJtZNxB+3cQncoVpWqO1cNeJxGO3qX9QiRC+wVsbjbCLFiuY/Yx6DmnarmNjCon5n4CNF1Yj+qGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFLKQ3rMlaRcjZlxMFiRWH19Ay8DO/hPWP7c7Y2iTPUplifuV
	fGhSVdouMafwJjgR723QEa+UhOxOBT/1ebCLjGnipb+JRGfSASCIxURudH6/aApUfHGusNGH7Ki
	jj0QIW5UlrTHJyMvxMFm7gziMffAIhemTskXa3FYO
X-Gm-Gg: AY/fxX6hvdt6QUVNWECaksK5dg+B0WU3490PNH49qxOHQtmJLT9GXKQt1WDfXQuYk4f
	ANYb/tMs1lbnjeoDx5QfXFFfmUbsIatQGnpkdyGMUCa7RJo8EkarjTEVL/++yGKVKXx2lfa4jh0
	G3VQh1VN3dSTrXocoECVVOMPlITsQV/dnty+SvOKPjsGfssQmx3IW9gCGfwwWlC2izCsW6oH6Bm
	+ia5i9Zf2Xesl9L40iBF2uLGgreusA4RmGfZ5tXmHjxmMfng4ymrlotZAOtKW+OSg9/XxmB50+J
	o5wg
X-Google-Smtp-Source: AGHT+IGwwQUfDNp+vdSlrkiwzJXWM9K8ws1FUdgiERj8R7G2XmKien1SVaxnduxq+RIKu9VEsX6JxqLsnPJ4rVxMiNQ=
X-Received: by 2002:a5d:5d87:0:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-4328651421amr32429445f8f.18.1767606985261; Mon, 05 Jan 2026
 01:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com> <20251223-b4-kunit-user-alloc-v1-3-fb910ae0e50c@google.com>
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-3-fb910ae0e50c@google.com>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 17:56:13 +0800
X-Gm-Features: AQt7F2o3aJjc8pg9gpsN4beGFmZtGXKEZCUwLZWf7shEfxiNcIVw9dUD1NE-KYk
Message-ID: <CABVgOSnGH=nvJPsww5KjeQmTpX46HE0PJ20uOWpcWDi11MyOgw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: test: fix mm_struct leak in kunit_attach_mm()
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008010dc0647a1129f"

--0000000000008010dc0647a1129f
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Dec 2025 at 00:18, Brendan Jackman <jackmanb@google.com> wrote:
>
> Here's how I understand mm refcounts:
>
>   funcs             | counter  | manages lifecycle of...
>   --------------------------------------------------------
>   mmgrab()/mmdrop() | mm_count | mm_struct and PGD
>   --------------------------------------------------------
>   mmget()/mmput()   | mm_users | userspace address space
>
>     All mm_users references share a single reference to the mm_struct.
>
> mm_alloc() returns the mm with a single reference to the user address
> space, i.e. with mm_users=1, mm_count=1.
>
> kunit_attach_mm() then passes the mm to kthread_use_mm(). It does not
> call kthread_unuse_mm(), instead it relies on the kthread exit path to
> release the relevant resources. It does this because KUnit's resource
> cleanup logic works by running cleanups in a different kthread from the
> test. You can't have cleanups that operate on the kthread, because
> the kthread is already gone by the time the cleanup is called.
>
> The kthread exit path will indeed drop the reference to the address
> space, i.e. it will call mmput(task->mm), decrementing mm_users.
> However, it does not release the reference taken on the mm_struct when
> kthread_use_mm() called mmgrab().
>
> To fix this, use the new kthread_take_mm() which provides the API KUnit
> needs.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

This seems right. We did have the ability to run cleanups on the test
kthread, but we couldn't guarantee it (because the test thread could
be aborted early, due to test failures, timeouts, etc).

I'm assuming that we can't just throw an mmdrop() in a resource
cleanup function (e.g. kunit_add_action()), since we can't do a full
kthread_unuse_mm()? I gave it a quick try and nothing crashed, but
that's not exactly a ringing endorsement that it's correct:

diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 3fca4ae223f6..5177537f592b 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -7,6 +7,8 @@
#include <linux/kthread.h>
#include <linux/mm.h>

+KUNIT_DEFINE_ACTION_WRAPPER(kunit_mmdrop_action, mmdrop, struct mm_struct*);
+
int kunit_attach_mm(void)
{
       struct mm_struct *mm;
@@ -29,7 +31,9 @@ int kunit_attach_mm(void)
       arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);

       /* Attach the mm. It will be cleaned up when the process dies. */
-       kthread_take_mm(mm);
+       kthread_use_mm(mm);
+
+       kunit_add_action(current->kunit_test, kunit_mmdrop_action, mm);

       return 0;
}


That being said, if mm folks are okay with the kthread_take_mm()
approach, that certainly makes things easier on our end, so I'm happy
with this as an option.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/user_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 564f5566641d5..3fca4ae223f67 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -29,7 +29,7 @@ int kunit_attach_mm(void)
>         arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
>
>         /* Attach the mm. It will be cleaned up when the process dies. */
> -       kthread_use_mm(mm);
> +       kthread_take_mm(mm);
>
>         return 0;
>  }
>
> --
> 2.51.2
>

--0000000000008010dc0647a1129f
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgLfB9g5dxQP456c5R7sE3iT+VZ25y
9QIOUJDByre+/oswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDk1NjI1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAuG41i9DkRai6gyhnNSHC29OprCu2rfiXgYBeTwRwcvS4MOR9/Ep7GHGlpPd3G+NC
S00bHfKXiZD0Z9D16TDr3gDupFUgp7vR7RM8Q2neJBlH1rW3+3HzFHWpMc11oVRpj+tIePmVdVlX
wrIG3gsDsHEyeWjZ1288rG4j4+F8KMHYc5v7FLBZH+ea6sVkhxLZPHtivJuM+tC1UyhbU3rDCpyQ
1Ny6qYEHymwxFP5K9JGDVbWRyP3tF/CBtQSBjuCRPvD683Db9nwigVLSxdWqkgNIhov25UVU+B+0
5DPlDDRE+hu6P6aSmYG4PairmGAWi9PrxkldZn7LzRHMz/zVsQ==
--0000000000008010dc0647a1129f--

