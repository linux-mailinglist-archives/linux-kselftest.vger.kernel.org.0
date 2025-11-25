Return-Path: <linux-kselftest+bounces-46464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAAC86CB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 20:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203033A5A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5DD335564;
	Tue, 25 Nov 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYtag8H3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4z14ezq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375133554C
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098484; cv=none; b=ne/i7Fx8tlJCij7AaWo4EP7i4UxdoapVORoKoMLJne3zDkqLQBHCbJPx8mqebzq3UXyXXR46c82rLYeZ0c1g/TPKUa4Drq7ZO9bOyTIrswwJuJi0n2YRAXR7QgeBxoB1iIEEQrndQ3IyozcrbiPCnmTflUUMwOtEj+8N8YGth+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098484; c=relaxed/simple;
	bh=HqayHoP1kvtY/gdJ3minqrH9s9nn7eYqWOg3b1zRuDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqv4QyXV4bXnlrYvgZ/c0ND2AHuAmZVh9HHcvRKw7HBzLlBHxsUkuBRr2QBdU4pZnheTIRz2++aYkCSGFBdnqih1HiXAjLVLgkEv29ZLaKXDl6EZ3u31GvLiodRmUWnQQlb+7OuVH8on6rfdCTTk0hV1z0ArUoIoFqwjS2nee4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYtag8H3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4z14ezq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764098481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qx6sgcmtbzfT8nlrCbJjKmeKver9dtlckhLCSjjEuU=;
	b=cYtag8H3IKTGI3qw1xoA4MtxHAeh1ZiAa7nZOIJrEIGKbQCiWy1NvfHqqKuVMzVtgiyJVQ
	nlh5ScAEu04g5av8osRkPBbmEmNsmPFYdu29eeaddmZJYzQP4cVhFrPI76Tsi8pV6KocGp
	8lSQ8J4jm61k9E84hRMiqKiLvXaGFrs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-RV-cB7PtOp--u5hjNDEl_Q-1; Tue, 25 Nov 2025 14:21:19 -0500
X-MC-Unique: RV-cB7PtOp--u5hjNDEl_Q-1
X-Mimecast-MFC-AGG-ID: RV-cB7PtOp--u5hjNDEl_Q_1764098479
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b233e206ddso1464796785a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764098479; x=1764703279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qx6sgcmtbzfT8nlrCbJjKmeKver9dtlckhLCSjjEuU=;
        b=s4z14ezqOlM0RNI8K6CUTrIlP4K3o2L3IV47hAOpMOZqauiirSVwp9jRnhzk53H7Pq
         adzBZYOU0a0lOzUfpKwsb1p7cVKZUTZnW+jW8r9F/7OWcZQMeksdz1LfcOzpJaXcu/BA
         ioPzOJNqTcqAYXzFruGJlQtjSgrAshjlXkDUxXRc7gyMBJeXH+yxC5XC+O5ybhYTSDNn
         ygdgm2ZS3gJQF4JIg6HgFEtIgj0Boihl3nUuy7/sbbMjUQcFuoQSbsBoyWlx+QhvtmgZ
         QQG3k2S6vg2e454izDUg3ENDhBfx4zaTIcK8wls8FT+rVIFZ6GP3zCUC9RX777k9oy0H
         F8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098479; x=1764703279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qx6sgcmtbzfT8nlrCbJjKmeKver9dtlckhLCSjjEuU=;
        b=wH4ACJ1xCUqFpjz7yG+JkHy6MJbn1tvZ/iv/M3y9hn7KIBa5HYR8LrwwEmUjUJl4oB
         4V0+sv+8JJzwO8uRXlyzpWNsM8eRnpoYUIq3BMvbQ1zSPiNNGVBdIHpuOg/ypxsaZZSn
         1lSRxxuL8HAQh8NI9fI/oEiC7S8O5D2E7tuypu8dzCNOhlSkS6eYW8puuMbTO5dDfOoU
         bWdQqUlfuO0yRe1ggMAdiYNaZxhGIFP9/cfu/VaFqXu+qNMVPQPMgOaRpR6oXE4s72Br
         xvnZGcy10Whp0iaB3gO06sZ2Rw0zOqU1FcU27ZqvRlpds/3D9gkTsObnb4qIUyOdaCGl
         XVUg==
X-Forwarded-Encrypted: i=1; AJvYcCWEuqLqrftgJ0pEku6n+WPh62ZtTPVo6LGcn4Q8TMtWaHsxclWhJutgqK1UA3gOH1K2OC6Az8yYOPJ0Q07f1Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfmrNTE7xkR7sRyNZE+XwBrooWruzSIru50l0qzB9bi/+QvTax
	q69ALGmFG09T/0gc5wdAGuQvu5J59WCfYAWDkuHAI+SlSBuZu9AZlh+oA1/YTJYivIBMxnLfesA
	OollrPwZ3FYfGbagTnNrg2wY6c/DQQW1Zlae9lIzgpvP//WlzxUciQgkJe6i4vPBy6ZPJ4g==
X-Gm-Gg: ASbGncsXEBNUQLiFnYJnC3jRjoE5CG4c81EEX1ZIYbHAOS64EdY10jM0JfiQ31Tkel1
	43Pbxd0O20kvcPzj5xlp4yLddebcpuW8ahPCdaBR5CbEuIuIk78OFmglmjG8wMF4ViLmazyLucV
	eNz+GnJZuikLL8N1rFeM6oBk6y/PEjAKdcYSnU16Te7AeyINcies4l1u2gwHivovaijmnfs8NPQ
	XvcRtkV03bmG/l79wiKmS92b/2nWwFiK/RZ1724z6oHGExNBlsJryOyZ4r+L4353KXlUFprSLD+
	gi3nI+CrqfOX9nCKMifTyMEvu66cNu0gXl6/wt2fWqCvSb3w75YTyk04ZwZfA57EPOSLiBcmnlr
	ZjWM=
X-Received: by 2002:a05:620a:700b:b0:891:9bb6:6b9c with SMTP id af79cd13be357-8b33d4cfb76mr2360728185a.44.1764098478783;
        Tue, 25 Nov 2025 11:21:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCwC+zV9ilL/kZYBgogz1BW/k0XjgDzjkTt78Ehqb7OwOZ4OSkjcxPe6SUz84vf0wVoVyZhQ==
X-Received: by 2002:a05:620a:700b:b0:891:9bb6:6b9c with SMTP id af79cd13be357-8b33d4cfb76mr2360721485a.44.1764098478205;
        Tue, 25 Nov 2025 11:21:18 -0800 (PST)
Received: from x1.local ([142.188.210.156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm1226353585a.24.2025.11.25.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:21:17 -0800 (PST)
Date: Tue, 25 Nov 2025 14:21:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Message-ID: <aSYBrH_xfMfs6yDW@x1.local>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125183840.2368510-4-rppt@kernel.org>

Hi, Mike,

On Tue, Nov 25, 2025 at 08:38:38PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When a VMA is registered with userfaulfd in minor mode, its ->fault()
> method should check if a folio exists in the page cache and if yes
> ->fault() should call handle_userfault(VM_UFFD_MISSING).

s/MISSING/MINOR/

> 
> Instead of calling handle_userfault() directly from a specific ->fault()
> implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
> notify the core page fault handler that it should call
> handle_userfaultfd(VM_UFFD_MISSING) to complete a page fault.

Same.

> 
> Replace a call to handle_userfault(VM_UFFD_MISSING) in shmem and use the

Same.

> new VM_FAULT_UFFD_MINOR there instead.

Personally I'd keep the fault path as simple as possible, because that's
the more frequently used path (rather than when userfaultfd is armed). I
also see it slightly a pity that even with flags introduced, it only solves
the MINOR problem, not MISSING.

If it's me, I'd simply export handle_userfault()..  I confess I still don't
know why exporting it is a problem, but maybe I missed something.

Only my two cents.  Feel free to go with whatever way you prefer.

Thanks,

-- 
Peter Xu


