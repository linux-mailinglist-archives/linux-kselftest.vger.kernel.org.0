Return-Path: <linux-kselftest+bounces-28327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C7A50992
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877CF167916
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D4254B1F;
	Wed,  5 Mar 2025 18:18:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B276254B1D;
	Wed,  5 Mar 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198701; cv=none; b=tSEstaZT4VUs4izurGV505y7wQp5QN3+hEbopIUPAkQjWaDzBwfXdoWJ86fVcDG6kWqQCWJPF8CIZP0X6yWwxdebo5Ffo56fRuJ2FA9MWnRpOPxMUSHUXe7FYGBrkXuPH15Be295JzZtRsw/za3W9q2KeOShP7phQ6TDNDARnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198701; c=relaxed/simple;
	bh=EWdQOzeZgi3xp35UvvieHdisZ+11dmjgdry1cvXgaMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWjaKJuRVRkbAPL4aAXG9S3Esl3KZJ7BFImafekbYINxCb+Ljpmd5BsXV4/9IVTqWMPxC6YOzHvQmif1X1GJy7L55JjPigejrjxzMQRbOAM9aPO6LiabPGuL1MZzU19+BVukrwBoSTFtz4mH9KrVFkzoE6WHtHZ+pmvCoGsAsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso1877024a91.2;
        Wed, 05 Mar 2025 10:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198697; x=1741803497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU0gezNi8JooThAkifKKSc9m4PKD6Ev2EtHJr2dcBO4=;
        b=abHIa7eq1WKzKzmWsBzwqoZSQpp+wmgmeeAHB6DFaZjrkhUvM6U5lEYl0OHvoM3ihq
         SXo1uqCGdmiEOsY8GQn0eximRh9BnOnvZ5BZZA0Tv5ek7UVLP/f12GJLipEiwiU4U+qj
         Grpz48QSorGcud89YMQ1aY7uVs2n+4ShQoWsJNSRsYqCROdAMWyM9K41uCIzKzy5QIUI
         myBDD5xZJAUoYO7OwNi8s3HBDtE3ik4ZrQvnpdY7bjM52r9Vla46hjs6pZmG7Ibdt0Dt
         ofJ3MDerApH3RQy/+qxKClja1E81MioRI+hPh1Qq9Zh1F48TiVI3f8iShfYkmc/62W9Q
         oCFw==
X-Forwarded-Encrypted: i=1; AJvYcCWfj/W1KiWG8loy/dxcEv8fDWCdqDu45PjjqOWC3wKl8JhhnoYlKi3MBE27eQcRbDx93KIWQ8jCeNNeA2o=@vger.kernel.org, AJvYcCXdf+QrrOzqv5BpZfvDSN1pYzJ10dn9UgTi/jkp08QVEUZggL6lrmp2+iQ4RDx1YnMC7crypq+qHCaN@vger.kernel.org, AJvYcCXnlljg5bgwSiALbiVevyYoD9bjNh9B/YuqkfCXqCyO96nOflxvy6bS4uDazhXYug8dIK7Ujn7J48EtOxUHQSxI@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCZu4xBQD9UI/A1Krb3htgBrhEVqKx9PplG5GYk7TJ8Kr8fO6
	ONSEFx/VbvSUgVzreLgoxRuoMaacAN9aoq/0Uc37/7YM7YGYeJV/
X-Gm-Gg: ASbGncu2WchSv1k9mJyjjP8EPovHxUO4tbic1KPY44mskPy+86AFqW1CT7Tg7MkWriN
	NLKJitIM01UNSX4oe0IL9kgODuAsBLOLecCAM5IdHVa33jHJHZ8VFt1IOOYl5yRHwWlZd+Bx5IV
	dxSW86vrMwy8Lejq8hocHChfdP0fni+dHG4t2yH5CH6iBfYwh1Z+4ahViugqVS2O52hG1JUp4Ax
	Z5FPOODRkswKlYopCCCOT+AEHAwEeTFWd5ZfYDAa2AdQbT3bvROhr+TztmhnCWYG+RLhJMMHq0J
	McuiEgb+EnGss6eNMcBGRXWILWPAZvxI65vipamVntUIv3Gb82FrcgaSo3Zn0PSMDIzss5CcTgI
	EQWU=
X-Google-Smtp-Source: AGHT+IGRrCWS17fzwK6j09Vlmf8hZRbR86lJZycgdKn2UXwWbfdu3akGWw5/qyeC5oYcJBVlPmslcA==
X-Received: by 2002:a05:6a21:6b17:b0:1f3:4661:d19b with SMTP id adf61e73a8af0-1f349594984mr8673716637.30.1741198697523;
        Wed, 05 Mar 2025 10:18:17 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7de37c13sm10435334a12.34.2025.03.05.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:18:17 -0800 (PST)
Date: Thu, 6 Mar 2025 03:18:15 +0900
From: Krzysztof Wilczynski <kw@linux.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Fix some issues related to an interrupt type in
 pci_endpoint_test
Message-ID: <20250305181815.GJ847772@rocinante>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>

Hello,

> This series solves some issues about global "irq_type" that is used for
> indicating the current type for users.
> 
> In addition, avoid an unexpected warning that occur due to interrupts
> remaining after displaying an error caused by devm_request_irq().
> 
> Patch 1 includes adding GET_IRQTYPE test (check for failure).
> Patch 2-4 include fixes for stable kernels that have global "irq_type".
> Patch 5-6 include improvements for the latest.

Applied to misc, thank you!

	Krzysztof

