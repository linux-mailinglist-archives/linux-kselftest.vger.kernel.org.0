Return-Path: <linux-kselftest+bounces-28020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C969A4BB21
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3A61633FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F71F151A;
	Mon,  3 Mar 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgiLBA6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47E1F1300
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995278; cv=none; b=rzP1JzivraEpx4eZdFMW/5f/H0ZhaxU/WnH0xbgoCHQT4L30F7f56Iyl6yeLgweTOyteWWTJcq+utwyDw0vKu6MkdobtCOaWiE0YXAlYlT7AClnKQlhjmaYcobhYNUlDf6KTmm7dSw8u9GrM/OtvGmg0rgkqN4AcOr5mbh+8BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995278; c=relaxed/simple;
	bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2IiTuhSSEPP9XmjFo8uXinlCP5WDhy+OB1R8AARWijRQjv9bKUx3Rt3t7pBA9k9GOmbYnD0pQQXHdQ4NmCj36FGXj6S3u2fV5skxEI2tZpqsfR/0QAvtEioJXmHJ6mbepVCwVMkBntGM25falItz6ue1gawQRiwDuDX31EuI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RgiLBA6V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso77445e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740995275; x=1741600075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
        b=RgiLBA6VqA1r/rTZL53gs0kfR6RUEaqQDh9RaY1qKZjeOunf26kirb6BD0I2qGWOFU
         yaxxzXs5YwFnooGBfWq3+wbFk/wCAG4el8F39wUkIcIj7DhW5WmYrAo8mop/6TZVYrc2
         LXjF1vCgECoOPUJdR4TrNL73Ky2id1q1c7ysIkbfCuzPz89nJhES7XjqWjmd3zvh8o6H
         HnoVQGzesXYQAfqbv5NHe7zIZf/fJD/8pJp8yZ4nobqxdE5xw4q8Ew+mEDouXGwzuBQH
         mYhLOJo35AfRH5y28lGBrtIxjk4rKRsFchMwl7eF8CD9EYUQ0OCoC94E3OWEroYFOvhc
         IzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995275; x=1741600075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
        b=i37m2OkTfslOcBud0u3v+/IIbPEytSFMAnsnBFcCVzf5So7rT7BguF2HX+K4iVOfwv
         yL3D/o2EXfOs8sC/t5QomEpEpCZQN54PY4AKYLlWjDv+fxdiCaJcoJ5X5CepAg54RV8N
         b+lnATCjpRMtuEES5t8W4TPI3557qTq/w+D7s+nkNXay3WxEyuJgJuAHSdy5bnrxLoL5
         W3LmgszQ6hk9N3LHDyBlckrjbqUOS+FlSjtBVfjSKzhBOJdEt/rrZUbeY6XXmUsIYgtj
         XbSoj03ybHk6NWpn/c47PsrjghPk/cdjQ9EQRLq/Ec5tBMHBgKOqHWBN4uRMg1j4ew93
         mP7A==
X-Forwarded-Encrypted: i=1; AJvYcCWS7l6ClCxQ1tVRDI2T7eq/ethnMTrbLm4cZ4QV4hzceT68ik5Xo+sXRBNAz5YAYNWvbbSB2xOAVR0lzW083Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6w6RerPwLP5IV3L/KquYWWux9XfGAPVsy/Q9aKVYxACi7TmU
	RffzzUK6lyNOO2cGwseB+Gfn2nBbfbZG6KOEOhc2BSlfSH9j7q3YXgwv+Gc4Pw==
X-Gm-Gg: ASbGnctWxaJV8rCJelzkOk2xfZAFkrsrMd0SplqUiq22TI8yjcYOQJndpUnyjE3osFh
	aTThWhCmnpL3HdPtxCPTPZLnSyRVtqkFWEB2lzG9BaC4goXbr8Vs1v+Vdh58vyjdDo0CeslPFqR
	jRPPmXa4laXTWRc758ydbAdGEOrMtQ3/bMqrTUrW3LnRIFa5fzwnm68zo5hK7EH52PBe68x/GPc
	MWQbNNk865aHTWc43nox/Db3R7v2BWyZdatDcqE/cBSk9ECZAm9P1CNX0vUtlaYqEk2lPLPMyZl
	kevo4qyyu39p9T9dO7hleZosnPtf7TB8G7FacJPVNanOHBWxhz8x/N7UVlsZlVlWC69qT7ziNfq
	Cc+qm
X-Google-Smtp-Source: AGHT+IGuRRTpZx51thwL2b5hSvmhDVaJN8ebU23ciUC+XksIIzRnxpwUI7JqUrlrpyq52tUWkeY7xg==
X-Received: by 2002:a05:600c:3c90:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43baff09304mr2232035e9.1.1740995275531;
        Mon, 03 Mar 2025 01:47:55 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a16sm13935378f8f.79.2025.03.03.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:47:54 -0800 (PST)
Date: Mon, 3 Mar 2025 09:47:49 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
Message-ID: <Z8V6xYvqqkPxULgN@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
 <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>

On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
> Taking a cursory look at the test, it creates three threads for each cpu.
> The bounding of the variable is fine but that being the reason to rename the
> variable is not making sense to me.

Hmm yeah the name needs to be more abstract. Do you think nr_workers
would be confusing? Or even just "parallelism" or nr_parallel? Or any
other ideas?

FWIW I briefly looked at just cleaning this up to remove the global
variable but that's a bigger time investment than I can afford here I
think. (The local variable in stress() would still need a better name
anyway).

Thanks for the review BTW!

