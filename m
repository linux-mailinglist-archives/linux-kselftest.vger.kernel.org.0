Return-Path: <linux-kselftest+bounces-11469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3706901088
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 10:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6C1F228F6
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35790176FC0;
	Sat,  8 Jun 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhoQTDNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C1176FA7
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836271; cv=none; b=EeLZzOSY2zOr9aAF7Ufwndo+iIG86paQsMF+nLxTHvqXuxihUZ1v3XOXQmYn/X7MdBWYpHIPjqST7YkE3aCcqfh07ZEHjG97uDZEMZx/gB/SrYTHsWiESTY52k1JWNQmR4UgUmv6Piq/4vTIGDfmd0MTCKEvn1ctUCnuhP6kQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836271; c=relaxed/simple;
	bh=5on2dPsmuodYcizX0JyXpW8voEFI1qdBfOjnZbdq1mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvMwJEfFf+W6v/JtJ5JzTJZDawjTABoopuxeRjCic9gPlSIYKJtKxVonhXEx/vXx/Fk0pmoKCDkVScBSbcAUP8/OVFIlOppq5MIo8kKi2UGSXiUlLgm6zMYctJ/AXJqdgTlwk0SbG51IV2sSrIOgTJVjp0V4vhY9J78otQTYbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhoQTDNf; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405dffca81so19821cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jun 2024 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717836268; x=1718441068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKQxWGu4kul6MINUnJ3jHQfSThQI0NLFxb/86IZIics=;
        b=LhoQTDNfEPHoL6uSjLv/NaDboiObupHJMCkEuJ7P9C2ytEp6PpzHQAWiLC5PNrNuiV
         uFoV8FDINSGMBe3VJWCYHGUSkgmLndiiR21FGjI0xwLZQWk9/BP8AiMQcIuFH7OR/EV/
         VNtJ4ezlmE02ah04fNJcQJGHJxuNbdN8YS2zHyGwjq7mWsPsN21gLJv5ZI0sMbMx1+Z5
         MA5OZN1OAsv+VRldPE/WmuELUGiUhpnLhVTBwO70igAz5xREWLg/VAzX1fhoPPody74A
         1wmNDNdgsOaJ97YroyEUxUfntURtS2g4nB5pErhCyUQVu/ddRL3OiMdBq50tjh5H2vTV
         QWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836268; x=1718441068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKQxWGu4kul6MINUnJ3jHQfSThQI0NLFxb/86IZIics=;
        b=VYS4G2fig+vKSEO1F2IisOXgOFpEp/Tfbab2wEengGN+nVso3Q+ZXr6xVQ3R05ALZV
         sXukvlIn9GoeSd2obAZZ5s3lSUaeleZotFdfjBTolD3QGG6n3gtbv3PSLjmwcnUXRURN
         qx7IXs6va1zsKQpT4AkCmbVlPaX9AlmZMwtT1bFgtTffMsmKjBHJml1IEj452+rMVyz2
         QcnZ17jjfJCIG146whQJ5SSNfNGA9bnxLoTFuAQwsrq5jc6Er6njvA1incYWjmlesmtx
         fu8IThBpzMzzzOWf1fF0Gui1ukmuIhpnwp8BptldvK4MFz3MQ7WPcdBFBYWqdHHZkoGK
         8mfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGVqGoQ4XINoVXz/ipSFcewqTV0xqnfDJ4yXQTCatJE9lxfAw+QP5oudrIO92ayYXmJ3g0ccWS8Dz932NageVtLRI261b3qSCOBf6Yfww6
X-Gm-Message-State: AOJu0Yy6ieRNQV71VJTYUR0PrCKHIeTmVHlDaTypiC5Js2Ulrn/gqhV3
	QTxtX6UmeJYcTw9zuavxx/w46w/kuL7OVvLDP1pA4ALsRXCPmu/bizJA6bVO8OXRnz2ld2f3L//
	mUi9gPxyOTQdz0k9pArMNrtu+v3vWkd5FCNEu
X-Google-Smtp-Source: AGHT+IEtEinskhdjNZ2sFH0osFnSwXRqvXW/RD9Ea/AR7NvMj9PVGwTe16VIMvYytdJybUdtZX4lMchnVOSomlZsxA4=
X-Received: by 2002:a05:622a:228c:b0:43f:f92a:bdb with SMTP id
 d75a77b69052e-440578d42c7mr1050781cf.13.1717836268062; Sat, 08 Jun 2024
 01:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519190422.work.715-kees@kernel.org> <20240519191254.651865-1-keescook@chromium.org>
In-Reply-To: <20240519191254.651865-1-keescook@chromium.org>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 16:44:16 +0800
Message-ID: <CABVgOSmD-v4rXDkcKgA1o2w-Ypzs_rYBKCx=2i2BWjWgd=o2pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: test: Add vm_mmap() allocation resource manager
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vitor Massaru Iha <vitor@massaru.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000093100c061a5cecf7"

--00000000000093100c061a5cecf7
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 03:12, Kees Cook <keescook@chromium.org> wrote:
>
> For tests that need to allocate using vm_mmap() (e.g. usercopy and
> execve), provide the interface to have the allocation tracked by KUnit
> itself. This requires bringing up a placeholder userspace mm.
>
> This combines my earlier attempt at this with Mark Rutland's version[1].
>
> Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks very much for this!

A few high-level thoughts:
- Do we want to move this into a separate file? test.{c,h} is already
getting pretty big, and this would probably fit more comfortably with
some of the resource-management bits, which are in their own files.
Not every test will need mm support.
- It'd be nice for there to be a way to explicitly teardown/reset
this: I agree that this is made more awkward by KUnit cleanup normally
running on a different thread, but I could definitely see why a test
might want to unset/reset this, and it would be more consistent with
other resources.

Otherwise, I have a few small questions below, but nothing essential.
There are a couple of test failures/hangs for the usercopy test (on
i386 and m68k), which may have origins here: I've mentioned them
there.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h |  17 ++++++
>  lib/kunit/test.c     | 139 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 61637ef32302..8c3835a6f282 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -478,6 +478,23 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>         return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>
> +/**
> + * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
> + * @test: The test context object.
> + * @file: struct file pointer to map from, if any
> + * @addr: desired address, if any
> + * @len: how many bytes to allocate
> + * @prot: mmap PROT_* bits
> + * @flag: mmap flags
> + * @offset: offset into @file to start mapping from.
> + *
> + * See vm_mmap() for more information.
> + */
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +                           unsigned long addr, unsigned long len,
> +                           unsigned long prot, unsigned long flag,
> +                           unsigned long offset);
> +
>  void kunit_cleanup(struct kunit *test);
>
>  void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 1d1475578515..09194dbffb63 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,13 +11,14 @@
>  #include <kunit/test-bug.h>
>  #include <kunit/attributes.h>
>  #include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> -#include <linux/mm.h>
>
>  #include "debugfs.h"
>  #include "device-impl.h"
> @@ -871,6 +872,142 @@ void kunit_kfree(struct kunit *test, const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>
> +struct kunit_vm_mmap_resource {
> +       unsigned long addr;
> +       size_t size;
> +};
> +
> +/* vm_mmap() arguments */
> +struct kunit_vm_mmap_params {
> +       struct file *file;
> +       unsigned long addr;
> +       unsigned long len;
> +       unsigned long prot;
> +       unsigned long flag;
> +       unsigned long offset;
> +};
> +
> +/*
> + * Arbitrarily chosen user address for the base allocation.
> + */
> +#define UBUF_ADDR_BASE SZ_2M

Are there any circumstances where we'd want a _different_ base address
here? Could it conflict with something / could tests require something
different?

I suspect it's fine to leave it like this until such a case actually shows up.

> +
> +/* Create and attach a new mm if it doesn't already exist. */
> +static int kunit_attach_mm(void)
> +{
> +       struct vm_area_struct *vma;
> +       struct mm_struct *mm;
> +
> +       if (current->mm)
> +               return 0;
> +
> +       mm = mm_alloc();
> +       if (!mm)
> +               return -ENOMEM;
> +
> +       if (mmap_write_lock_killable(mm))
> +               goto out_free;
> +
> +       /* Define the task size. */
> +       mm->task_size = TASK_SIZE;
> +
> +       /* Prepare the base VMA. */
> +       vma = vm_area_alloc(mm);
> +       if (!vma)
> +               goto out_unlock;
> +
> +       vma_set_anonymous(vma);
> +       vma->vm_start = UBUF_ADDR_BASE;
> +       vma->vm_end = UBUF_ADDR_BASE + PAGE_SIZE;
> +       vm_flags_init(vma, VM_READ | VM_MAYREAD | VM_WRITE | VM_MAYWRITE);
> +       vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +
> +       if (insert_vm_struct(mm, vma))
> +               goto out_free_vma;
> +
> +       mmap_write_unlock(mm);
> +
> +       /* Make sure we can allocate new VMAs. */
> +       arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
> +
> +       /* Attach the mm. It will be cleaned up when the process dies. */
> +       kthread_use_mm(mm);
> +
> +       return 0;
> +
> +out_free_vma:
> +       vm_area_free(vma);
> +out_unlock:
> +       mmap_write_unlock(mm);
> +out_free:
> +       mmput(mm);
> +       return -ENOMEM;
> +}
> +
> +static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_vm_mmap_params *p = context;
> +       struct kunit_vm_mmap_resource vres;
> +       int ret;
> +
> +       ret = kunit_attach_mm();
> +       if (ret)
> +               return ret;
> +
> +       vres.size = p->len;
> +       vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
> +       if (!vres.addr)
> +               return -ENOMEM;
> +       res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
> +       if (!res->data) {
> +               vm_munmap(vres.addr, vres.size);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void kunit_vm_mmap_free(struct kunit_resource *res)
> +{
> +       struct kunit_vm_mmap_resource *vres = res->data;
> +
> +       /*
> +        * Since this is executed from the test monitoring process,
> +        * the test's mm has already been torn down. We don't need
> +        * to run vm_munmap(vres->addr, vres->size), only clean up
> +        * the vres.
> +        */
> +
> +       kfree(vres);
> +       res->data = NULL;
> +}
> +
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +                           unsigned long addr, unsigned long len,
> +                           unsigned long prot, unsigned long flag,
> +                           unsigned long offset)
> +{
> +       struct kunit_vm_mmap_params params = {
> +               .file = file,
> +               .addr = addr,
> +               .len = len,
> +               .prot = prot,
> +               .flag = flag,
> +               .offset = offset,
> +       };
> +       struct kunit_vm_mmap_resource *vres;
> +
> +       vres = kunit_alloc_resource(test,
> +                                   kunit_vm_mmap_init,
> +                                   kunit_vm_mmap_free,
> +                                   GFP_KERNEL,
> +                                   &params);

It could be easier to use kunit_add_action() here, rather than
kunit_alloc_resource(), as you wouldn't need the params struct to pass
things through.

The advantage to keeping the separate resource is that we can more
easily look it up later if we, for example, wanted to be able to make
it current on other threads (is that something we'd ever want to do?).


> +       if (vres)
> +               return vres->addr;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_vm_mmap);
> +
>  void kunit_cleanup(struct kunit *test)
>  {
>         struct kunit_resource *res;
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240519191254.651865-1-keescook%40chromium.org.

--00000000000093100c061a5cecf7
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIN2RsqIiNAPL7Zc8cJFBgtemmqpTijxgN/phvIPArEMgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA4NDQyOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJV7hB
uTAiUKi2m0jDNjuHtx6X5Sg3cprXxXNWIdPdW/Kn92vBm5MyzKv/ZmxERY4yNwL79ixFlQXTMpw/
/j439d6fr83GzgAwZETPKm0XpRi9j8CdWvZ0mll/O3/dwOoOImOWTAi+i2qYxFnEe+S1tYH9+92R
sp6dEr2j1X6IdWUdpy/VyFLBgB4gkk55e0BRwLfS0QjGjiuGmlAmBucSVRiM1UrDfJixcEUZYNKe
8SnLenjgt1Kjfi2l68v6S3LLvefA3TPCvu9PsP7PvbHCZsILa95q+u8eIQS8FwDhMbaLVDZsbg6B
GvWxR3TQ28PxoLGqWL+SyoxerK114Vwl
--00000000000093100c061a5cecf7--

