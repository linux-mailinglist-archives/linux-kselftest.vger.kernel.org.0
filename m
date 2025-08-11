Return-Path: <linux-kselftest+bounces-38708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98135B2161F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E90A427E07
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F832D97BA;
	Mon, 11 Aug 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNjpV+v+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BC1FAC34
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942914; cv=none; b=ak7hnBg/ZONznV9TJQUndpJ9qWvpt7mGsbRZHV5OSWpBE4hWn5Rkj/d2cp5b4bD41bt/tUO/ZOvCjMNVoJQxB9mXAIxg95dDPLu2iX04DK+L7BybwfaSNQhEZbmmBEJhA9eoXFdIN74Bij5dR3cN7vTkRs7oPYqYKOokQEKb1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942914; c=relaxed/simple;
	bh=45vuuubIMWUUtPAOSUo9OJvNM15V9sNdVsEQC8gblIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEFpBC4R3xV+xs0omcPAyiK53TrXP6dm78zjobLF4+Sqr1PSdB7w7qyHY0IsawXXLuC6dIPtTMAr8iy5cQ+yYXDq1Y37Epz4FfBy0MD0zGeJFZ/LLj5uI13cAm/c5Uytbt9oQa8qpAhLnddBxwZnZ51rIiFccImP1XPFiKkJGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNjpV+v+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so3678523a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942912; x=1755547712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLEUl1LU8Wd86Kf0RO2n3/0VCWmQgPXXz614kfQpHU0=;
        b=bNjpV+v+i+JaOUlSpW2+z4REHTmHKqVtQ7z5fmszUMh26xWBy368Deazx5ykddb6bg
         H28u39fZHzIHrFS0yyoERnV2qzA0EbGVR6v1nJitQaPEC8xlOlQHxhb9ICR364fQkc+R
         cwuwdxeaGplrOKNbY8R828fQWJK5VpY5rg2lGsMKkfekqidjFw5xiro2phg8xYDpxoC0
         byco4osJ+SQJQOrUqTC7tHHK9iqpAyXVttUcdI+tY2OQcB0t44CBtcWgUqDhtWygduGE
         ZAu7CM9NwNXLAD9XjBhuYFjcxe+Lk6OO3UX8CNL9zu6e/AG7aQJHdU7qXHpzHiWhvz+9
         YACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942912; x=1755547712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLEUl1LU8Wd86Kf0RO2n3/0VCWmQgPXXz614kfQpHU0=;
        b=wYrtCYa9g6R2JPH+DpQ3zNYU9LWC887ljxxKazx5W/LpNRsalVIDdm1PkExlXwN29B
         Bla2N2YPPmBHZ2mMgp+uzZk4JcQ21Ufjhs0HOn8rS9ppGusCygFtDPjE/FeJ+zd1bnqB
         yPLUGIprRKVJp4tClutTYHqbDGFsBlx49RN4SrZXlNl90qEZn/FVeAuiUmnfTEv0Kdzv
         FmmViGmo744S8GrJAmHPwFRx6s89leeLwFk65cYMd57X9Ox0kbsTnEE3z4rOHZzKOtsg
         19yl/bSak3yzZLABQwB8A/hcJNFINfPYYQgahxZpvjayiBHqkE4iDIhPTkNvvNid2LC3
         9qOw==
X-Forwarded-Encrypted: i=1; AJvYcCUzar7ZV9n8L6iFJener6u4whnAaEawkr16v0T8GUaUMMEGixirsTuVN8XFoXsPNYrJ0tIPWORdzFrPhDQDl1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/aUUbQHcrJ7nNzYIDEYQbWylUFTOwrkIlXD5AhXFp+2gtkcH
	qzvPPUGv/+ePR/1wkpUtxO3AOq0DcLptZ/IPJz98tYdfwU72QTvbQX8s
X-Gm-Gg: ASbGncvnlVPBIP+fxnltFL+QqwwNQaWOxW2OXF6zavuyYHq/6vl/9JIEdkouM7PwcKl
	oaCwp29dKmsQaEi/SbenU/rjxBc+SudHaofl+OeUPDh3Dv8oweiYoeCsc56feDhcppTxN/PZeC4
	Cy1ChT0FMJhi94JV4pb3MYNo0Kc/9LHv+XuKHVU5R28aUiU0AppQBLH4GyOuKryCH6R5JMtadpR
	QgNrteb2VuUMGskomXmWAJou1f0kWEiRr0xo7/8ohpDrCPc2z8F2QlOgnKhwpyMZ4tMI8rF2jnJ
	tmH8TmHrSLeaw/F0CgNArUjvxzGn04MVtqzUVYzttJXFRtE0DrpwYfVS7ObxsUaGs67nGlh0CCI
	QCeZ2Dgcsz7cQ918ro7pFXi9CWaSEO88JLufwkCbvT/Xb7+G3EoiJtw==
X-Google-Smtp-Source: AGHT+IHQP/gjpkgtgU9oCrE6WZy0pPW8gkPGtnayycj3g78Wo6JoWQFhXmjRrQT2ghZKKT8uPm2P7Q==
X-Received: by 2002:a17:90b:280e:b0:313:62ee:45a with SMTP id 98e67ed59e1d1-321839f2b35mr20590862a91.13.1754942912368;
        Mon, 11 Aug 2025 13:08:32 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216128ac08sm15547043a91.30.2025.08.11.13.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:08:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:08:29 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Donet Tom <donettom@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
Message-ID: <aJpNvb4ehfyk55Um@fedora>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>

On Sat, Aug 09, 2025 at 07:42:09PM +0000, Wei Yang wrote:
> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.
> 
> Pass in the hugepage number and do the check based on it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> 
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

