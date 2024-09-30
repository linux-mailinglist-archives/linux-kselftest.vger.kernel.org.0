Return-Path: <linux-kselftest+bounces-18604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA2989F14
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A2F1F2232C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCD1741D1;
	Mon, 30 Sep 2024 10:05:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF81F95A;
	Mon, 30 Sep 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690726; cv=none; b=ly3L33ZeaHwu9PbPVdX1AYL8tQhRhjnPQ9GGjCH/3JT3LlSr/+FP/lldeC9d1eExUVbW/RPVdjDcJoTJMqgQSlu8ey1K+ETWn+3eKvPXrMtrzX/QetW0yvqmrD78hAvVfLO7kZbj7eS69l/gM8XlEHbrTuGwlHi4R3WNkJiVlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690726; c=relaxed/simple;
	bh=GBnqVbsAP3bpkcW+Z1mKA9sO+KJte2kMXeC3W0Q8GsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6MWCIKFsm2MZ3Z1BmQsZTp14mAoxkjuCTgRALQX4BoeVN5crwg3Yy0DdEBcXxxeYsbZEEiRgnu8UAlG6ELDxnVf1Nymgpl594I20apHe3wlcD1hOU/KnF1Kb7W8pfAJOWF7LGmDo8c+e8scRCIdTUYR9sDJ9jzgt2N76D3cUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so957006866b.1;
        Mon, 30 Sep 2024 03:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690723; x=1728295523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBieAD9/yGWjzkACpfrN87DzHeRoFJFlEgT7fzyXuhc=;
        b=vkfO3jNBvcN/TiqQACGD9XDy/uLS3xAZGOpMTq+AJ+MzSf+drdynOyLGMsJe1kWi37
         E/n9ai3Dh/ySEgOWkiT8ranm4d4WTlMKUoKJ+H9h1ZfHP7zRGsVlij00dhtBfs+12L88
         R/IdLVTYPoyBainBR2KpiZ+6S5ZQa/2q+A/QKIabf9r4HPSxQwxuPkvGWwI69ygGqhCZ
         i77fI+ZmVtESqDhQz2YJYxQi/3V9mie9MzS2IimDUmasKuIX2zBZJCDPBeyy089Xh5MA
         kXo1zdHUz3peGkbJ4+YBQFVWImq6dX5rmNcTJ5iqLuHyDMU6lChDo8hhnPRl8bXRi0kr
         7q8g==
X-Forwarded-Encrypted: i=1; AJvYcCUjhjW6cI8XQRPAKkGvZd60gTaWU/vRbvhBbElYLAu/DogmCNfIPengo3l3jGdbn9KndOpgsC/7WjAg8JE8UCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlHSlwi/QBHbrBNMjM9QyeCdWJ7p/4rO6/awgF7is9p5/ytIQ
	BI49g9PawX4lQqP0kWEOGpPTUebVm3M+9Yp3cMUggIafOTj8fjxa
X-Google-Smtp-Source: AGHT+IF9ytZyajrXNa9tvYoariFi9zOWXuAqF6rDhp0J/b/2+2uR/tfbQA2NKEuaEIu79zrfEGCgfQ==
X-Received: by 2002:a17:906:dc8f:b0:a90:c4a0:9b17 with SMTP id a640c23a62f3a-a93b15d456bmr1707784466b.9.1727690722713;
        Mon, 30 Sep 2024 03:05:22 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bcccsm514568266b.173.2024.09.30.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:05:22 -0700 (PDT)
Date: Mon, 30 Sep 2024 03:05:20 -0700
From: Breno Leitao <leitao@debian.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: hugetlb_fault_after_madv: improve
 test output
Message-ID: <20240930-loud-brave-cassowary-0aecfc@leitao>
References: <20240926152044.2205129-1-david@redhat.com>
 <20240926152044.2205129-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926152044.2205129-3-david@redhat.com>

On Thu, Sep 26, 2024 at 05:20:44PM +0200, David Hildenbrand wrote:
> Let's improve the test output. For example, print the proper test
> result. Install a SIGBUS handler to catch any SIGBUS instead of
> crashing the test on failure.

That is way better now. Thanks for improving it.

> With unsuitable hugetlb page count:
>   $ ./hugetlb_fault_after_madv
>   TAP version 13
>   1..1
>   # [INFO] detected default hugetlb page size: 2048 KiB
>   ok 2 # SKIP This test needs one and only one page to execute. Got 0
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> On a failure:
>   $ ./hugetlb_fault_after_madv
>   TAP version 13
>   1..1
>   not ok 1 SIGBUS behavior
>   Bail out! 1 out of 1 tests failed
> 
> On success:
>   $ ./hugetlb_fault_after_madv
>   TAP version 13
>   1..1
>   # [INFO] detected default hugetlb page size: 2048 KiB
>   ok 1 SIGBUS behavior
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

