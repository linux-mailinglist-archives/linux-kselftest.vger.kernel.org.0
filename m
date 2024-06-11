Return-Path: <linux-kselftest+bounces-11672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC79037F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A751F249E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9D176FA7;
	Tue, 11 Jun 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwfjCo6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E3176254
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098579; cv=none; b=dHx0VgT8sHsyKYnpRiN1yc7WAg3YDcXZtxzWTnXo/krJz+Dxd5a389DlMzaArTXhjRffPhXH/3L90xnHzYNvXpJjfTtOR6XtA/HmHget3KUaozDRv2UJ4l5QIDwyBkZpoEsyYwpqLo/6MrwBcZlkoDmUeOxYelcc6aMUyO0rixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098579; c=relaxed/simple;
	bh=dDF82/WVEMJLMp6RKwaMKit1ulza66VoYaoZYIYpjww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brH+/QrbLVUqjhKiVhmFKoRwSdvLWfsjJ7j9DXbo5w64yhTGjmenRbS/Mq9pR+d6SRo2wcffl3UmAQ6wu3gpbK9h0F4cD/TNrTarhYUjUwRVI+HQs27cz2zxd1YHFHYsN5qVxA9X+7l5q/MZe4l+BURfGNZr3RCitb4O6eerBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwfjCo6m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718098576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TlB7F7lscejzuVTo3t1wMraq8CrMqmylVI6BgXXCdcI=;
	b=YwfjCo6m87gw3UrI4B27Ca9tfwvZNxToefzoMfiW8fWPzlmJwE7JJvabrjv9mw5WQ1/SmI
	4ZhH5jYW0oOzOzBpliZt4q346irnaEaoBsQFBQtgn/05vBWNskMC9XAjJvIB3sFFliFHgP
	GQRYzwy6zpSN37g351CQoYFnA3wk/+Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-PAQmiwNtNBCbdxJs0JnOeg-1; Tue, 11 Jun 2024 05:36:10 -0400
X-MC-Unique: PAQmiwNtNBCbdxJs0JnOeg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd5d5e151so25226551fa.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 02:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098569; x=1718703369;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlB7F7lscejzuVTo3t1wMraq8CrMqmylVI6BgXXCdcI=;
        b=S+myFaEtq3cwb86gqQXCB3d1ag9F6ENXVxgsVjq+keWI3YCV6kyO0FOrZ3sYqTa8hU
         lTx0RQhVxIQp3ApovcVfyQdEBxJ/jP2idsIqN3RUOMgnM7jZCi81t3ef85ni9QZ27qXm
         2R0DGpnM4ejcMXzJpJDNWZKAT7/hNIaF+x8ix+9olaEUXcpEHv134MfX5wyeX9Ic+0OK
         MDSW9bBRUbXyqZNTsY9+fKo1bNIfN/S6q7y2XVrSPBnCX9JZaggVxBdJuPdRL7Ec7+zG
         ZqiQ/wBe/W43ld21U/sUitwGNeYoebQA+qbQ8U6mUZF8lQtgoNhH1pWHSaVFSATmycbt
         JgyA==
X-Forwarded-Encrypted: i=1; AJvYcCWGbuoa7gwIlM/p9oZsSqsIOhT0lgo5ic2phdbImRO/OPvwzuYeegqcXoz/moxLoC/p3FmN6enPoG0tlp8N/A1WONo05V1mXKwX4WLrD72e
X-Gm-Message-State: AOJu0YzfF4p7ZJyylnDgQ4N7RHH2Q0eWPjcOS+m/HtuJUqarpSKXE/k+
	ZaNqKugfDkU36R74KnPcc0RplfPYnBApigB4BC7MhWaR3lUvnkMXtGwrECi+wo24+PKIlFC1PMo
	uheZQ+01ICTX4WRjYRByMkRu8kQj8dKQ1oRD3qenul6oXpy6t+nwpHgyWKkNEUiILvQ==
X-Received: by 2002:a2e:8e97:0:b0:2eb:ee03:f5e4 with SMTP id 38308e7fff4ca-2ebee03f623mr22790741fa.26.1718098568818;
        Tue, 11 Jun 2024 02:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNp2sevQyfiC69YnEOTxSqiVOgujok/h0CX14g0NhU6HUh+1k242chVMmfp1m+LeDXZiGLuA==
X-Received: by 2002:a2e:8e97:0:b0:2eb:ee03:f5e4 with SMTP id 38308e7fff4ca-2ebee03f623mr22790591fa.26.1718098568334;
        Tue, 11 Jun 2024 02:36:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c6900sm171291355e9.36.2024.06.11.02.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 02:36:07 -0700 (PDT)
Message-ID: <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
Date: Tue, 11 Jun 2024 11:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
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
References: <20240608021023.176027-1-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.06.24 04:10, John Hubbard wrote:
> Eventually, once the build succeeds on a sufficiently old distro, the
> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
> after that, from selftests/lib.mk and all of the other selftest builds.
> 
> For now, this series merely achieves a clean build of selftests/mm on a
> not-so-old distro: Ubuntu 23.04:

Wasn't the plan to rely on the tools/include headers, and pull in there 
whatever we need?

> 
> 1. Add __NR_mseal.
> 

For example, making sure that tools/include/uapi/asm-generic/unistd.h is 
updated to contain __NR_mseal?

... to avoid hand-crafted defines we have to maintain for selftests.

But maybe I am remembering something outdated.

-- 
Cheers,

David / dhildenb


