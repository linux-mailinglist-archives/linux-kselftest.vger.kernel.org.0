Return-Path: <linux-kselftest+bounces-36597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65889AF97FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 18:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0232A3BBB52
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462202E0903;
	Fri,  4 Jul 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gygFLwC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC92DC34C
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646054; cv=none; b=h/yTDrvDxMDFxQo2Rs+fEV2DgFWss1JDWyUpL+RcJWK7XuN3lHRTREkVZX8id0xBmSpFSIac5t4SDVQ/6+Mhlm4BPAPtJ2kc2WuMMIOpk+8dSXy7+gcrLi9EgTxDmX3ald2UAySd7eTsh2HzXXjqnhyCjw6FBsZbVZ/p2ZmRehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646054; c=relaxed/simple;
	bh=Vw1axICA6lHzwM7NB5Mc0856OTH7uhitFoFBSnQMuIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdQLpm5Y/svvyn8fQKayaYezfDazOUm7V57y6Rfkakm9ALI25u0Exz3KO/rFjbQIG7Bnb6WiodV4UVDGBaLU/9/lqh5zV4ja2wawKudkoW/Np/jMpDSjG7c+tfpfMv5tLQ8szoZdgBK9J/+3mcu99azksSHrL2isiF/OUhwImyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gygFLwC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751646051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/Z64A1L91eoVM0oVYxeXCv31/CXTq/WMm33nMh52sU=;
	b=gygFLwC5TgWDRpK6G4yvk4Nxv4giJGt1Os367UfFr1X9AZXR1YZKYPYPZXs52dfN1MeF8e
	0FnQOwHpJeCQpYMMuepddFFXnnlaupidTBFejExB1DAycmVLVkNyQA7/NsE8OmsfnK6dba
	UZW/Ipl4nTV4pe6JvteYnfmzue+8AAs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-a0HCUshVOLqGTddjl7CqVQ-1; Fri, 04 Jul 2025 12:20:48 -0400
X-MC-Unique: a0HCUshVOLqGTddjl7CqVQ-1
X-Mimecast-MFC-AGG-ID: a0HCUshVOLqGTddjl7CqVQ_1751646047
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3487d422so14274756d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 09:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646047; x=1752250847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Z64A1L91eoVM0oVYxeXCv31/CXTq/WMm33nMh52sU=;
        b=Ubf1Dl5yq077OEekbOqLR5kysybuMsDs5sqcwTMRRamYH43uAvm6Vvv499MLhs1XWm
         ZqpE4Bw3wXCMnfayGRP0x5Aa/miCHn/s6BQUDJ1+bMEBDVi6DmITKYdnlWod1TvaV+R/
         C5XXFTPN0xldNF5iPAjEf32FhUUPyVJbiRu2pOpbyHn3Q86/jXVaGhD7umTMolZJKm1E
         D9IpDSI9CFbGjQDVK5VtQvV3xTUjSR7zfeow7+gzeYROsgOtMMWOlYOfDMTyT2UY+T4/
         j1adGbfnyd5JPHQp5uflW9S5ohZH9hPoBd3lGfLMOKT8kU60Ujniw+MEpwABHAf1WI6K
         CVvg==
X-Forwarded-Encrypted: i=1; AJvYcCW6t2b7qtSXBgKXI4GjYvKxP5YdpWPTM0NG3tyyrbd4ZZFx5+CJyujGpz6zlXRAfbyU1zPL+mz2jK9pJviJbJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlLCFHHWfbPWFUqPQJKv2ZbkZKlyTlAAfTwHE9X17ishar2my
	jO6cKc1cmpDM0MG5LR2c4rVhKQCbAY3bNiuWB1onJeAVmsXaJKXd1CZvjSnBDfmCQrooBRmBLDw
	soQGBDdSaqkcfKUuZeT+9iqGXjOZaFWlBagGId54nDRrrH9hAD7JDYh8++fYsGpK0IQXT9g==
X-Gm-Gg: ASbGncvwDdSOHtFgDsjIxcTNEUq5JM/+qoqrmpzMVMitZrhsONheLFxrQ38Xql7NXBP
	YZrco2ljFo/lmZEZa8MfvbukqobPIISS0kPn6oWO4Ojc2DxLB/PeEy4QU7evVw8cizWmLS7vx9C
	Ohdnp5D5C9ziS0l+tH0BV2c+8T1WVTAlYm9vrzWInL3xtfwkGcbSKgcbvbi1MLlBO3q5poyS3q0
	XIYZTqXQejkIMWrwsMQaflHQjeYYDhmu3xTAeARE/WAYWmYopIMVbOPWDTvT6Natb6ilnYLpmGJ
	Rar1jfwmC0Zkmw==
X-Received: by 2002:ad4:574e:0:b0:6f5:106a:270e with SMTP id 6a1803df08f44-702c8cd9c14mr31160156d6.44.1751646047395;
        Fri, 04 Jul 2025 09:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QKwHLNjLHITPK4hmbCxjyMhaRZnObLUF7+e4ri5Ww0N5q0etFpJdEt757O7D8qHEJZMJGA==
X-Received: by 2002:ad4:574e:0:b0:6f5:106a:270e with SMTP id 6a1803df08f44-702c8cd9c14mr31159896d6.44.1751646047084;
        Fri, 04 Jul 2025 09:20:47 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb3186sm166607085a.109.2025.07.04.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:20:46 -0700 (PDT)
Date: Fri, 4 Jul 2025 12:20:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, jackmanb@google.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aGf_W_ZgIf63dmAz@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250702152057.4067-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702152057.4067-1-ujwal.kundur@gmail.com>

On Wed, Jul 02, 2025 at 08:50:57PM +0530, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.
> 
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>

It runs all fine here now.  I didn't check line-by-line, but I keep
thinking this is in general good.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


