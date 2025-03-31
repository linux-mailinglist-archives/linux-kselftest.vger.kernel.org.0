Return-Path: <linux-kselftest+bounces-29941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF03A7609E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 09:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4502B188481E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0C1C5D4E;
	Mon, 31 Mar 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+oaACnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A21E492
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407649; cv=none; b=fQ/GLjiuTPjBWsWtZuGfnhp0SCTiTs3vQe3rlMVKjmiUi6jpOPljuYWSq9ANnjIp2JV7WasceXZ6H2TRjN1eDFQoNoo2xYrCJwN1utCJe3dJ87nyDkRmJOZTiUPqzRTiFesQtIhRe+hJnEien4wGCd6ig32GG3z2b101daSHP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407649; c=relaxed/simple;
	bh=pSOWZdd/MbIKZjh443M8gHoV68P+KisZJPKaJJZIdxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRfp1QsIs3AavbvMrMv6pF3xoR6q/HfpGcxS1679usCyQHY7ZAxNOd2TVygwbcRgdq5wf7/Wa7YT+BvoBle40b6+A25TugzDdS6/QYVaZbWtfXfLXB4TqFDyziGI241DRGF48EOH9WIln931PoAZ6mm40vIJxOsShPz9T5/Ogak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+oaACnb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743407646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snXUyEbtvmR9vqAWor24hXesFNJShZnkZEKY6CqFCEo=;
	b=J+oaACnbMc9A2lcB/TB79BfJyVpO4okJMUgq4IX0XgE7D6S+mDXzGK7B91SxmhX54N0fhU
	kUv7/1Kupt33WMGezN3XXs1GptZsLXnZj9wcWSFqTh6GMavjbY/+fbFoNefqzDfTFlQFl5
	jJPFtDimWr6U0b+RdgcG8CqC5YfiXO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-efZpDS6VPUyk1jmXzLmYFA-1; Mon,
 31 Mar 2025 03:54:01 -0400
X-MC-Unique: efZpDS6VPUyk1jmXzLmYFA-1
X-Mimecast-MFC-AGG-ID: efZpDS6VPUyk1jmXzLmYFA_1743407640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA50180087D;
	Mon, 31 Mar 2025 07:53:59 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A119C180094A;
	Mon, 31 Mar 2025 07:53:56 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:53:53 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
Message-ID: <Z-pKEYr01vEaQDIw@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost>
 <87bjtmxtuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjtmxtuc.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Mar 27, 2025 at 06:32:27PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 27 2025 at 16:42, Miroslav Lichvar wrote:
> > On Thu, Mar 27, 2025 at 10:22:31AM +0100, Thomas Gleixner wrote:
> > To clearly see the difference with the new code, I made an attempt
> > to update the old linux-tktest simulation that was used back when the
> > multiplier adjustment was reworked, but there are too many missing
> > things now and I gave up.
> 
> Can you point me to that code?

It's this thing: https://github.com/mlichvar/linux-tktest

> It would be probably useful to create a test mechanism which allows to
> exercise all of this in a simulated way so we actually don't have to
> wonder every time we change a bit what the consequences are.

Yes, that would be very nice if we could run the timekeeping code in a
deterministic simulated environment with a configurable clocksource,
timing of kernel updates, timing and values of injected adjtimex()
calls, etc. The question is how to isolate it.

-- 
Miroslav Lichvar


