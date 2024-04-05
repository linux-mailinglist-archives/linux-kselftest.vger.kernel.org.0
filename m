Return-Path: <linux-kselftest+bounces-7296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8689A148
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524C61F21CAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6D16FF58;
	Fri,  5 Apr 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hkg4dnxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904E16F901
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331164; cv=none; b=sTnD2kDOQekZsecY+ecVrjvkjdLBtffnEspjAnmdWuZn4xKNmKHVvpwc9jOkQMfFKLWLjLQ/+BpEQYdW7DCAGv77lII/g0vtlEdQnFNnajQXpiIxH4ppdghmeE/wPTY9YCphNDyxXgA0RvTt4EJPH4m5E0u82vxYM+sLiRjwoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331164; c=relaxed/simple;
	bh=5eqSCNEjtJXpk/6DZsrwgHXPlVatBGh6RhudIFZY20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UegV7LeGrZ0peRl5bqR1UPTKWh/sv6iRLPPRETkPteioKvr7vehLZLr85VTx0iVxz4WBaLMc0xPH0ByE4rJwcPRcfbr4YaVN5Og2P6RRQPqaURvNgIU//pz3Z+N69VXqq/o9Ngf8ufZ71HuGM7LHWEELOzpB0S/lTBFIM6qDtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hkg4dnxw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-369e3c29aedso9831725ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331162; x=1712935962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HBupVq8sRNQ0/e+zQ08oh46OVYn1TgMtv+BrDWwTbo=;
        b=Hkg4dnxwDMCrAOvN8HDCH3ljSRijHRknpzplWblGFJ2GMQw8meOFH92uNGUF4Urhh/
         IJrei5Y7kRlaWhwVatmaDvwNhhkFrr446f4x49yWMfulOu0q8Rme0RhqjitoXM9QoSU4
         kTrVFszhX5PLuaU4AVdGfsgF93skE6FSpxlMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331162; x=1712935962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HBupVq8sRNQ0/e+zQ08oh46OVYn1TgMtv+BrDWwTbo=;
        b=psfpX9sVB3GgKcZVwGnhJ+skZ+zKekyFj1jWZjonxSCALBW/Br4ewyRafD+EnPUqHs
         Z2B+HjFAfdmI38U9/q8YiEoMcal2cPEyD1thHus1S/ToxiO3uTeZ+1kflMR/yT8XGZVI
         qpruEur8IwfA3vtL+//0N9RCBHPZCyqixjdTtq9yuijhyIxXRRBYtf6okklmRUYXmOl5
         jiMvRMT4/CEQA9lX8PtH+DpIZtse15Ohf0A+nQji07snuvuIfpxfgetBKYe/IKtUc9MJ
         5DoZd1dOR2FuXOpT0ExoqmV8gPL9ckhtueUNVysv/WLqDNB6zm4QPK0eiY/wG9EB/jGC
         0ZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtfTdMzleAHdbScsV1P7MZZzNJLwCoB+oqhsNWz2/EGF62hgtzH2/PdmyKExacFtx7FfsHOENiZygDFDTblegfcDUW/ABKXkrmC9+MKZDE
X-Gm-Message-State: AOJu0Yzdmbk8PwCS17z+/eVhxs8XVroSX0WoRoY2Cv7BE2/oej5HTUuD
	mJdfqH8d+1tSUwAiSOnaYFgP9bvR2U36oTxAVBP1UhWpRDU3mgJhdT2tq/NY2A==
X-Google-Smtp-Source: AGHT+IFAyS5NJbvUgCystqIUFG6PUixCvpV/gat4hk1z7KjiiUWgsTIr7EJgMOjn894eip4sM3zwUw==
X-Received: by 2002:a05:6e02:1d0e:b0:366:89b9:565c with SMTP id i14-20020a056e021d0e00b0036689b9565cmr2174618ila.15.1712331154523;
        Fri, 05 Apr 2024 08:32:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020a631205000000b005cf450e91d2sm1274954pgl.52.2024.04.05.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:33 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] selftests: Replace "Bail out" with "Error"
Message-ID: <202404050832.35AE5A95@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <20240405131748.1582646-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405131748.1582646-2-usama.anjum@collabora.com>

On Fri, Apr 05, 2024 at 06:17:47PM +0500, Muhammad Usama Anjum wrote:
> "Bail out! " is not descriptive. It rather should be: "Failed: " and
> then that added prefix doesn't need to be added everywhere. Usually in
> the logs, we are searching for "Failed" or "Error" instead of "Bail
> out".
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

