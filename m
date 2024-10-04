Return-Path: <linux-kselftest+bounces-19080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005E99134C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E91F23C85
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F51547DA;
	Fri,  4 Oct 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/yQWvvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7B1798C;
	Fri,  4 Oct 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085945; cv=none; b=Rcmsu747SCBujYHx6EuKZh6aCqauOkow0yGMuNXhYU2kRmSvJJx2Nccf3qfZDKo4cGLjJSdIgDd7+kUwhaStT5QP+tPqUXaOccc+D4tY3U3zhUgLZfiJJVOKa/RbcGS+H5X2d7mdEgnw0o3BluwdY1UvvZnNObytyRgJefv8WEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085945; c=relaxed/simple;
	bh=e7uYEUVrwAmgJEKxlmdLdTFW6JlEeZeDh+5bDid9gok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrmxltGQQNoEDf9k3dW9EtLv5MtXIqzZJuw+Uiw5+xV0uKco5NKCXV32dpP2FF1t1wRDePV4v56e9LqPi2Q01BvkwCEfosV02Z+S/gkQlyK426DErn33jG7u2IRMUUWoRbCFHhOiJOHua4oysMUBC99nTw1JYYUDYPX3aoH9hmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O/yQWvvu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Cy5y7ftGIYSuJU1GDHG1e2mx2IRBKUaxFGuxqtudW+o=; b=O/yQWvvu1ppQMMoFjbp9pRAD6b
	etawhsfETbuSHSpHTtHfSM7ca2XXxf67ibJaFjhOugIdsI3zxLqJIgtx3pZcwz2Up1iSbrBCwdskN
	+SRgWlN3d0marg8CO1LRbFRTSK888EvlBOd5YAAuGSsvLZli/ZtrPu5zovW46BFAUSl3e8nmb41Rh
	EAYqPVjy6QMNA3i4aYgmHNSO2XdkE1Quk4cws66SOyNWz5ycPYsGVuUM9ZyC0wpuwyH4DwVX5niml
	EYNVA/3L/PZpe1H9r3bIHdnrsQtvsCBUtrqaq40Ow4Qwq3ZIQzf+n4nS3OC07IThxqtlH2qT90dAE
	R8djFPcQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sws5o-0000000Bb1Z-46SU;
	Fri, 04 Oct 2024 23:52:17 +0000
Message-ID: <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org>
Date: Fri, 4 Oct 2024 16:52:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com,
 sroettger@google.com, pedro.falcato@gmail.com,
 linux-hardening@vger.kernel.org, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com,
 merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 enh@google.com
References: <20241001002628.2239032-1-jeffxu@chromium.org>
 <20241001002628.2239032-2-jeffxu@chromium.org>
 <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org>
 <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/4/24 9:52 AM, Jeff Xu wrote:
>> above is not a sentence but I don't know how to fix it.
>>
> Would below work ?
> 
> Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> threads without write permissions. These behaviors have the potential
> to modify region contents by discarding pages, effectively performing
> a memset(0) operation on the anonymous memory.

Yes, that works.
Or at least it explains the problem, like Theo said.

Thanks.
-- 
~Randy

