Return-Path: <linux-kselftest+bounces-41429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E90B55946
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 00:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438AC1C25AAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004B22FAFD;
	Fri, 12 Sep 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQvoDpDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BB220F24
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716485; cv=none; b=o9AuzXXbz1WDYtlBjusg8tjysj640/vgq1lpVscrb8dpwdtQTl97AFPur6LdxkrKmOPhIlmR9lJcBUJb3fxrsXlUXMQyhNqsu2uFnByKMFLBaiilwa/LiHSrAv0IhcdzAMW0cpP7lQ4DIpDipusgya6yUhwxS1RsEfrdEhwT+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716485; c=relaxed/simple;
	bh=+BDgsMX06Ju/kfaG0zZzie2LOuabqWLb2H21wc6L6XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2UFTKsrAAUAo8vCD39mrVYG1/p67h0eVpccMm/ltXWaEYGtSjjdwY0fRZUcazMRxWK8JkjGD8dGgLoeuyz1eRCqqCNEIwCfC5dTxjZuOwVvkI27mTz+Ab2GsJ8c6p38r8ZXwBWBGZ4B7CcL0aVxOvsjXp/1prH7pgsulsASM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQvoDpDf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-606b375eeb3so1262990d50.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757716483; x=1758321283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3zugougNjwzeyQ8N92kEFKnLBurBuSSiIdQ2OlaO4k=;
        b=yQvoDpDf5691pshA6v5+mZ05cq+ehXVKCqiMTQ2zx3M456Yc9G/WcnoB1o5kquiCKL
         2kvMbuLktV5wnnz0wUmEbRP2uaCmYjrRl+MTb4sgJU7KACrTsWxela1Sw4IcJx9crCLs
         SN/UiOzy6NR9dJI67TVDjLCRQB/dXnnNgYkTjfnzp8El78RMB37w8Ig98YQKbTrWjX4l
         h4wM5Knr7Zqu1F3oHgWf5PJtT4iaegjeH/0ia2RZ/d43CpDeo1Ocnpj0I3WL563ZEixM
         uMcbz/RAZLt4Hjmhoz7VYfitEnl0sg55kD0s5P8KFKe0WAOZl6qXz4SrSzY30/xTa+r2
         Z2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757716483; x=1758321283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3zugougNjwzeyQ8N92kEFKnLBurBuSSiIdQ2OlaO4k=;
        b=lX0ngk8wR71YlbGmqGP42mPAIycN7Q1JX1Kt/4LNpRGQApfs4M6ohVTo5Wvz7wh5IU
         LemJ8gc5ir2/wh5M+PMuP1jLAWLWpmnFnxmMTBRI3XNcFY92A484q6bqPeKtIfKnplLp
         ek7hfW+r80f3+CxJZVIodWyZK0dnS/D5itvtbDmpPKd24jLgiVz3NLfAi/ZA58Hyo2/m
         zp8W92UrsxhseDddU5pPcQ8j82akuT9yoT9GG1fOL2EOflYbUuc0UsuuAP3NG/2VxC1d
         p6KiCLFIDZKeIiQuKBFomeasNza266GESSx6PHgCj7RwCUwlOs+3cWXw88b0VJ7sXoBx
         cMTw==
X-Forwarded-Encrypted: i=1; AJvYcCXex/+YE5hovAK5HpIZVFO0frEq/OjMBck+Iq0jTH7OSzYMZ31mQ9K4gkGLOA3lSyCSK1Sb4FYi3ZbhBBYwf38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUI8MoLZKJtqV9yiQ5d/E95bzgZpIhylcnFEWN1nxlDpQbchH
	unMYSNrYBM6obnco9D81Yn94853MrulEeRNB5trBGz0wwVTPlPeUZntZUgt25vPk/duna6m2VMY
	T1QlwVT8y8adCgmJcwCHsB4XqsaSuhP5UQHn4QxFP
X-Gm-Gg: ASbGncutABCSv8vgnzYp0aunCywkyOWd1CWZ4sE/JR8o0TQKTLGkegSkyUeI45zfajz
	cXoZ0S3AmTN/neiD9J1IdO2llgBUDxJ7PRyTf2V6Tmw33iVWljSDJdyb70YChPLAUTEjuiYBgwe
	9w4AFSVULO50I53xqkY03QkJTcF+K7T8NVA755j7SGR+BshOaJgWnm9cjqzSNyDYCMIvCBrS0K9
	J9wNGombtKvo025JiFvlAICx9HD65Kvexy9lfIGWBA6
X-Google-Smtp-Source: AGHT+IH6Vti9lvQ8aUaABheCs9G3Hl3xVoC4+hQSx4/7LM8FjjVWBkZYCg/y4dcsvWJRkUBy/Nx2M5I2c/6Y8yIpI0U=
X-Received: by 2002:a05:690e:88:b0:62b:8ae5:3fb0 with SMTP id
 956f58d0204a3-62b8ae5402amr414384d50.0.1757716482689; Fri, 12 Sep 2025
 15:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com> <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
In-Reply-To: <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 12 Sep 2025 15:34:06 -0700
X-Gm-Features: AS18NWAw_XyCFedOeHxZhcAGyjfZOKpYwjL4OIfOUrwy6K1ggYgW8JlV5rraAH0
Message-ID: <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: kalyazin@amazon.com
Cc: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:15=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.co=
m> wrote:
>
>
>
> On 10/09/2025 22:23, James Houghton wrote:
> > On Tue, Sep 2, 2025 at 4:20=E2=80=AFAM Kalyazin, Nikita <kalyazin@amazo=
n.co.uk> wrote:
> >>
> >> From: Nikita Kalyazin <kalyazin@amazon.com>
> >
> > Hi Nikita,
>
> Hi James,
>
> Thanks for the review!

:) I hope it's actually helpful.

>
>
> >>
> >> write syscall populates guest_memfd with user-supplied data in a gener=
ic
> >> way, ie no vendor-specific preparation is performed.  This is supposed
> >> to be used in non-CoCo setups where guest memory is not
> >> hardware-encrypted.
> >
> > What's meant to happen if we do use this for CoCo VMs? I would expect
> > write() to fail, but I don't see why it would (seems like we need/want
> > a check that we aren't write()ing to private memory).
>
> I am not so sure that write() should fail even in CoCo VMs if we access
> not-yet-prepared pages.  My understanding was that the CoCoisation of
> the memory occurs during "preparation".  But I may be wrong here.

This sounds fine to me, but could you update the changelog with what
the behavior is for CoCo VMs and why we don't allow writing to the
same pages/regions twice? Something like:

"Although write() is only meant to be used for non-CoCo VMs, it is
valid for CoCo VMs as well: the written contents will be encrypted
(when the page is prepared). Because the contents may be encrypted, it
is nonsensical to write() again, so write()ing to prepared pages is
disallowed (even if the no memory encryption occurs). Furthermore, in
the near future, page preparation will also result in pages being
removed from the direct map, so there will be no direct map through
which to perform the second write()."

(This is all provided that it's actually okay to write() content that
will be encrypted... I don't know why that would be improper, but I'm
not exactly an expert here.)

> >> @@ -390,6 +392,63 @@ void kvm_gmem_init(struct module *module)
> >>          kvm_gmem_fops.owner =3D module;
> >>   }
> >>
> >> +static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
> >> +                                    struct address_space *mapping,
> >> +                                    loff_t pos, unsigned int len,
> >> +                                    struct folio **foliop,
> >> +                                    void **fsdata)
> >> +{
> >> +       struct file *file =3D kiocb->ki_filp;
> >> +       pgoff_t index =3D pos >> PAGE_SHIFT;
> >> +       struct folio *folio;
> >> +
> >> +       if (!PAGE_ALIGNED(pos) || len !=3D PAGE_SIZE)
> >> +               return -EINVAL;
> >
> > Requiring pos to be page-aligned seems like a strange restriction, and
> > requiring len to be exactly PAGE_SIZE just seems wrong. I don't see
> > any reason why the below logic can't be made to work with an
> > unrestricted pos and len (in other words, I don't see how guest_memfd
> > is special vs other filesystems in this regard).
>
> I don't have a real reason to apply those restrictions.  Happy to remove
> them, thanks.

Thanks! Presumably you'll make it so that any unaligned segments will
be left as zeroes; please describe this in the changelog as well. :)

> >> +
> >> +       if (pos + len > i_size_read(file_inode(file)))
> >> +               return -EINVAL;
> >> +
> >> +       folio =3D kvm_gmem_get_folio(file_inode(file), index);
> >> +       if (IS_ERR(folio))
> >> +               return -EFAULT;
> >> +
> >> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> >> +               folio_unlock(folio);
> >> +               folio_put(folio);
> >> +               return -EFAULT;
> >> +       }
> >> +
> >> +       if (folio_test_uptodate(folio)) {
> >> +               folio_unlock(folio);
> >> +               folio_put(folio);
> >> +               return -ENOSPC;
> >
> > Does it actually matter for the folio not to be uptodate? It seems
> > unnecessarily restrictive not to be able to overwrite data if we're
> > saying that this is only usable for unencrypted memory anyway.
>
> In the context of direct map removal [1] it does actually because when
> we mark a folio as prepared, we remove it from the direct map making it
> inaccessible to the way write() performs the copy.  It does not matter
> if direct map removal isn't enabled though.  Do you think it should be
> conditional?

Oh, good point. It's simpler (both to implement and to describe) to
disallow a second write() call in all cases (no matter if the direct
map for the page has been removed or if the contents have been
encrypted), so I'm all for leaving it unconditional like you have now.
Thanks!

>
> [1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.u=
k
>
> >
> > Is ENOSPC really the right errno for this? (Maybe -EFAULT?)
>
> I don't have a strong opinion here.  My reasoning was if the folio is
> already "sealed" by the direct map removal, then it is no longer a part
> of the "writable space", so -ENOSPC makes sense.  Maybe this intuition
> only works for me so I'm happy to change to -EFAULT if it looks less
> confusing.

Oh actually.... how about EEXIST? That feels like the most natural.
But also no strong opinion here.

Thanks for all the clarification, Nikita. :)

