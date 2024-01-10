Return-Path: <linux-kselftest+bounces-2797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C6682961C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 10:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772A7B23096
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C943DBB9;
	Wed, 10 Jan 2024 09:18:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAE3D55B;
	Wed, 10 Jan 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so4838438a12.2;
        Wed, 10 Jan 2024 01:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878313; x=1705483113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf6aWngDm6PCCoPwvV8Wz/ElrBZHYRFAEEcA6Tfxtkk=;
        b=EWQVDWNNh7iAppmUhg58+PMjNCzrMOQsgCF+yn2YUwG1V42S/qC075sJymWNj1DY5Q
         ehoOSjXVbLLy8ZR5ZxIrNCmw6CZpqLXDifQHXxLDHUYyQoYNFEH5Fxsqsv0SbiIfJ4JS
         UPb7hio7NmOMsdgniX7ta92lXa7ubJmLvLG9xEQEa56snWN/zpxEhXM91E5zpdtSuMAc
         xKx6/Fd6xqCa06Bbw/TRS/0ehzOTstlEvQBfkCAGwDg//BhJnmQMHtDlJIb7e/xtTvsh
         Oo+5WHkVecqfeknMlOP1jDFy4UwXErUAtUn/HFagjq9K9xy0Uwk6lZ7saKZ+P+pl2lxo
         azKA==
X-Gm-Message-State: AOJu0YzMlYqePzdmlkXpXHmnNRlMYb4sh0B9J9KVLJvpIGRVsUaxAYCW
	wEi0+cV0tsEzAIJeyIjbKwDTX4oexql1yQ==
X-Google-Smtp-Source: AGHT+IG+x/cTJ8rCUu/ixa5PQDfz8WNBPdxJYJ7zgxjYD6RYKIwgJSbC1+GFbnMEwz+4gm+IWIadJg==
X-Received: by 2002:a50:ab5b:0:b0:557:7871:67f7 with SMTP id t27-20020a50ab5b000000b00557787167f7mr296202edc.26.1704878312840;
        Wed, 10 Jan 2024 01:18:32 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7cd88000000b0055751515a84sm1795987edv.51.2024.01.10.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:18:32 -0800 (PST)
Date: Wed, 10 Jan 2024 01:18:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: riel@surriel.com, linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
	vegard.nossum@oracle.com, rppt@kernel.org, songmuchun@bytedance.com,
	shy828301@gmail.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/mm: new test that steals pages
Message-ID: <ZZ5g5iM5+xfw1pJ6@gmail.com>
References: <20240105155419.1939484-1-leitao@debian.org>
 <20240105155419.1939484-2-leitao@debian.org>
 <20240109214731.a7694ae4a575be838b40e9ea@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214731.a7694ae4a575be838b40e9ea@linux-foundation.org>

On Tue, Jan 09, 2024 at 09:47:31PM -0800, Andrew Morton wrote:
> On Fri,  5 Jan 2024 07:54:19 -0800 Breno Leitao <leitao@debian.org> wrote:
> 
> > This test stresses the race between of madvise(DONTNEED), a page fault
> > and a parallel huge page mmap, which should fail due to lack of
> > available page available for mapping.
> > 
> > This test case must run on a system with one and only one huge page
> > available.
> > 
> > 	# echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> 
> Can't the test framework perform this configuration prior to running
> the test?

We have this infrastructure already set in the run_vmtest.sh.
The "hugetlb_fault_after_madv" selftest needs the same configuration,
so, once the fix is ready, we will just add something as:

	--- a/tools/testing/selftests/mm/run_vmtests.sh
	+++ b/tools/testing/selftests/mm/run_vmtests.sh
	@@ -227,6 +227,7 @@ nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
	 # For this test, we need one and just one huge page
	 echo 1 > /proc/sys/vm/nr_hugepages
	 CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
	+CATEGORY="hugetlb" run_test ./hugetlb_madv_vs_map
	 # Restore the previous number of huge pages, since further tests rely on it
	 echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages

