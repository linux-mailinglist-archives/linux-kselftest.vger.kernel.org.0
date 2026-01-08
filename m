Return-Path: <linux-kselftest+bounces-48549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC0D0574C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FA23010507
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5E310645;
	Thu,  8 Jan 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9tDBaeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189D30FC10
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896454; cv=none; b=HMUm5BpqEOfdR3HnbvunpFDu5aynSwrjCCoDIhkWUT4wFYUBtXfYiWSGs0J0xv3sShOKpDZ47QVmqwe7kYVvuwT6biYB4d1TeW6IhESdrxG5fcdvgshGBsNptKYsBwoXLf0l19WhIf8QqU1i6Sn+BmvT7v2ur1vNWe1tm0MOJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896454; c=relaxed/simple;
	bh=GzuqYe/6g3NXsycaPJ3wfrGJWIZ9Zq2hM7oJaoMdsKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCLzUzvuVqE/1P6zr82fTsAi7QbRtZhu3LTDbSrlEBIGrurvPCuMRV0lNkPJm1XwpgCpHJiou9A69owt78JTfdQ83LJUZKtc87Xi0/ZBpvYC/FTp5SqahSM5udBZncpBi/5u5CYWf0/C0sPkfmpiBzMBNgJnJrZ6P308HXwT+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9tDBaeN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59431f57bf6so3877387e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767896451; x=1768501251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIWbnb8wuVC6CuULSZXd500nKi+vGu5lt07cRCcuv7s=;
        b=l9tDBaeNp3+kLcEW9d+Kldiz02VwGoT24dhp+LJ0gXfy8BkIyYYExSmxwSGS/m3mRL
         7wQvums+dk/OcEdVvNZjpLz84J/VFviM6EO7Khl6bl5aeGE4tX/X7mHzyahJA9kBJGMl
         nlywFHjqG1Ts7YaIWh7YgpKAQjXtj5lutGG20naWUWacg/25D0UvUk/OqbaKSyp6BkPC
         p2LkCiGHjc0EeBrVl9EDq/oRIG38q/boQsY8cq32Wi3Wc2pAOrcA+jm66qhjTMTmcc9F
         hBjqwPMqC7V0QIXgIrj9zksRCVQsS7kSPnyH9o3XsnVw1+IFBHiywgFAnespzXwrONwO
         z07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896451; x=1768501251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIWbnb8wuVC6CuULSZXd500nKi+vGu5lt07cRCcuv7s=;
        b=oLGoZNQCe4BMbjxHO5Kr4/bOjgBCWnIj5hf0TLecvbGtIXLivx9CAicdx9bUbQpF8e
         M1Bq+nYW7YHASODeY8oBzzxwMbEM1a6+M9u+BA0YWaan0kCFN7bIAu7xkZFdn7+SnATD
         pwypuV3VRfR+1IHlrwbGHxcyy4E1fe6AeKDv1Ntac03Z4LqYsuC3WLL5J8w+oRZMGeRo
         S7NL7kHN+6PRlswbzF4bnYmQxOhzOTvH+dJVjkf5wKsa5mtVu3KhCjfS6zEBwDAbyif0
         ga0njpp8028PN+nFNhuTNzZAJbbUdkMhIrWCu9SgBSUhipdge337ksekc1jua93GceW2
         lo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTOYo4UM2fpNiGZEt6QJGuwC4D5qafQN5AV31gP6nDH0fhxPfnZay2gS2n0pTm/2AjX09hhz6Yb54JxZqCyqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAi1U9utffKLYsTCh2U3tYpEjab/tRibARW7gVkjkVSOkxsg8
	qILMVrM7Ri82j62Jg8CA258qrcXKkoFE6gPugd/vGd+k9D9TihsoGJfl3FcYmVXdNKbdL+MQyHQ
	uq0HsBRkNy9z/RKwE7/SzO2oUkxSBaYDbUFkyqisY
X-Gm-Gg: AY/fxX6H3GLaGzmySwr+z4j+J8+tR4oeVjnLX4oPofN4gfLU8f2iog2HmqasGz9z4bt
	mRqEDACXCQ3YFsOt5ntYXrPbhvUz1ulFoOTY3vE/95CjFmvdTjyS3iDTTUgfveKX53qOYqgetB4
	aSGPnxDPeaiB5Gm5ho+iSJIY5OIWM9nrgDdALVamX1LAunzU7+6YP26ACbFcdHXOkbceC3/i4tI
	+O4Fnm4ahJe/A1nXvhBo+inSi3kHOeneC+e70koIEj6/OWfwqLQhTfARMkbWBveuBW5rvJ+
X-Google-Smtp-Source: AGHT+IGlNr+3Kfg1ZZ1Rz3y9SDsVCFvv2d1eRF6oYKoBZYZUZix/Hoq5N+7xb5AEgTcbVMLSMIeLtGWM+CA8pDiBRA8=
X-Received: by 2002:a05:6512:33ca:b0:59b:77f8:910a with SMTP id
 2adb3069b0e04-59b77f89309mr957015e87.19.1767896450308; Thu, 08 Jan 2026
 10:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com> <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com> <20260108084208.30edd533@shazbot.org>
In-Reply-To: <20260108084208.30edd533@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Thu, 8 Jan 2026 10:20:22 -0800
X-Gm-Features: AQt7F2qKH486tR5MMOncEkjWyL_zCi9lKI_qFkK-DGaW8N_GezgP57tFurPCsY0
Message-ID: <CALzav=ctJBKYsYQ47XMHDQ_whzF=XpcsN6B6GmGc9gy4-tPfzg@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:42=E2=80=AFAM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Wed, 7 Jan 2026 19:36:44 -0800
> Alex Mastro <amastro@fb.com> wrote:
> > On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> > >
> > > Speaking of, maybe we can add a test that creating writable IOMMU
> > > mappings fails for read-only BARs?
> >
> > I think I'll have to look into this as a follow-on. I'm not sure how to=
 validate
> > it yet without mocks or similar since I don't have such HW.
>
> I think the read-only aspect would be in the mmap, not the BAR itself,
> ie. can we create a read-write DMA mapping to a read-only mmap.

Good point. So it'd be better to have a test of that in
vfio_dma_mapping_test. No need to use a BAR mapping.

> ROM BARs are the only BARs that are read-only, but they can share a
> decoder with the standard BARs and therefore have a separate enable in
> the BAR register itself.  Due to this, and their general usage, it's
> never been necessary to allow mmap of the ROM BAR, therefore we cannot
> actually DMA map the ROM BAR.  Thanks,

Ahh, good to know, thanks for the context!

