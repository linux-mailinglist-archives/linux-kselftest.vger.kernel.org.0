Return-Path: <linux-kselftest+bounces-15049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B3794C7DA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 03:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A51B2190C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCF42F2A;
	Fri,  9 Aug 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQlgvrVr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A20748D
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165260; cv=none; b=alJibal4tijWNB0tinC5nN22EgCqcGLLUBqZg3mFFpHc82OfCQ3z0i4pQk3BOy53jicpFZHZ4im2USwaHMAVocHeY9aIfDj+++a5OCag+iQ6uZV11pgDw90ho8ltGMxjkvM+8rXDmeTDA7Xa/o+rDIrgxVDVkjGhSWSRfqPMh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165260; c=relaxed/simple;
	bh=TzrW3y6SzsbNFighfe8q6Qkw+b/AgGKoiKBOEDWYo2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvxM3//6UzhL2H1TXCNyMX6E1fm2DVWhZ+skHXKZrhazobSQx32YPQycEflDqvianqk+4AupPQRweXI+6HhrWOele4wM5kFoE7iBOnfkEaRDxX3xRC/AVVufuwiDv8p6sTnyoZuWRfFd1P89g5D2d9G6CyT7UdINqeDCBZLjsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQlgvrVr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723165257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUh2ZcyYR28eZFFdQirdhBUZopZzvCQuM/XbmHwKiM8=;
	b=jQlgvrVrBEZZ+ToogrLZI8TZS9t8bjiiyJEuwNFloqjBJRZ00vACZpaOpxpmUc9rwQF/7y
	a7/GkcLvxr4zfBslbnEpeObYUrov3N5IMsDI3HhGtPfbT6eHDeN99o08ZvqIPyDmoyTCwJ
	MPijO+HKeGFI/e/m5q6YuncaarHcquo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-5hjdLnQtP42zcJyK7MW5VA-1; Thu,
 08 Aug 2024 21:00:54 -0400
X-MC-Unique: 5hjdLnQtP42zcJyK7MW5VA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44FB31945104;
	Fri,  9 Aug 2024 01:00:53 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B4BB19560A3;
	Fri,  9 Aug 2024 01:00:49 +0000 (UTC)
Date: Fri, 9 Aug 2024 03:00:44 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
Message-ID: <20240809010044.GA28665@asgard.redhat.com>
References: <20240808145639.GA20510@asgard.redhat.com>
 <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Aug 08, 2024 at 02:20:21PM -0600, Shuah Khan wrote:
> Wouldn't make sense to fix fix this in selftests main Makefile
> instead of changing the all the test makefiles

As of now, the usage of rpath is localised, so it is relatively easy
to evaluate the effect/prudence of such a change;  I am not so confident
in imposing rpath on all of the selftests (and, if doing so, I would
rather opt for runpath, to leave out an ability to override the search
path via LD_LIBRARY_PATH, if such need arises);  in that case it is possibly
also worth to add -L$(OUTPUT) to the CFLAGS as well, as the compile-time
counterpart.  But, again, I was trying to avoid the task of evaluating
the possible side effects of such a change, considering the variability
in environments and setups selftests are run.

> Same comment on all other files.

> It would be easier to send these as series

I hesitated to do so due to the fact that different selftests are seemingly
maintained by different people.

> please mentioned the tests run as well after this change.

I have checked the ldd output after the change remained the same (and that ldd
is able to find the libraries used when run outside the directory the tests
reside in) and did a cursory check of the results of the run of the affected
tests (but not so sure about the BPF selftests, as they don't compile as-is
due to numerous "incompatible pointer types" warnings that are forced
into errors by -Werror and the fact that it hanged the machine I tried
to run them on).

> thanks,
> -- Shuah
> 
> 


