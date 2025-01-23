Return-Path: <linux-kselftest+bounces-25014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6614A1A5F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567287A4BA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7702211495;
	Thu, 23 Jan 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wsTPFG0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687920FA99
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643591; cv=none; b=lDV67+8HeGKq7ineRTzTAMA4TMveiFQomVGRFrzhOJjUP2LzAAN/8sLkz3vX+h4sZo4wlZ/Kjqb8+Q8cq3mUB6CsaUPy8t8eMvLNIb5Y/j2UGCsyd2Fl8dujvjbLZevsHwOl8d9P/fXvL0oLQoOqDhwhxItyf+bGsZ6n1NHduh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643591; c=relaxed/simple;
	bh=ZSXcYW7RW1lm0Y5aBlQdpdnEzWwcYwnyMHayjpCNWzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irDgQny3qqad743ja3z6UnvkCQpHO8tQ536SZeW7akhidS4IQ6MDszUf67AefyYrlRIcElduvVPW/EGrKw6/qWqNAXAqNknWn403JVSkDuSssGcP6xH9U9F+Ra20gwlwSqFDHhqU/KFJm/rd0X6G9+QQB+yWWvM+LlaDv+W1gQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wsTPFG0o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4368a293339so11469535e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 06:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1737643588; x=1738248388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE9njkO5rlhGWyfm/wwoDDQos0GMgUfQpTo3o3WC4dE=;
        b=wsTPFG0oew1+KwU/0S6hYo7ggOKWl+yR8ElHOQ2+drr3jP5v+9utno8JlWOgmPM8y0
         NQgy+0K8IL6hTnI0I+VDt7Fwy5+Ii4Omovk2bLatPNeZaYG/cSxVbi1zXJprIXZPPe1s
         Vs2Dj/JEKnpeqxRLKsmxexQ6T1kZni/TKgzXT4fl26g7476e7tiPLjmletwQS3efWCnp
         O3kO/nd6/dWFTx8M+Eg3gqYf9CgpsVPWuU+QmS7sWgkVS3qrDgenf8M/Y/GKAVX0veyT
         e0Kcx0a5LioQz5T7Ozgps60E0As8B5C8KzbiOPBuhO6VE1KSmgOEE81cQPDnFJsmfKWh
         /54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737643588; x=1738248388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE9njkO5rlhGWyfm/wwoDDQos0GMgUfQpTo3o3WC4dE=;
        b=KRNaOpGc6vu/tSzDtBVs0gErhwJ+iG2q6ApEo+YVub3Wg+SkK3XXI6ihJesVz0Eost
         JoOYqjZgJ1RnnXmJBObxFROKb3icuvfq3waH0lDoHdvK6VIEN29/a/aW+xVUaz14JcJf
         Yptin3PYWujy3vI26rTjhfeaIOjSyMzijnlbuEViyoanfFWqe3R8XG6RO3UAVVTGdI5p
         pjbOthZOOoVjtHclBKoz+p8ipq+y5iFY8pFsW0k0+VsnRoMXjy6jeEBObSA5l6THWQXu
         kkGIJBxagis6hKKBKjQ824n10sfRv2XH9poyQ/IMPqsQ4C8IsK+X+a4LK7aP8iFhyv8z
         hgAA==
X-Gm-Message-State: AOJu0YwjJsxinMPCECfyhuy0R8yA1VFOcHsK0cWh46da2e5fliLGTo/t
	7FMYTIW4TmZd23RtFzH1Nm2vbbXwa+Y1mK/uN99mGn/1rWrAcvxVSKruKQu0dUgyPZQaKmPQl3E
	6Qqs=
X-Gm-Gg: ASbGncusH+EPCm1YYW/j2JeuEYjj7K6HOIE2YZOBJLELIP4J2Wj4bfb7E9g2YHZa0Sa
	/insy5LNkpLC9ow9YPuPPl17Kj+37PjLKgF1shOPJO7iWug5uAHpGESmBK+zG3FH7tPpzW+2ENr
	7L3J7iDgrNPkf7YvEG4yJqaDxJJnDZUKMZc17S/pr+zwCkp+xZU2J4aWdlOUv9mWKRLxHEubBr/
	YVYavfLWPmvHzPJECr770LREgMM+OxzjoYYLdGIZ+3gebNE9cBuGwq1Th0G0Wj/LcB5P4oV/fot
	j7Si
X-Google-Smtp-Source: AGHT+IHSbJRP89PUvqCfe6XVziReSXL1TAuXKxVQkpUrbJ+a9b++AdJiYrNdmEQf29DsriG4tW3pUg==
X-Received: by 2002:a5d:6da3:0:b0:38a:4b8b:1ba with SMTP id ffacd0b85a97d-38bf5662598mr27554504f8f.14.1737643587792;
        Thu, 23 Jan 2025 06:46:27 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ad40:de3b:e658:a016])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327df12sm19671794f8f.92.2025.01.23.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:46:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kselftest@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Koichiro Den <koichiro.den@canonical.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	bamv2005@gmail.com,
	shuah@kernel.org,
	brgl@bgdev.pl,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: gpio: gpio-sim: Fix missing chip disablements
Date: Thu, 23 Jan 2025 15:46:25 +0100
Message-ID: <173764358055.127143.13169466880971669873.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122043309.304621-1-koichiro.den@canonical.com>
References: <20250122043309.304621-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 22 Jan 2025 13:33:09 +0900, Koichiro Den wrote:
> Since upstream commit 8bd76b3d3f3a ("gpio: sim: lock up configfs that an
> instantiated device depends on"), rmdir for an active virtual devices
> been prohibited.
> 
> Update gpio-sim selftest to align with the change.
> 
> 
> [...]

Applied, thanks!

[1/1] selftests: gpio: gpio-sim: Fix missing chip disablements
      commit: f8524ac33cd452aef5384504b3264db6039a455e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

