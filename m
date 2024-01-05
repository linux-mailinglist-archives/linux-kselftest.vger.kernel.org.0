Return-Path: <linux-kselftest+bounces-2670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904C82593B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 18:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F21C213CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1A321AA;
	Fri,  5 Jan 2024 17:40:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FE34CFF;
	Fri,  5 Jan 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a29a4f610b1so35826066b.3;
        Fri, 05 Jan 2024 09:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476443; x=1705081243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlUFws2gRA/RLYCi/5I30yTmPUCTa227qvusJyIYZC0=;
        b=RTf1HBjese2oFBNWJZ1BF6SIvM+bgCbQg+p/r8M3GDV+LjjjaaqmtqixqjwiklRy2W
         7e+YaQcvY6cdXraj/+6wFlLaseRWHcaN1ud+6p50VTwA8y/PpcUJX0Jye0r7XsJ9iEX5
         fuF+dPcL74hjF9xthKx6GyLYkR0VCBMJZwDzfdmwsq+SAX4tnZ4QgEHoaD+jVQB3IaIO
         xJXWE2xmwMSonrvj1+LruK0Yw5kYBFofNCbaEdU0O/gPQDK+tYf4LFeFuoJ8YcD1DnCH
         /ZfX3IadvqxIrTlnTp5w/YH5SRPcRz6FJHyGk959m33x6q5J2a9wQpiaDuT1zv4BN0dz
         Mqhg==
X-Gm-Message-State: AOJu0Yw5O5IALlsUwdZ5Xf8WRwzEhzljidooIJa1GSvWnkPtd3yqEG4C
	fJ8sUuDBybtA6zUqaEzqKE1eCna+SBNr9pyV
X-Google-Smtp-Source: AGHT+IEeIf8oSS1KS0fchCV2GTwxwTiUfXgb23HN/cieltvEE/SNnIdypOpnKZDe67CNJbZAeUX7Kw==
X-Received: by 2002:a17:907:2cd1:b0:a26:cdd1:d45d with SMTP id hg17-20020a1709072cd100b00a26cdd1d45dmr1151404ejc.130.1704476443506;
        Fri, 05 Jan 2024 09:40:43 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709067d0700b00a26b057df46sm1084391ejo.126.2024.01.05.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:40:43 -0800 (PST)
Date: Fri, 5 Jan 2024 09:40:41 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: riel@surriel.com, linux-mm@kvack.org, vegard.nossum@oracle.com,
	rppt@kernel.org, songmuchun@bytedance.com, shy828301@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] selftest/mm/hugetlb: SIGBUS on stolen page
Message-ID: <ZZg/GfXCeovU0eeN@gmail.com>
References: <20240105155419.1939484-1-leitao@debian.org>
 <20240105084238.306269c3f3a63cb0fd130baa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105084238.306269c3f3a63cb0fd130baa@linux-foundation.org>

On Fri, Jan 05, 2024 at 08:42:38AM -0800, Andrew Morton wrote:
> On Fri,  5 Jan 2024 07:54:18 -0800 Breno Leitao <leitao@debian.org> wrote:
> 
> > This test case triggers a race between madvise(MADV_DONTNEED) and
> > mmap() in a single huge page, which got stolen (while reserved).
> > 
> > Once the only page is stolen, the memory previously mmaped (and
> > madvise(MADV_DONTNEED) got a SIGBUS when accessed.
> > 
> > I am not adding this test to the un_vmtests.sh scripts, since this test
> > fails at upstream.
> 
> Oh.  Is a fix for this in the pipeline?  If so, I assume that once the
> fix is merged, we enable this test in run_vmtests?

The fix is not ready yet. As soon as the fix lands, I will enable the
test in run_vmtests.

