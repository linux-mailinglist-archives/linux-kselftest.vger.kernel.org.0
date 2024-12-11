Return-Path: <linux-kselftest+bounces-23144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897079EC418
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 05:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9851889C1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3C1BBBEA;
	Wed, 11 Dec 2024 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx3PR1WH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CC2451CC
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733892477; cv=none; b=XtXj76/gbr6iIWIfohB4285J4d8LRycgNBC72uIF6OAzH0qqo96UP7oT7kedCnSH2gN53cGNgh2NwWecdymsRuPZudpGmPAcYYiKsIi5Z8v7748zOinLGES8AF/eJ4JnhGgdA3g7cpkjUA9snc/5N8S7CJIzJeWLi3afHIvoObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733892477; c=relaxed/simple;
	bh=uHE8siFyh14HkR7zEWr+RzX6wEmDLIqqQjY4sJZKZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qloRhIxMPXd3ed/YbK7lpmF7h25K9Gk5arTcKV2/da1CNd+x/WZZNBzTF67NZaMWdUpU6KCfwgxmUsv8Egjod+OfXQpao5EyM73QIsjDbL0RWDgVLykiQ+RxVf+CZ10Lrxf5glA9fe9QVhK7B6Yub98JKJUEtlWsc/GWZgHEIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx3PR1WH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e34339d41bso52894567b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 20:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733892474; x=1734497274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Otzfy2Fb7dTAUP4VzNQlaGCzwGYbYIGIagEoJ0T4F2I=;
        b=Qx3PR1WHuEoxIoS4B6+Epgw3TEhNn2/pBCvb6guCuiXsJIkPvfgByaAVS+KHtVYAkw
         2zBDHbVT4gSeEKW7JwQDdXrQQTZLN0Ph1tAsXU3E0ehHIgMPwxAPPcH6YjVfDGrO9U6J
         GTWF1Wrv43V+5Zwy2+pPo3tYXlW9X9kdGAsEOSer86W1+UlgsNmMyxJHROaID6OTQ7Wh
         9gQ0zc1E2q4H17yQCrQMfZWjG6eHmRFw2zt1YRl5wu/ibYYbItCigETEyfPiitjThB20
         a2g3cBEVkRDhewiRmF7RmL6XmpPbLQkJ2dhG0D2gOOSJlkhx4mMMhmlHxIbu3+bksW7B
         uuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733892474; x=1734497274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Otzfy2Fb7dTAUP4VzNQlaGCzwGYbYIGIagEoJ0T4F2I=;
        b=bh+qEKYoSlynppxd1taJtCUHFak84GDJxNy9xm8B5fLRsJix9fw3ylmJVsNU9CTMEH
         PPbRK4tNxpL13gj6+nkVgTbY7TdnPpcFH3jyEBUjhoDFs9m9CzwSLiC8tF2c8JC3gQ8m
         nJqTLv2QY+ZNrQs3yn/x7uoUt7VNQRWH0UunS6JNDVyCtT/3vQyXXyZyVFQuyVrGU+Bv
         QByZZ67JIGtC4FCHBEbwe40QCxbR1mpX8rKFq+ciLdFXXZO+ns61iM2OduUjgPsAjROE
         /4fc8HCv3FbZcRu9RelqZVB9ojEoUXkL8h8qI1Q+ZGkNTLxyOM0YzDkNYh51TC1trwZ8
         n53g==
X-Forwarded-Encrypted: i=1; AJvYcCWWNjmpeuKBuAElGTX2X9KYVA3BYivutsLb0DiTS8uJWBDHEHEjMsDpwOo/IvCzs5gSg0qCAFwsc5xhXfIbfQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOHLuiQGm8b/IsHNCxB1C6LJcN4Y7ItqoRJOSk6baMgHgqd4G
	7FaOQsDnlDUwuIw5NvJosWhPhm++yBBtzRh6nHmuUNY8wYEGB5/0
X-Gm-Gg: ASbGncsnBlCh2zwBbjqnbNMvUjPaIybzpX9nw1bxnalTsqeMUO/hkAYSE61SBH6wxmI
	zkZeZBLrpxQE78bjvjcDV7tzHPe6vRBPDogspBV42Bq1ZqT069rjHabpETVFJmIlJw4+uwv3tre
	BQediVT3q88JkJ3RLOy4fLrStepuyQnwswaDg5yh368wOv8/NJ8fMpQFfmmubyx/bukSQwE1TS7
	QDjlnyhIpwmOy0sbb+jNxbnS6/Lhqn1H/E/CAC0S/fGgzqqhxgAYtwP+l8YYgvZG7CmS7rUOYH6
	lX5wk6lD77FOOsFsfHFtANPdHJqkbQZYr/JqlZ0=
X-Google-Smtp-Source: AGHT+IFO5egOIMeN8mVFlXAGU43fYYzh+evpktzZVHTnhqWN5Wtu+fY6TuYiZYEvzfI5jqap6VJksQ==
X-Received: by 2002:a05:690c:7446:b0:6ef:e390:1d4a with SMTP id 00721157ae682-6f147fe14d9mr16515447b3.11.1733892474455;
        Tue, 10 Dec 2024 20:47:54 -0800 (PST)
Received: from granite.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cea6fefsm682047b3.111.2024.12.10.20.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 20:47:53 -0800 (PST)
Date: Tue, 10 Dec 2024 23:47:51 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: davidgow@google.com, Andrew Morton <akpm@linux-foundation.org>,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	skhan@linuxfoundation.org, rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v4] lib/math: Add int_sqrt test suite
Message-ID: <Z1kZdw3VybM9zN3+@granite.localdomain>
References: <20241210172822.97683-1-luis.hernandez093@gmail.com>
 <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg>
 <Z1kKlhUceHxZrMeS@x13>
 <n9o7rp0q-3894-544p-7s36-693qo49p9no2@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n9o7rp0q-3894-544p-7s36-693qo49p9no2@syhkavp.arg>

On Tue, Dec 10, 2024 at 10:58:02PM -0500, Nicolas Pitre wrote:

> And for such kind of test, more values to test is not a bad thing. So 
> I'd suggest keeping { 4294967295, 65535 ] as well in the set as this 
> represents a nice 
> edge case.
> 
> It wouldn't hurt adding the entire set from 0 to 9 as well. Many 
> different edge cases in that range.

I see, agreed, thank you for your suggestions. I'll go ahead and carry
out the following changes:
1. Replace the ULONG_MAX test case with the aforementioned { 2147483648,
46340, "large input"} case
2. Add the { 4294967295, 65535 } edge case
3. Add missing cases between 0 - 9
4. Add a couple more cases 

The updated test cases would be as follows:
{ 0, 0, "edge case: square root of 0" },
{ 1, 1, "perfect square: square root of 1" },
{ 2, 1, "non-perfect square: square root of 2" },
{ 3, 1, "non-perfect square: sqaure root of 3" },
{ 4, 2, "perfect square: square root of 4" },
{ 5, 2, "non-perfect square: square  root of 5" },
{ 6, 2, "non-perfect square: square root of 6" },
{ 7, 2, "non-perfect square: square root of 7" },
{ 8, 2, "non-perfect square: square root of 8" },
{ 9, 3, "perfect square: square root of 9" },
{ 16, 4, "perfect square: square root of 16" },
{ 81, 9, "perfect square: square root of 81" },
{ 256, 16, "perfect square: square root of 256" },
{ 2147483648, 46340, "large input: square root of 2147483648" },
{ 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },

I'll incorporate these changes and submit a new revision of this patch.
Please let me know if there's anything else you'd like me to address.

Thanks again for your guidance,

Felipe

