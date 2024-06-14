Return-Path: <linux-kselftest+bounces-11982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567729094AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4444B21A48
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37419005B;
	Fri, 14 Jun 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KN0preVS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7818FC6C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406619; cv=none; b=VZLWRiWiA2eXdTJG0HYi+kPA5iZnY8F/LpiUzcfWDcTzFG3B765QV+w1ofhUEyZ6ziIGyNSgvVLw4R4M2wmebzJxMeQILPKH/1OV6Zl6out5OwzECwtC2RzmY/BRVtK9DX0uM2BvU4wSpWQ1+ktf+3jY83zZHooNTd1hN5Df+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406619; c=relaxed/simple;
	bh=HBZ8c72MkYU8netKasktWfqGShzs0OT54b/QhebpP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdvvpAz6GgOxjxSCCY10hfaM/jjdDa25e/LMmx7c0yDyQn2kKjOE81xIJvsouIYkTKszzqSpWKgZQ67XIlohjUt+Eb5jVncc8foAMHjUC4YBEV1k4M5Fmb1Vwl7eLgIfl9P2bpm/tQaTWQvtkJs+YQDwvf6+bthW5ZK44zAFagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KN0preVS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f70c457823so22893835ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406616; x=1719011416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLrLbkLvm0tzY1MpEgPbssfKu8Uj01vCeIVrV1R6cSw=;
        b=KN0preVSUBg8oW44G6gLpUTyabnGj+IwrbB483ZUWb8jirmE32n2xp5Q4nzoaYzPBR
         pjhvSVVB41tgPACvUACPafFHctssUpVZcH/PxLI1bzTkgA/Z73FCC3WRDULPxpgfNw3l
         qY+/9+pNBCx+UvaFKVK/An9xf3CA5+smhOCbYCk3xoE9hXKwC2qUDPr2ajGCJ5zSAvfL
         bEMIx4T3jcwtXRnOCn/IR/G3Bc8xCzYMCH8KmDojGU6qPUAGkDAzytZa7/3ptyQXUfrt
         rLeK8p5Y7u0IQN813j1+lTv3APMYDmkdEXkL87OUXCsSIJ8Mlo6DMPdtTSaamPShm/x/
         jBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406616; x=1719011416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLrLbkLvm0tzY1MpEgPbssfKu8Uj01vCeIVrV1R6cSw=;
        b=Clt76L9PL693wEBxBA2qKiM4VGtJ5Hz/HLddnoDUsG43pKLlPc1c1l6cKOwoo0y3eB
         suJs0hw8GWkvMp+RnGGTZbrk2sO0Qt+MZZsOmzXetO5CAVNdqc3LBECkfZSIYka8Gfw3
         G2mOiBGiviGBU4uBwWRZCw7jqUyEDHahNPVTIT/3i+7sq3BQf6156+XhLbfvEeZkf4Pk
         9dc6ApjFkBhNV2rOzBt/TumbGE6kfSceYZ1nV+D7Ka+6rrpK7MP3z0+sNCzi2L24rVaC
         lnTx2dBGAzhwoB5QNlw/5jnraHkptPfAkS3W2iC7w4IGMDfRMcSVevMXk3tLQxkZc3GQ
         YG2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+LLzJaz8r5O6PY99dOgAJ9IuDhj71C8a/wHmuEyEVr5yBVZ/12Pkhqme2citD9MwqKKYYkSv2lmC3bktR1QLlG6NnUyOocvqoI/iK/sU4
X-Gm-Message-State: AOJu0YziEyDrw9OXm75UhW1VlfN7NWciODYVVEmwZH1JCZuVzO33ino6
	UGN/F1pMxcw3qaHE/TSIlyB3OQKJTBGpikwjZB1R31E5od/EoHBTqE7QqwZTXQ==
X-Google-Smtp-Source: AGHT+IFcGsUH/QLxSXoL5wsJjIp8jl2vBep3vY4YHvN9/DueuGnm24AE2rupPbUPlpI7DAnWqNrRNg==
X-Received: by 2002:a17:903:32c9:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f8629fb039mr39146585ad.52.1718406615926;
        Fri, 14 Jun 2024 16:10:15 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f485ccsm37485285ad.279.2024.06.14.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 16:10:15 -0700 (PDT)
Date: Fri, 14 Jun 2024 23:10:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
Message-ID: <ZmzN1CBv5j9YV543@google.com>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
 <ZmiXqOHYaLLX557z@google.com>
 <2461f002-fdd4-4bf5-b797-827069cafc4b@nvidia.com>
 <8a6f384f-02b7-4a0b-90dd-e6843909e8a9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6f384f-02b7-4a0b-90dd-e6843909e8a9@nvidia.com>

On Fri, Jun 14, 2024 at 03:56:01PM -0700, John Hubbard wrote:
> On 6/14/24 3:51 PM, John Hubbard wrote:
> > On 6/11/24 11:30 AM, Carlos Llamas wrote:
> > > On Mon, May 27, 2024 at 02:16:22PM -0700, John Hubbard wrote:
> ...
> > > Reviewed-by: Carlos Llamas <cmllamas@google.com>
> > 
> > Thanks for the review! I have no earthly idea what will happen next.
> > I'd like to hear at least something from the maintainers about their
> > intentions here.
> > 
> 
> In fact, I have two more patches for vDSO (these are separate issues,
> for the Makefile), and I just noticed that there are several accumulated
> Reviewed-by and Tested-by tags on this patch here. So I think the way
> forward is this:
> 
> I'll post a v3, with three patches for vDSO selftests, and the latest
> tags. And let's see how that fares.
> 

Yeap, a resend would have been good. This time it might be best to bring
Andy and Thomas in the loop too.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

