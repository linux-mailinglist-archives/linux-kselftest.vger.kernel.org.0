Return-Path: <linux-kselftest+bounces-20695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19569B0ED3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B71C20C66
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D8214414;
	Fri, 25 Oct 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz/aemUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079720F3E7
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883808; cv=none; b=MjElAM8kazPTppYN8sGSaBm+IDzE5l7rQvWXlZBElAkCE8sYE29niSb3yLF1dxmkUrOus/UqhuNnVlNKDryuEH0RK3leBAWt1XllRkEKtJyCvf3fbCNQg5as45zr5MpPd8XTCiCMnetrWq7If63suUvmmP7I3XTEiB7uq5kQmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883808; c=relaxed/simple;
	bh=dubQIxc40UXqFzy5w0FvByzSpEMCMZVqqzf2vV3whpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3vDhfzjxOa040hzYtOK0JPsUsMpnY+RPmzmjupmzYpeTveonub7/KFhgygYfKL4tBm+HOq3rMBqERWqG1dsJxZqMKS0PXXMFVc6lwyCDLwrMvuscwnJrWdUooYhYycUyagj2CSOZdF0JUC4NRwJOgr8ojpjKISQekMGBb6IOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz/aemUz; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d24099415so703897e0c.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729883805; x=1730488605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dubQIxc40UXqFzy5w0FvByzSpEMCMZVqqzf2vV3whpo=;
        b=lz/aemUzbClgvqs/mMKLySTgTcZqzPCG1SKk6ttePeMPxYGYsXsqxp4IVUu8ZiiaIP
         87KBAQs5yQ+jExSO0bGSbcBoTwvFTh0XGT8vxoM/okgPUQNFE3Mqet8Bb1gOWtQ6FFFZ
         5WLQWM4ZeVhae2yLcqnAK3PZ5/LpGx9p7aibtxpUGC7kgWl4DZzeXnvFSDahb7dh6+Nz
         0TjVURx1cOVjunUXpa9m1GCze+/fUWjgPd/MJBe7fYPGzgXtpENyHiYcBFnx0HqNCLAN
         W5UX4qwxfc/yggX1NvoqnxsaiV3H/1XneQkEDgoj5ByoLRByQ/WlhrJsDB6Y9l8bnGoN
         dg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729883805; x=1730488605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dubQIxc40UXqFzy5w0FvByzSpEMCMZVqqzf2vV3whpo=;
        b=cHoHZE0u7VHayC/7E7UfbWc1G8qKdzLXBE19XApTg27Zv99/WzDuN6DLYM6sWHPkvs
         PQtaTiWVAgwFGzZh8xFjvVh34E4aOseJ4y91DnKUx44i9M5g5ndoK3l0TerH1WV+bnGj
         KuWKT90m2NTVlrSZmjuVR9ranY1eUyVglBrPt3bM26mxwLjU06FnJ8bNTsiZ551+jtsJ
         kQOg5ajBVAww7BMs5R4QQJVjzXJmbTmxc1Zmc8TIGqybQKLw7/muDLuS5PrwIGL1e1J5
         Nvws4mCsHmCX5zrpzMkQVoabE9DZxdb7ZHdoVmfqR6d1hU0u5ZaksISlkFVcqG8eUxtk
         ueLw==
X-Forwarded-Encrypted: i=1; AJvYcCX32YAaXtbkfb3NTWaG/r/W9rf3e3BX3YfjlgbrY81OdJzEHn2it0TiLW7uyKBh9S48kPI8rSjC/Fec2wenWsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhaV3WWOB3V2+9LX5W1mPQGNVGESzcw4WK+zPHlo05hOxxqXu
	nX7VJEtbOLsN6fxGfFILQnroaanOANnjGf+LhMdP3TrMfZcNQmxU
X-Google-Smtp-Source: AGHT+IGSI9It2r8yCOmuUigZnEh6/tjoKL4cFTuPj72HzyWQKLiDq7KWpY2RcB3vOGrBZ3npSh4EBg==
X-Received: by 2002:a05:6122:1786:b0:509:e278:c28a with SMTP id 71dfb90a1353d-5101504d301mr278237e0c.7.1729883804985;
        Fri, 25 Oct 2024 12:16:44 -0700 (PDT)
Received: from x13 (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-510043a6416sm226119e0c.14.2024.10.25.12.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 12:16:44 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:16:41 -0400
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib/math: Add int_sqrt test suite
Message-ID: <ZxvumQ3Od2lXYknp@x13>
References: <20241024195511.72674-1-luis.hernandez093@gmail.com>
 <Zxu3Nd_xdOIdyYl9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxu3Nd_xdOIdyYl9@smile.fi.intel.com>

Thank you for your feedback and patience Andy. I apologize about the
hastiness of the v2 patch. I've addressed the feedback and would like to
wait for any additional reviews before sending out a v3.

In the meantime I wanted to answer the questions posed to the best of
my ability.

> Shouldn't the thing to be in lib/tests/Kconfig?

The Kconfig entries for lib/math are located in lib/Kconfig.debug as per
David Gow in https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/

> Where is this? I don't see it right now in the Linux Next...

It's a previous kunit test suite, it should be in both next and mainline
Makefile: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/math/tests/Makefile?h=next-20241025
Kunit Test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/math/tests/int_pow_kunit.c?h=next-20241025
Kconfig entry: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/Kconfig.debug?h=next-20241025#n3103

The Kconfig entry was fixed in next by Kuan-Wei Chiu in https://lore.kernel.org/all/20241005222221.2154393-1-visitorckw@gmail.com/
which I had incorrectly placed at the top-level in my original patch,
hence the discrepancy in the location on mainline: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/Kconfig.debug?h=v6.12-rc4#n3092

One more thing to note is that there is a patch that organized the tests
in lib/math as per the documentation:
https://lore.kernel.org/all/20241005222446.10471-1-luis.hernandez093@gmail.com/
Which resulted in a conflict and the fix was carried over:
https://lore.kernel.org/all/20241009162719.0adaea37@canb.auug.org.au/

Again, I appreciate your time and review. I hope this answered some of your questions.
I'll continue to follow this thread so as to make any additional fixes
from further reviews before sending out the next version.

Best regards,

Felipe

