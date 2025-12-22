Return-Path: <linux-kselftest+bounces-47815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B2CD4B19
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 05:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A50C3007211
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 04:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCB22F75E;
	Mon, 22 Dec 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgKEJxzB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6F14D29B
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766377958; cv=none; b=EgzOttMXZZ4bsw/35Spwu/GPfKYg57Exa6lCKAe/81iFdT7HQJkqQN9Y0mITLxH73k71DmXI6jF/nFLgA366wuOlmVmAGz2LHDaISiOoG8IKdJII0uniA+ZPm2Pi71fnTUPJVjyYQgq040jojyqBe5d8Mv3F92Wk669X9FKWJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766377958; c=relaxed/simple;
	bh=JABHQlBpZmwvqX/QzLrI9mJ4AiHwRQk/nLSt45LLyj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu48EzqgTxPH35ZiBAF9MUTy+ZuTAy9XIe/M0Gu3ClqIHL2L+ugGk4O8TxcyR4zeP0VGNSpjXGeoigmBgEgDlS1OKRRyPjRLXR+MY6WqwTycLrqJRaW/eI93Z4HM6sPAbYkfAJjfotpx/DuVaD3X21Ha68LXPCuT65LQp7winBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgKEJxzB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766377955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOXaiRxr3cPmAHLihU3EDtTfZSpwuqBxKeRVKpiPhxM=;
	b=LgKEJxzBUMMHmAavzYWO/VJwnHzoGe2oHoxEsgaUaKgCV+iHy3nviXVwfm3APhdxxZt0jk
	gFKFNWs8JHG8jxpfQ+DTx/4ik1DEp4qkd2UT/tZWFi50Raq2Edvbw9jK1aLCJPP9AMz81o
	xSEZUPUZX7at3S5U17S//zgB+Y5xZKk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-lYN5b-iWMHKdX4Gz4te0mA-1; Sun,
 21 Dec 2025 23:32:32 -0500
X-MC-Unique: lYN5b-iWMHKdX4Gz4te0mA-1
X-Mimecast-MFC-AGG-ID: lYN5b-iWMHKdX4Gz4te0mA_1766377950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9105C19560B2;
	Mon, 22 Dec 2025 04:32:29 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8336019560B2;
	Mon, 22 Dec 2025 04:32:21 +0000 (UTC)
Date: Mon, 22 Dec 2025 12:32:16 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v2 1/5] selftests/mm: fix va_high_addr_switch.sh return
 value
Message-ID: <aUjJ0OKZajNNoQok@gmail.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221105709.d2e44cf1bb05bd9669e76d0c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221105709.d2e44cf1bb05bd9669e76d0c@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Dec 21, 2025 at 10:57:09AM -0800, Andrew Morton wrote:
> On Sun, 21 Dec 2025 12:00:21 +0800 Chunyu Hu <chuhu@redhat.com> wrote:
> 
> > Patch series "Fix va_high_addr_switch.sh test failure - again", v2.
> > 
> > The series address several issues exist for the va_high_addr_switch test:
> > 1) the test return value is ignored in va_high_addr_switch.sh.
> > 2) the va_high_addr_switch test requires 6 hugepages not 5.
> > 3) the reurn value of the first test in va_high_addr_switch.c can be
> >    overridden by the second test.
> > 4) the nr_hugepages setup in run_vmtests.sh for arm64 can be done in
> >    va_high_addr_switch.sh too.
> > 5) update a comment for check_test_requirements.
> > 
> > Changes in v2:
> >  - shorten the comment in for hugepages setup in v1
> >  - add a new patch to fix the return value overridden issue in
> >    va_high_addr_switch.c
> >  - fix a code comment for check_test_requirements.
> >  - update the series summary in patch 1
> >  - add reviewed-by from Luiz Capitulino on patch 1 and patch 3
> 
> The "Changes in v2" material is best placed below the "---" separator -
> I prefer not to capture such short-term development-time info within
> the permanent kernel record.

That makes sense.

> 
> > This patch: (of 5)
> > 
> > The return value should be return value of va_high_addr_switch, otherwise
> > a test failure would be silently ignored.
> > 
> > Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
> > Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> > CC: Luiz Capitulino <luizcap@redhat.com>
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > 
> > ...
> >
> > According to the doc below, I don't add the cover letter, not sure if cover
> > letter is preferred, and if that's the case, the doc need an update.
> 
> Funnily enough, your series was in the exact format which I use when
> committing patch series.  Usually people put the cover letter in a
> separate [0/N] email and I move that into the [1/N] patch's changelog,
> as you've done here.

yes, I see cover-letter is the actualy way people is using and looks
like I did some of your work putting that cover letter into the first
patch. I think I'll add cover-letter in the future.


> 
> > https://www.ozlabs.org/~akpm/stuff/tpp.txt
> 
> God does that still exist?  Pretty soon it will be able to legally
> drink in bars.
> 
> I think its content got absorbed into a Documentation/ file a long time
> ago!

I happened to open it before I submitting my patch, and wanted to know 
what would happen if I follow that. And it looks like cover letter has
become the actual convention.

> 
> 


