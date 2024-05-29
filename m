Return-Path: <linux-kselftest+bounces-10818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFA8D2BA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 06:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B82876AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165215B12D;
	Wed, 29 May 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXPpr6c0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1410F4;
	Wed, 29 May 2024 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955367; cv=none; b=R6sFWlS09FngHhphQUkzUH9snNtbCisMI8zBxD/m7xw2OoE0LGTdl//CQa1QQdqKMhfh4AhIeZCIR+U8emWQ0fmEF0HJcW3Lk83UNtoD6lZzREiOy/sebRGtIvM7zp76Gk/fXCeObkNs7zK16qG68WyLRHPn97HJW9WjOU1x/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955367; c=relaxed/simple;
	bh=lxC/S3iBDvLQFDA6HbrEv0F9SmQ+A/SqEV8xkQ9UrH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGE18yjPKdiaXIhz768Bhc8heNzGatFj83p5v5RaO/TfhKQ/LsiwlR4eggPOxEWVDe1/mpgz684svSHdY6Ys0Ke2fGU6Wjcts/ksiwKDn/P9KZiG6SnuX1Kj4c+bX3axYIZX/f09epeRv88qTA5B5wJys0eZMyEPl3tb0N5Sfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXPpr6c0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202ca70270so19134935e9.3;
        Tue, 28 May 2024 21:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716955363; x=1717560163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUQ7rQZYzQapUhz9VctJrkZnstSdpS0FQ8DXDeIk2CE=;
        b=XXPpr6c0KNt/RLOemsKiR8pfqMn68UU31j+0+FCafHU1bsKr7COC0T6RdvkoVss+gy
         zgamnraOuqjG877XDjeNR3kNQxgxnPxbQYVoJ9pm5ZrjWF/emhPhEPEkh1z1gqtmnvDQ
         PSroD6FZOHZ7zCAal6CB/cNLGpFaxpvnTilMlvYYCxqC2cLK98N7SJikHOLxv7t4yadg
         A4kA1Vk+Z9ZPpMHF2E3zbYmKlehy5FzZgpff02fgbE+anykzkVhSbCsHRL2hMoZkPrQE
         thbvCEJiqHvQ3qDkNeInFOHnhlUQhZ4ElLKSaquxWRrDY54nzgC6w9Xv1sRtfgvaMsig
         M6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955363; x=1717560163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUQ7rQZYzQapUhz9VctJrkZnstSdpS0FQ8DXDeIk2CE=;
        b=wR+3TKdu/fXYxaKrVHeuYUYcgdPwR1KtzrbPnlddAu7lfrLLY1OPpB1SikEHFMABDc
         xAZvEZKigt5NFCZFxLZH/rMx3hWiVNtFQutC4HqhDbIg54thd9FO3x2lNqdmPUS1iSxt
         ZcPKrPy/hPiaoL7hb2/CKyYZuNJA8SzSBSmlPC7jrCvSTw/HOjJfmYY3U1Wi/hfxgVnT
         kwwcLvPJfwxNqlMRSK1z8M1QrOZn3PPPQKe6x6VyQsK1U/JGsBYV0ffhS0+uO60jhXJM
         Vj8262PWQOtbK4pMW8jK66lgVILMFP5ihL4+NF6wbe1SXa136X37qcFf+wrdYUoDFwBU
         ESEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnon7ExMfZsJaKKywXe/VbRCAgvpWJDWlT60mH4L4Y/l9oypSQ04+dlBDUll8U4DJI4UhZXtDlGzbFSiJnGFhZBcRKK/uEf6Pv5bLpLsNgAr7q8SMbCq5t1PkvCvLXBBYvGl00N35eJ6MdFKZOygxy/bN7YcNrUKqKCtyyQrHxQ1SzZQcqj/p1kAIOXU2pqIP5+XoTLzgZbC1lrdCtzCD+7yO+oAIcEiEIN9QUu1/lLyU2/aM20llAKM4=
X-Gm-Message-State: AOJu0Ywr50cWLJUGLpPkCix1H7EQKlFfYyQ0uJOcN469GItvVijUGeWq
	rzPuT8FeOVvoFpha8crGr0WeSV1V14qhwUil9bYOtXRJAXFLlEEh5I9h4w492UkwjJLl6GRnThT
	+oYLT1oQ8kP3zvrO8CgrD1RDL3I9pSCAm
X-Google-Smtp-Source: AGHT+IEcc0R/3aTXwhzekGq6976I5/Bgh/+z7I78iDqWQ4ACqC9Bv2FYZa0tJo6a6tq+gaXKPiDOI0GfUi9+dMXph7Q=
X-Received: by 2002:a05:600c:5129:b0:421:1fb1:fe00 with SMTP id
 5b1f17b1804b1-4211fb1fecbmr38409115e9.17.1716955363165; Tue, 28 May 2024
 21:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org> <20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-3-8c6663df27d8@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 May 2024 21:02:31 -0700
Message-ID: <CAADnVQJbc4uVmhh+ABPMBGFjTYwQQp3wGLeTBYEUWti3R8V8aw@mail.gmail.com>
Subject: Re: [PATCH HID 03/13] HID: bpf: implement HID-BPF through bpf_struct_ops
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:15=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> We do this implementation in several steps to not have the CI failing:
> - first (this patch), we add struct_ops while keeping the existing infra
>   available
> - then we change the selftests, the examples and the existing in-tree
>   HID-BPF programs
> - then we remove the existing trace points making old HID-BPF obsolete
>
> There are a few advantages of struct_ops over tracing:
> - compatibility with sleepable programs (for hid_hw_raw_request() in
>   a later patch)
> - a lot simpler in the kernel: it's a simple rcu protected list
> - we can add more parameters to the function called without much trouble
> - the "attach" is now generic through BPF-core: the caller just needs to
>   set hid_id and flags before calling __load().
> - all the BPF tough part is not handled in BPF-core through generic
>   processing
> - hid_bpf_ctx is now only writable where it needs be
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/Makefile             |   2 +-
>  drivers/hid/bpf/hid_bpf_dispatch.c   |  52 +++++++-
>  drivers/hid/bpf/hid_bpf_dispatch.h   |   4 +
>  drivers/hid/bpf/hid_bpf_jmp_table.c  |   3 +
>  drivers/hid/bpf/hid_bpf_struct_ops.c | 246 +++++++++++++++++++++++++++++=
++++++
>  include/linux/hid_bpf.h              |  64 ++++++++-
>  6 files changed, 362 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/bpf/Makefile b/drivers/hid/bpf/Makefile
> index cf55120cf7d6..1cb3f31e9335 100644
> --- a/drivers/hid/bpf/Makefile
> +++ b/drivers/hid/bpf/Makefile
> @@ -8,4 +8,4 @@ LIBBPF_INCLUDE =3D $(srctree)/tools/lib
>  obj-$(CONFIG_HID_BPF) +=3D hid_bpf.o
>  CFLAGS_hid_bpf_dispatch.o +=3D -I$(LIBBPF_INCLUDE)
>  CFLAGS_hid_bpf_jmp_table.o +=3D -I$(LIBBPF_INCLUDE)
> -hid_bpf-objs +=3D hid_bpf_dispatch.o hid_bpf_jmp_table.o
> +hid_bpf-objs +=3D hid_bpf_dispatch.o hid_bpf_jmp_table.o hid_bpf_struct_=
ops.o
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index c8bb79ce2354..7216c3c7713d 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -58,6 +58,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, =
enum hid_report_type type
>                 },
>                 .data =3D hdev->bpf.device_data,
>         };
> +       struct hid_bpf_ops *e;
>         int ret;
>
>         if (type >=3D HID_REPORT_TYPES)
> @@ -70,9 +71,25 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev,=
 enum hid_report_type type
>         memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
>         memcpy(ctx_kern.data, data, *size);
>
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {

In the typical case there will be only one prog per device, right?
The for_each is future proofing?

> +               if (e->hid_device_event) {
> +                       ret =3D e->hid_device_event(&ctx_kern.ctx, type);
> +                       if (ret < 0) {
> +                               rcu_read_unlock();
> +                               return ERR_PTR(ret);
> +                       }
> +
> +                       if (ret)
> +                               ctx_kern.ctx.retval =3D ret;
> +               }
> +       }
> +       rcu_read_unlock();
> +
>         ret =3D hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_DEVICE_EVENT, &c=
tx_kern);
>         if (ret < 0)
>                 return ERR_PTR(ret);
> +       ret =3D ctx_kern.ctx.retval;
>
>         if (ret) {
>                 if (ret > ctx_kern.ctx.allocated_size)
> @@ -122,7 +139,10 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev=
, u8 *rdesc, unsigned int *s
>
>         memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_D=
ESCRIPTOR_SIZE));
>
> -       ret =3D hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ct=
x_kern);
> +       if (hdev->bpf.rdesc_ops)
> +               ret =3D hdev->bpf.rdesc_ops->hid_rdesc_fixup(&ctx_kern.ct=
x);
> +       else
> +               ret =3D hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FI=
XUP, &ctx_kern);

This is for backward compat?
I don't see it's being removed in the later patches.

>         if (ret < 0)
>                 goto ignore_bpf;
>
> @@ -150,7 +170,7 @@ static int device_match_id(struct device *dev, const =
void *id)
>         return hdev->id =3D=3D *(int *)id;
>  }
>
> -static struct hid_device *hid_get_device(unsigned int hid_id)
> +struct hid_device *hid_get_device(unsigned int hid_id)
>  {
>         struct device *dev;
>
> @@ -164,7 +184,7 @@ static struct hid_device *hid_get_device(unsigned int=
 hid_id)
>         return to_hid_device(dev);
>  }
>
> -static void hid_put_device(struct hid_device *hid)
> +void hid_put_device(struct hid_device *hid)
>  {
>         put_device(&hid->dev);
>  }
> @@ -205,7 +225,7 @@ static int __hid_bpf_allocate_data(struct hid_device =
*hdev, u8 **data, u32 *size
>         return 0;
>  }
>
> -static int hid_bpf_allocate_event_data(struct hid_device *hdev)
> +int hid_bpf_allocate_event_data(struct hid_device *hdev)
>  {
>         /* hdev->bpf.device_data is already allocated, abort */
>         if (hdev->bpf.device_data)
> @@ -592,14 +612,22 @@ static const struct btf_kfunc_id_set hid_bpf_syscal=
l_kfunc_set =3D {
>
>  int hid_bpf_connect_device(struct hid_device *hdev)
>  {
> -       struct hid_bpf_prog_list *prog_list;
> +       bool need_to_allocate =3D false;
> +       struct hid_bpf_ops *e;
>
>         rcu_read_lock();
> -       prog_list =3D rcu_dereference(hdev->bpf.progs[HID_BPF_PROG_TYPE_D=
EVICE_EVENT]);
> +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> +               if (e->hid_device_event) {
> +                       need_to_allocate =3D true;
> +                       break;
> +               }
> +       }
> +       if (rcu_dereference(hdev->bpf.progs[HID_BPF_PROG_TYPE_DEVICE_EVEN=
T]))
> +               need_to_allocate =3D true;
>         rcu_read_unlock();
>
>         /* only allocate BPF data if there are programs attached */
> -       if (!prog_list)
> +       if (!need_to_allocate)
>                 return 0;
>
>         return hid_bpf_allocate_event_data(hdev);
> @@ -623,12 +651,15 @@ void hid_bpf_destroy_device(struct hid_device *hdev=
)
>         hdev->bpf.destroyed =3D true;
>
>         __hid_bpf_destroy_device(hdev);
> +       __hid_bpf_ops_destroy_device(hdev);
>  }
>  EXPORT_SYMBOL_GPL(hid_bpf_destroy_device);
>
>  void hid_bpf_device_init(struct hid_device *hdev)
>  {
>         spin_lock_init(&hdev->bpf.progs_lock);
> +       INIT_LIST_HEAD(&hdev->bpf.prog_list);
> +       mutex_init(&hdev->bpf.prog_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(hid_bpf_device_init);
>
> @@ -662,6 +693,13 @@ static int __init hid_bpf_init(void)
>                 return 0;
>         }
>
> +       /* register struct_ops kfuncs after we are sure we can load our p=
reloaded bpf program */
> +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &hid_=
bpf_kfunc_set);
> +       if (err) {
> +               pr_warn("error while setting HID BPF tracing kfuncs: %d",=
 err);
> +               return 0;
> +       }
> +
>         /* register syscalls after we are sure we can load our preloaded =
bpf program */
>         err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf=
_syscall_kfunc_set);
>         if (err) {
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf=
_dispatch.h
> index fbe0639d09f2..e52c43d81650 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.h
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.h
> @@ -10,12 +10,16 @@ struct hid_bpf_ctx_kern {
>         u8 *data;
>  };
>
> +struct hid_device *hid_get_device(unsigned int hid_id);
> +void hid_put_device(struct hid_device *hid);
> +int hid_bpf_allocate_event_data(struct hid_device *hdev);
>  int hid_bpf_preload_skel(void);
>  void hid_bpf_free_links_and_skel(void);
>  int hid_bpf_get_prog_attach_type(struct bpf_prog *prog);
>  int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_typ=
e prog_type, int prog_fd,
>                           struct bpf_prog *prog, __u32 flags);
>  void __hid_bpf_destroy_device(struct hid_device *hdev);
> +void __hid_bpf_ops_destroy_device(struct hid_device *hdev);
>  int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type typ=
e,
>                      struct hid_bpf_ctx_kern *ctx_kern);
>  int hid_bpf_reconnect(struct hid_device *hdev);
> diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bp=
f_jmp_table.c
> index aa8e1c79cdf5..8a54ba447718 100644
> --- a/drivers/hid/bpf/hid_bpf_jmp_table.c
> +++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
> @@ -81,6 +81,9 @@ static int hid_bpf_program_count(struct hid_device *hde=
v,
>         if (type >=3D HID_BPF_PROG_TYPE_MAX)
>                 return -EINVAL;
>
> +       if (type =3D=3D HID_BPF_PROG_TYPE_RDESC_FIXUP && hdev->bpf.rdesc_=
ops)
> +               n +=3D 1;
> +
>         FOR_ENTRIES(i, jmp_table.tail, jmp_table.head) {
>                 struct hid_bpf_prog_entry *entry =3D &jmp_table.entries[i=
];
>
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> new file mode 100644
> index 000000000000..be514a98e55b
> --- /dev/null
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + *  HID-BPF support for Linux
> + *
> + *  Copyright (c) 2024 Benjamin Tissoires
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/filter.h>
> +#include <linux/hid.h>
> +#include <linux/hid_bpf.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/workqueue.h>
> +#include "hid_bpf_dispatch.h"
> +
> +static struct btf *hid_bpf_ops_btf;
> +
> +static int hid_bpf_ops_init(struct btf *btf)
> +{
> +       hid_bpf_ops_btf =3D btf;
> +       return 0;
> +}
> +
> +static bool hid_bpf_ops_is_valid_access(int off, int size,
> +                                         enum bpf_access_type type,
> +                                         const struct bpf_prog *prog,
> +                                         struct bpf_insn_access_aux *inf=
o)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static int hid_bpf_ops_check_member(const struct btf_type *t,
> +                                     const struct btf_member *member,
> +                                     const struct bpf_prog *prog)
> +{
> +       u32 moff =3D __btf_member_bit_offset(t, member) / 8;
> +

this is good...

> +       switch (moff) {
> +       case offsetof(struct hid_bpf_ops, hid_rdesc_fixup):
> +               break;
> +       default:
> +               if (prog->sleepable)
> +                       return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> +                                          const struct bpf_reg_state *re=
g,
> +                                          int off, int size)
> +{
> +       const struct btf_type *state;
> +       const struct btf_type *t;
> +       s32 type_id;
> +
> +       type_id =3D btf_find_by_name_kind(reg->btf, "hid_bpf_ctx",
> +                                       BTF_KIND_STRUCT);
> +       if (type_id < 0)
> +               return -EINVAL;
> +
> +       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> +       state =3D btf_type_by_id(reg->btf, type_id);
> +       if (t !=3D state) {
> +               bpf_log(log, "only access to hid_bpf_ctx is supported\n")=
;
> +               return -EACCES;
> +       }
> +
> +       /* out-of-bound access in hid_bpf_ctx */
> +       if (off + size > sizeof(struct hid_bpf_ctx)) {
> +               bpf_log(log, "write access at off %d with size %d\n", off=
, size);
> +               return -EACCES;
> +       }
> +
> +       if (off < offsetof(struct hid_bpf_ctx, retval)) {
> +               bpf_log(log,
> +                       "write access at off %d with size %d on read-only=
 part of hid_bpf_ctx\n",
> +                       off, size);
> +               return -EACCES;
> +       }
> +
> +       return NOT_INIT;
> +}
> +
> +static const struct bpf_verifier_ops hid_bpf_verifier_ops =3D {
> +       .is_valid_access =3D hid_bpf_ops_is_valid_access,
> +       .btf_struct_access =3D hid_bpf_ops_btf_struct_access,
> +};
> +
> +static int hid_bpf_ops_init_member(const struct btf_type *t,
> +                                const struct btf_member *member,
> +                                void *kdata, const void *udata)
> +{
> +       u32 flags;
> +
> +       switch (member->offset) {
> +       case offsetof(struct hid_bpf_ops, hid_id) * 8:

but here you're open coding it and adding ugly * 8
Just do:
        moff =3D __btf_member_bit_offset(t, member) / 8;
        switch (moff) {
        case offsetof(struct tcp_congestion_ops, flags):

the way bpf_tcp_ca.c is doing?
Open code of ->offset is asking for trouble.

> +               /* For hid_id and flags fields, this function has to copy=
 it
> +                * and return 1 to indicate that the data has been handle=
d by
> +                * the struct_ops type, or the verifier will reject the m=
ap if
> +                * the value of those fields is not zero.
> +                */
> +               ((struct hid_bpf_ops *)kdata)->hid_id =3D ((struct hid_bp=
f_ops *)udata)->hid_id;
> +               return 1;
> +       case offsetof(struct hid_bpf_ops, flags) * 8:
> +               flags =3D ((struct hid_bpf_ops *)udata)->flags;
> +               if (flags & ~HID_BPF_FLAG_MASK)
> +                       return -EINVAL;
> +               ((struct hid_bpf_ops *)kdata)->flags =3D flags;
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static int hid_bpf_reg(void *kdata)
> +{
> +       struct hid_bpf_ops *ops =3D kdata;
> +       struct hid_device *hdev;
> +       int count, err =3D 0;
> +
> +       hdev =3D hid_get_device(ops->hid_id);
> +       if (IS_ERR(hdev))
> +               return PTR_ERR(hdev);
> +
> +       ops->hdev =3D hdev;
> +
> +       mutex_lock(&hdev->bpf.prog_list_lock);
> +
> +       count =3D list_count_nodes(&hdev->bpf.prog_list);
> +       if (count >=3D HID_BPF_MAX_PROGS_PER_DEV) {
> +               err =3D -E2BIG;
> +               goto out_unlock;
> +       }
> +
> +       if (ops->hid_rdesc_fixup) {
> +               if (hdev->bpf.rdesc_ops) {
> +                       err =3D -EINVAL;
> +                       goto out_unlock;
> +               }
> +
> +               hdev->bpf.rdesc_ops =3D ops;
> +       }
> +
> +       if (ops->hid_device_event) {
> +               err =3D hid_bpf_allocate_event_data(hdev);
> +               if (err)
> +                       goto out_unlock;
> +       }
> +
> +       if (ops->flags & HID_BPF_FLAG_INSERT_HEAD)
> +               list_add_rcu(&ops->list, &hdev->bpf.prog_list);
> +       else
> +               list_add_tail_rcu(&ops->list, &hdev->bpf.prog_list);

Looks like future proofing, but I feel it's too little to materialize.
Take a look at include/linux/bpf_mprog.h
I suspect it might be useful here too.

> +
> +out_unlock:
> +       mutex_unlock(&hdev->bpf.prog_list_lock);
> +
> +       if (err) {
> +               if (hdev->bpf.rdesc_ops =3D=3D ops)
> +                       hdev->bpf.rdesc_ops =3D NULL;
> +               hid_put_device(hdev);
> +       } else if (ops->hid_rdesc_fixup) {
> +               hid_bpf_reconnect(hdev);
> +       }
> +
> +       return err;
> +}
> +
> +static void hid_bpf_unreg(void *kdata)
> +{
> +       struct hid_bpf_ops *ops =3D kdata;
> +       struct hid_device *hdev;
> +       bool reconnect =3D false;
> +
> +       hdev =3D ops->hdev;
> +
> +       /* check if __hid_bpf_ops_destroy_device() has been called */
> +       if (!hdev)
> +               return;
> +
> +       mutex_lock(&hdev->bpf.prog_list_lock);
> +
> +       list_del_rcu(&ops->list);
> +
> +       reconnect =3D hdev->bpf.rdesc_ops =3D=3D ops;
> +       if (reconnect)
> +               hdev->bpf.rdesc_ops =3D NULL;
> +
> +       mutex_unlock(&hdev->bpf.prog_list_lock);
> +
> +       if (reconnect)
> +               hid_bpf_reconnect(hdev);
> +
> +       hid_put_device(hdev);
> +}
> +
> +static int __hid_bpf_device_event(struct hid_bpf_ctx *ctx, enum hid_repo=
rt_type type)
> +{
> +       return 0;
> +}
> +
> +static int __hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
> +{
> +       return 0;
> +}
> +
> +static struct hid_bpf_ops __bpf_hid_bpf_ops =3D {
> +       .hid_device_event =3D __hid_bpf_device_event,
> +       .hid_rdesc_fixup =3D __hid_bpf_rdesc_fixup,
> +};
> +
> +static struct bpf_struct_ops bpf_hid_bpf_ops =3D {
> +       .verifier_ops =3D &hid_bpf_verifier_ops,
> +       .init =3D hid_bpf_ops_init,
> +       .check_member =3D hid_bpf_ops_check_member,
> +       .init_member =3D hid_bpf_ops_init_member,
> +       .reg =3D hid_bpf_reg,
> +       .unreg =3D hid_bpf_unreg,
> +       .name =3D "hid_bpf_ops",
> +       .cfi_stubs =3D &__bpf_hid_bpf_ops,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
> +{
> +       struct hid_bpf_ops *e;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> +               hid_put_device(hdev);
> +               e->hdev =3D NULL;
> +       }
> +       rcu_read_unlock();
> +}
> +
> +static int __init hid_bpf_struct_ops_init(void)
> +{
> +       return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
> +}
> +late_initcall(hid_bpf_struct_ops_init);
> diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> index a66103618e6e..96495e977204 100644
> --- a/include/linux/hid_bpf.h
> +++ b/include/linux/hid_bpf.h
> @@ -65,11 +65,12 @@ struct hid_bpf_ctx {
>   * @HID_BPF_FLAG_INSERT_HEAD: insert the given program before any other =
program
>   *                            currently attached to the device. This doe=
sn't
>   *                            guarantee that this program will always be=
 first
> - * @HID_BPF_FLAG_MAX: sentinel value, not to be used by the callers
>   */
>  enum hid_bpf_attach_flags {
>         HID_BPF_FLAG_NONE =3D 0,
>         HID_BPF_FLAG_INSERT_HEAD =3D _BITUL(0),
> +
> +       /* private: internal use only */
>         HID_BPF_FLAG_MAX,
>  };
>
> @@ -112,6 +113,63 @@ struct hid_ops {
>
>  extern struct hid_ops *hid_ops;
>
> +/**
> + * struct hid_bpf_ops - A BPF struct_ops of callbacks allowing to attach=
 HID-BPF
> + *                     programs to a HID device
> + * @hid_id: the HID uniq ID to attach to. This is writeable before ``loa=
d()``, and
> + *         cannot be changed after
> + * @flags: &enum hid_bpf_attach_flags to assign flags before ``load()``.
> + *        Writeable only before ``load()``
> + */
> +struct hid_bpf_ops {
> +       /* hid_id needs to stay first so we can easily change it
> +        * from userspace.
> +        */

hmm.
patch 5 just does:
+       skel->struct_ops.mouse_invert->hid_id =3D hid_id;

I don't see a reason why it needs to be first.

> +       int                     hid_id;
> +       u32                     flags;
> +
> +       /* private: internal use only */
> +       struct list_head        list;
> +
> +       /* public: rest is public */
> +
> +/* fast path fields are put first to fill one cache line */
> +
> +       /**
> +        * @hid_device_event: called whenever an event is coming in from =
the device
> +        *
> +        * It has the following arguments:
> +        *
> +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> +        *
> +        * Return: %0 on success and keep processing; a positive
> +        * value to change the incoming size buffer; a negative
> +        * error code to interrupt the processing of this event
> +        *
> +        * Context: Interrupt context.
> +        */
> +       int (*hid_device_event)(struct hid_bpf_ctx *ctx, enum hid_report_=
type report_type);
> +
> +/* control/slow paths put last */
> +
> +       /**
> +        * @hid_rdesc_fixup: called when the probe function parses the re=
port descriptor
> +        * of the HID device
> +        *
> +        * It has the following arguments:
> +        *
> +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> +        *
> +        * Return: %0 on success and keep processing; a positive
> +        * value to change the incoming size buffer; a negative
> +        * error code to interrupt the processing of this device
> +        */
> +       int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);

It's fine since you want to keep the prog mostly unchanged,
but since the whole api is improving maybe it's time
to do something about hid_bpf_ctx in all callbacks?
Pass into prog what prog needs to see.
In the old api all progs had to have a common hid_bpf_ctx.
With struct-ops it can be fine tuned.

Overall it looks great.
hid_id did the trick :)

