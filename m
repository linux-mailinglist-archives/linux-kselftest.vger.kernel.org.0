Return-Path: <linux-kselftest+bounces-21954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222859C799A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FD11F21087
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3482003DF;
	Wed, 13 Nov 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfrnQqoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE01E0E13
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517700; cv=none; b=MtaGBp/OWSJC/2Stj1zllG+LwRz6lkGMQvj/mZ1u/GXzO+3owDOPG/7wd1EjaZnSEpyJD946UPppt2foyXyF+FONFx9DGftH9cCZnRRBe5wu3g9qDPpaQpf9p6tzA9PfeCi9GBHA6StEpiEMd6NFdifIQ1S0gw3vZrrl+O9GQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517700; c=relaxed/simple;
	bh=MwTDjeCUUuvtEqRz3jfVu5/q3d7xdDWCUuJsQkbpCU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0BOeKPBB/++qRNYwvAOZsAiqcR/pGKuwaB/7Bz9ZiCtz8WfckSSGUrREPjqQudFw0TsyFDoUl0Jwc6IlToH1kinb4jxgTjnBHM3ynq5OGXrX7PTPhOREoSlAddsQuBf7v7Vw+u0Y4ZaCZ0Ym20my2T2DemJ+d3vCw8ZddmnqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfrnQqoI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e51ce601so352298666b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731517697; x=1732122497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9rL7o/PvlGWFQw5XVVoTFVbdNmHL9RGbywRCyJvRDw=;
        b=QfrnQqoInwCYfsdcua1c8ggRL0Dg37DcQy5iHDfHfFk7yamWnxoUiywrhe3mwj3d+q
         hkH1yN2DZdS0GvnOlC/GvWW0+lI3iTkajVrFNGhpbYhUVmLt/wxC9UNRq6D7GYdRZwmg
         8JYIbQj/f8OuRlu+m7NMwmPG2Vn1BGfL3WWmJfSsnh9P6KNJanIVE4Nf/Ze/NcJyGNHN
         XpcvCpaDl9tA5NMjxrq0RtAJ4bpOETW/n7G69edtOjNKqQ7AmYN2WKyy/7xnXsQweoqM
         TtkcjhcVmX6sL6DZnc9IYNe+j+VC+m96bF8h82M1uXgNhoRGWI70T1U16APTsoyKcC6d
         hQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517697; x=1732122497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9rL7o/PvlGWFQw5XVVoTFVbdNmHL9RGbywRCyJvRDw=;
        b=s7vF+7JTmleJwOMmTc25BW2Xpf612GkS86r+WEvp/gbZ61ZtxsmjX3XHeNNFR06eL0
         s0NhxYbcAAcUZ9oq0wb5aHad7AuzTLLNM2Q6hl1EAr243og6CwvQ73suaDwPsaUIYEYG
         Qvs/zzVA3i5VIlhqZ6Se8PQGnCnv+1WAN2qcuMzFAwFVsEJ9Q4AE0pRJJApPzT1c3Q1a
         S75wN4vabBCXOwWtljeoS4qPlnKD9HB7zR7Sf7BTJLoav8piElc/kke9+H0LznUusngH
         vVaMPf2BHsmqpe5rdpsg7EV/m/IwGsC55hKFp5cH8qvUTdnD0AfNLszei0swAFLkGlDd
         LxyA==
X-Forwarded-Encrypted: i=1; AJvYcCUmCiEGqyrL+c/FrsLliMSLsbMjztPEHDD/G3S3QVzt1Oq07xoGwjSSqbXSO7kQ94iaLc8Pl5GmsvE3i7tTKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3jZHv5AtWRiy8QEp01IgNKWZqh/2JJsmN9TeGagBnh3dGIn+
	St3JcsxmnHm1ra77Q5kBLSuXG8SMBjdTnqydfVpcnq0BRbtnzE/qjDB3TCSoyv8=
X-Google-Smtp-Source: AGHT+IFHDCrNqllb0ktO340z3QbZiHkoWYqo0nZOFt2gofDRgTZmVfkFehiSYjXNelnICUHjddaKaw==
X-Received: by 2002:a17:906:3406:b0:aa1:dd58:aeb6 with SMTP id a640c23a62f3a-aa1dd58b0damr578341566b.57.1731517696816;
        Wed, 13 Nov 2024 09:08:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c3f5sm895702066b.76.2024.11.13.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:08:16 -0800 (PST)
Date: Wed, 13 Nov 2024 20:08:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
	Kernel Selftests <linux-kselftest@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Ido Schimmel <idosch@nvidia.com>, stable@vger.kernel.org
Subject: Re: LKFT CI: improving Networking selftests results when validating
 stable kernels
Message-ID: <1bda012e-817a-45be-82e2-03ac78c58034@stanley.mountain>
References: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>

On Fri, Nov 08, 2024 at 07:21:59PM +0100, Matthieu Baerts wrote:
> KSelftests from the same version
> --------------------------------
> 
> According to the doc [2], kselftests should support all previous kernel
> versions. The LKFT CI is then using the kselftests from the last stable
> release to validate all stable versions. Even if there are good reasons
> to do that, we would like to ask for an opt-out for this policy for the
> networking tests: this is hard to maintain with the increased
> complexity, hard to validate on all stable kernels before applying
> patches, and hard to put in place in some situations. As a result, many
> tests are failing on older kernels, and it looks like it is a lot of
> work to support older kernels, and to maintain this.
> 
> Many networking tests are validating the internal behaviour that is not
> exposed to the userspace. A typical example: some tests look at the raw
> packets being exchanged during a test, and this behaviour can change
> without modifying how the userspace is interacting with the kernel. The
> kernel could expose capabilities, but that's not something that seems
> natural to put in place for internal behaviours that are not exposed to
> end users. Maybe workarounds could be used, e.g. looking at kernel
> symbols, etc. Nut that doesn't always work, increase the complexity, and
> often "false positive" issue will be noticed only after a patch hits
> stable, and will cause a bunch of tests to be ignored.
> 
> Regarding fixes, ideally they will come with a new or modified test that
> can also be backported. So the coverage can continue to grow in stable
> versions too.
> 
> Do you think that from the kernel v6.12 (or before?), the LKFT CI could
> run the networking kselftests from the version that is being validated,
> and not from a newer one? So validating the selftests from v6.12.1 on a
> v6.12.1, and not the ones from a future v6.16.y on a v6.12.42.
> 

These kinds of decisions are something that Greg and Shuah need to decide on.

You would still need some way to automatically detect that kselftest is running
on an old kernel and disable the networking checks.  Otherwise when random
people on the internet try to run selftests they would run into issues.

regards,
dan carpenter


