Return-Path: <linux-kselftest+bounces-24445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA29A1077B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DCC160642
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EEE2361DF;
	Tue, 14 Jan 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFsCDi59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45A234D19
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860325; cv=none; b=kiM+E8+SkCySNU+ofU+qh9FeHk8EAEA5d13L/rmUBnzu+cBJhjfqeU14lVbxXM3FdjxfC1JLj9hUIzqbM7TicR3Sd5NVmWAIi7Fh5C+YeYPCoRBjMWZmwFtptLNew7xDzb4Q5ASAIWuEvUGhR8AjlOGEuEb58sloCrAnJJnU6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860325; c=relaxed/simple;
	bh=yNJQFrzUEx23xGSrLXyTj4JRT93/xTHyUzW8i/EdykI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbyRPLjEpK2OCtURR9E8YOlLR0VpHZXy9r36TMpluMri0E+tZHxD/Bs0vy1LDDex4uy91L8Zj6vOFVPsLH8nLw5T14oR/jMmfOp879BQ86y2/olxdR+EwjRQe+njYyjuuSGR1rRndDbj4DdSufDlQYCn6zE64dFwprk6kF1YxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFsCDi59; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736860322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90Sh6A4D92eY9IojNRcYjWzM2AzR0p1oVcnVvH6tHfI=;
	b=AFsCDi59Fapu+LdlttQtv9JEguyIPeIsc6WBe2lblVVoivRzhWiiJnmAHiHi3Iqk6uvL+Z
	F+Wkx1q5fFm6Q16bfqi66nhDeaGjduYCbM//AHLstgEzPjB1jo0d9cwYuIQf6bUIn4QRHg
	lwTjbrBB0Cpc+guempXn2zUIUl7y8FE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-N5emNakUP-Gxmi3tsm2QIw-1; Tue, 14 Jan 2025 08:12:00 -0500
X-MC-Unique: N5emNakUP-Gxmi3tsm2QIw-1
X-Mimecast-MFC-AGG-ID: N5emNakUP-Gxmi3tsm2QIw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43582d49dacso37488805e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 05:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860320; x=1737465120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90Sh6A4D92eY9IojNRcYjWzM2AzR0p1oVcnVvH6tHfI=;
        b=dg7J5vMHiHAhsFDhVE+C47kOoYNEON5AnfIhF19in61GY2NUS4CLotvvVv6BXMmL4C
         YQrhOO4xF/ji/nyzZY+lpJxIpI8XtNLDr6ofnxsXzrbHSsRm/xCUtSpNGOV6G853iU9l
         3Z37/kCKBfdmwqmMRVCZuFpWGNw1GN0JY6pTiLojeVIiobRkKujHq3Op5FCvk60hE7C/
         KaTMWFHNsWoswjzypLMP2Lv31jevz4UxCcrxnxqPcQeXQPpLS8Xk25oTMHmWb341c8+N
         U8GSKwrgc01s6mticAWgJg2Ta6ljy6x0pLoqh/u6vD9YW5Xqxx+rBTIazeoCRofiETtA
         Pz+w==
X-Forwarded-Encrypted: i=1; AJvYcCURs5vpSwzC1btvheop7GmClUiGpEWB5K6/bijrxWA02LOyvaI26N1vQ7d75uA/6SMeqRGhVQPitdJIZzYRpuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycm0dUQnqsMdxm00FQ+Wxx5QMcJaFROunPv+oP2yrtfh4tb2In
	YVZX0rYNY+hgFExTLhrhyBAgZk2C4m+9efDxBPtigDi9nAuqY1xkwl5rkhYsuqDWtuNtxWQwJgs
	Jd1AcaGswrXSwGSLzwi3CGrDsMCNamIsQ1Y5Gr+kZ0Hg0SbInESHVHR2IaPAACqUrTA==
X-Gm-Gg: ASbGnct7MEeTp6h9rGevYcVuiQAhxQMuH3hnpDxifMGitTiCPPjGkGdCxTwF7VZhgXB
	bmj3LpWgKR5cpeKY2hHnecIuKnLVzt1oCADUcLvLIGG9/fVqCitq4m7TRX0w6ULRdDj+IajA02U
	D/SnHQJtiR0ktgdStUsVciHgT+sNzkSUd8s6HTIHr4Z/Nb0e1kcfCy+vG+xCjtspX+lRtF86txY
	OkfY/Fx8lYEcwlLIWtAqEtzfaJ3ly2UU4rNL2un9V7tI4pExWyfyXfgj09U0tfh/CIyFPj/iXZO
	LjP5z32ycoVcti2h8AxF47r+G+hT/qPb3kn4PQKoYjIy5iCYMozssD2ITE9DXYFyxW81oF0bkzl
	NqqyDngjj
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-436e271bcb3mr248790405e9.30.1736860319695;
        Tue, 14 Jan 2025 05:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgMUjLxUFWXQBy7U9vrNapCtE0VApbu9G3fBG90YwKqZV4xp/ONfTprgG15keMciyMYhvPLg==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-436e271bcb3mr248790145e9.30.1736860319341;
        Tue, 14 Jan 2025 05:11:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc08bbsm207765915e9.12.2025.01.14.05.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 05:11:58 -0800 (PST)
Message-ID: <059fcb77-7eea-4e3d-9b70-d88975388d9b@redhat.com>
Date: Tue, 14 Jan 2025 14:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] selftests/mm: virtual_address_range: Unmap chunks
 after validation
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
 <20250113-virtual_address_range-tests-v3-2-f4a8e6b7feed@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113-virtual_address_range-tests-v3-2-f4a8e6b7feed@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.01.25 14:15, Thomas Weißschuh wrote:
> For each accessed chunk a PTE is created.
> More than 1GiB of PTEs is used in this way.
> Remove each PTE after validating a chunk to reduce peak memory usage.
> 
> It is important to only unmap memory that previously mmap()ed,
> as unmapping other mappings like the stack, heap or executable mappings
> will crash the process.
> The mappings read from /proc/self/maps and the return values from mmap()
> don't allow a simple correlation due to merging and no guaranteed order.
> To correlate the pointers and mappings use prctl(PR_SET_VMA_ANON_NAME).
> While it introduces a test dependency, other alternatives would
> introduce runtime or development overhead.
> 
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


