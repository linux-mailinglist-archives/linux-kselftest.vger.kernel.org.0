Return-Path: <linux-kselftest+bounces-10020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BC8C297A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B81282E91
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164581C69A;
	Fri, 10 May 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ssdy8x/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78C1BDD3
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363089; cv=none; b=f84PoURYamOGayVHhMEn9OPvLlj+jrnxWG+McxMhDlhGRT7hq5U9YgOGGPPMweIE3p9jQT1CtrWv7EuHTPa+6mMxGiBYSsXfTGNuB09dSsBxdOw51zNVc5upd0pTTY5DDJqeUaNc94rF32Ko7PxDqF38tTPMIk4jmeur7n6Ev8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363089; c=relaxed/simple;
	bh=xJmMGpijLVbfzV1aLbCyIFqmqtVghhRlL3fIAx0Zf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msh/reZiJnbw6pFE2juCwUhJlxw7W3KJlYv8ap0zGsgiwmp4e6XwC5ZCmfqa6Hsx6fyDYwpDz4Ao4U7Yry597mu2uOb4PKJuqBuo9E+HNxdlD0msgliDnW6JGoY5yqQUFrIbI2MuVV9wrYlrwT4oMumKIfHnI+gHqlD0gHvO64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ssdy8x/g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so1857882a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363087; x=1715967887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=Ssdy8x/gu3v6owk4cRKjS558k6DX65Wm05p8vmbUS80yA1nhMtBEJKTlXakydU7iv4
         jz8AfO4nTvtwcQQHM5EqSaU/QOgxMSGVsoDmr4ZGk5pIburKLY11uAn84+0OKXfb5nef
         O8XA4bl+7ytiI5z8A35fyK64yuLYpUa3igqEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363087; x=1715967887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=bof6ZOXf2FBlBUdsAPOg9bIG2poRgo7efsWqc+/NsmueGLWm0pC7uAZcJY7ltUwvyH
         0TsWM20TSCig+UBzghrcsz/QyXJJJI0/j5m4v3teHCibBB6vYzi70V0N8B4Vv+VxyQpf
         8Cmrs65gVjgAWb0OIxDZSbRBInx5TkawAlwDWEBZJnQO1WimKxO1IWwIicrihqEkrP3i
         1rhMpz3Cs4WzITnfhg7hYEkEAujRcclUEiurTBM0KHnsHQat/CA4CSzLWFiH5yFteUs0
         c3HeGl2Zc7PH8dVcdofE2Dev+Q6tKsBpEC5c5o467Oc4fRis4lEEgTTjag6Sj82m8rGd
         bCtg==
X-Forwarded-Encrypted: i=1; AJvYcCU4HtM0QqDuNmltp4EF/RVlW/6VIL0CK2+cM6ekfstOzybMtoLecA5q2wIy7DCZJ2FTmmux7avSN9GfY07wiIUE0sTFcjnQ74PLyyTDDjbj
X-Gm-Message-State: AOJu0YxAR1CmX/CfGdZFVRaDBDcoGGkHaQXZaSE1pQxeXGGuw76Abdvp
	0PHiITr1oJJlRRf87yOiO1Ry9O7Hv+xlkneQUvfoqA9woVD0tJKXSK3HI89VyA==
X-Google-Smtp-Source: AGHT+IES457OerJ6E+sjpYxMiTqrSeTP8IOKWgMKTpX1LuCp+KnQ+g1iaESf6bNjK6mubIK/EdZwFw==
X-Received: by 2002:a17:90b:46c4:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2b6cc777f3cmr3358191a91.14.1715363086792;
        Fri, 10 May 2024 10:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53cesm5360572a91.44.2024.05.10.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:44:45 -0700 (PDT)
Date: Fri, 10 May 2024 10:44:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
Message-ID: <202405101044.5D2742EC@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-14-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-14-edliaw@google.com>

On Fri, May 10, 2024 at 12:06:30AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

