Return-Path: <linux-kselftest+bounces-21161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF19B6E7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C36282C9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AB214424;
	Wed, 30 Oct 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XEhp9Ssz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C720E31C
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322715; cv=none; b=Q4gOAcrCg48O+0acK2cYXgSApJSKBv5gG5RLRjQXw458YiU2r2KvnlkZY0cwGNP59v++YaKz1sjpJrMFQhgz6Gfv2M1vFZOz3daV8wOqvd3r/x+zpNdZhqUwBrDNpnxlfWCXsnfwsZbNAQxnfg6zjTXDPunqrPMATliA8cE1gNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322715; c=relaxed/simple;
	bh=MX31BUMIF20ob09Ys6TTsNW8yvLIH6a8r5EeG9LcUYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWHrzTKFg1S8PkYRFO9hGkKSjLn9GNYkZJbg9GRGBnrMr0fN9WewhkEvdAnp7xNJpk7XsUTSdHG5iyBkrXTqHFEJibB/krJ1glTKXJUire22pKzA6IA3yuNOaToKur3BRMvWXPQWQV9RcIBSmh+3wWXy/dUxUo+wmrFnAsIKqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XEhp9Ssz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso255490a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730322713; x=1730927513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MX31BUMIF20ob09Ys6TTsNW8yvLIH6a8r5EeG9LcUYc=;
        b=XEhp9SszHrAKdWDT+4mKmdhuXGDt6SkhxYCdyKzjAh+PCwH6BReRLkkp2cvWY7ZwM7
         LCX0ZeUjEbali1s6RwqbX/gBe4cCSW6/7ymu5KmfDa/s0wng/fVv/lKw/8IJ59Gq37i0
         Q92BeLRdYqd7eDtWc2vRmKp36YulgLp6daZZAA/Ly1duPi2aGTgf/ofpjnoxL2SmxJYZ
         7D+N8tVtNf57WcsHmTaQXR3X6RvpEvG11gp2ui8YFSw8miFoRoTIptW7+Bdcr5AFyx6L
         jon8rWGTyn7e5e4hNc3OS3DrZ06vcJzuPsHvZq9RIXhjwrrAG1NV+fH8XiOLsZjhFqck
         jn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322713; x=1730927513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX31BUMIF20ob09Ys6TTsNW8yvLIH6a8r5EeG9LcUYc=;
        b=YngvfQafrtIE1ns0uFJwFCxcnpZ/BHbxbQo8bS7fBjxRob5WdkoWwE8tnAqjaeEobX
         1qgNqdc7unhkP4FOT9k89DovOu89IBE1sMQeVD5DpMLnODf8AyE0hme+DbQCArmIGiHS
         ZvPKNE//BT/oUdytVQxo6ax6wkKbirly4XEBsvZxNnf5zj+hIAfgEuCEWljxBUYyD42O
         qmjf1ZMX0NVyshaQYObt+2D0G+OTh8dPO5qbiplEZJbpcBF+zWxuoxGzeX0LBppP+TRZ
         QnSTK3HAh1xfGRj6+O1Ofa9VnNMftIpy7U7XSUTVuWSlM4WypEKA1j9J0RoLvaygVQuf
         6MiA==
X-Forwarded-Encrypted: i=1; AJvYcCXnF794xrTzOnpALOJRWI7RGu+CdUMMJTMSfA0TwWF+NyoY+oyNJ1+KX2JR/2kLOfZ2kKlu0HYjuLB9CL3q2wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZqAtePkeNSJ+ts2h62t/6Sl9ytn0SqmVc4E0EfYBlMUCYZ6Q
	cgyHjatkDCv2qhDafHyAMyb+nOJKtwAAEFcoxiRtkMH7VP//5YHlWWHqa3L9xFk=
X-Google-Smtp-Source: AGHT+IF6AzPMNPEniI5XY1hXIMrdAsMeRP4cjQPYvIhPdkK/YKbMxfipb2Fum4HXbUgPeOo0b8V0+A==
X-Received: by 2002:a17:90a:470c:b0:2e2:a667:1a18 with SMTP id 98e67ed59e1d1-2e8f10548c0mr18380348a91.5.1730322712852;
        Wed, 30 Oct 2024 14:11:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee46fsm289665ad.21.2024.10.30.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:11:52 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:11:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v11 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Message-ID: <ZyKhFSb4N0WVNFQY@debug.ba.rivosinc.com>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
 <20241005-clone3-shadow-stack-v11-1-2a6a2bd6d651@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241005-clone3-shadow-stack-v11-1-2a6a2bd6d651@kernel.org>

On Sat, Oct 05, 2024 at 11:31:28AM +0100, Mark Brown wrote:
>Currently as a result of templating from x86 code gcs_alloc_thread_stack()
>returns a pointer as an unsigned int however on arm64 we don't actually use
>this pointer value as anything other than a pass/fail flag. Simplify the
>interface to just return an int with 0 on success and a negative error code
>on failure.
>
>Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Deepak Gupta <debug@rivosinc.com>



