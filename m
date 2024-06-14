Return-Path: <linux-kselftest+bounces-11929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C994B908BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561D5282DEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20319645D;
	Fri, 14 Jun 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEySDumO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8357E574
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368095; cv=none; b=Yu6Y+d70NuabLtEf4c1yAlr37lPRXk2tZ4nUBPrXivQcdI0ci0ei4jqwi7oOAxCtrkZ4ctRvA9RGba1DYGx1dWLWxBi4Mj463htuZNxZ7t+DUsELvCpA4T26sNkpSOgBplKG/HnG19YAPH5Ld+3BFZ99P3o06zlxr9qky8Rb8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368095; c=relaxed/simple;
	bh=WB0n4Nw8v6FP92UkyEHi3buw3bVenYcbikfby5Qsepw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV30Uv9JX5ISILaRKT+XZQSXHf5xmZ89HWDYIE8fwU4dlc8rTnwsguY1RKW1uxKBsNI7VRIxwB3mpEanltmB/BzMleGGkvl7bAbvr4ZXLGATxdg5FcJGH0uf7jQX92yGvdSWEWe/Ue+t9GHjhMNPq5WbSaC3xr3O+x24FS4kOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEySDumO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718368093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=44OrimEhmtrhm5kT3OMFjktUTjI2bbjoVIwPzlDDZo4=;
	b=EEySDumOXl8k7eM5eE5+pfMQw5XZNPgP+WssTSdqkI3m4cecku3jMJLHdYB4nUIdQP6xLd
	fmCM2kUMPmkDTPlSyxoT9eAU6pNUgby76QRjocaiw+w4NYoKGUKniMRk8pZDDVMq1UFs+N
	uBbLsm9aGiyYuhrBSw6ImfqhgN4ke2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-jqkkawa8PGawB1PSK4qb5w-1; Fri, 14 Jun 2024 08:28:12 -0400
X-MC-Unique: jqkkawa8PGawB1PSK4qb5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4229a964745so13272045e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368091; x=1718972891;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=44OrimEhmtrhm5kT3OMFjktUTjI2bbjoVIwPzlDDZo4=;
        b=jJrTWZpYO7nOaR/ShKmjNl3ptQZobTrQgFyndftiOgZYaWdEEnr1LKQuLXNbdMiWxJ
         0MyYZC/OPz2RkTHclROl8jqyfl0QpnwOxVQx45P+ueMUq9ECPUEEY0GxJY2Bb875xnTb
         U6xaHh8bFf/0wX4lhRHaCP1JjyQkW0aMeFI505aRbrOw3u0uNpeeWC4TP0bHep1wB5Rb
         /Dj1Efqlk+skmTVDDK5vEeLHdw476f/C8G0LEXOqF7MAu99sRlaXCFck9ZI7nY8eF7dN
         YZ7/Xdo1EY1inNDKh+asain7uSR/sGmQExXsn55ypv29kjR4Wj1LvSUL45cwpj/lCiL8
         rUdA==
X-Forwarded-Encrypted: i=1; AJvYcCWIZ6FANSj+/+sYBIaS4edJAZCcmhDAqha6tynr/1KSD4KPRz/OP3sK0XSrvGLkTsiizsp3N6GSg1CTKMr6T2394s1c++sTOr54PRtReCQE
X-Gm-Message-State: AOJu0Yx7iQG2rUU7TZs8DWvsSo8W24FKEYOu1Ow+TBxGi9GlaygBgyiV
	8B1tTtV9Zf4QE/m3dxm4acG8nlCPtnYkxPYjupAaEQ+xCbQRXFbE/suCLtcvRFjh3ZmQds5GrIj
	xcNG2qjiwm0k0e1LUQyzf7ebazq6auuuIqgxEfzil24ZVI5wObOtIGDpKsmw3KJi/5A==
X-Received: by 2002:a05:600c:358b:b0:421:75e2:c090 with SMTP id 5b1f17b1804b1-42307be9ad6mr9684235e9.11.1718368091025;
        Fri, 14 Jun 2024 05:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEY5jcT3+kJEcHCxufK6taxbELIO4UwJqeqjP1xwhwbg/Xt4vvi2DkQU8xTOqyNCQN612FCQ==
X-Received: by 2002:a05:600c:358b:b0:421:75e2:c090 with SMTP id 5b1f17b1804b1-42307be9ad6mr9683985e9.11.1718368090576;
        Fri, 14 Jun 2024 05:28:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73bcsm93684005e9.41.2024.06.14.05.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:28:10 -0700 (PDT)
Message-ID: <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
Date: Fri, 14 Jun 2024 14:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-2-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614023009.221547-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 04:30, John Hubbard wrote:
> The selftests/mm build isn't exactly "broken", according to the current
> documentation, which still claims that one must run "make headers",
> before building the kselftests. However, according to the new plan to
> get rid of that requirement [1], they are future-broken: attempting to
> build selftests/mm *without* first running "make headers" will fail due
> to not finding __NR_mseal.
> 
> Therefore,  add ./usr/include/asm/unistd_[32|x32|64].h (created via
> "make headers") to tools/uapi/, and change the selftests/mm files that
> require __NR_mseal to include from the correct location. The way to do
> so is to include <linux/unistd.h> instead of just <unistd.h>.
> 
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
> 
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

If it works, great

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


