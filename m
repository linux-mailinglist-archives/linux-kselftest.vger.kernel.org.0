Return-Path: <linux-kselftest+bounces-41669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A8B7CDBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801A9463820
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B662C08D0;
	Wed, 17 Sep 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUQZBz4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD727C17E
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106383; cv=none; b=FM4k/6/hbaN8hXAWvXCm5M3CJQ5paQ++W+/a+U1Haf/k5BMeJwzcageDWxIWU6nTQR47zTgMOLBR6y4Z6xvYNZa9U2qWtVhrhULUvJtDURi4QSPiR46QaPkfILuRMYI8JR/82ofa4mc+N9ANajDGlG40FB9PLJNGRNdWdBYEAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106383; c=relaxed/simple;
	bh=Ikb0ULTLN47O661rXEoFttNyAecoMC7wAc2tvgvurUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+rQPra9ljmUiVrY0sQj548dkdmH1RCUvDtlgoVLYBnA1qe8WO5uEl6W7sJnVHZLG+iZ9aYndjR9x30kfQF0F6cUUZGMtVJ3bEXWYRMw+NbjCmGLpVamvuWyLdOnZngEll7hKyJYZ1yvLnh00KlTp1qN4KuBMi5WOnkwGIT8PxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUQZBz4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758106380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h6j8Nz2GipAO+d9sYeGusBaesKR+rSO74MbWDuoA0aU=;
	b=TUQZBz4zd6gSLt+q4unYgO7VVNJPDQVdTt01L9K/A+SWmdSSnuJ0mwfoEbEdDNHZjYzLhC
	92RrpSCRrume2tLXthaomNFjkikhUzkMR80AbicufP0ZGkO6snN2kBI1hz+xS2pKFWQn4e
	LPQtUyXxcQ7pwbVuc9/d24whRdCNkEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-1LOfW1G8MdKx0YsZTxhJqg-1; Wed, 17 Sep 2025 06:52:59 -0400
X-MC-Unique: 1LOfW1G8MdKx0YsZTxhJqg-1
X-Mimecast-MFC-AGG-ID: 1LOfW1G8MdKx0YsZTxhJqg_1758106378
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so34365405e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 03:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106378; x=1758711178;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6j8Nz2GipAO+d9sYeGusBaesKR+rSO74MbWDuoA0aU=;
        b=IQtfIX9OzSI0sFHzDjfF7nSclsce8W8NEFqQozkUU3ZIgPL8z3l9QuT6KSR9hl7q9D
         cZnuX+NR9lgwvBOtwmViQj7m1i8fqjz+9G+Iv4P6EcQurEiYz0HlnpjwghGDDNtR391C
         Az3E/h1igN0FUNp6teS9SBBm5w2jl2szawGqRCG7sTa3WIZ/7iIgJlGtkbrZ9QwTVE7j
         m5vhEojptMG/Klwp15nnU8hA2zMmkTUhW/vkCzrDUf+wVH3LMRwAKGXeniGq30Ix55tY
         b/Bc5CJlIMivlKNbf7eocZxutmDL9WBqLU6rFhtSlqVr2CxkbDD4n9PzANmSsHq7X7+S
         sDMg==
X-Forwarded-Encrypted: i=1; AJvYcCUTVKEVD07yZtXjmX+MrrB7H95d5PRSqWYO5mfUVsE04p9ux+726S2pClsgRDRE6AQAIDqjY5e/KlofEWpfyYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUpIk5muG5Z7b3OzNyat1UoBumdLsYt03kFqiqk/9hCTx7jjf
	i6wfarTs2QoS1r11APE1MfFEmh+oCjb96xbOkxNQr+DtRH6uvJR3X2IUUr7fgYRhM91sbG74eiz
	5XckkPymKOmf5bD9RLkY0gyUeW+n70YzvvsBnjQ9nrLYRybzEWduM5Hgrl6wIvLQWIjD4Hw==
X-Gm-Gg: ASbGnctK5s+59Bni/o4hiKM4SgVLLXdPaMV1QCddsuPd4vgHVspl9Mz87jByfxbnYhs
	c//Sa48oTd/9E+7uJZynyYCkUs2YzaBXWL8opcFRdTM+miWk6tRqrBHWd3wadjgZKWcRjCtP0eR
	VSlp4+0Y/SoJherV5yHH62GxiM60oxx71vXHwwP0K/1qcrIPwjFzfWelmkHNViBYA7coJOjFZUu
	0ulhkDRqoBt0dMOXh/+c7i5p8JEwYg1GkJSyWqEfmve2zAcWp6/ZUoh6e91YumJrxaN0X45/z2c
	J5DUt5rjRz7VxlwDyMfHfM7ZXbkiBvVloWYklgxeLchRjWqZHt1ifhnfiZrEHpPu8Id3G0LxrK+
	wtYVAYfzjPmXAl91fwwBLR5np8X2/2N83hjb2bJL961OWBh0v6c6PPYpwxPx3u8OJ
X-Received: by 2002:a05:600c:3b09:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-461fc6674f9mr17283995e9.0.1758106377760;
        Wed, 17 Sep 2025 03:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESkIdDmkpsYOdBEK8Vy0LYg2yM7axrrebxRGyM0x90xAENdINMOVuiRGc5rue0jgcFRLjsmA==
X-Received: by 2002:a05:600c:3b09:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-461fc6674f9mr17283645e9.0.1758106377323;
        Wed, 17 Sep 2025 03:52:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d33633bsm32518195e9.11.2025.09.17.03.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:52:56 -0700 (PDT)
Message-ID: <ad019c14-5211-4261-bfb8-c4e0dd3b2535@redhat.com>
Date: Wed, 17 Sep 2025 12:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-2-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
> 
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
> 
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.
> 
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


