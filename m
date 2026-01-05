Return-Path: <linux-kselftest+bounces-48185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53CCF2E33
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD4230AAD0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B02F12CC;
	Mon,  5 Jan 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Romxx4w5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D82F12C6
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606984; cv=none; b=d0KS9wilAGMFAHUl8QuEveH6nfhhIfrBaqIPlmsyxuOwYXGQdps+aAR4yFxQApcvPYpQqj9Yhux95bG6HgO6Gn4YpNCnIi3AVPq6hZ2Umfqo575BvMXNj/l362mwcZHpoSLA5WwZlFG250hd/9UgfdSU2aa8abTezzVdzwKrm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606984; c=relaxed/simple;
	bh=UUdksuD8jdnlEIBQPXCHjAxGCpgPYNpmB/hdzdNu6NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9QiDAzo7yXnTBYy5e/Z/eeuafPt2gofUPx4dbE4e0ZiHFYLS26/rFqM3EQrwvbuQJtzMYjHAnV1EadNKwzlYhfeG1Ns6gYjdT0YP+O1ulyr5mPG6tSFuxD5hwwBwYQ27zeduoIjLUwhcHn37rxRSrYViZ6vcZw3Kbvexu/kXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Romxx4w5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so11033011f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767606979; x=1768211779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0C9b2qkJrI6CxeL0PKXxkgKny3PfhoBbMSjeJNEpCg4=;
        b=Romxx4w528ykCmV1OAYXeBcAKEnfhmZFgU/MqRdq/Cq8DdRW5Nnwe6ZRGybuhW4UK4
         8vR7C+CIjUmIKrm5eQhM+68CPlDYRWSbl5zh6ApY7WyGEFSHQ8JAPmRfENWeDU1HDu2j
         ytqDxwD/TnWIgDty3spHfr9Gu6m2/HFgIs6fyG7w9VWmme0nDi4+zjWv5SxmFsOK+RHd
         9dyE3/tPEXM9A61F2osAJc4NmmcCRmORVKlFKfAreeEfldLWXRh23+Wd5T7GbG+5Truy
         z3J/Gxc0gTtZxk6YPihV1YKftMk+bBPuEOHcguJ4zXvtSz+ocpQBWrZ8up7YzzQyKGql
         TdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606979; x=1768211779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C9b2qkJrI6CxeL0PKXxkgKny3PfhoBbMSjeJNEpCg4=;
        b=BzS0hCMMxutf1jZ/olEVqZATBTshsvCihvYan7EnOiUEYW4TpgFZ4xDixbBDDHKdkQ
         0DK1+1HRk83pveNbqJLuPD5DAeHLiBKSywdqTje3EE7HaRIkpgxJjn8ZnJy5hFNWwOHy
         bE3t6HurPImDmwAamiC1IsDy+e/TdnQ6yEYwRnhRtlrl81CvC/BekTx5BagzW0TNueVR
         k2TW2KzSLK1AaBLL9E5GVq9+9M7FpgxOl4mjgELoKyFRp1jVnN2wYJN5XEH94DpQakF8
         VnHJ5EFCfI83957P7HrpYSFuiccqanPwzU6MEpTYW8VFh7Gohg/bQUVD+bR3Ux4BSTAD
         nPhA==
X-Forwarded-Encrypted: i=1; AJvYcCUKXQwn++qaj8NV4WE0NqkOLaD79IMrslbgiBRWUoOPAN6awZFESc4KLX1Z73TeJ8oxH/LbKOrJCyOzgebVtx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwVgh3x01r4qR4bKNBsZWot04YA7SmU+1lIfpuuqGLLw/X/dW
	Lfh0sw8ymH877hf1OUarDiPjoGNS5Sfr+oSfbblrnXgk5V1++yjUESiCjkD5m/d4tn9GriklAYf
	gnWJ8mkSkXm8HbZAZXdF6ECwZ9E+nH+b5a0wxuLG3
X-Gm-Gg: AY/fxX551hxrisdxyz/t542ZwiR7maFOAxtucGpsFxXRjTKA9rWgNEfaVHsm9kFyQOL
	icyty0kOQOJlOt3MSMhyPdRnZJ7GgMJ6XJQK8QhrieiGLE7VxzmIRPBQmbG/wQ1viSzfpbqgduh
	ivVhUBxiHtgUofH+t8Pf7OayR9qMgoVS5Y63/sBQUHEfzhj0sA9Jz42eAf1oqWMfI1FPw25kJ2z
	pOV6dwYSLzGDZuwpwsiOByv91vpMDszA7U2237GfPf4s+ADtOxV9UXKjjPFLSIS3Ppo0A==
X-Google-Smtp-Source: AGHT+IFhHGqV+111+Jsl/C7heOpaY1/FMuHju4NwSGTautSM3LQjZq6+CfqKPbYyrgfW0H5gLSsVGXIU8o316QNo+WU=
X-Received: by 2002:a05:6000:1acc:b0:431:a33:d864 with SMTP id
 ffacd0b85a97d-4324e4cbe79mr60695677f8f.18.1767606979125; Mon, 05 Jan 2026
 01:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com> <20251223-b4-kunit-user-alloc-v1-1-fb910ae0e50c@google.com>
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-1-fb910ae0e50c@google.com>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 17:56:05 +0800
X-Gm-Features: AQt7F2rWRtCZ2foFqib5wHn__dRxlvbLK48dSdGfX_Bapcf6uaBoiId46FXURj4
Message-ID: <CABVgOSn8UjWjEe-FNfOBSpZiBL0797VvJQZOOGp5QB6tv52COQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: test: Delete pointless resource API usage
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
	boundary="00000000000022f4aa0647a11243"

--00000000000022f4aa0647a11243
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Dec 2025 at 00:18, Brendan Jackman <jackmanb@google.com> wrote:
>
> This code uses the low-level resource API to track parameters of the
> vm_mmap call, but it doesn't do anything with them, because the mm
> teardown code takes care of tearing down the mmaps. Delete it.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

This makes sense. Maybe there's a case where tracking mmaps as
resources could be useful in the future, but I can't think of any off
the top of my head, so this is just wasteful for now.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/user_alloc.c | 76 ++++----------------------------------------------
>  1 file changed, 6 insertions(+), 70 deletions(-)
>
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index b8cac765e6204..564f5566641d5 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -7,21 +7,6 @@
>  #include <linux/kthread.h>
>  #include <linux/mm.h>
>
> -struct kunit_vm_mmap_resource {
> -       unsigned long addr;
> -       size_t size;
> -};
> -
> -/* vm_mmap() arguments */
> -struct kunit_vm_mmap_params {
> -       struct file *file;
> -       unsigned long addr;
> -       unsigned long len;
> -       unsigned long prot;
> -       unsigned long flag;
> -       unsigned long offset;
> -};
> -
>  int kunit_attach_mm(void)
>  {
>         struct mm_struct *mm;
> @@ -50,67 +35,18 @@ int kunit_attach_mm(void)
>  }
>  EXPORT_SYMBOL_GPL(kunit_attach_mm);
>
> -static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
> -{
> -       struct kunit_vm_mmap_params *p = context;
> -       struct kunit_vm_mmap_resource vres;
> -       int ret;
> -
> -       ret = kunit_attach_mm();
> -       if (ret)
> -               return ret;
> -
> -       vres.size = p->len;
> -       vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
> -       if (!vres.addr)
> -               return -ENOMEM;
> -       res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
> -       if (!res->data) {
> -               vm_munmap(vres.addr, vres.size);
> -               return -ENOMEM;
> -       }
> -
> -       return 0;
> -}
> -
> -static void kunit_vm_mmap_free(struct kunit_resource *res)
> -{
> -       struct kunit_vm_mmap_resource *vres = res->data;
> -
> -       /*
> -        * Since this is executed from the test monitoring process,
> -        * the test's mm has already been torn down. We don't need
> -        * to run vm_munmap(vres->addr, vres->size), only clean up
> -        * the vres.
> -        */
> -
> -       kfree(vres);
> -       res->data = NULL;
> -}
> -
>  unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
>                             unsigned long addr, unsigned long len,
>                             unsigned long prot, unsigned long flag,
>                             unsigned long offset)
>  {
> -       struct kunit_vm_mmap_params params = {
> -               .file = file,
> -               .addr = addr,
> -               .len = len,
> -               .prot = prot,
> -               .flag = flag,
> -               .offset = offset,
> -       };
> -       struct kunit_vm_mmap_resource *vres;
> +       int err;
>
> -       vres = kunit_alloc_resource(test,
> -                                   kunit_vm_mmap_init,
> -                                   kunit_vm_mmap_free,
> -                                   GFP_KERNEL,
> -                                   &params);
> -       if (vres)
> -               return vres->addr;
> -       return 0;
> +       err = kunit_attach_mm();
> +       if (err)
> +               return err;
> +
> +       return vm_mmap(file, addr, len, prot, flag, offset);
>  }
>  EXPORT_SYMBOL_GPL(kunit_vm_mmap);
>
>
> --
> 2.51.2
>

--00000000000022f4aa0647a11243
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgU21tlyrnKcwwD0HKVywy0ClrUDAI
j+EYTMvKqDXyr+cwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDk1NjE5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAhnpNofOc/GkBsAs8w8CbRSs5Yg00s1/8jWOg7Ebu/8M+4BKRIisEa/yJUi/4QX+r
R1m0mUXVAFVmqrgCKlwshETvWw8qHJ9a+SNZ8CqgQ+/5IigJM30FaXG9ZVqDYKBgwMAKSsIPs4mL
7Rn5nylgL8GNLTTY4vGd2NS4joSQ+c0RYvponWWXbPqKwPxWsToqbCkcOFpIdm/PsqaIfqbqkDbt
aI0axgW3blHp44GKBa+TQYWHg2fOEOSA1lDTl8NHbFFKiyW9nx8rflICdnEahfN4NSREALyY6Xxs
NusJu6CjSUjlJ93VEAi4zWTF2Lygj7Ue1U+Y4KryENxeYpqm3w==
--00000000000022f4aa0647a11243--

