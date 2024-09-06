Return-Path: <linux-kselftest+bounces-17401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1F96F686
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133F5B2322A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730861D0496;
	Fri,  6 Sep 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PI9bu0YV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1UELMw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3201CFEC4;
	Fri,  6 Sep 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632230; cv=none; b=XUuWQSGkbW4Kgb6ktELQtwvNKMY6Sv3blkSqnueYMvzjjzQVh07/FmVLAQe5sj1IXS4pOqa3ZJ/MWXrqtgHDziyu9lIjM0OYEqKjH2PLB1U9I4eZmTQFCwU68mI1zOx6b96CiWIbnl5X996Jo+DmvYWGQr1kz2bTlicW87t9xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632230; c=relaxed/simple;
	bh=h+YA3asjMlGGmJx85JbgCTK7XK05bk4L4vBo0Vy2mgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3axLT/pWf1yjAZwEzBbIx/NzSztFJs0J72mQHCRhfwmtcXgUEj3pLCeSIZ9GC3BmrdGr8yBxkSEFgiL5GQnfaeXIOyTf2KFTrDpzfq+khhP+mLKTbZJ1SRYI0tdRaL54Nq0vk/PC72rWrtMdHqDxvRnnzuAl0caCbyIg+Cud4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PI9bu0YV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1UELMw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgKZ+vumIKUNr1c37nM3ODum0IPpcuNPXqGXpLZQ2aA=;
	b=PI9bu0YVpkmN73dFy+C3vBR9JgyVylYpbUP/mta5lrBEAd5lr807kojIYf9KB3GC/nU5zc
	fcux0WI5FZgCtPCwPT1BWo9YyVztzZ7qEcE6li+jFqKBgs6bRy5Ix2we7hF7U/+Dvy6CmV
	tq6HeWSqz8zT7WSJ3LPQQfIzBWFdEpbtrRZ3nypxTXR7924EamGJLHFwxuth7peRVPuP2f
	ouNLYOLToXKNkwPBjVqUGHeuPtIRQR6w2FNvX6PaSYMNANYisxIn66UzYeRWul9ob2LWpV
	QVkaIx4Y7Hj2PRLsLmoZ5+Ovj6Pv4q/wmIoZTtLPP4O73S1itv7BkWitHIR5/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgKZ+vumIKUNr1c37nM3ODum0IPpcuNPXqGXpLZQ2aA=;
	b=n1UELMw/VWcRzbICFlv0LEUPLcm7gDKr48jYFPDvy4mAFUgxPoS3eXbUIGuQ9t5dmuoEZf
	iVE0A3pW+1M5x5AA==
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mingo@redhat.com, shuah@kernel.org, zhang jiao
 <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH v3] selftests: futex: Fix missing free in main
In-Reply-To: <20240906021918.3125-1-zhangjiao2@cmss.chinamobile.com>
References: <20240906021918.3125-1-zhangjiao2@cmss.chinamobile.com>
Date: Fri, 06 Sep 2024 16:17:07 +0200
Message-ID: <87ed5weujg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 06 2024 at 10:19, zhangjiao2@cmss.chinamobile.com wrote:
> @@ -362,6 +363,7 @@ int main(int argc, char *argv[])
>  {
>  	char *test_name;
>  	int c, ret;
> +	bool is_static = false;

what means is_static? It's not connected to test_name in any way and
please use reverse fir tree variable ordering

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

So either use a variable name which makes it clear that it is related to
test_name (something obvious like: name_allocated) or do

       char *test_name, *default_name = TEST_NAME;

and do test_name = default_name; in the error path and then check for

    (test_name != default_name)

Whatever you pick will be better than the non-obvious is_static.

Thanks,

        tglx

