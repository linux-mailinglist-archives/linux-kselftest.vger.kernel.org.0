Return-Path: <linux-kselftest+bounces-28982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260AA600B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D107189E3E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16C1F12E8;
	Thu, 13 Mar 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa7H0qjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286A1F0E40
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893140; cv=none; b=pNxdp6E/YtS/i+pzOU5AHpHnxxjz92+GMOfY+qNp9d7TGCB5X4P1eEvKZOZkgnp/aYg7yyxpw14zy/m/FIvjSzkfVOUlpqL2IzSxZqj8Frwr7bXzDoQT8q6RPky8MuVR/UEHuKHgOJKgk87NWFLPzX7AI/M1S4DS9X7E1R4jZ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893140; c=relaxed/simple;
	bh=jagCpUiEiGHEWFubbh7emapvGjhnMLj+b75pACy+vZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfw5JTNml0TnP+YJHL/377qqy/iKkBYTSx9zrm/MLaCuY20vzQ2PGuH0ZpjNpCKplQFDYBGiu+Y8P2YGZoqfXAfJYElb68HZqKDbzpc2eNcDXnHkbWmdJs7P2RkCxcsO1ImlTe+91MZa18c6XPYy3/XpWGT2rcLUFjVa13p56tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sa7H0qjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741893137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu8Zt5JHKLInYlZV//fPfzrbXAHVXgUz1d/jNhTgXBA=;
	b=Sa7H0qjOTXP+In0oYuh9aTl+/aGQoPsttMrDXBfMjMyIVcVAragm5qSsf1PGT45uaHj3Z0
	lW4lB+SyHGQCQ4pUKSw0/SVHxsIUftBZYLd8RnkFm4Y6e1Y657Qdk9q2Ety2wy07I1g+0L
	+vPvNAimCaFtBpxrCaAj908vxIMSkGQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-9DYvR3c3M-CDJSSjE35Usw-1; Thu, 13 Mar 2025 15:12:16 -0400
X-MC-Unique: 9DYvR3c3M-CDJSSjE35Usw-1
X-Mimecast-MFC-AGG-ID: 9DYvR3c3M-CDJSSjE35Usw_1741893136
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a89afcaaso258831685a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893136; x=1742497936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu8Zt5JHKLInYlZV//fPfzrbXAHVXgUz1d/jNhTgXBA=;
        b=lsZ45EPLhNKm2mjqYlMs3Cf09q6c1FO9Rn6wjTNxeZ7ZwNbNr98YbBixJVIZKVrzvv
         aWeM6tpuV7aE427n3b2DPzUAKjsc+3KV/5gSr60058NwMGR9hrMjekskx0AU60h8/biW
         OQZTMpSyrY35cWde40uYZi4sWM+jk9GSS1yJPVVSB7FzGKc//sAW2swNUY5RRSxYNx4w
         /waROndMh4WDsMcXEEK3Kb4jnn/16CQrqmw6sXcINycytJhe7nPdf/ZYV82lR4kZoJ8R
         xAtZLND0Y53HVMeMP/LmF2VbUTnse2H+HJsKobTFDWWDntSp4CeVaw9ZIb7MJ+QCStzg
         k4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUSV/yJ7xf7+bEB9Tkiz30plNDCyzVQmR3L48Zg2xmfKOz4bkxpzel4HGT8qowDymnmU2mhvgw9XqghOT+obkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynmrxa3FNhGPpSMJFEkADj6LCNK11X3+qJ9N/LQyJ8pgJhknvu
	tYS2pjH3yGY243D37CxRF6rCbhF6dxZ9n48rJdoPL/Iz4oxPW6/evsL8UOWllFkbJONllKEtISH
	4C40vXosCpbpUQmM84Q8bZyOlb9AQRuwPC8bmFhRatz8ReI/oMKY5lQlpN2NfUn6D2Q==
X-Gm-Gg: ASbGncs8DIFJYDvjUZKpKkJdBE5SBKxNCufT+KBeTBtrR+XFRU7XDY+ai8C2lorl7EJ
	svcou/xQiIelPSoyDReZ+/E46rK8CcOXe8/ziN4l0OauHeIxxC3C5NJ99GBcgBFjMjynxEsUQw7
	hqnTN8IBH+4lXz/nCq3HWH6OiIQo9QhiyqAcf+4cwyybkbhMnTPRowvplfLodSNjNfumGls/fuq
	W2eFBd0AgFiGW1eNs7X4ZBR6LJSvQt75/ZTdPfuQ+Bq5vWP+gRmmbZ3eBHr46oEl3bHsFejIwnr
	PWVPqxA=
X-Received: by 2002:a05:620a:838f:b0:7c3:c13f:5744 with SMTP id af79cd13be357-7c573713527mr744171685a.3.1741893135764;
        Thu, 13 Mar 2025 12:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmL8wnHI3XvOc6TmOoi5mIyx1LyijkYTY/k9F1G3PKJ/9z/mlexd/aqNP663C+GN+ActHxCA==
X-Received: by 2002:a05:620a:838f:b0:7c3:c13f:5744 with SMTP id af79cd13be357-7c573713527mr744166785a.3.1741893135438;
        Thu, 13 Mar 2025 12:12:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89ad6sm130678585a.102.2025.03.13.12.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:12:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:12:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9MuC5NCFUpCZ9l8@x1.local>
References: <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>

On Thu, Mar 13, 2025 at 03:25:16PM +0000, Nikita Kalyazin wrote:
> 
> 
> On 12/03/2025 19:32, Peter Xu wrote:
> > On Wed, Mar 12, 2025 at 05:07:25PM +0000, Nikita Kalyazin wrote:
> > > However if MISSING is not registered, the kernel will auto-populate with a
> > > clear page, ie there is no way to inject custom content from userspace.  To
> > > explain my use case a bit more, the population thread will be trying to copy
> > > all guest memory proactively, but there will inevitably be cases where a
> > > page is accessed through pgtables _before_ it gets populated.  It is not
> > > desirable for such access to result in a clear page provided by the kernel.
> > 
> > IMHO populating with a zero page in the page cache is fine. It needs to
> > make sure all accesses will go via the pgtable, as discussed below in my
> > previous email [1], then nobody will be able to see the zero page, not
> > until someone updates the content then follow up with a CONTINUE to install
> > the pgtable entry.
> > 
> > If there is any way that the page can be accessed without the pgtable
> > installation, minor faults won't work indeed.
> 
> I think I see what you mean now.  I agree, it isn't the end of the world if
> the kernel clears the page and then userspace overwrites it.
> 
> The way I see it is:
> 
> @@ -400,20 +401,26 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>         if (WARN_ON_ONCE(folio_test_large(folio))) {
>                 ret = VM_FAULT_SIGBUS;
>                 goto out_folio;
>         }
> 
>         if (!folio_test_uptodate(folio)) {
>                 clear_highpage(folio_page(folio, 0));
>                 kvm_gmem_mark_prepared(folio);
>         }
> 
> +       if (userfaultfd_minor(vmf->vma)) {
> +               folio_unlock(folio);
> +               filemap_invalidate_unlock_shared(inode->i_mapping);
> +               return handle_userfault(vmf, VM_UFFD_MISSING);
> +       }

I suppose you meant s/MISSING/MINOR/.

> +
>         vmf->page = folio_file_page(folio, vmf->pgoff);
> 
>  out_folio:
>         if (ret != VM_FAULT_LOCKED) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>         }
> 
> On the first fault (cache miss), the kernel will allocate/add/clear the page
> (as there is no MISSING trap now), and once the page is in the cache, a
> MINOR event will be sent for userspace to copy its content. Please let me
> know if this is an acceptable semantics.
> 
> Since userspace is getting notified after KVM calls
> kvm_gmem_mark_prepared(), which removes the page from the direct map [1],
> userspace can't use write() to populate the content because write() relies
> on direct map [2].  However userspace can do a plain memcpy that would use
> user pagetables instead.  This forces userspace to respond to stage-2 and
> VMA faults in guest_memfd differently, via write() and memcpy respectively.
> It doesn't seem like a significant problem though.

It looks ok in general, but could you remind me why you need to stick with
write() syscall?

IOW, if gmemfd will always need mmap() and it's fully accessible from
userspace in your use case, wouldn't mmap()+memcpy() always work already,
and always better than write()?

Thanks,

> 
> I believe, with this approach the original race condition is gone because
> UFFD messages are only sent on cache hit and it is up to userspace to
> serialise writes.  Please correct me if I'm wrong here.
> 
> [1] https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/#mdf41fe2dc33332e9c500febd47e14ae91ad99724
> [2] https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com/T/#mf5d794aa31d753cbc73e193628f31e418051983d
> 
> > > 
> > > > as long as the content can only be accessed from the pgtable (either via
> > > > mmap() or GUP on top of it), then afaiu it could work similarly like
> > > > MISSING faults, because anything trying to access it will be trapped.
> > 
> > [1]
> > 
> > --
> > Peter Xu
> > 
> 
> 

-- 
Peter Xu


