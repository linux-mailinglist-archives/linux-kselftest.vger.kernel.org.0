Return-Path: <linux-kselftest+bounces-14003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F8F939474
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75901C20F06
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F888171094;
	Mon, 22 Jul 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdQtOpLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855A170836
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677652; cv=none; b=CB1Ip90LTKjsPT3Z5taz/4q+owaVWSAb2A+egcfXdxTRCNvS8UTcZBO7YjV2d3+pymwsTXUto2jH+9R5i/jt2nZ/jcWeacRb5VOpM5X2+wz8mYilK4xXKL+8GisZbFitmH+FXYkOU5Zt6XVqOEQPFPSbLl+lr5wgBhuRcFvick4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677652; c=relaxed/simple;
	bh=lxD+x4M5ZuRIs5SmkXUd3G0EwqlJokSJsLs34BG1Yj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtHDfC2OWOMLCeEh10ejFQVV5uvHgNRorQjSoG4ucI/qgUcgsskdD8AyiWDGvwD6deluTv9T4H+0IXoiS9ynqqCLJSN9XaEgNDyV505PRyTx2r5MTAw0BOsdQOLaMDd6EGFQ+iiU7uj8+m4vq2GjAd1PKPLDXfYzSRGwTQN0B4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdQtOpLC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721677650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iHghnHlTR8qrrh0D9KWKWiFHRcAr406QMFW8Evv2TA=;
	b=BdQtOpLCJcQFTVkVwMoBwIJnIEofO/CXJ6OmcZ5utC2gbgCv9iGLvjbXDpEiDANSok3xhb
	az4XDksCk2X0fazGodEKlXcJx5z9CWNDtcvnwJUW0gW7eNd7uBR0uL9nijCFwWeMrwR9vf
	qmhdUh/360TSpUYW+G02XHF7pXat1kw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-BrAfaY91NDyFN1Rm5wFZKQ-1; Mon,
 22 Jul 2024 15:47:26 -0400
X-MC-Unique: BrAfaY91NDyFN1Rm5wFZKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A9D81955BD0;
	Mon, 22 Jul 2024 19:47:23 +0000 (UTC)
Received: from [10.22.17.2] (unknown [10.22.17.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BA171955D44;
	Mon, 22 Jul 2024 19:47:18 +0000 (UTC)
Message-ID: <9abf7f84-c103-4280-825c-b382edb9b8fe@redhat.com>
Date: Mon, 22 Jul 2024 15:47:17 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: David Finkel <davidf@vimeo.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240722151713.2724855-1-davidf@vimeo.com>
 <20240722151713.2724855-2-davidf@vimeo.com> <Zp6jSoB14boeGhWH@google.com>
 <CAFUnj5MF4nKq0B7aWWyBpK3b5EZh7W4+xAmeg5SMwpd7gHptsA@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAFUnj5MF4nKq0B7aWWyBpK3b5EZh7W4+xAmeg5SMwpd7gHptsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/22/24 15:30, David Finkel wrote:
>>> diff --git a/mm/page_counter.c b/mm/page_counter.c
>>> index db20d6452b71..40d5f4990218 100644
>>> --- a/mm/page_counter.c
>>> +++ b/mm/page_counter.c
>>> @@ -82,6 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>>>                 */
>>>                if (new > READ_ONCE(c->watermark))
>>>                        WRITE_ONCE(c->watermark, new);
>>> +             if (new > READ_ONCE(c->local_watermark))
>>> +                     WRITE_ONCE(c->local_watermark, new);
>> Hm, can't we have a single comparison on the hot path?
>> Also, we read and write c->local_watermark speculatively here, Idk if it's still
>> acceptable with an ability to reset watermarks "locally". Maybe it is, but
>> it definitely deserves at least a comment with an explanation.
> Unfortunately, since the two watermarks may be reset at different
> times I don't think we
> can consolidate.
> e.g. I think that if the usage peaked, dropped down a bit and then was
> going back
> up again when the "local_watermark" was reset, we'll continue only
> bumping local_watermark,
> but we don't want to touch "watermark" until we hit that watermark again.
If we make page_counter_reset_watermark() reset the local_watermark as well,
we can guarantee "local_watermark <= watermark" and wrap one check inside
the other.

         if (new > READ_ONCE(c->local_watermark)) {
                 WRITE_ONCE(c->local_watermark, new);
                 if (new > READ_ONCE(c->watermark))
                         WRITE_ONCE(c->watermark, new);
         }

Cheers,
Longman


