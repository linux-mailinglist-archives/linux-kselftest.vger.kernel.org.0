Return-Path: <linux-kselftest+bounces-29068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37BA61C12
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B905119C79A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E6209F3B;
	Fri, 14 Mar 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvopIwaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E2208984
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982668; cv=none; b=k8S3G/FRtY1kmU+0X2J8XdUNrBbL1sORZSqxMl6od9tq548dCg9A/zRGwqg0qsgCLILShrBzcVz7U1cKj+mezqoUfza8Sr6bGpV/7uBntGxEI6+Am/ioDKuy6B6ynKAvowwJie2Z2CmlmHg25hsLPxzjKCqKJKqFhx2Da3QQ4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982668; c=relaxed/simple;
	bh=+H598cocfIacpoV/aS/IeuVnKEx5ukzRWbUj/A1EjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR1DEtX8ukxhp5NU0bvuYz+8fAeaaOjyfM6UeqsA+3+LE+PIOq+4CXUfuxg4GaVBnkDrtmaqtE1zD0zKGrDcgNGQNmnOeyHj8mruRqinQG52pSSMnmKROwsIqYBy0qPK++kLZbGmUfepgv3X5pL+Ehvz+Uf+kMHIVKgEVGx8Yss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvopIwaf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741982665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqRyL6MA+QupMYvedIjsb0gClHlzTIPhGP8UWlhlKow=;
	b=fvopIwafNGPqrnhaXHXVl0x3YmPEuFEGdMQzM/q3OIOIQ2CYYtVPpZUAa4QSNIEdouNYfv
	ZNTif/1wILE+/TYa/TU0brLU3lhLgevWj5D2f4tpTi/KlZS9pVLITaHeymE6lTuEFYBfsm
	WbL101GbSkwkPTcDPYPKGEYdRfkcEuU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-sMdJfBM3Nsmy7_yOj8fmJA-1; Fri, 14 Mar 2025 16:04:24 -0400
X-MC-Unique: sMdJfBM3Nsmy7_yOj8fmJA-1
X-Mimecast-MFC-AGG-ID: sMdJfBM3Nsmy7_yOj8fmJA_1741982664
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e916df0d5dso46731516d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 13:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982663; x=1742587463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqRyL6MA+QupMYvedIjsb0gClHlzTIPhGP8UWlhlKow=;
        b=s8TT7/tHQ351p1nodlbgDcVrN9suEAkX8hShU/soE7xediV5Vsy/4d9Yffiqc+U1Gi
         l4hCIPXRTzKGr4OxRcDltKVj3pu0lzk3Ewd5km8h5qbdp08TxuNfdIPiYYleVjUlZKHV
         NYN++MsDsYPdp7OVG+mkq8bNOVto3ZekeSlL32a7dYaYhwz/FXF/YKCH4UO0atzQZims
         QeZ/2/8HROOXWDIzvy9d3TaX8LtJpFBdqVHsNWqvhiaRz9ppt92Zi3c2/tqhhUcrTYpZ
         vnS4FLRYAeomegEgCS2JtfITeEy3PSBQrAgdGvuhE/YRPsXA4+eq9oz1yLGlZl8excAJ
         nS/w==
X-Forwarded-Encrypted: i=1; AJvYcCU73xeVqjG4ZLe/crfNVtuXJ8sQkphqBCN2RaCOvpJQY1HU0v3eXtzUBS5LMRLvnliDLnka9y2F/gSOzb8BUy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFjQsPIDlMq1EDb6kwkVp4eyyx3tJY7R/ovCkSWyUwOJnR8TX
	qCT1P6XielF7Pp7BbbsMuV5MmdvcWS+R191Skdce7G1TanpFbTAv5hUGMOrtulM9IaKy2afMXzz
	1yHzQuMODCgLoAQ/Ul+bZRrIrADHeDUNnYly3ATPRfp5JpOP1B+5QktawC9bV5LfuuA==
X-Gm-Gg: ASbGncvhvJb21lo6y3YkORAF7YPMruikFGuM4hfn62+5v5551GkWH+Txrwznfco+0+S
	tydAPHvlIg0RejMBqIycNHwTqNDuVBHcyidSMS/Uvg8X5PvbhlTDtKQ2AlP8IutbW5pJc1P4Ema
	alg5ENkdKIa2s03CgNhziL2KV/UeSLs2tB2ZvWX2byRrMRp/AKNHIwGXJFXghUUtP033JVZo7FW
	9D1SYEXUsaBo2oTXjQ4ImxTzaI7ra2aS/VYGeDUICDjlhcre666GPE4xDb3H2gcmMhVV2Mp+xOu
	3Pg4Pp8=
X-Received: by 2002:ad4:5cca:0:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eaeaa1c6e7mr54402586d6.11.1741982663665;
        Fri, 14 Mar 2025 13:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdrnxZkVhHJCu+0L4gTXfr+cGtUYoXrRv2lUDPgB5Dtd3VDIpsWxWp29AXtnPsgwf8cd2wQQ==
X-Received: by 2002:ad4:5cca:0:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eaeaa1c6e7mr54402066d6.11.1741982663335;
        Fri, 14 Mar 2025 13:04:23 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm27689416d6.22.2025.03.14.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:04:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:04:17 -0400
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
Message-ID: <Z9SLwcWCMfmtwDZA@x1.local>
References: <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
 <Z9NeTQsn4xwTtU06@x1.local>
 <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>

On Fri, Mar 14, 2025 at 05:12:35PM +0000, Nikita Kalyazin wrote:
> Anyway, it looks like the solution we discussed allows to choose between
> memcpy-only and memcpy/write-combined userspace implementations.  I'm going
> to work on the next version of the series that would include MINOR trap and
> avoiding KVM dependency in mm via calling vm_ops->fault() in
> UFFDIO_CONTINUE.

I'll attach some more context, not directly relevant to this series, but
just FYI.

One thing I am not yet sure is whether ultimately we still need to register
userfaultfd with another fd using offset ranges.  The problem is whether
there will be userfaultfd trapping demand on the pure private CoCo use case
later.  The only thing I'm not sure is if all guest-memfd use cases allow
mmap().  If true, then maybe we can stick with the current UFFDIO_REGISTER
on VA ranges.

In all cases, I think you can proceed with whatever you plan to do to add
initial guest-memfd userfaultfd supports, as long as acceptable from KVM
list.

The other thing is, what you're looking for indeed looks very close to what
we may need.  We want to have purely shared guest-memfd working just like
vanilla memfd_create(), not only for 4K but for huge pages.  We also want
GUP working, so it can replace the old hugetlbfs use case.

I had a feeling that all the directions of guest-memfd recently happening
on the list will ultimately need huge pages.  It would be the same for you
maybe, but only that your use case does not allow any permanant mapping
that is visible to the kernel. Probably that's why GUP is forbidden but
kmap isn't in your write()s; please bare with me if I made things wrong, I
don't understand your use case well.

Just in case helpful, I have some PoC branches ready allowing 1G pages to
be mapped to userspace.

https://github.com/xzpeter/linux/commits/peter-gmem-v0.2/

The work is based on Ackerley's 1G series, which contains most of the folio
management part (but I fixed quite a few bugs in my tree; I believe
Ackerley should have them fixed in his to-be-posted too).  I also have a
QEMU branch ready that can boot with it (I didn't yet test more things).

https://github.com/xzpeter/qemu/commits/peter-gmem-v0.2/

For example, besides guest-memfd alone, we definitely also need guest-memfd
being trappable by userfaultfd, as what you are trying to do here, one way
or another.

Thanks,

-- 
Peter Xu


