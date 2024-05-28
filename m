Return-Path: <linux-kselftest+bounces-10788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E828D1F8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D602831BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39016FF47;
	Tue, 28 May 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LGuNQzaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B901DFEB
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908493; cv=none; b=nUKMYHiv6p7/zMMh/dCzqOGJE6MpcsyncNwxX2Y82Lt8yqT/COxBS/JI1s1Asc+vLDZeNrM+7ugI6qcri+E8a4o7f5yhwY1pjox6bPF89Tc9H2f8ziswmut2hJccGFSOuUQUJJCLtCPL0nDJ/rQJx2Vd2qjo6KwSbgnIuB388y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908493; c=relaxed/simple;
	bh=LlvRFJOILCzbgT7NNvYggBjSUHVYjQn217GQwoLyvGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDj2L8RB+7ZgGOBQNOAgusORragnCm63ThwCJ8uX4v44gBcdv2vzFNjvvxuOM8q3fvFX4uyFOs2lh+iZzOQChz76roS/7AVBhcDAbAQh3j6ivKvao11FvXJh7qKKiVZtbbwi3lhSuFyrKPKFZG5yMKo8rUnm94VEWs4bBPMSmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LGuNQzaa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso161652066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716908490; x=1717513290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZpXRomCophLuh4kP0Z7OM4gjJuOz191Vdv0Rm3MAJs=;
        b=LGuNQzaaX9qwTzTPWDHCllYkFttcLNJqr8FAVGDK/ue0zZsCxbwkQrul0ApRu4y9Us
         k/vc6S2Oo7gCifyIJEKByxkv5PY9t+xQMVIzbbyMXI93CwrV/lDgiB8JsOfVwa2yaix/
         E7ZWv9pb0p5zW6IJ08DW+5Dg8aLena3i8+ZajwBrGdGzPHx7/0gK5Ili+aR7Ak9ketts
         eMD/4dT1Setm+E5kZWpSjyuoyI5NdCJcojQfa15oevtQr96+ZKQ2hV2v0hySgHSzaPJm
         jsNJXTEafCbgrsf43XbHXhmH4ZXnxEvklYSL4XVkYq3RuE/54q+2tt2Row6pmT7ANVqx
         gDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908490; x=1717513290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZpXRomCophLuh4kP0Z7OM4gjJuOz191Vdv0Rm3MAJs=;
        b=vYe74U2U05XZG4eWqfswb76KUv+mCdk+yD8KWmjwALYsR3G5zadgkQTy40QYTrVjih
         DiuZYvVFDacSRlTKSQ59YqmbNwtQ9hF4wU1sKz8u5CUeU2p3gq+XbQq3/q8I8kgsea15
         t0LVntEgojIcP7OBbo/RniZGI7FnlDnKEXn0TAFkOglPBtYoMa0lcvL2XpgbXnsZ+wOY
         d2R8OG9/NzSwsPB/k5/w3vPi4ltDO7q2akMqwN0AFOvNEZmXKdSZ2LuFefkqTPBhE/EI
         gifGAEphT7LmJRXrOhZc5BI/D1jtDXGhvWkbpbMp01AqG9w2M7wBe2ntaQZWY92qJ8cg
         vScA==
X-Forwarded-Encrypted: i=1; AJvYcCWhpw+JYK4xul37oHF3ykPWDrzqhs60hp8pb7Ai9jY+QCTy0BMr38QiruNOv3H3QtjKQud7jLa99aa5ZxPJWvyMxu1r3qQRYbtNwrB47V8h
X-Gm-Message-State: AOJu0YxKDw9aUM9Z8KqYjxAu7pIYjd2hx95AFj42EyFdl3hOdMgGd1YF
	4RRSHz2/005yW1+YQyCMPJkI1ijn6b8Iq/Pttp7w1L3G4gUpof9gJdU/2kHIOvc=
X-Google-Smtp-Source: AGHT+IGjXdR1wwIB/XQSuS/su8bySQhPGF1f9VfG551f27pX864NaKYfbnoT+xMu5gTVpvnmh+tb7A==
X-Received: by 2002:a17:906:1f06:b0:a59:f2d2:49b1 with SMTP id a640c23a62f3a-a6261f91570mr1034023166b.9.1716908489852;
        Tue, 28 May 2024 08:01:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda6d74sm619241766b.201.2024.05.28.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:01:29 -0700 (PDT)
Date: Tue, 28 May 2024 17:01:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <ZlXxyIMNA64Wy395@pathway.suse.cz>
References: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>

On Sat 2024-05-25 11:34:08, Marcos Paulo de Souza wrote:
> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

I am not completely sure if it is a good idea to test so many
aspects and use so many different test modules in a single test.
It might be harder to maintain and analyze eventual problems.

But the change will help to catch more problems which is good.
I am fine with it:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

