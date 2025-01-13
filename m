Return-Path: <linux-kselftest+bounces-24413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B41A0C51F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 00:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56373A798D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871D1F9ECE;
	Mon, 13 Jan 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGN55zD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368401CACF6
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809603; cv=none; b=Ahz8WozQRwg9ehfDHPQnUvS+jIQRBHXPll206B6U8Y/MzNXcQ6LNJZHWpAilwL9Zd0EcB6PUc6NoF9xtWtrxWPVic34jenajt5FfuCxh3mZLeYNxOTfrk+y08GLKQKibgezXg4zrjw3dEyVzKiY6Lw3j2McD+VzCUPSPr8WZAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809603; c=relaxed/simple;
	bh=FY3CAUHnUAGPlAvnTqBwytKqjfIe0H96ZK2+kvt3Gpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNgbD+hANurzUoZztFk86rVye81tzxu43qQRtIhv2FSk0Xq0F1pxa9SAp6kPdWhmcke0ftms/Kfj+tOgKj/O8i5uoiV67Nnwfu3OxuisjATmoIQhYGI8TipK4l4O0zlAowiFNM3LATjHaVO3ypIIZsP1E1osiCP7CYd1sePavxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGN55zD+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e6d1283aso190304239f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736809600; x=1737414400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t98L05cLqoN9QlNAdFWwtAB2uSyAKNpsq0R3tlTJnx4=;
        b=fGN55zD+QPKLTIC1ERc58hM9umFVkrs3t9SSVj3jKPYQaee3iswV/0spT0NsKCUget
         JEyaj3elRNTisN9FN7FtU5LE4NLRwVksQ6Iqm7IzCO96TvYeJpyB84YBTzrg3KQtZIFP
         uHobzoMZG9AS9FwjzAsqrxgm2ABSeadHkVotc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736809600; x=1737414400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t98L05cLqoN9QlNAdFWwtAB2uSyAKNpsq0R3tlTJnx4=;
        b=q6Jjv+M9ApO1RIj3IBirrDw2plFeSelpevNeK3GQ4nPM+NIYiWbPzc622aeiDWbIFw
         XWu4Amy6C3IL33akVZpvF9DWqGPEi5FpgFYtLept7tTPIywYqYWejevldCdXDEKP7of/
         mK0GAXxCdlHztGipYVFnI3mRyMzLaNxtwAYSuxFQkTBC0q0vQQZc+N4xlMs2MUBdedgB
         fTRXZ/Qz6cXB/qJ3lwmJLVdDafEDtcvWm0/C0yNmUfwUaLBNUbFQrHM29fYFUj1ZBrdM
         QjUpSjsjVWmDTu1aMihn/NEkPrQHD/3KMaXe3V6OB1+UAVjKZ9eOTnXobbFwQYaNipix
         VzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSFqXrDDBffQYU2tEMXwJ8fGfnvZiUCUrfO6D5r4l0iN6IM83wCLoCWjhhAFu0xFrUO/nw4ETS4B6vUi/689Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuCZHoSgIeav4Vpb7wqH5ysllOshnk4faGZd0Mp8NwZdyXXER
	NLX8NpCsy0zmp1BVzbfMyzyDiiM53oDxWmfvqeW8HWecNp5VCBQLVRnR0sn74Mc=
X-Gm-Gg: ASbGncuJGDjJkDSwtJdPc0AFyZVG0bBGbn5HvhtjosQ8ahe9hTZPgyqNVj7nhpcP7up
	O1AVdRGahVjCPwU8nlkNLoege/DmOIPnwSHIXKxW+dsCbPo73KEjnqCGnh+4ARoeMzJlyfPTS05
	Nay4N8jbC7n/l04O+P5+RY7vL5qAYBj8Zuwyy031yZUg+va+yOlYfT5EuFXj8hnGNUvJL0Begh0
	UtHEW/had4KBcA8ce6Jw1T8Vx8as+DtvuBQPeNwSeJt1on7N3VE2I2q+dn0tsH4T2s=
X-Google-Smtp-Source: AGHT+IH8D8/WA3nsz270K68ibq75FwpYAmp8r79kGSFWGw5muQ30GDD6Uv2Knph7vskIzmqScVtI3A==
X-Received: by 2002:a05:6e02:1a8f:b0:3cd:c260:9f55 with SMTP id e9e14a558f8ab-3ce47570cd3mr131591595ab.4.1736809600570;
        Mon, 13 Jan 2025 15:06:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b717838sm3014196173.102.2025.01.13.15.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 15:06:40 -0800 (PST)
Message-ID: <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
Date: Mon, 13 Jan 2025 16:06:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
To: Raghavendra Rao Ananta <rananta@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241210224435.15206-1-rananta@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241210224435.15206-1-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
> Currently the rseq constructor, rseq_init(), assumes that glibc always
> has the support for rseq symbols (__rseq_size for instance). However,
> glibc supports rseq from version 2.35 onwards. As a result, for the
> systems that run glibc less than 2.35, the global rseq_size remains
> initialized to -1U. When a thread then tries to register for rseq,
> get_rseq_min_alloc_size() would end up returning -1U, which is
> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
> have the support for rseq symbols.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---

Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
commit if for Fixes tag

thanks,
-- Shuah

