Return-Path: <linux-kselftest+bounces-33641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8DAC21CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCCE1C04A22
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2D22C35C;
	Fri, 23 May 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTm6YpXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCA229B1C;
	Fri, 23 May 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998864; cv=none; b=JIFGfssbAQc8MypDOeyiXbqVcuBwDgfPUjUVX0xgEF8oENHaHNPmPy0iXtyZBahSq4gLW4VHDlVnCQ/XQZiArLXczrEWwut5ETTYMlTvt+D2jJyhlPRIeaNydRpRlrFHttLj8LdoKzSUGFKiG68VpFHjY5rvq2eu3X/Lfpg/ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998864; c=relaxed/simple;
	bh=fQM36qxJEofH550SYEql58cMFaL0cbMQSEGt5673CDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sriaRVd5IdO/W1mQ3F7C8H0WSN8xBLyrZLdFZiA/3pdQM6B/dSWr6u1mT1hZ4rGAPyISYgcKUte+JVXZiG5aIfbctmWyFfht5wCgttPb79Qwv3ASzFgq0orKbJqMt01Iz97X19K3S7auhW1bM5PgKYKo9EdTHHU2b15CPvFNK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VTm6YpXt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qFE8tg2hkqL/QDMRDxBmyrXVviTv054S7EmAHGK1Cu8=; b=VTm6YpXt+rg+boo/Y2XlDLHfjF
	uTUdFDuv7CRduVt0vgcpt1H3qXyWcKOUKwBJyBzjyRnEO9SE7JRpGZOhTfBBSEBXLgYIEYKbXlZDB
	tpsVGBoReZXjDVnjHYqsbdp3l9lenZI0uN4sGBmjoTHFC/oSTcCk06BRBBvKukbRvtHnIoQOohxFp
	AAk2xVkEy/ZUzR6Fa5IR24TYqZXrrQUCbpTsXVqK4NnKuLMx7BbaRzGqb7TLhfaz4cV5tvbk6Bwys
	vuAtkKS5Ar3GY61i/vpDcdclGEPpTbtP7i+0lOv6wFveWet/d/4Gtx0J7aORLDJMVameaAuX32RZ0
	m/g+9Shg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIQLx-00000007VFJ-22r2;
	Fri, 23 May 2025 11:14:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10E13300583; Fri, 23 May 2025 13:14:17 +0200 (CEST)
Date: Fri, 23 May 2025 13:14:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 00/13] KVM: Make irqfd registration globally unique
Message-ID: <20250523111416.GJ39944@noisy.programming.kicks-ass.net>
References: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>

On Thu, May 22, 2025 at 04:52:10PM -0700, Sean Christopherson wrote:
>   sched/wait: Drop WQ_FLAG_EXCLUSIVE from add_wait_queue_priority()
>   sched/wait: Add a waitqueue helper for fully exclusive priority
>     waiters

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

