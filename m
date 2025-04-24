Return-Path: <linux-kselftest+bounces-31613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83589A9BB14
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DD77AB4B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3228CF73;
	Thu, 24 Apr 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T9X3Dc4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928A27F74E
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536172; cv=none; b=Qnpj2MMbR6RmKX4WgoHlJbmtH+cEZHsnjxs4mzN93Q+FQMPdwiaBgQj/t+VykIFjszSQaeYT57upNcQ8EYa1jhq24m6fKujnKXpbs6L2RUxNRTWDTJFg7qq6MrEErR5meEx27vIsBd/TEakAiFmS/ExfcQ+UJmrxJOfsbFyUCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536172; c=relaxed/simple;
	bh=LBAj35BXtPm72neUP6fWKKhui+OAcA6lM/hlfGmwp+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BPgluVZzTZImnxU24EUUlpr8yMTm3x03StSaXUzVqBci2BwEfahNdt1bE0p0/i6MFSlrVYAUBLcNMGW2vU7DB/R5ntVzlGCzfGdErU6++p+IgPwKz7WxciC35eNJkRybXT+ilmD1VK05r4dSwZCfagQxvI40hx0rkRlqOGbRsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T9X3Dc4N; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85d9a87660fso148298639f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745536170; x=1746140970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJjb6BpJL6QKvLq7uGZb94kh5q9VZv1RBI7gdmZfS1s=;
        b=T9X3Dc4NEwuLh1xEy5ZOt9W45gZV8ejJw5cZKce6/nCy3xU+vWawF6UGjbfTIF7/8k
         eCxopddy1dqwLhxGpqZcF0g9BfMwjFOm8jDUCqYwSpGwCd7SOR7ooC6hmxM7PpXhyzcX
         m7ClQWBQoHTXIlq/K70mq/3EObJr4MoPHNcDD1BDBu+5QfIOMWsezPXof98/BcL5agxf
         jcFDBO3RDOqG9NMlcENP8655EDuAhsuycQyZCfFTQLd87HkqO5YKHXZF4Q3CuAiEFcg4
         M6o+FQKxSl3HsxlUwtLBqRRlOhxWGdTExQjuQyVbFgN5Tdxu94K1UC1GNPYMM72G69kZ
         8xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745536170; x=1746140970;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJjb6BpJL6QKvLq7uGZb94kh5q9VZv1RBI7gdmZfS1s=;
        b=RiJRtwRTNLIqp1AsIEF0tdJNCEU+YmfjqYDxmqsSS/4ZRQ5D86s0GTMlI/0s04KLHi
         iCmP8TMCwvGjVRj1cSQ7ezX2/RhatroOWqECqA+kjPmagoUi13Fg+WM3Mfdb9eK4yLU3
         XnCivGqr+5VGF1AI/w0+RAX7DrQFIOfNFtbMYeao0mz8UT0RPuOdFJhuh7PtmPn3X0XP
         w9oyx7dmNaYRD5/o1dq9MVpCkM8Ni4Dm0anKOPLivxQZeZwnWBkzb7mRxBlNjTTg+7xR
         68usx9DoHikPxNwm/AYnG0XFB/XUU694OmJdYbfl36yZNbqs8vEFEAFWVZA45H4Zl0pk
         c46g==
X-Forwarded-Encrypted: i=1; AJvYcCUFO7le+F80v/qIuTXZQgXYt6L0RI6+suHS+9F0oAi8Mr1P10+TmCrn37OQJ8nsMiTHBMDiHv/YbLnSBhJ7SOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2yTRSVqp4uZkg/GWcUJIHdq3IvGJGs6Gjh6pk33aE/BQjnwl
	D18DKBbSJxkn7Gwf0IV64xFG4U6/qGeopsiR+/x/x/36Peoll5NQF+H1Pls5miw=
X-Gm-Gg: ASbGncsz18NzsqOykShSd3jud/8YOS5M45YunGUcHYQaxPr3ucRJq+q6JWIS5GrDHFx
	o3JMqmu514LF/rHYKgxTD52HcP4Fwfw/FCnSdrE1oRJz6qatcN3IttvNF0R/7DdynaEa1ZoN8Od
	XeQcaSE9E/A8zkPoLKkkkk2RaHEpoll5r6MYfl1myWcPkVgMs0rWQfDh5XNdyfMWcUdhw/sXOA1
	8DzGiaGfM4T6r6UyiG5sgx9ryjJU9SXJsq/eXFjWCGiQuEcXJgCnJW9ocst5mWGARYcUIT3p5TF
	8ulLnjbWfu2AToSJrBC57ygY9x6On20rSlzD5jfSxaU=
X-Google-Smtp-Source: AGHT+IFN4iX9Opo/jgx0my1Sh/OktR9LAH6c9SxUf0e5vgEkErJNPR+8tLRlz2/fbrwi+twY4MhFrw==
X-Received: by 2002:a05:6e02:19c7:b0:3d4:244b:db20 with SMTP id e9e14a558f8ab-3d93b5c8413mr1280655ab.16.1745536170090;
        Thu, 24 Apr 2025 16:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824ba0ec4sm486419173.113.2025.04.24.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:09:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Haiyue Wang <haiyuewa@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, David Wei <dw@davidwei.uk>, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250419141044.10304-1-haiyuewa@163.com>
References: <20250419141044.10304-1-haiyuewa@163.com>
Subject: Re: [PATCH v1] selftests: iou-zcrx: Get the page size at runtime
Message-Id: <174553616879.1018402.4580438030053211278.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 17:09:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Sat, 19 Apr 2025 22:10:15 +0800, Haiyue Wang wrote:
> Use the API `sysconf()` to query page size at runtime, instead of using
> hard code number 4096.
> 
> And use `posix_memalign` to allocate the page size aligned momory.
> 
> 

Applied, thanks!

[1/1] selftests: iou-zcrx: Get the page size at runtime
      commit: 6f4cc653bf408ad0cc203c6ab3088b11f5da11df

Best regards,
-- 
Jens Axboe




