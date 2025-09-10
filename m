Return-Path: <linux-kselftest+bounces-41203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1803B52368
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79221C2331B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184930FC23;
	Wed, 10 Sep 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zk6DwjOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22485272807
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539437; cv=none; b=Uth+RuZI7Sb90nvmEqhpU5acw0Zm77ckXF41KPEnenJn3k05MV9r9BkRi9n0HNzTea8YUI8EE6dUPsx4PjlE8M3qI4I7/XIFQ2errOA649WplhhyyLX0ENSeflLi4s9bErtJA6nSdfUuQkYPztYrdRVTIqTjTb4bf6kavw43DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539437; c=relaxed/simple;
	bh=d4u2croQRqHeFHDIJ1SzU/4czH4b6u4L198LRaiPE8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3hxyRmgwMzxsPGX1ViGtcmWr9nWfO1q4muk96zU8AKpSr1Q3QZe+zsZAb85TVWhegd0/opJwd2Z1L06TDsWDt7rScb/ION3cfevNofulJMYfFm2BTYCXG7Y8e4nGPcDsnIiTgFicKgEL/M68/RxMJsnf8TJEtu/4CpJlv5VvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zk6DwjOR; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6045eb3848eso28109d50.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757539435; x=1758144235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkAS8Cy65QDLj5I+d6oGhBN8bbmh1b9Rv/Sfz/w1PE8=;
        b=zk6DwjORw2+r2yK8W39qdTg7UEUe2tvLaDXAvEVmtPmg/qiMBg0I2SfFGmFigp4/rA
         nadYYKNCKeT9Kc86Sg6/SZkt26aBlbE77rgPMetTd9sTQe+JpPz4vAvrRtH2cugpBjeQ
         E1IfFnWbaY5LonyxcXlJ7H9uuZcqf+TglwScvWT/TloPVTYJ1Ow/4Tdux/FwdA4zHbMI
         Yty1dg/50yAB1Tgy+OKEGeKdo7e5UEjHh7GmNxW2LN8ZXvGrLqhRshXuLdD8XIFKazmE
         neudNsZvKXxyOcFUZx4TB02ARfJoMIhXUJplH9vTHSAwg169yLYifWuBVdm7/l70U7tR
         tIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757539435; x=1758144235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkAS8Cy65QDLj5I+d6oGhBN8bbmh1b9Rv/Sfz/w1PE8=;
        b=wqHfD6UgzjyyGwLN2Glmi6p8HUNDrxQ4tRmFEdgDv0NH8LjYqbGq6ycQNflkeDivZ0
         mjgkJexUxAGqLtO1kOhWgM2gF2CYH9Pn5Ugghhoxem7p39XTxa0vOLnaBWfvWnV9YBWy
         ZVPNpjGJNwe8w6ON4Y8L1zLLU6k+1ZyYurolzh5DsaGvP6Ki8f0QkYJDn5YVFVzrwhcj
         Hf33lI3hi3NJy9rYbo+rwr5zg+aM/nT1Oykp+DpLcigVzRXkmGzCKtHX6jFfIYnLnQik
         xhL0n7MkE9nQgtBRQd+uNIcCPri73Q7WRsW+iBZm+cO80ySsQJAUhpMX7L6W2h9WjmAY
         Guwg==
X-Forwarded-Encrypted: i=1; AJvYcCXJedUhhRoK7ztinw+/35SP9bufdeViX0rgCLvEAseFXS54UfDui0IpoNdzagp9yXLfTQKRv65xrOXW6DVK9rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOCNIvuMSF97RspGqOPmgaxk0yz8Co9s1u3QMcwUBjLdBCpEN
	jtZ7b32r0d45437sZq44b/01g0wv/yR4CwGanp2lKPjaCDA8IeW5RQh0nJLEd2r49t7hWSowG8F
	itWpr1Qp8UMRDUUTajHDAjrtv5/HMclJWPvbnWILc
X-Gm-Gg: ASbGnctw/4kDiYTqwAuH6d4CJwipVgAcPIpoey+cmiWbxl7JqdrXNQMpquaAuwmijKC
	a6nCLZPX6avWrlPIYc/bkEortqEcR/7DtWMIDYpMAMlkZg+nKA4Xpul+K3tAhEP9SbJ1f0Scefd
	O7HSRwO9a9sB4tszFGgpohZhH3ebUDCEwOdGtvCm0Sxi1ZHxNW/Ven4r/EQ+XBxZ7dy5aiI1EoX
	3VclHY0cADhN5OMRiH3PN8m13lvkMKqxTPKC+o816PE/xoE8yiH5JU=
X-Google-Smtp-Source: AGHT+IHZpuAIpP6eU8XgbFP1ihmPC/VQZiOoNU+Aq/FCti1zZ6kcOWyFQNZrZuCxHtYj7ukkLXh1f92vcgX3i27OpLw=
X-Received: by 2002:a05:690e:150f:b0:600:46e7:e51a with SMTP id
 956f58d0204a3-610274a362amr14607055d50.19.1757539434611; Wed, 10 Sep 2025
 14:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
In-Reply-To: <20250902111951.58315-2-kalyazin@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 10 Sep 2025 14:23:18 -0700
X-Gm-Features: Ac12FXxBiQR_yOnKkTX3Mj5Vty6qT5i1blDHt6xkWg63pMdSm1PpYlQkfLTvYk4
Message-ID: <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:20=E2=80=AFAM Kalyazin, Nikita <kalyazin@amazon.co=
.uk> wrote:
>
> From: Nikita Kalyazin <kalyazin@amazon.com>

Hi Nikita,

>
> write syscall populates guest_memfd with user-supplied data in a generic
> way, ie no vendor-specific preparation is performed.  This is supposed
> to be used in non-CoCo setups where guest memory is not
> hardware-encrypted.

What's meant to happen if we do use this for CoCo VMs? I would expect
write() to fail, but I don't see why it would (seems like we need/want
a check that we aren't write()ing to private memory).

> The following behaviour is implemented:
>  - only page-aligned count and offset are allowed
>  - if the memory is already allocated, the call will successfully
>    populate it
>  - if the memory is not allocated, the call will both allocate and
>    populate
>  - if the memory is already populated, the call will not repopulate it
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  virt/kvm/guest_memfd.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 08a6bc7d25b6..a2e86ec13e4b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -379,7 +379,9 @@ static int kvm_gmem_mmap(struct file *file, struct vm=
_area_struct *vma)
>  }
>
>  static struct file_operations kvm_gmem_fops =3D {
> -       .mmap           =3D kvm_gmem_mmap,
> +       .mmap           =3D kvm_gmem_mmap,
> +       .llseek         =3D default_llseek,
> +       .write_iter     =3D generic_perform_write,

You seem to have accidentally replaced some tabs with spaces here. :)
Please keep the style consistent.

>         .open           =3D generic_file_open,
>         .release        =3D kvm_gmem_release,
>         .fallocate      =3D kvm_gmem_fallocate,
> @@ -390,6 +392,63 @@ void kvm_gmem_init(struct module *module)
>         kvm_gmem_fops.owner =3D module;
>  }
>
> +static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
> +                                    struct address_space *mapping,
> +                                    loff_t pos, unsigned int len,
> +                                    struct folio **foliop,
> +                                    void **fsdata)
> +{
> +       struct file *file =3D kiocb->ki_filp;
> +       pgoff_t index =3D pos >> PAGE_SHIFT;
> +       struct folio *folio;
> +
> +       if (!PAGE_ALIGNED(pos) || len !=3D PAGE_SIZE)
> +               return -EINVAL;

Requiring pos to be page-aligned seems like a strange restriction, and
requiring len to be exactly PAGE_SIZE just seems wrong. I don't see
any reason why the below logic can't be made to work with an
unrestricted pos and len (in other words, I don't see how guest_memfd
is special vs other filesystems in this regard).

> +
> +       if (pos + len > i_size_read(file_inode(file)))
> +               return -EINVAL;
> +
> +       folio =3D kvm_gmem_get_folio(file_inode(file), index);
> +       if (IS_ERR(folio))
> +               return -EFAULT;
> +
> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> +               folio_unlock(folio);
> +               folio_put(folio);
> +               return -EFAULT;
> +       }
> +
> +       if (folio_test_uptodate(folio)) {
> +               folio_unlock(folio);
> +               folio_put(folio);
> +               return -ENOSPC;

Does it actually matter for the folio not to be uptodate? It seems
unnecessarily restrictive not to be able to overwrite data if we're
saying that this is only usable for unencrypted memory anyway.

Is ENOSPC really the right errno for this? (Maybe -EFAULT?)

> +       }
> +
> +       *foliop =3D folio;
> +       return 0;
> +}
> +
> +static int kvm_kmem_gmem_write_end(const struct kiocb *kiocb,
> +                                  struct address_space *mapping,
> +                                  loff_t pos, unsigned int len,
> +                                  unsigned int copied,
> +                                  struct folio *folio, void *fsdata)
> +{
> +       if (copied) {
> +               if (copied < len) {
> +                       unsigned int from =3D pos & (PAGE_SIZE - 1);

How about:

unsigned int from  =3D pos & ((1UL << folio_order(*folio)) - 1)

So that we don't need to require !folio_test_large() in
kvm_kmem_gmem_write_begin().

> +
> +                       folio_zero_range(folio, from + copied, len - copi=
ed);
> +               }
> +               kvm_gmem_mark_prepared(folio);
> +       }
> +
> +       folio_unlock(folio);
> +       folio_put(folio);
> +
> +       return copied;
> +}
> +
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
>                                   struct folio *dst, struct folio *src,
>                                   enum migrate_mode mode)
> @@ -442,6 +501,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>
>  static const struct address_space_operations kvm_gmem_aops =3D {
>         .dirty_folio =3D noop_dirty_folio,
> +       .write_begin =3D kvm_kmem_gmem_write_begin,
> +       .write_end =3D kvm_kmem_gmem_write_end,
>         .migrate_folio  =3D kvm_gmem_migrate_folio,
>         .error_remove_folio =3D kvm_gmem_error_folio,
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> @@ -489,6 +550,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t =
size, u64 flags)
>         }
>
>         file->f_flags |=3D O_LARGEFILE;
> +       file->f_mode |=3D FMODE_LSEEK | FMODE_PWRITE;
>
>         inode =3D file->f_inode;
>         WARN_ON(file->f_mapping !=3D inode->i_mapping);
> --
> 2.50.1
>

