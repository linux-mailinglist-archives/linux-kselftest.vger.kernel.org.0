Return-Path: <linux-kselftest+bounces-3452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2083AB09
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4027B2393C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F277F1E;
	Wed, 24 Jan 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSok5Cnl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A86CA69
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103583; cv=none; b=SSqea2ShzUHO6nbr8WoKqVnKxcz12WaV0YNk5hT18/J76P0Z2xJ5s2HDeJr5O2a7hL5bs9GDYIkkV+Gcp8OHzPnX+sDR76XmI/h46ZnwuXnzlyKvaC292aZAT23AR07RimqJH0EYgHIVRFXlTic52OtbMqMNVPoeL3tNOcBblAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103583; c=relaxed/simple;
	bh=npa0NVykoMEN5MSYcp671yDBaYHZIPWOdfRNArMuVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dml0dxJ87p32eGc1weaVdXmVixFusriQfDT+e5Zy7l49WjyCD/AN7BPwv74TWH/b7JsBR66++LGBmTzdqK5/jFK9oA9jC5qsf5mpQYLkO8I/5pC4yTq1aKkL2XrMm3+4I4VSq389GKhHgl7+HT9AodSXw+X/Y1FBYsxaf7cbviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSok5Cnl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706103580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2dSIR4rbvdDm+KCVPpjilkj3+2xgOobjinuJW9fE8M=;
	b=fSok5Cnltk91wJeDsEWXkhkVURnBt6qi3SpoeXsvLTUwQEaH4D1nQR6skIGbqM/ZUQG+aA
	l7kvWetTU8gNPgkAIXaX0caiO3ZetkYi5hvmYr1U7emcDAhZWOxDUfWCtnIIYnpc3bSA/s
	5hl3y+F0oiJIzzfdYeAoCzaQZCdpBFQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-xkn0jY63Mbux5a5ldMJXKg-1; Wed,
 24 Jan 2024 08:39:36 -0500
X-MC-Unique: xkn0jY63Mbux5a5ldMJXKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B67B1C068CE;
	Wed, 24 Jan 2024 13:39:35 +0000 (UTC)
Received: from fedora (unknown [10.22.16.111])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A7C40C1430;
	Wed, 24 Jan 2024 13:39:35 +0000 (UTC)
Date: Wed, 24 Jan 2024 08:39:33 -0500
From: Audra Mitchell <audra@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, raquini@redhat.com,
	Adam Sindelar <adam@wowsignal.io>
Subject: Re: [PATCH] selftests/mm: Update va_high_addr_switch.sh to check CPU
 for la57 flag
Message-ID: <ZbETFZX33L2ELujO@fedora>
References: <20240119205801.62769-1-audra@redhat.com>
 <20240121143153.5dcfe26dea53ba0e896dbf85@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121143153.5dcfe26dea53ba0e896dbf85@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Sun, Jan 21, 2024 at 02:31:53PM -0800, Andrew Morton wrote:
> On Fri, 19 Jan 2024 15:58:01 -0500 Audra Mitchell <audra@redhat.com> wrote:
> 
> > In order for the page table level 5 to be in use, the CPU must have the
> > setting enabled in addition to the CONFIG option. Check for the flag to be
> > set to avoid false test failures on systems that do not have this cpu flag
> > set.
> > 
> 
> Thanks.
> 
> I'll add
> 
> Cc: Adam Sindelar <adam@wowsignal.io>
> Fixes: 4f2930c6718a ("selftests/vm: only run 128TBswitch with 5-level paging")
> Cc: <stable@vger.kernel.org>
> 
> A more complete description of these "test failures" would be helpful
> please.
> 

Hey, sorry for the incomplete description. The test does a series of mmap
calls including three using the MAP_FIXED flag and specifying an address that
is 1<<47 or 1<<48. These addresses are only available if you are using level 5
page tables, which requires both the CPU to have the capabiltiy (la57 flag)
and the kernel to be configured. Currently the test only checks for the kernel
configuration option, so this test can still report a false positive. Here are
the three failing lines:

$ ./va_high_addr_switch | grep FAILED
mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(HIGH_ADDR, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED

I thought (for about a second) refactoring the test so that these three mmap
calls will only be run on systems with the level 5 page tables available, but
the whole point of the test is to check the level 5 feature...

If you would like me to also update the description on the patch let me know
and I'll update it and resubmit. Thanks!



> > --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> > +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> > @@ -29,9 +29,15 @@ check_supported_x86_64()
> >  	# See man 1 gzip under '-f'.
> >  	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
> >  
> > +	local cpu_supports_pl5=$(awk '/^flags/ {if (/la57/) {print 0;}
> > +		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
> > +
> >  	if [[ "${pg_table_levels}" -lt 5 ]]; then
> >  		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
> >  		exit $ksft_skip
> > +	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
> > +		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
> > +		exit $ksft_skip
> >  	fi
> >  }
> >  
> > -- 
> > 2.43.0
> 


