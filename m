Return-Path: <linux-kselftest+bounces-39015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3FB272AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8619BA23180
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1B283130;
	Thu, 14 Aug 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTAsYgTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B189280309;
	Thu, 14 Aug 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212164; cv=none; b=cOfmrSgrTWd+FZVfbCZ2knCTX+DIhpTqlm/r9bAKdwBHfLfg+IV0J0CyroNOZgcssZkzoQnJbhoh84fHDT1+G7FnofeBcHPwthAxhoVGgQ5IjaosMqGWuuwffRj702z5LEiBiisVImnOUFwh4ZplHCFpcKew0kwizZCxV3/8Mtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212164; c=relaxed/simple;
	bh=mQHd7PTKwFf9DIdBJXB1vK+y846gRcI0pvlTZeYISMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttPpIp/R9oShITatp+Pi+Jm8joi55H4eB1UdUEA7jCtSWf+sQPRxYKM9iFkF2mzCFBdtUTiCG6OzRyQfY6dSBtLB/g//iyk4/LSsTBovwXSIqIp1e/yAZpCb3aFWL8XL1Uu6T9XQsGQFPQnCCaUw0H1ldORdncVCUS+en4ZLu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTAsYgTI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so1619082b3a.0;
        Thu, 14 Aug 2025 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755212162; x=1755816962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5AKvjWPxuvk9+NvAN7NRCHNy5BREu+iLhDk4IMjA/w=;
        b=GTAsYgTI6afpqeXATs/2ePSUo8GXWgeqYAPeQuU8eEG5i6DqethsYTdteskZJbCwb+
         8imzVeqXVa7fpeURXrX9Q3qWshcqNPc41QF5IHt2pOajL7SVChInxDydxpF8fmDzS4VB
         qxuE2PrKqXkRmPksbMLk9kAqVDfFIrbDPpDh2nZ9VC62RwxnhMnLe91opREq6bDSFVRc
         6o1lgu0okGWxW/n7tHn4OnI7+3ITkv805mLw6awaEhqdinPBluQPPGBUMnCybUg40odE
         URQdZ+mkoGmFNnVwFAhq5zotHiijQ0bpwtO3aaLKnXJVpWAcs0Vj24zGurvNMS+GM6F4
         EHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212162; x=1755816962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5AKvjWPxuvk9+NvAN7NRCHNy5BREu+iLhDk4IMjA/w=;
        b=tf5CuJ1DsyLWsqz1T4RuddBnh5wr8s9PIfkO+D0Nv4s5XR9tNZg7vIqAbAamz9sBpl
         IsRYC7Nv9ZUpoYEHSWe3acloHyp3V7t9iq8oh02U5KE5cy1qRbj/J1iCJRNFHmqdUbcG
         Np46Hb0xsAImGAJth8dU5Xc8Z8MWs8I+aEabmDt5AwJzxIm8je5K2Pk0wwnTSO1UmXba
         bH9tAio5VdnqYEqeJJPOLdT3eJzQcSZxQ+oAk/0phphsQtnMrbtuCtgZ6IBny2vNpUoF
         AL7c7uccGxWe9Q5tHGCOBQC8tAwQyLkbzj/vAiDQYwYOZF5CPTIj5a0dsikGzE9dpJ+2
         1gBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PLlmcXQv3vF6gKvWckNLSUvDpf3FL8nMatjdsqfchq2AFtd6I9Bv4eJeMhh68G74qZlBqPJioqvbJTkBEMbn@vger.kernel.org, AJvYcCVVIJHkU07VNm/VhzKB1BFM5fZ4PSPoMlMHNhg56oZN8TsIPL+EZcY/jqRgZeJAX7ke4eDCqsZGJt66@vger.kernel.org, AJvYcCX0NhOdNWUDSiXbfD4mLXLlbzowlEJJGtWsJHyGTANAGlHk4byPK3pohTsFPgeoarZdXFd/rGfMjEQ=@vger.kernel.org, AJvYcCXxBbQMx6jG6soTHiRDfsZUIXjjsDYRcB8boGk5L5IaFgcxrO3tjHkMAkitbQF/jeMhW4cqTisEzlqtBPV1@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFV5VBCgu8W4kJw6jJl39kueK66mCmN121uYfmRmBZv+oZRwm
	UVyxlJNx8tG6hIXPoU7vVhPxe9JexhwwBzySTozGADBm8okItTuDmNzj
X-Gm-Gg: ASbGncvSX7jYkGRHuwCInaBN5XHe/u8E+UkKybH2o8LGz5aJybK6+7AUNyWpR2/h+/o
	fl1/VjbdntgHvgbE4qLby+ZqCpX/pztEZ93rxwe+WQ074SZVOwOhUcMB0vP+0tDzmzHlWDTK3cD
	F+5rBz55GNGlonj6f+QLTC3gpvsM95KVrCO5VtIutbheemiTd97dl2YYIHckG/Xr0Op2ur6lmQj
	eowMurhqefswaNMvoLbCrrKtfwWmFPh+apgJtwGVRL40nRYeq8Dsoix3RVD4RCag3ye2v5wBNnN
	nJOY9/Vtu3d5BvmuMscMKF0MNoQkxdr4T7s7pYhV3MPnYbDhJT7OpCl6P/svxNt6Fabz7AvWki+
	pCGAaZVAa60u5Sx23Gadl/A==
X-Google-Smtp-Source: AGHT+IH7mGzPa5mo9B5wynWRywyhFQPatdKJXTvrQw/mOHTL0M+5shEN/BMB8QgAUqPFJnuwQV4jTQ==
X-Received: by 2002:a05:6a00:2392:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-76e2fa2cc1bmr8017756b3a.3.1755212162510;
        Thu, 14 Aug 2025 15:56:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdf61d092sm32632771b3a.116.2025.08.14.15.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:56:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7A568423F8C9; Fri, 15 Aug 2025 05:55:59 +0700 (WIB)
Date: Fri, 15 Aug 2025 05:55:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tim Bird <Tim.Bird@sony.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH 0/2] Documentation: ktap: formatting cleanup
Message-ID: <aJ5pf-5nxHJcqzgZ@archie.me>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
 <98ed6868-8030-4d10-b66d-c7e3d42886f8@infradead.org>
 <aJ2Epp0b3HgeaMxk@archie.me>
 <e2186e21-d069-4881-8829-b698cf90d5e3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2186e21-d069-4881-8829-b698cf90d5e3@infradead.org>

On Thu, Aug 14, 2025 at 08:55:08AM -0700, Randy Dunlap wrote:
> 
> 
> On 8/13/25 11:39 PM, Bagas Sanjaya wrote:
> > On Wed, Aug 13, 2025 at 06:58:12PM -0700, Randy Dunlap wrote:
> >> Why send this patch series to the workflows mailing list?
> > 
> > Workflows ML is listed in get_maintainer.pl output.
> 
> Thank you. I didn't realize that. So in the MAINTAINERS file
> workflows ML is listed under DOCUMENTATION PROCESS and with
> these specific directories:
> 
> F:	Documentation/dev-tools/
> F:	Documentation/maintainer/
> F:	Documentation/process/
> 
> so yes, you got it right. Thanks!
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

