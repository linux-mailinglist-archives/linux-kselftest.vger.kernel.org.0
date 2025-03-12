Return-Path: <linux-kselftest+bounces-28836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA9A5E474
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64265170BE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74666255E3D;
	Wed, 12 Mar 2025 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RV0vJD6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD91E5706
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807959; cv=none; b=C5ltYZaAuPEhfVIsE5arCuEHKBYpj7vLbTfmjXTOqOVteTzpRtjYeqVdcLEt0tcKKqGKtPTtFt4mCNV/nsWZpGW5CVF8Of6BYHwcmvaOzzE2qEUQj8hty7VmRbxje8gUkUdgglnC5JVpzdwbCK1+mDKEf/hkacF6V0XUK6qkK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807959; c=relaxed/simple;
	bh=xgBdBBk7i8LAgh8FiRTW2kFqQf8f3xZuiFRK09preGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuLfqdX4iABlFksjlBdin20uZ9Br9UQvg03hC0OkS340t73sGr9XbdbwLS5LwAvoXMShFBt+7raG8f0s6onZz11PfQPdTlif0FLBu+kWnOcI8TWqwqycVB1kXW56tNamaLLQ5O0goQLjf3Qpo1f8b5V8kJ+0T16Nxudk/R640n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RV0vJD6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741807956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXwwCzq0XPmqyi1BVWI5psFQo3FiUiCtEITxNLAbSss=;
	b=RV0vJD6UAewLPRsi4mGVSBdEYqPMHZ13JvRAv0monfpbr5cnRZD/o+tCR/UWLqiElae8vN
	c1ozSPvWIk7FvABeUFTGqBneCVkHdW0Neme5BB6O7z3dabVbWnjrg56nLkIELQ8KAyXAc4
	fpcPeQUaUZqxTlLcUzfnzKkv5qAIaQ4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Rhh8evM8N-aXmVFev_DA8A-1; Wed, 12 Mar 2025 15:32:35 -0400
X-MC-Unique: Rhh8evM8N-aXmVFev_DA8A-1
X-Mimecast-MFC-AGG-ID: Rhh8evM8N-aXmVFev_DA8A_1741807955
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ead629f6c6so4611626d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 12:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807955; x=1742412755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXwwCzq0XPmqyi1BVWI5psFQo3FiUiCtEITxNLAbSss=;
        b=Rae72whApIebuFYeRylm02oC4JDOct7kWwmQwdSg+Ik05vrGMHF1cZNAEhrevKlW1R
         RNLy39Q4sJ5Eo5i/65FvqZuWqr7zSLdklNoR3XObYD/ck+MgC6InunVJczx/kZxZ+seI
         LfwY2aNDixH19BDSooykFgDL41b4tCtmXh6LW4hDvbZ8J6RqdTOrZH/j6sdc8wKFhcNs
         CZ/l5HRAwpaNkRYJhRHU6WxQPTQF0zHy5uMT9JsnvPr/0ghJGxNQfJ6ya8cg4xhsDurd
         Rmd5F9KO8+FUBa3FEB/hmwcf3VPS+ZhHInyTdGy0c9Q+KHgKRabSopf9tHFsUiO7jKAs
         6xTA==
X-Forwarded-Encrypted: i=1; AJvYcCVPnO5dPkb1oWVb8RnzHlQZ7StzdDWqx0AtloqXaHzn6iHBrK30qghNQ+PuhuBCRCVerGehtTlQYKZgA5AgnsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1sCU6VZiGfczGBetgF9WkwSOpobGhrM2uk4Cpi5aJVsQzhOp
	YFycEcGbpyeJON+Z2PJin6+Un1nQzkGDWuInrALPZKff9GHmk6efvG3bnozYwKDGyRg9sHE6gy/
	qzpe34KLu8k/wm5eRSscqhG/kqgIufibfzwQ5Ef9dGRV3VtoPPP9P/N8yJhCbi73oNw==
X-Gm-Gg: ASbGnctkd05WpPgo8wjcfIif2+mG64IORFdsto7kgx4GJmwFLwzR2YEMaT8UEGAiQUw
	2fIAa1NJSwwnP70E0VRuwHCgFgy718aENtDJ8vhoOFZm3bGb6BKiYh6rgJn+y3DBqdYuZIz/piX
	evYDi4rjXpaPtGqF4U+JVIdpraHUm09hKUWFvgwe7TUSlhXw041f9wjQ4SyfKBZBq1JoWOiiS2q
	0sDdhEqX7J+Q/lVWzjxd4Mr4uNnw8dKBbdEtSWyBS3yRjjDWqVONU/UZ62hZU+0njbHanKNQ14X
	bNVIKlY=
X-Received: by 2002:a05:620a:268e:b0:7c5:55f9:4bbf with SMTP id af79cd13be357-7c555f94e37mr2089058185a.7.1741807954919;
        Wed, 12 Mar 2025 12:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG21UoB4UhW6J7OnJXCWJmtkS+rArAGv2lRBmFk4GlTGcEtlkmQsqJSDwW+31DKN2CBG4Usgw==
X-Received: by 2002:a05:620a:268e:b0:7c5:55f9:4bbf with SMTP id af79cd13be357-7c555f94e37mr2089054185a.7.1741807954664;
        Wed, 12 Mar 2025 12:32:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c8f99absm570901185a.117.2025.03.12.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:32:33 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:32:30 -0400
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
Message-ID: <Z9HhTjEWtM58Zfxf@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>

On Wed, Mar 12, 2025 at 05:07:25PM +0000, Nikita Kalyazin wrote:
> However if MISSING is not registered, the kernel will auto-populate with a
> clear page, ie there is no way to inject custom content from userspace.  To
> explain my use case a bit more, the population thread will be trying to copy
> all guest memory proactively, but there will inevitably be cases where a
> page is accessed through pgtables _before_ it gets populated.  It is not
> desirable for such access to result in a clear page provided by the kernel.

IMHO populating with a zero page in the page cache is fine. It needs to
make sure all accesses will go via the pgtable, as discussed below in my
previous email [1], then nobody will be able to see the zero page, not
until someone updates the content then follow up with a CONTINUE to install
the pgtable entry.

If there is any way that the page can be accessed without the pgtable
installation, minor faults won't work indeed.

> 
> > as long as the content can only be accessed from the pgtable (either via
> > mmap() or GUP on top of it), then afaiu it could work similarly like
> > MISSING faults, because anything trying to access it will be trapped.

[1]

-- 
Peter Xu


