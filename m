Return-Path: <linux-kselftest+bounces-6675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A388D150
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBED32275F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB513E6B3;
	Tue, 26 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyuJz1sn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5613D8B5
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492839; cv=none; b=hsbqmRDYchv2/QnRV7+35Lq0XoC3UIacC1hEYQfry+r16JJ6lBLU2YGHa2f3XL9QghUC6XB+QpU6oXiM7JolUqXTlqivruft76sjpb/XqZI1eT2UI7oYy0OMQdc+mUjkKM+34cpPs3AftjQe4CfmZc57KzXi65Pp/MrKf8Npup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492839; c=relaxed/simple;
	bh=yx8FqHoYQC1PWSggMb1zsMpypq8jpF4oFVsUHceinSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5APMYsf/ytt3J9p3gwV85Ve2xpTRn5Dm/g097jeAxPoMwcV15XOjMk7b/hdQmmrkLCsxBuA8x/MpUqD3AYTtr8gyoLF5YxdIMmft1ZPKk6MmR7y5KSSa5OO8bSiMGRzuxWEtHlY2F/QOMwhLylRhm520R3QtMT9WB5v+NHLxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JyuJz1sn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29df3333d30so4312516a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711492836; x=1712097636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvOJt/m6EX1Fwx/utuRWvS5dkTN8eAFwRhRBD4PxWcU=;
        b=JyuJz1snuaNpYTlA+i/4xYc+mVvynUDy9D5DDc7Eac3f7xnI0TjujQCBHvw5wOPQxO
         ML5NJ6PRBuP3Og8FPFyyMS64OkuI/UqO05nT7P/xcBvUThiP8RHYZq+rBj72JCc5JqjG
         VO8L+mzrTEhdt17mbJhsIHv97WsB3EHzUNcgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492836; x=1712097636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvOJt/m6EX1Fwx/utuRWvS5dkTN8eAFwRhRBD4PxWcU=;
        b=Lf32wU6DwuOVvTLj9Eyx8L0y+lNtQzgMsEeCOB7oqYMzLd6G1zCocBnlMfz3ZWFSvj
         1NmC2zN/g4vO+FXzm6N5/HXtfqgC6pi71uMyiQgLGPlOcmwwab8N9BrphJ2WSM2wA/b9
         rvWb799WwDeVx+tVrigAjmIeWfEjq0cNtq0IHVQnqBUDIK+K1kUeoF8a+G7xMoXHNNya
         cB1kqb6BIXC2bds0kXBPNROg4Nx5e/blB1MW36Mx03R7TCVJrBVgIIzrVVZo4DqmfS2Z
         gNMD+g3JueepiDnnTILQYfezBX0gDVZqoW4j0YCMzjB013lBPr8epJWtGFdsgSMtex20
         fcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA+/zgr1DpCpaPTTMYwX43QypcPL8a15S7jYWRhUJNNw80j+c1MojCezVRnniKDkcq5aF0T1la79sZAbyjetk7RyOX5UIYD9SK+HHeiY7P
X-Gm-Message-State: AOJu0YyDDCdfaIjVUM4yPbHSLHbskFbpYDH2r6FhUMjCIY30n+Jyd7Nw
	hq3ALHUthwhBqI46YmYQnpz4DhNddrel+5/FKQ6XgXwebtxnf0tUkvnhKGdkmA==
X-Google-Smtp-Source: AGHT+IF5G3KrocdACcX+f3m+HzePkIM6XGT4hipE9Q1qTgD2Rdqr0vhVlYeGHO3NcuiylpnYgzVGcQ==
X-Received: by 2002:a17:90a:53e4:b0:2a0:3724:6c70 with SMTP id y91-20020a17090a53e400b002a037246c70mr1191157pjh.39.1711492836017;
        Tue, 26 Mar 2024 15:40:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sg17-20020a17090b521100b002a08ddb5bb3sm130502pjb.12.2024.03.26.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:40:35 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:40:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Message-ID: <202403261540.8F0D7A0@keescook>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
 <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>

On Tue, Mar 26, 2024 at 02:46:02PM -0600, Shuah Khan wrote:
> On 3/14/24 02:54, Muhammad Usama Anjum wrote:
> > On 3/13/24 11:56 PM, Kees Cook wrote:
> > > Children processes were reporting their status, duplicating the
> > > parent's. Remove that, and add some additional details about the test
> > > execution.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kselftest@vger.kernel.org
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > 
> 
> Applied to linux-kselftest fixes for the next rc.

This is already part of the execve tree...

-- 
Kees Cook

