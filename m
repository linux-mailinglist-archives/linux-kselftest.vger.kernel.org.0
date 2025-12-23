Return-Path: <linux-kselftest+bounces-47907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E6CD7EB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B71301D9FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C02BE7AA;
	Tue, 23 Dec 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyiIpgrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD229993A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458508; cv=none; b=CNSOM79YekCgQIQwTK9w/+ds2FcSYnWf7rq3MBJTav9HD+JuB57rRCTwQ03oMg9KwQeRkylKnls+fU8JhLkd/otD40BBG/sGh90Jn5Vfv9uUtPY8INGpFmnIqsDUgPmpjrHVxrBMgkFjLPd2oixIEUcZFh/SturJeFEYDk46dbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458508; c=relaxed/simple;
	bh=mue/kvZDX5ntmAhN2lUI5jVQPB/R4gb2/X+BiXxZiKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSKp/zlTgIwRyxHgNGqSVCEqlyIhI/OOzHVG+VbtWWZ751s0EoZ/SM6RjDOH6qCie6IToSKoZHbAjKFgCmrubSxOkRKEqktQ+WLLGlSK7D2jwOXk6LZZ541V1pAA1e0gxZX7r/nWZ0l2IuF18yZ+tORkMBDNHqFIlKGbO92oGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyiIpgrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766458506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tO3PGXcrbO3yWzecK3b3DT9nkv9paSQm/vGhx+nO1p0=;
	b=WyiIpgrZOYRrhEjtULVYIqZIB1LXNS7cXtQZx4H2J4dRN4/94bFjVaxGnHNOGQfMJuPih9
	OgliRpbjLQ7qeiq+X/oieRAJ2maVMO3r615M0mvB4ECdhZDMAxVvZuQWBAlVE/DvY415MC
	9TQ48nxDRPerbFfFa17fqNIueVfdZ+A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-uGCB806uN22TqaBQK8HCgA-1; Mon,
 22 Dec 2025 21:55:00 -0500
X-MC-Unique: uGCB806uN22TqaBQK8HCgA-1
X-Mimecast-MFC-AGG-ID: uGCB806uN22TqaBQK8HCgA_1766458498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 223C41956054;
	Tue, 23 Dec 2025 02:54:58 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FA4719560A7;
	Tue, 23 Dec 2025 02:54:49 +0000 (UTC)
Date: Tue, 23 Dec 2025 10:54:45 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v2 1/5] selftests/mm: fix va_high_addr_switch.sh return
 value
Message-ID: <aUoEdbP5oE4q47qR@gmail.com>
References: <aUjJ0OKZajNNoQok@gmail.com>
 <20251223011532.4337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011532.4337-1-sj@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Dec 22, 2025 at 05:15:31PM -0800, SeongJae Park wrote:
> On Mon, 22 Dec 2025 12:32:16 +0800 Chunyu Hu <chuhu@redhat.com> wrote:
> 
> > On Sun, Dec 21, 2025 at 10:57:09AM -0800, Andrew Morton wrote:
> > > On Sun, 21 Dec 2025 12:00:21 +0800 Chunyu Hu <chuhu@redhat.com> wrote:
> [...]
> > > > According to the doc below, I don't add the cover letter, not sure if cover
> > > > letter is preferred, and if that's the case, the doc need an update.
> > > 
> > > Funnily enough, your series was in the exact format which I use when
> > > committing patch series.  Usually people put the cover letter in a
> > > separate [0/N] email and I move that into the [1/N] patch's changelog,
> > > as you've done here.
> > 
> > yes, I see cover-letter is the actualy way people is using and looks
> > like I did some of your work putting that cover letter into the first
> > patch. I think I'll add cover-letter in the future.
> > 
> > 
> > > 
> > > > https://www.ozlabs.org/~akpm/stuff/tpp.txt
> > > 
> > > God does that still exist?  Pretty soon it will be able to legally
> > > drink in bars.
> > > 
> > > I think its content got absorbed into a Documentation/ file a long time
> > > ago!
> > 
> > I happened to open it before I submitting my patch, and wanted to know 
> > what would happen if I follow that. And it looks like cover letter has
> > become the actual convention.
> 
> I think you could use
> Documentation/process/submitting-patches.rst instead.  The html version is also
> available at
> https://origin.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks! Sure. I'll use that. I know this doc, it's where I find the tpp.txt
in the 'References' section.

> 
> 
> Thanks,
> SJ
> 
> [...]
> 


