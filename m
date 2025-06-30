Return-Path: <linux-kselftest+bounces-36128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA7AEE99C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840243B73DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59393236431;
	Mon, 30 Jun 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdWV4fcB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20D4A23;
	Mon, 30 Jun 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320228; cv=none; b=bzGu0uafK6Wnan7PQXp+hplHbe4wfJFJImmI534yZwNQIMW2duwGVnC+iB/GLoJtRtgRhneGhyshZuZPFC/K3gxydjNCkeJZqQbgDwBKa9Tg4pCr4EvlSBX0OAtcosnxDXcQ4m1mHKYeqEoBMoH11yLel/7MqUxbrOvpSnDAkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320228; c=relaxed/simple;
	bh=0RkMeCh2hbGmZrtpA9D/x8eJHKdGugLcbLSzPvl7xto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjWhUuH8ACVFGVtwJ7INsPFS17fCDf9kpV+qWU0IgFhST4X44tdxcgCfN0sZdQnGVqJqSNX/pB7jTdRBFSAsTpuVHtQNEmSZthMg7lkfzCXrto949DWHsoS6Dpa9qCidYWTN10KsdwnOfWMUPMwknG4npavAcFjNyz+JbD8EY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdWV4fcB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3220c39cffso2907519a12.0;
        Mon, 30 Jun 2025 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751320226; x=1751925026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RkMeCh2hbGmZrtpA9D/x8eJHKdGugLcbLSzPvl7xto=;
        b=DdWV4fcB8EhmnIAsTMuaRWg7unTjBQuYvJD3vy4Yer6rl57M4UWXoY+EX2Nlj/Ahst
         EW/qaN+OzlAnp84noC1ubjIGjrh4xsTjOS7q0KptSP24RGqCy6HAPWxyR/bBVsQn9lFM
         ebonj9E3m7xAgBxUV08ZZ40yXhEMLtN9CpUFv1pEt435nnk37p3Haao8UijzImbi4maB
         2gXu1aSYJQGQecu0JFJzOHcqac/lkPXdyuoLBfK/nf7S3Pfl6i9agaZimfu/MyBhFpDH
         xZXZhmHDI6xza5XCvtAsCreG0Qcy8geX6P2PnwK8+kFF4CyDf3osK2c8olhsYYpwHiip
         15Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320226; x=1751925026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RkMeCh2hbGmZrtpA9D/x8eJHKdGugLcbLSzPvl7xto=;
        b=I0OhXNHYZgjTaZdryc975St3IfT2oSaeo2vgXjfHcNB3rTSgRjOiNSRUucNoI2vhr7
         OrTzR5oJWVUvPBY0kuAzaMAZ+8T3fdli/DYYJdwPk2Fxx9eufgtn+CgE6lWQxGIutWwa
         4Pms82y/cTwPd0jUgXsN8HVxDDcgxU06bVMXoVHY3ketAxgAwO6dFEp5kOyL7iBHh6tV
         YrI7H7DWOIW4hUjWumIf6oSdQKTUBuBEIQqxFvGNNawK8bbRSvebdwwuUDP7qqJ9nkhC
         1A34xZlw0qayjrJ3W8eyZQ+VbnRK0XEvJiIs6HjgpSiIfvcCp3AsXwfLIsACQqe4Ei43
         5FUw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQgkFGATw7kk7jlOhtl8mjczU6JVXjgOCGKrxt3+z24RbhB4bppKykA+tziQYPMkBlz1Be5E+o49at6WJjw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfDp97gCgW9P+dl34gDC9cO0YJbmQNcstpT5WPOz/jJhGR2GX
	Xt7Hnhg7sYszvWOVPp/9NAI/9HaJTddncQPpGXxl0EU8xcKJcKG1FlwW9KyQCQ==
X-Gm-Gg: ASbGnctEZmLMTJRaX8tTn6pLKiGv3KdBE48XpoypyuoedEmRiLN3TTxfU4H3hBFXTGH
	fHL8nGzzNYg3R/cog1RaafeygdjXu2I00sxjxb6KfZgrwcmA8KgX7TUEMsFux8qo+57THfzO1cM
	RknV8k+ymSHByuri4Z92AwtC6+rHqIyxGgfZC5nQdUj3uhD54k81vEVl6tsCASg8ORO5uLKjntP
	Ia2k4Nl8ptiPMLN2yOHUcpEnBSza2Shkmtf1XOVv3nEHc3ZcKWlKdXB9wLt7RgNbLrfWoZA26dz
	AhWyT2Seop4WJUtPMh1mTLdW/42Ucje5ia/encWRvtq07kSZqZGLlBJGWqSvrEfJUg==
X-Google-Smtp-Source: AGHT+IEOwulVDAvC2fDl27Xyy6tM9twH63GOMNcYh3xf8cPJ6z6aA7P9o8/LiUVpB8GzqtCW9mEJ3A==
X-Received: by 2002:a17:90b:5708:b0:311:ffe8:20e2 with SMTP id 98e67ed59e1d1-318c8ff2388mr19490313a91.4.1751320226208;
        Mon, 30 Jun 2025 14:50:26 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53bc247sm14507336a91.21.2025.06.30.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:50:25 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:50:24 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftests/tc-testing: Enable CONFIG_IP_SET
Message-ID: <aGMGoICSLZerw5CM@pop-os.localdomain>
References: <20250630153341.Wgh3SzGi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630153341.Wgh3SzGi@linutronix.de>

On Mon, Jun 30, 2025 at 05:33:41PM +0200, Sebastian Andrzej Siewior wrote:
> The config snippet specifies CONFIG_NET_EMATCH_IPSET. This option
> depends on CONFIG_IP_SET.

So it should be set automatically when running `make` ? IOW, why do we
have to set it explicitly?

Thanks.

