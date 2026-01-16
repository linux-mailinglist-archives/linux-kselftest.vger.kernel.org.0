Return-Path: <linux-kselftest+bounces-49182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA16D33BE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042C5302A94D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78588348875;
	Fri, 16 Jan 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGnCjbUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D83346B2
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583773; cv=none; b=Qc+yOZZMuwTfyZH5xXzBM1i3s5P1xX0CK747HcZyL680B9/JeYeSSzpMNm7qPQDQgzuoWb8gi5TBRiExyepY9F7E/uj30C+Xu7Xcr2ciMClKFs8Cj8Y/3DPfXAtZG1pmXBaAF+a24N/7erKW/nOCAIxz/8siG8w7++FJxSSVRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583773; c=relaxed/simple;
	bh=0HukBWkzWF4xfMna97oVTMuTQacjQzaYvagieCOdmqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT7356HDRUd9AudsLC4S1xAgJkwJKZUdZZT7Al7WsNK8WBpjbXjJiOV4XqboiuvlLMPjKb32QDezPxqhiYeNyr26jp2RaDVGgoJq7B847zzxmVVdGjQ9ZKmqXISmOckSz3CjLoShQMI0oVl6MGeecowrhYWGdNmseZDUS+1ipfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGnCjbUm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a09d981507so16285715ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583771; x=1769188571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HukBWkzWF4xfMna97oVTMuTQacjQzaYvagieCOdmqA=;
        b=IGnCjbUmV5eQsLNtDqTDFEreU9QOfihBhTL+i5J0wM6pyNs082CrretcvjuKgZOs+6
         TpcRGJzW0OgHSMnJmhC4xtGUuvfFa2IziCAunc6QisPZ3Jm3PR3SXQvMtkxW/ITgCNO+
         3A7fYpJEjaeBTpL80to6Jl+0G1DqLhIyae6oq9GV3AYlg4ItyCRaE6LjNnN60h0NgvSw
         o9cbVkNdpbJFpbdNwqiaMmJqpFuUNt1JWQ9wbd8BiVWsZhF1zTyg3PcEHHvZjtx74d7/
         1qehiZIxDdEZ0Hzw4ACCHaRIhVw76WbSAeOkgkeMhro4vGtW7hYvjT47l/JoWZsb6agZ
         ckGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583771; x=1769188571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HukBWkzWF4xfMna97oVTMuTQacjQzaYvagieCOdmqA=;
        b=fo3aQUsDpCwgE/DmMY1jG6+6iLA5pRbji1IVv8vlaYTrF6mgyW5/IB9LTckYuJtB2g
         gQQNEFvGpSq12OM2aI7iKrLN9GT/gwOmGI70vUXJZURV1U/q4pIG4nS6WtW/bLCIqoOZ
         k6UQKz+9wgqVB09f861LkA28N7JC64xkZyakj9h/8O011J9PfFbqZxo5QaRGg2bGevSb
         t++LOEuDnWnb0+wRNgLIWd/vKAQcMAC6BqVLLDLlntbLzQcNQHYFL+b9eNuFkQ8w/RfL
         ImuKfPhW0pVPmKPMU1tYZOqGXlP4wkcA0dWxxD47eJ76sbmtuONaz0D59hrIL6paWHVb
         maCg==
X-Forwarded-Encrypted: i=1; AJvYcCUbsw0iYgGvt6Ycof2O9h5FUbg1Xxp86anOt+Z5M23ReJPRLs1o300gBDniRUulIz+UyQ/hF4ctRXRJbVPUFtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8rRsM0zrNXZeo1fo/k8Gz/+53URO5SvNO8cxv0bdzG6qFOBl
	+u8J3aepk1y9Kb3hU7wgTOIyMeAFbvUuNfOdz+i57uBUUgcjpDvMOn1f
X-Gm-Gg: AY/fxX7daa5mdX0kRuY0DAx2eVQjIjWEXdm2bCI3MB2lY0t19Ikus9H1iAzCHBmH04N
	ipoidM5eyKZZLK7LfZT5cD34LLrm2trzPn0DT5pnb5CariqRXFtdpYCF5YHWuoXuHWK0bEtNZcj
	WsP4RePujn4iRZ08FPvR+NPyrRqN4Lsuo7rGk4KP2VXBdobtW6LTHUY9Wov6IzGtXr//pwgNDw9
	3FkWoeOWfioX2hkmZPTwKQ3Abi8mxwkYiIMOeMN5NEeIqayeZoJCXCIZfrEj56PKQiS4fktbXuS
	Dj056Qm6VsnhaIKancEZo0HEVFCaZ0ouMhGrOZjP0MHKcyDeTLnvhP5NhX0DpjOzewkWEq0wgek
	AoqRqRxX984hsmG6wuYo3CgV0HR1JUHFY0NFw1TkuhFRics/+FqM5KSma6twu2up5FwHC4Yx7fi
	V4FuDylkI=
X-Received: by 2002:a17:903:2407:b0:2a0:a05d:d4a2 with SMTP id d9443c01a7336-2a700a37c8bmr65178465ad.23.1768583771236;
        Fri, 16 Jan 2026 09:16:11 -0800 (PST)
Received: from fedora ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dc83dsm26270535ad.50.2026.01.16.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:16:10 -0800 (PST)
Date: Sat, 17 Jan 2026 02:16:04 +0900
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kunit: add bash completion
Message-ID: <aWpuYs0Mw6fR4rLO@fedora>
References: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
 <44b770121202e9f41648da5abaf9a87d5b8811c6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b770121202e9f41648da5abaf9a87d5b8811c6@intel.com>

Hi Jani,
Thank you for the suggestion regarding shtab.

On Fri, Jan 16, 2026 at 12:10:27PM +0200, Jani Nikula wrote:
> The alternative would be to make the tool more friendly to existing
> completion tools such as shtab [1]. Since the kernel as a project is
> really averse to adding external dependencies, you could take shtab's
> CLI approach, and commit the completion script in the repo. Only
> whoever's updating the completions would have to install and run shtab.

I understand your point about avoiding homebrew solutions, however, a main
benefit of this approach is that the completion script does not need to be
regenerated or updated manually.

Using shtab would introduce a new dependency and maintenance where the
static completion script could easily get out of sync.

So I would like to proceed with the current approach.

> And the whole thing could be taken a step further, adding, say,
> tools/completions/{bash,zsh,tcsh,...} directories for all the kernel
> tool completions instead of spreading them around.

I agree that centralizing completions is a good idea. So it would be better
handled as a separate future effort because it is a tree-wide
reorganization.

Regards,
Ryota Sakamoto

