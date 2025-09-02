Return-Path: <linux-kselftest+bounces-40647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621FB40E3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 22:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57D73A0F88
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D809350D42;
	Tue,  2 Sep 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jApovokm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770E3054D5;
	Tue,  2 Sep 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843194; cv=none; b=u1q3pe4P1926z6M6RnowuAFh9Dc0Bb0oYN96b3u45k7oqc1K5RHhXDq3bTfHZjhgvtIDCldJEg5pEAi/yF1Y6DopVmXh9kmeb432hSya8X1UMY+uMm5j9+St0tsFPEozEeFXv6TzE0XV6AjbsEdSq1zVZuRr+nXKxG5n0Y+Qnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843194; c=relaxed/simple;
	bh=QWQ7lU0T+kF0+AtsOOMQGS0O6XkoLY7A5Dsmz+jB3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIWn1/idZIv/ArXvCpOv+L2IuS78guZZBDo4o4vkmHk4c1AEEG26ulp/mYQiEnOZw8hmnDGe2veQXb0AYL2kf0Y4aF8by1EYfXb/7u8uNmDhZVqm0Z8C1XvfJ02RWjkMOaBlPs5BI2WuHrY88gyGBAAC64O+qSZZIK0AOBEZeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jApovokm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so28659075e9.3;
        Tue, 02 Sep 2025 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756843191; x=1757447991; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVK2tUSQ33SqKWvrtmKuuwwgdgNcHcoDhIdJoECqwro=;
        b=jApovokm3hKBuQtX1fVUABl4vuL1Gl/E2s2ojXDFwYYXKNo3ud47O9yef2wnPkUkpc
         N08pAlGV+QInjUSYeTyPzu4J9KQfPS/DwXoEw9tTJJ8CCU+sAIIe9RGE1D+/JaIxwUvP
         vRAwB8ApqEEbUcrFEV2kmkBVcIq9OkENB0y+qJdXTUZnnCSx/kMjBcY+V5Ui5ZaaaOj7
         Ci43rZutor9hsYX6pjHQh/uyk530Q7sN73TR+KZuWYh7kWHECmEHdps17H/YEcQMsSQR
         fIjaMrfuaPUhRJ9ABQaQPU29La6aQK42+0DVNedNMgKjNrNuzvrDQj/TkSTZ1psKAGRQ
         1G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843191; x=1757447991;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVK2tUSQ33SqKWvrtmKuuwwgdgNcHcoDhIdJoECqwro=;
        b=r8Hd3pQwTT6iB+1obn9ARAbwgc5CPMxiBQKopORzdnV35979Qr6qxtxdD5jrQNC/rb
         qKo3lSjMsSOyPIm8++M/Y3629o3Yaph1TydTNpu3jA+0fqSS6+3Fv7bXQ4ORjbCVP/Lk
         JhTs1bgVqi0nSqTrj9eAoT6K3VDqlm8yNKe7FEhFW+GfOxh8JdtGFe/c5+1Wx1FxSdsy
         3J50OB7fELlxOYS/0LiJjt+w+/U2cKxCe9XyxgljdzGToghKNLzL7LmVLauXFp1sljmp
         Z0n6qusGZ/OAY2NrXdtQYpNjixYq10DipETKbmFc84AGfoi3OXv1IqZlEAiSq1b8iYaE
         Iw3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQRbNYuuHKowRGxUxVGI7t2OUHmy5zxlYxIO2iqyvMGm3qzITzAULcqQV1RuxbqgPthl8LbMlosczysuL8aLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1OPUg4w5lQCeYMKvLWg1UCFi4Wst+3547/oKCtu9JSoI6QPs
	sp8ikIHYL9x7k7QAJlNRLbCF0uDe1KjtcMK6nXWzKX2riUKkEmW5hA0k
X-Gm-Gg: ASbGncugXS5y792wj2mY4QBMEIsnn6UFX4NVCyoD3PTQBfcXplp6UPvso9XnaH4uOBP
	0Qpt062VxsAzEkV9heFaQ/o8dDeZiEwBgDbf6ABUOMOF+1nybTtloLQwNpx64AD37JGf2o1VQkR
	0ths4/uEMPXgAQh/iaZmUxvOW0C2boODjGfgky5zl04wmJz8jkRhK4/a/xe74ahZQD1lzTq482Q
	FoyoTkFpPUd42wia1RGi2Y820bhEysu9HcX9sgp0iLcnaOTdYXKnQgHowGQe3hgdrQ85ytEnEQL
	JJ7fQFYhWSAxDw4qrpIVJxe6JFp4Gbt+4kTuy7W1X53oGWk/Uzoiv7u0hOV1Cul+s9xiN9MQjt+
	rHZYJNmqtumNy+YlKdeepz3Wf4w==
X-Google-Smtp-Source: AGHT+IHQV2oJYjYljdld4Wh4gdxE2HPUPFQOs8rCtgfrNl1dH9ZLK5M1o36UkS52Sihg1n+pZ+hYow==
X-Received: by 2002:a05:600c:1e28:b0:45b:8600:2be2 with SMTP id 5b1f17b1804b1-45b86002d9fmr86765995e9.2.1756843190844;
        Tue, 02 Sep 2025 12:59:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e380b77sm214291355e9.11.2025.09.02.12.59.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Sep 2025 12:59:50 -0700 (PDT)
Date: Tue, 2 Sep 2025 19:59:49 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/mm: split_huge_page_test: fix
 occasional is_backed_by_folio() wrong results
Message-ID: <20250902195949.pfjv55in3cdhxhfg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250902162536.956465-1-david@redhat.com>
 <20250902162536.956465-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902162536.956465-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 02, 2025 at 06:25:35PM +0200, David Hildenbrand wrote:
>When checking for actual tail or head pages of a folio, we must make
>sure that the KPF_COMPOUND_HEAD/KPF_COMPOUND_TAIL flag is paired with
>KPF_THP.
>
>For example, if we have another large folio after our large folio in
>physical memory, our "pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL" would
                                                               ^
One nit here, we missed                                        )

>trigger even though it's actually a head page of the next folio.
>
>If is_backed_by_folio() returns a wrong result, split_pte_mapped_thp()
>can fail with "Some THPs are missing during mremap".
>
>Fix it by checking for head/tail pages of folios properly. Add
>folio_tail_flags/folio_head_flags to improve readability and use these
>masks also when just testing for any compound page.
>
>Fixes: 169b456b0162 ("selftests/mm: reimplement is_backed_by_thp() with more precise check")
>Signed-off-by: David Hildenbrand <david@redhat.com>

Otherwise, 

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

