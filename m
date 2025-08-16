Return-Path: <linux-kselftest+bounces-39149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A611B28E58
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143823B274D
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9E20C48A;
	Sat, 16 Aug 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WspO71bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5F1EEE0;
	Sat, 16 Aug 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353279; cv=none; b=dW3k6Mq0H0XLL5STcC3FRhLUVRFOffW+P+LMgeBCBNfDJ2ksQFoSCwi5Pj8HvTYxvXQo3MaTnGn5fnum8bb1Msv2JUu0HwA7ZpR/UNOi5mrPvmVEMjCghEZN1g1qvFPOHSscgGx/QU7/HqxatswUSYJD9KHword/bfv91nQibxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353279; c=relaxed/simple;
	bh=Om8lZ9OBULN9cTC5jNFpnEdKLYJXaAz5uqr1mPgysk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPmqkniFxys6+lj2kFkBQSQIMypUA0fIEH3LEKgbzlxbe0qScCJxpUaDfnke/AxjzYGB1UeM3/2rbz9fGZD3o8Z2AunSF/EmA7BY1DXVKqtos92NKNLumS7+8xuraVtytrpR2VfY2tHe9IpULdOsKo1zHkPSRhf/p6acoUtR99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WspO71bf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so2329368a12.2;
        Sat, 16 Aug 2025 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755353276; x=1755958076; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uaxDkrC90fmKFDmTr+OGwUc637UVz7/TValI+Y8iKI=;
        b=WspO71bf0ced8L5V7BKn0pvpVuJecYlflRbn7Y8VG7TmfpXaGLEtkFCvH3ssKLHyZ/
         xQCu8cZhH9vZyV70B4xl85fx5vlSkFwMqcjfggUkuA96sB2MldnP2w8a/HBdG99VOwBn
         dGj2YB6/ccug0o0+I4vmPqaQu+PGxF6uBlzNqZFI3ebNGD6kQDZMl6cEbTGdhjhPsyJN
         7j8QnVgcyxtcvQF8nvPLgJspULASSPR/T7aHQG7dl7osuXHPLKMTAfOymELJebinQeCj
         hxvAyQrVLdSS+cuvA7O1l/1c23XrcrYl2Hjpdk3glNSAnhP4wtT9/IrMoZei2jetY7SX
         AxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353276; x=1755958076;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uaxDkrC90fmKFDmTr+OGwUc637UVz7/TValI+Y8iKI=;
        b=bL+mNK6HP547BdU2qUmbv4sJYlhT4xK/pSOCmjAaWqSoLyGWLnbdpqSDwvN7jwHhtK
         U9G9gVJx32aAdjQ2ko1aO/CZOg9yG8wQvuqXcI8kfNQr0euVIr0XF2+XbqPalNRmhb1e
         OpMHyw0ZSraBXrPQQpZOExvwm/ZMXJHXE7/z41AresyVZz8D7Xmd7nvfuUIQt+WU2hsZ
         s52xY2OBKZyfRKrIcfFz1Xn366xWx68cyyuCP//Td2ajai8HQjeOC/HXhFVoWye6l2V9
         PS7LW4t8iK0uxFm7kDRJNYnQPYhDV89HvlueKjqw8r57/NzqS56mk5aL/3uZjZhk/MO7
         gnow==
X-Forwarded-Encrypted: i=1; AJvYcCUUGzBGjWdLxmWpEwQsRfIpz/0gZLO8u36yoaBHkimx6UvlGT1cxtRmBvHsMgArXGYabnjlVXTtCoHfxAQmrA/f@vger.kernel.org, AJvYcCXN3O4Ht7uh1O9w5uf8LTFX0+maVi3ghwi4jzyNpQDiznJ2MZzKanaYuqpVTWvsO10W+hKG+iZYWOaQO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cVNB8x7fTStllw06D1i7Y2A6XyEfFNgnDqM10BT/0Ri8S844
	CtmjE517Eok8bxXASp3T+DNtQvNppMgkhfGkZ3k9a8444tjsglCgKaKa
X-Gm-Gg: ASbGnct1jNPkFuts9Be8UfEydkHOOWyVnUoQDvuR3CTxzxOsHJ771zfEPdxUKCXX8tB
	/AyB4+XTMpnjDn/8DYwTEpU00Iz1fDTTvueI48OWEEOt8RXhfvTqH6OComYgaZy7FoLOINz9UgI
	70rvco3pho5S1P8fVBvevsC5Hb4Mn5FhwvLTY1mAQ6RfI/eYlP6kL1W9pMXZcSQRxiY3gU+j4I7
	neJgxkvFnb4U9k17BExQZOaCN0VjL/W+pH+bNBEF+XlIoy3T+5nfOuWOesn7kJw9FvICIFjkHk6
	afypnppnlBPNTOCvI0kq0e/mq8AM28ejS83j+Q/PzYIms8btsojn/jpu38/OzPVXud8qYpC0KQZ
	hYRWhQPsesHSZttQq13maZw==
X-Google-Smtp-Source: AGHT+IE1b/Pj74re6G/Q6vJ6st0rdkU7h9PGlQizm286SNk7tjVfBDAwwmFTOY+1Vb+2pSq1IfaDTw==
X-Received: by 2002:a05:6402:2681:b0:615:a201:df41 with SMTP id 4fb4d7f45d1cf-618b054fbb2mr4471169a12.22.1755353275548;
        Sat, 16 Aug 2025 07:07:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae4besm3499692a12.38.2025.08.16.07.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:07:55 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:07:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 3/7] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <20250816140754.tgkn5kwf2i2oe7va@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-4-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-4-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:09AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>This patch fixed 2 issues.
>
>1) After fork() in test_prctl_fork, the child process uses the file
>descriptors from the parent process to read ksm_stat and
>ksm_merging_pages. This results in incorrect values being read (parent
>process ksm_stat and ksm_merging_pages will be read in child), causing
>the test to fail.
>
>This patch calls init_global_file_handles() in the child process to
>ensure that the current process's file descriptors are used to read
>ksm_stat and ksm_merging_pages.
>
>2) All tests currently call ksm_merge to trigger page merging.
>To ensure the system remains in a consistent state for subsequent
>tests, it is better to call ksm_unmerge during the test cleanup phase
>
>In the test_prctl_fork test, after a fork(), reading ksm_merging_pages
>in the child process returns a non-zero value because a previous test
>performed a merge, and the child's memory state is inherited from the
>parent.
>
>Although the child process calls ksm_unmerge, the ksm_merging_pages
>counter in the parent is reset to zero, while the child's counter
>remains unchanged. This discrepancy causes the test to fail.
>
>To avoid this issue, each test should call ksm_unmerge during cleanup
>to ensure the counter is reset and the system is in a clean state for
>subsequent tests.
>
>execv argument is an array of pointers to null-terminated strings.
>In this patch we also added NULL in the execv argument.
>
>Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
>Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

