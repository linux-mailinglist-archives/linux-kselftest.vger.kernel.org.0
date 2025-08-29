Return-Path: <linux-kselftest+bounces-40249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300EB3B090
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374C517F383
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851301D5146;
	Fri, 29 Aug 2025 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVWa3s/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01D4A23;
	Fri, 29 Aug 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431843; cv=none; b=pUQF2AXBJ8Ls/YlFgEf2mbXamLNMOG4/JL++Ib68HKs+Qy/098GWAbv7hqDsgBcCpAfPtqVuckBp27Y7TR+yStqaA3ymnEWLeLpga17zvYUe+MgTkhKJEFw9JlFJ+kRfxjnD7JYJcyWMusVChQWhck51pdSuoSD18gjTjhhHfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431843; c=relaxed/simple;
	bh=2iKqJVyH4Bdr4GzgXKHMtxy7z3aWlHQKPMpS42UUYOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btiCel9pR/68SdTFvUq7kXkFItoUA2WeoPNuWFtpNTN9lGC14aoDGb3tBqNIWtUmYXvBjMqw39bwbQxroeQL4tz1I+8taInkeVZE94kgybFsBUo3FbDy7Jsksz3TJ8mSlkaNJ6bTYHjKdhCkfmF9dBdB539KRFRffMPdz80LYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVWa3s/0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1940760a12.2;
        Thu, 28 Aug 2025 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756431840; x=1757036640; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHBd+IlZFh0zNXe4qwll2lktsGmbBJatMBbb3xWhGl4=;
        b=ZVWa3s/0PpLCWjHbxxtyNcaqM50Ohba395MKw1nxwzszR4cFGhlD1QF37wBkMkEg04
         Ee19V8wfOMNSl5QQDO2cOXJZ2XR7FQezWskOPS/YqAQL5/UHrcUQNBDyNXPMnoUtUrYQ
         3Za8RoUqWX2wnqRB38UejvcBILjSsbhp/uwFVktagbFQfN0WUbYWEmQahscBAvQIsT+9
         mnajiEMAkUmkNGKJl9Us+f2c6Uhcj1rh+L1cBifA6RX7zdx9rs6HrlB+udxIaSsHFY3o
         7Cee4vvzSzi+JzBaBEsUlA1OXSHd+s43uCZ9aLrZ3RYAZ5nPFCRieas06IH/jXwDo7T2
         inGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431840; x=1757036640;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHBd+IlZFh0zNXe4qwll2lktsGmbBJatMBbb3xWhGl4=;
        b=DpcHOr73ZgW/xAQB71xguXFbZt1TBQwlyugXh1PcihxEdI1Q0K/yBp+zsZdkBNaOxC
         TB4mZvsUAFQj7L6COIv7/Du2XtcfjfPH/04K22smvBOeDb92vJCx/mQLagLtZoDncPzK
         mGIKLrXxzILGbxI8sG2CxZcluxk32kvw0SJICgbt8Hf9tFUOd72eGBSxvrSjIf+QKL7E
         lVG//Q0NSXAR7AH/8QyObIf30XYbSO6/MvIZG0/AHTyiZ4Sj+F7Bf3N5Yg8lvIsXuoOe
         5Y2LnXaOifg+3WtzWm8JS3JiEReY+ROI9arOjEvScBBkK0RxiEFGczWToSxfD27tgGXw
         nFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDmBzRLl8BZt/BypckKdFs9C8HL4sP/KulsjKbuWcKKgKMmNqSuYOz8uNBxvyORj+UgQPYO/ImOs9jJkQ=@vger.kernel.org, AJvYcCV6vPJP8ERFOBUcwaiSbvOaEAJ0Ed3XzEX4YCUh4e6Rro7IpNu4pd86ej7FJZY/qlc6vVzCw+IK/mz0M+L8aP9a@vger.kernel.org, AJvYcCVxGV4LI7eBluButnUXgbN7kx0Mosfzd+HdjIf53zYlSQ1LHq1yCXzeaW+mWiVvgHDseELNdFdlvtqHWheuHf+wFq/fHp4u@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh0fo7Lau05bT5EaUiGQbLmHYYW8pCYcR9iJUXH+ks3An42aC
	FgrrY/wtpfPiwtlWVHO/jLYak1Az2/XJqC/3+QxXDEB1i9t3cydOribO
X-Gm-Gg: ASbGncsRAQQp+6ldyCAs9moy9Q6CP9nB5O3XCyw9CpuSIOcaffeO80OERd7oIBEsBX4
	x7vaQEwMPOgtCPmn6Mk4FkInNwq+/p+cNu+7f2D8JbkDIzlVdYwyPXxu3Uqu23cVQ5NabhdCUps
	VB/bIePGPveP1XAqsWljzEGRNmH6ZOiVVAUWk20Q9d9bCRJirHN9UY9xWeOpGVcu9rTumuR/qWP
	ctjPhMAHkATT2bzCtp8HtBi/fQvUcbk3LRA0y8Qxa58e1AgizzDfvkofvuWV3gmKwDYM0WC1sOG
	CpQ3MIz8spRCZBaN5ePHMHM9hvbYqbZsmrSBzseAcd/3X6WRNQrDj+0Hza5iWfeT1xqC+FCQbC6
	uCQ+0ZZ+9D9O4Rdd69IVL6RPkhnDvJ+AB0ch7
X-Google-Smtp-Source: AGHT+IGXzVFtf0umylBRxC6/BmYbJC8jpiFexix+nG4HrfEucqpX1yTWR5nqIgNiEJl4btVGLDUxpw==
X-Received: by 2002:a05:6402:2708:b0:61c:58de:85f5 with SMTP id 4fb4d7f45d1cf-61c58de8a22mr13525524a12.31.1756431839732;
        Thu, 28 Aug 2025 18:43:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm781288a12.8.2025.08.28.18.43.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 18:43:59 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:43:58 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: richard.weiyang@gmail.com, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, davem@davemloft.net, david@redhat.com,
	edumazet@google.com, gnoack@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, mic@digikod.net, ming.lei@redhat.com,
	pabeni@redhat.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH 2/2] selftests: Replace relative includes with
 non-relative for kselftest.h and kselftest_harness.h
Message-ID: <20250829014358.qk3zme4qlaojun53@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250828081026.yx6vgphtsf4pmr3y@master>
 <20250828094016.18063-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828094016.18063-1-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 03:10:16PM +0530, Bala-Vignesh-Reddy wrote:
>Hi Wei,
>
>Thanks for testing and for your feedback.
>
>Yeah, if you try to build inside a subdirectory, the top level
>export may not apply, so CFLAGS don't get updated, and even if
>they did, the path could be pointing to wrong location.
>
>As the docs recommend, building selftest using TARGETS,
>either from kernel source or "tools/testing/selftests/"
>works fine and doesn't fail.
>

But this breaks current behavior. There might be users for this form.

>If you really want to build from selftests/mm/ directory then
>defining KSFT_INCLUDES with a fallback in the Makefile will
>resolve it, but there is no need of it if we stick with "TARGETS=mm".
>

How about add this in local Makefile ?

For example:

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 810bd615b8c3..52f023071619 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -158,6 +158,10 @@ TEST_FILES += test_page_frag.sh
 # required by charge_reserved_hugetlb.sh
 TEST_FILES += write_hugetlb_memory.sh
 
+ifeq ($(KSFT_INCLUDES),)
+KSFT_INCLUDES := -I../
+endif
+
 include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c thp_settings.c
>Thanks
>Bala Vignesh

-- 
Wei Yang
Help you, Help me

