Return-Path: <linux-kselftest+bounces-40648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DFB40E47
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 22:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A17564A66
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4F2E762D;
	Tue,  2 Sep 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2EntBPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFEEEC0;
	Tue,  2 Sep 2025 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843240; cv=none; b=rLmFvvApj9umolMhLfkXFQZH75gKP5GM95ZFHg4W8o63RH3gXOAT5HSH+sQP8diN4n30yJGtnqKz86L6LAxHGoFtKkNB0Fof7yz2ocRWnpP3NSgFaWAZuulI00wRXhidTa2VszlzUSOpw/SlyhX3/JSyuJtNqaihYSHRaHp5yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843240; c=relaxed/simple;
	bh=aniwYY9jkYgpyjWKUmM4zFbGbCTrHhZtp2Ctj7gZrGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWEwSruk61SyBaGNWTBfNrMXEqj2iuhpHRifs/LCpjuaLpkACpsXZjuaahIZ1B/gfSR6atYssNlCb2QYiulFAJGQv4LypX+fwQ75K08G4LoAQFv6xdSSB7dOVWnQqHWDFukecu1gXWmNJEjc/3JBl+cs65CUT2raefNdeD5DcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2EntBPx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so1570155e9.1;
        Tue, 02 Sep 2025 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756843237; x=1757448037; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnwn8oz3u8ERteNvGUGXeU59pUXRW/r8woC2acqZVsg=;
        b=S2EntBPxtljbspcIlJioJbCESww+cOjw8g9yThPWZ6NiulzAQkTbvenw2DP0NMwIE5
         zEiE/34hgFJF2jbopFHeQIWQE8d6B+EAjDQOet7L6rKK0Mw9RPPfXhAEn6DWQIxHKBjJ
         HrOa0YMjncl0xkKxz1Z1EFuXNzGYZARO8dDrXUWS+SDGEh54VEhIiiEgc1Byxmrc1SJq
         NANJ7G7iOLdPCGgUnzp97e0RmCeYLKcYVkaIToUFGFQv7qOuJHRuZl7Vh+339/qwPiqB
         cp7oHytdEZexIGqV8ZCAxm/iQ9sb6yfUpHtGkkVYKKmkcf+3kDS00QkPQiAZ/B3IIloR
         zcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843237; x=1757448037;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vnwn8oz3u8ERteNvGUGXeU59pUXRW/r8woC2acqZVsg=;
        b=hL59JeiMFQ8nug3vuYtfzL1dsyu7ZNKERjphbbQ86kLQ/4Gv134wIct6A5p9L/9XPL
         jcDHz2FeeGO2HihpL3Qf1fWfySJSgk9GJ7zobFXRM3NbaTsksKnf5xjq+CtyfWm0pUYg
         /win+jKRksaelGTV7ZQYo4yPdoHUkWfs8XW8GilB6q+H3zgIwH7GT2GRBib7tQlAZGMt
         FQytnI9GrVPfERT7ALVk8Zvil8S2AjkoY0FsGBrY7hcD9d+fikjXDreqD4T3FyCJoipt
         Iu5uN1McgXXZEMQStjMFg1EI/4cvovV9sXZUS9lALHyXylPO995uKUDYaRc5ts5iqtBG
         I/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7f+fSa1MOoGM1FyufEoH2u5QM56RqXmmz7LXtoRpnBEGgiUYhmIDI1JqLGuQws3a5lZeh1s+k8G1tRyTSxTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUpSi+bgzgy9sDYya4xKLsGXBXxNMz9WtRmRTgmS0OX8KWIqt
	bKxwBKhQO+iW8t2NxxgAbb9jy4yi0npu9W/ncG7/o0hAOn+QCtAljiC0
X-Gm-Gg: ASbGncuMI8Sq4gUK8dpQi2RBGoSBmoJjWcXVf25av+ud9EhkAQMJgVqohR1WTmb4sN5
	kc3sC8xIYfN9yT43oVG1aoX67r5FYIo+bhXGOKq0UTaFZ8IJF0YrXsFvkTFOPq1rj3pk5ywNgU5
	SsNPO0AnGJIHIAjvKJ+u5WvdpzgOYeRzvFmEzgWW4Xe8sI8YqSQGztgxkjfN9IvCz/k26SemhDX
	sHTffnOxyEF3GIMED1wggotgJIlNLf+xoGV9V799kYz9C8/cFzRdEUZfrXhWQU9LL0Ii9MuGLsU
	1k7p+D1fCo8uNiPUYXQxuXRVAlx2UqgOy914M5LbnQoPoK2FDMwTjsJC1g8VLHm1WGq/nZcSFCu
	fv9HfzF+rfbAZ1hWlsKAropqjug==
X-Google-Smtp-Source: AGHT+IHEgm0JQcczqL6qbChvbVinJC0mTKPGSa9ic1yc/g9tqv/HdFawzpA/UHa8PWGwns9G5GWJOA==
X-Received: by 2002:a05:600c:6210:b0:45b:8d2a:cd07 with SMTP id 5b1f17b1804b1-45b8d2acf12mr60904505e9.5.1756843236735;
        Tue, 02 Sep 2025 13:00:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm162489725e9.15.2025.09.02.13.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Sep 2025 13:00:36 -0700 (PDT)
Date: Tue, 2 Sep 2025 20:00:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v2 2/2] selftests/mm: split_huge_page_test: cleanups for
 split_pte_mapped_thp test
Message-ID: <20250902200036.6mv4wqenbnjir277@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250902162536.956465-1-david@redhat.com>
 <20250902162536.956465-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902162536.956465-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 02, 2025 at 06:25:36PM +0200, David Hildenbrand wrote:
>There is room for improvement, so let's clean up a bit:
>
>(1) Define "4" as a constant.
>
>(2) SKIP if we fail to allocate all THPs (e.g., fragmented) and add
>    recovery code for all other failure cases: no need to exit the test.
>
>(3) Rename "len" to thp_area_size, and "one_page" to "thp_area".
>
>(4) Allocate a new area "page_area" into which we will mremap the
>    pages; add "page_area_size". Now we can easily merge the two
>    mremap instances into a single one.
>
>(5) Iterate THPs instead of bytes when checking for missed THPs after
>    mremap.
>
>(6) Rename "pte_mapped2" to "tmp", used to verify mremap(MAP_FIXED)
>    result.
>
>(7) Split the corruption test from the failed-split test, so we can just
>    iterate bytes vs. thps naturally.
>
>(8) Extend comments and clarify why we are using mremap in the first
>    place.
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

