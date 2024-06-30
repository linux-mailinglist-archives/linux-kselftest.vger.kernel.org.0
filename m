Return-Path: <linux-kselftest+bounces-12968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18F91D0EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80E4B20D03
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69212E1E9;
	Sun, 30 Jun 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2C3xgKL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE12772A
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741197; cv=none; b=fxmB+/CgkbtV0rrPh0MC75uoYKQuLf8bBgXZ8gpEPb4Qg+GltaGNbltcuIElgTT3Tb/v7MfIeAiAew6wM2t7/sAnGldo/U+lucbJEPm2JLCa8urOThFXtE3nCaNw5aycw2DPpoc7FfcH8jyJ6kFlS33i1ZmFdZBm0pD+sl0jMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741197; c=relaxed/simple;
	bh=48tWzKXqrBuNTITJbFvFyQpBeuNJqHizCnO3J2qvL5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sX/XahQwM03h/B33JyP6buVovU5+M5CP5KYQ/baER2msxjnWlgaiRjHKW1maBpEwDAsG8AF9FkgIbpKj4osNUKZ6QMMYMvoGHSKN/T9yv/eUMnSnSySp6PoF5mhJ4HWDtBCJIMPVY9VRVzrDI/7R66Dv12c+cq5u/boS9gRhkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2C3xgKL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa901ad6f3so131575ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2024 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719741195; x=1720345995; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuqrLG/iyQEUDQZ+GHH+AA9MRCDZPgNYvRKehcIb46Y=;
        b=B2C3xgKLwDh3Cl2gZxkzhol+ojp+4TJxn37EW43RMsF8w5VDLjBY+PcZW+SNB8V91T
         FNNIz+K+E7lfmMlPAypUavlx3sEMFT3g3TH2k/kULdFjy8eBciGQPowrX+43vDCV3VGN
         GnAxCzPkoscy5l9bppTHDFCSU113/iiVBv+HWH5WXcnsaATw5jm/KlWAwEWqdwdo1kdu
         wsXd0FwuqWiAm9+9i9N6BVvk8iCBgVQmCZpDKaLfttuACkGkqwwxgQqz/CG68/2TVAvY
         f+QHCLUuBLGUkZY/k6xC5XK/jb/1nfyVgAPVM3BahW1ndMkoqTK+SyDXSewbS33ov3Xm
         0Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719741195; x=1720345995;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuqrLG/iyQEUDQZ+GHH+AA9MRCDZPgNYvRKehcIb46Y=;
        b=kur4nPtUNrL3stkE8Y2RrCo/25BhQKHOIApEZl/EM7ohnK62jP5dalnJhTS9QFBXsQ
         4G8YNQGLVdrn1mLOFxnFUAC2bQKkQVudtTcZkGN0x/28WI38DZNyBTt3xJUThaL59SZ7
         LcSm5UyavkswC2992ymO8WHl9v9aj5HVeYQ+S5Q82/csCovRRt4th7XOQ9Eqid52fH8H
         Zwl7piNnPFz90ukv/n7Jt6f0VPToYY22bBO5EOR7Z1aigPMlPJsmnHfNw7C6GLj8KG37
         9YCgk3fl80Pi7LcniGFtaD75o7J/vOCQcwAjuMp6LAv/jmfVLQudBGdc4aYK0w5gn1Tl
         wx9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5KbDdFlcGetDcmiRBEtClDF/HUn7wqC2fgybR6V23mWe2YjKLNDvA4q8jk+hPdh2ct6goQksxxoE9E7IUGRlVnKycE12q+ks+gZkDP8f1
X-Gm-Message-State: AOJu0YxVDlscVYlubyPqnFUvivnjPLh97dY/6M7373GPmNrAxIcW+hB/
	VuuHIygRdLUAJmoRqzDL22MP1EwV+i74cTHPuEPSb18q1/98DCIeGuJKbTfb2A==
X-Google-Smtp-Source: AGHT+IGh0tdaPei75Qvv/3PC2bsHbzXwLxc5ZYZMwJ/JLo/HH99KuZQ9cFRZGl4AvEJMKXkY9e+sew==
X-Received: by 2002:a17:903:25d2:b0:1f6:794c:f409 with SMTP id d9443c01a7336-1fad8ef3758mr2142825ad.23.1719741194329;
        Sun, 30 Jun 2024 02:53:14 -0700 (PDT)
Received: from [2620:0:1008:15:66f9:a021:890c:52c9] ([2620:0:1008:15:66f9:a021:890c:52c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e392asm43679945ad.78.2024.06.30.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 02:53:13 -0700 (PDT)
Date: Sun, 30 Jun 2024 02:53:13 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jiaqi Yan <jiaqiyan@google.com>
cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
    ioworker0@gmail.com, muchun.song@linux.dev, akpm@linux-foundation.org, 
    shuah@kernel.org, rdunlap@infradead.org, corbet@lwn.net, osalvador@suse.de, 
    duenwen@google.com, fvdl@google.com, ak@linux.intel.com, 
    linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/4] docs: mm: add enable_soft_offline sysctl
In-Reply-To: <20240628205958.2845610-5-jiaqiyan@google.com>
Message-ID: <ba5f7c49-c601-c28c-f37d-d2c2e147e382@google.com>
References: <20240628205958.2845610-1-jiaqiyan@google.com> <20240628205958.2845610-5-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Jun 2024, Jiaqi Yan wrote:

> Add the documentation for soft offline behaviors / costs, and what
> the new enable_soft_offline sysctl is for.
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Acked-by: David Rientjes <rientjes@google.com>

