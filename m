Return-Path: <linux-kselftest+bounces-46848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CCC991C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 21:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D36FB4E45F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 20:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFD27FD5A;
	Mon,  1 Dec 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Unn2FQm2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYy+il8B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C59279DA2
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622684; cv=none; b=oV/BQOTtAC1rcG7l08PxeKJeJ44OGU44sC9I2Quq6BAwhxlvfXuY4fbP5sJJsvKjzR3ohgFLiQewc5fbywnsXMLeONbj8Ga3EsTl3hVlOEotADph+v/6+3bJKY/MCb72aIJaNW0eU/aFRGswXRDbzr8k2XLOeLloy2/OQr2S5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622684; c=relaxed/simple;
	bh=vsZAi3omBycoWUJakELYM68CvQJgslx/EVgOEpPXSrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPAkXyAh61rHsIDBi41xTyQH3/efmWgMBCh7Ew+OnrFzOhBwP2UQqgSTnYM/J8dZVFT+xO2mBGyxqEipwLXIQiU+xAvMjC9i9Y0TPiQp7aX3JOBM93vc5BT9xmPRY8W81RuKM0D0WtYworXB6J7em/yAFqvFbbLLiY/xSR5z9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Unn2FQm2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYy+il8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764622681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn3VhpmwVa+pbYhgAkE98mZ/JbvIwEHKcTRbeRu2cf4=;
	b=Unn2FQm2Dbn5qoCMR/nM+OpWYTN9QxccNi88BymLVwDSI2Kx1GWAFcFkdFmH8PltkhOm/k
	LGuygBAlwgkw2mtoLvf+U+igyNmZIWavCpzJBuvw383Vzvy02QICALQNv2AWzcGTp4Q61Z
	Oo7b7WRYS8vojHkJtF+b4y2hHCVaOcY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-bcpYlouZNJeTE--g0_cuiQ-1; Mon, 01 Dec 2025 15:57:59 -0500
X-MC-Unique: bcpYlouZNJeTE--g0_cuiQ-1
X-Mimecast-MFC-AGG-ID: bcpYlouZNJeTE--g0_cuiQ_1764622679
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09693109so80587221cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 12:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764622679; x=1765227479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn3VhpmwVa+pbYhgAkE98mZ/JbvIwEHKcTRbeRu2cf4=;
        b=HYy+il8BRM6OuS/S6jKN4CsK8hqz7O5fgdFb2ofNZA4F0ycR7LmJJP+1HFCogn1o1x
         8nhCZbC5C7weDoKS+R+o0Dkibzr3FTOjCXvK5ju8UMjo9yPoZlIfTRhsSqWtpJGjSjDK
         74KOjhuZ6l5K1y0wdQfdYDqO7vfoA4GssB6X+TXtc7+HcjJdgnhsUithHBs3i0aGN4zp
         XWFiGmPHHuTc6sESE9l/k2UQn1OELa9mAwuC8iB1R9uaesUDywJ02eNb3DT2EX/fetyI
         2o1LwnLDaKJ5fp+3Wf54SugJCHAjeupMrNsTkzUlXbG79LoIl1H9Y8fRaEIzIQBMNZlS
         HADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622679; x=1765227479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn3VhpmwVa+pbYhgAkE98mZ/JbvIwEHKcTRbeRu2cf4=;
        b=fM1WqZiVhh7BqwB/N3hrdRBJPgxC69TbZZPVlc1SloNrUuY32epBm5u0kzYPenfapi
         3HkhWBMEbIZRNoQkFSNjVgg5yXN+UglqoCy6Nl85RJHZtv85gRTNXPzepAwCTOgiRZhJ
         hbVk8xGcSTAS2uZUoCgp32vHSE67ROiC/IpFoROMsJvZXhJXiON+OOfqPIZysxlBs7Z8
         Q68GQ8Guby+/rrAJXatnDN+KNoeFwGnA79/m6WIueOH+rzc5YK6lj0p4eo34SXELPUoc
         jcmPSQ7OSIvW69+qkGSXFSpY77pe6w+RIFix18b7Ol6MdfEW2VbRy0VaD1i8/V23ANGE
         17zg==
X-Forwarded-Encrypted: i=1; AJvYcCUZpa4xWh1Gd6gD6aF5zAH9l7LNB7BcihikSvkFCjIz580CwAS2t32gL5JtwdbN329TwhCHGrfqctx0ldXNLhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVhwTTqP06NmmByIXIQjCnLDbVDqh7xf5iiUPGqLBNK19yh34
	QJ63jHRaPP6/L5Bo26SL0SJ3FkMSj/osPmg4/F5uKgjvLQIDFoiiv7YsBeeltlJY17CnNABzKNp
	UegwPplLIDRPPdp7dakNGzUDAWvOM9Gd5FtSEkNVHskMOvE0NQdZuNj0s0TEe2AwjkBxV5g==
X-Gm-Gg: ASbGncu7fTVE50MN4r/nQSYi6qgvW7lHt2t4mKhSEwI0OaqULK0Bo+htk8b1Xp5pm12
	9HgVDEqvHFxgEeQmaiVWlFbD5YuWI7Zy9QwL2U+ncZ4zvoJyMW+6fl2Y/bAm/QS+CeGb6xaQslD
	6p1QqFt/ntMmw3ToRSkfb4+3I8nxr01K75PgdzyfWQZxp/6k/d6nPOXts1LWZGzgd6XPaCnp8fK
	oOHuPpLKpxHocbkohylXiawL+W5alyLOMBsnIqY8V6m0EWixd0OWZANQL+s0GQmlY9sONvx8+Xw
	JtN3JOkNO4rjmBivmQ4D6VrvmkYnoNFn0F2RWUE/CBwhuX4IzlJqI7rlLtXVtf+izpGi/1UM631
	x7mU=
X-Received: by 2002:a05:622a:88:b0:4ec:a568:7b1c with SMTP id d75a77b69052e-4efbda33ba1mr388432571cf.21.1764622678860;
        Mon, 01 Dec 2025 12:57:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWk8T36NyEMOMD2WZTIhi05/ouYbVdGm/+oj1BADCz5jW4gqg2t7CwJF5ZBQ/vmsijc1KTvQ==
X-Received: by 2002:a05:622a:88:b0:4ec:a568:7b1c with SMTP id d75a77b69052e-4efbda33ba1mr388431931cf.21.1764622678340;
        Mon, 01 Dec 2025 12:57:58 -0800 (PST)
Received: from x1.local ([142.188.210.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2fbb8d1sm82384891cf.9.2025.12.01.12.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 12:57:57 -0800 (PST)
Date: Mon, 1 Dec 2025 15:57:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
Message-ID: <aS4BVC42JiUT51rS@x1.local>
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
 <553c64e8-d224-4764-9057-84289257cac9@amazon.com>
 <aS3f_PlxWLb-6NmR@x1.local>
 <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com>

On Mon, Dec 01, 2025 at 08:12:38PM +0000, Nikita Kalyazin wrote:
> 
> 
> On 01/12/2025 18:35, Peter Xu wrote:
> > On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
> > > I believe I found the precise point where we convinced ourselves that minor
> > > support was sufficient: [1].  If at this moment we don't find that reasoning
> > > valid anymore, then indeed implementing missing is the only option.
> > > 
> > > [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
> > 
> > Now after I re-read the discussion, I may have made a wrong statement
> > there, sorry.  I could have got slightly confused on when the write()
> > syscall can be involved.
> > 
> > I agree if you want to get an event when cache missed with the current uffd
> > definitions and when pre-population is forbidden, then MISSING trap is
> > required.  That is, with/without the need of UFFDIO_COPY being available.
> > 
> > Do I understand it right that UFFDIO_COPY is not allowed in your case, but
> > only write()?
> 
> No, UFFDIO_COPY would work perfectly fine.  We will still use write()
> whenever we resolve stage-2 faults as they aren't visible to UFFD.  When a
> userfault occurs at an offset that already has a page in the cache, we will
> have to keep using UFFDIO_CONTINUE so it looks like both will be required:
> 
>  - user mapping major fault -> UFFDIO_COPY (fills the cache and sets up
> userspace PT)
>  - user mapping minor fault -> UFFDIO_CONTINUE (only sets up userspace PT)
>  - stage-2 fault -> write() (only fills the cache)

Is stage-2 fault about KVM_MEMORY_EXIT_FLAG_USERFAULT, per James's series?

It looks fine indeed, but it looks slightly weird then, as you'll have two
ways to populate the page cache.  Logically here atomicity is indeed not
needed when you trap both MISSING + MINOR.

> 
> > 
> > One way that might work this around, is introducing a new UFFD_FEATURE bit
> > allowing the MINOR registration to trap all pgtable faults, which will
> > change the MINOR fault semantics.
> 
> This would equally work for us.  I suppose this MINOR+MAJOR semantics would
> be more intrusive from the API point of view though.

Yes it is, it's just that I don't know whether it'll be harder when you
want to completely support UFFDIO_COPY here, per previous discussions.

After a 2nd thought, such UFFD_FEATURE is probably not a good design,
because it essentially means that feature bit will functionally overlap
with what MISSING trap was trying to do, however duplicating that concept
in a VMA that was registered as MINOR only.

Maybe it's possible instead if we allow a module to support MISSING trap,
but without supporting UFFDIO_COPY ioctl.

That is, the MISSING events will be properly generated if MISSING traps are
supported, however the module needs to provide its own way to resolve it if
UFFDIO_COPY ioctl isn't available.  Gmem is fine in this case as long as
it'll always be registered with both MISSING+MINOR traps, then resolving
using write()s would work.

Such would be possible when with something like my v3 previously:

https://lore.kernel.org/all/20250926211650.525109-1-peterx@redhat.com/#t

Then gmem needs to declare VM_UFFD_MISSING + VM_UFFD_MINOR in
uffd_features, but _UFFDIO_CONTINUE only (without _UFFDIO_COPY) in
uffd_ioctls.

Since Mike already took this series over, I'll leave that to you all to
decide.

-- 
Peter Xu


