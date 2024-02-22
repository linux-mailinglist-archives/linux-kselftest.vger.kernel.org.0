Return-Path: <linux-kselftest+bounces-5266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB385F292
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DCA1F21D02
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407FD20310;
	Thu, 22 Feb 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNYATvmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BA1B7E7;
	Thu, 22 Feb 2024 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589593; cv=none; b=fkvRnd+DvmmYSnYmB2z1w/S32QZ3bBAGrwK9oLl2jefxMSPxCzdC3wtkRVj5e1fyNXZLcb0LRfA62WuWS7OB53BJ1viC+nh4vNBxqYk0wZZy0dvFk1iZUMzEMutqQBqVPNTh6oW4ypwklT/Z+v7Kk/vZnXGHerZ+WzuE4jFBjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589593; c=relaxed/simple;
	bh=KnY6kaip9BM7FrJjonxxh3mpPi8qcS0JyCecKgQh/gU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=Wmkp4KtBlvX8dsWopyUUHHJutqCmfDDyELQeDY3czeM0q+coOXlGcS7nmlOXN3LKm3B2cX0x6VwGSQCcjxeN52zqz3w3guFtTL2Md7YijXBEKvesKX4fLYx8vDCCROph2poSisPPPKT1USQfJDYPikMJDFoztr9JJAZI3VcUReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNYATvmC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e471f5f1a5so2434718b3a.1;
        Thu, 22 Feb 2024 00:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708589579; x=1709194379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnY6kaip9BM7FrJjonxxh3mpPi8qcS0JyCecKgQh/gU=;
        b=hNYATvmCV1PJrT0H9TlzrzrATukWMhUEIP7sZfKtCt9VNGfqLYaS0VA5zowY7oxEAW
         EnFXCd4S6BPFnIOBV2YpHvCy/IXEDdH2LrggyPCf9TZnowMHwoGNfnVOlilbT7OShmUC
         2vOuowXBJuTEK9xEHNWf7DD6Lxkrha3qUadcHQpQadU701ra4n7sgBfIH+lkUfU2A8fY
         b9j5IppSsxoO/lQDFsmT4+sRzQTvWyJiEkjwmc23M+40q6DJU0oYChWdOA+HiE90AghV
         QVNwbv5oHoUmDFEsbUV7SCk6Oc79FqKNETt241XISzEIPtdCfem/fJcJrvnHeRD4IRcY
         /g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589579; x=1709194379;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnY6kaip9BM7FrJjonxxh3mpPi8qcS0JyCecKgQh/gU=;
        b=CWpsR73qeguqpTj7TFKZDTnbMPtDQTLf22JX73oKl4yP0OCfxXOaMDuEQa/f4MV5Hz
         2HDjt+St0VNV8m/WkeQMF7bYRMZvFqvuc7xntf0eJ3/jRmsMiDRhaV69eOmOWzAYY5Yk
         QLUFKuDdSvYTFD4NL1BIGAlAIqtYk8wYYlDORFJ9NqKEIN1ltil+KR5Js8rmaMOZZHI5
         oFPB1zFIxvFane+OSTxq9tUjGrFyTsa40WDIrxw2DLpf6L3rsWT2WYl+AMvsl8OKiniE
         J40S/4dQ5qLlzIrqRpcjiWD17IfhysB4bduufO2QePmP+o+ctbCbVyJL6vnC7pP3aQmU
         72Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVrDh8FKJW9Wbc7xOjIh+8fOOBNcvQA2kv4MGW76h5lNZwly7k+d/XSJ2dkqTfhiSnUTOUXv3jULBfQTphBTmveALAY48c+yW/nfcZ4dZYEuWJN0MCF/TT1zKuCL1hGr5gEgoHS5A1M+wJELSJQPu9FMGqJLYrHJot2WQBeAduzc2I+eWw0W7UKQJebrA==
X-Gm-Message-State: AOJu0YyFlmlcJk4HUU2IrCNz47ppekeNAq3AD03AW8zD4gO4yZkKkQY6
	xFiIFKzoYYFPxiju8FeKhUXGGtpecNB12WYvL5oZwftxEhK5c6XD
X-Google-Smtp-Source: AGHT+IGgPrGvMG2ZkFBWVBhR0i51muQpwt/Ba+RuSmY+zYMXUKvg0MxHxIJRPZq8F9TAPfuvNzctaA==
X-Received: by 2002:a05:6a00:6815:b0:6e3:cc8e:bb40 with SMTP id hq21-20020a056a00681500b006e3cc8ebb40mr10231403pfb.5.1708589578839;
        Thu, 22 Feb 2024 00:12:58 -0800 (PST)
Received: from [127.0.0.1] ([106.221.232.11])
        by smtp.gmail.com with ESMTPSA id w20-20020a056a0014d400b006e471c54861sm6161032pfu.210.2024.02.22.00.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:12:58 -0800 (PST)
Date: Thu, 22 Feb 2024 13:42:44 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: nstange@suse.de
Cc: jikos@kernel.org, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
	pmladek@suse.com, shresthprasad7@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org, zhangwarden@gmail.com
Message-ID: <1da6e25f-3f1e-4acc-8256-53fbbdc29e78@gmail.com>
In-Reply-To: <878r3eyoku.fsf@>
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <1da6e25f-3f1e-4acc-8256-53fbbdc29e78@gmail.com>

>Is the declaration of klp_get_state() visible at that >point, i.e. is
>there perhaps any warning about missing >declarations above that?
>
>Otherwise C rules would default to assume an 'int' >return type.

I wasn't aware it works like that. You're right I do see some warnings about implicit function declarations of klp_get_state.

Regards,
Shresth

