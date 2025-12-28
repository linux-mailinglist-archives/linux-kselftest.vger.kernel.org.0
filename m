Return-Path: <linux-kselftest+bounces-47979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A154ECE4959
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 06:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148B2300D42D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C8259CAF;
	Sun, 28 Dec 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbfKqeV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D13257824
	for <linux-kselftest@vger.kernel.org>; Sun, 28 Dec 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766900911; cv=none; b=Oo6x7/qzal1ndKOXrpmKMIq3BEarV7L1F1bVTtQlLN/jxQUpf8D/otcTlvg6k+XfBgXLfgefmYbg+XCpXq6ZiroFPmsOTT1Lrrw2y7IpIqenC5xGUVmp56GqvJgFMzXOobvFIQFgQ3/HjdkwgA3Uj1vMf6ZnxFAlVFXdoYDiQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766900911; c=relaxed/simple;
	bh=1pJCobo7skl3IqJjut1/aoDj5JGv6MK8u9FvD8pNb2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv3y8S+zKS/iC8FLYwR+JkUK+XRX2YyvClE7hq7WD/pVlDpEx7hj9R7pOwHkvyQFrsR9ZclzHhxzUxMU61iDoKlFoaAnbbA+AW0copBAkFOTs/5drCX7uh13cttncv3JVr+rqw5CqI9p5pT1c5I7Ei22cWM5bobmV7LxPlog6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbfKqeV1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59584301f0cso8687218e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 21:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766900908; x=1767505708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpbqpIsug6MH33BRSdVEMnAsF4zSM1dpRpn6fI+y1V8=;
        b=JbfKqeV1R/D9PDEPPrpO1wYpIfzCnjYN8WzGCDsrD7n0KnJV0u3PDx7jcRD+sYwnIA
         eVLB3CpQB849HOmn+7qyvDAGHdjogV/RbhTM5RC3nhmHCZ0TyW6xK3JNdZNaqYQmvrUg
         cdF2N3n6AHfVPNdJ1ryI3wA2QGNWbPVUL4Yf3rtoYhAqO0T+o3WymyughkijcxLCR87V
         +fnF79OAU7EfREe3nNHWZEso4Y17g0IgnlTErD8PjLZJPzIMAvaP5vrtBPD9WVBks/2a
         8UcdzNEASY5xEWPA2yfKwUq+h/WI08DI0xTyf9s2SAxgEpPfJCz/aEfymR47u8T5Gj3+
         bs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766900908; x=1767505708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpbqpIsug6MH33BRSdVEMnAsF4zSM1dpRpn6fI+y1V8=;
        b=JT/Df2Y2BgDAWKVsB72t9kmvvo5/QGKOIdpW00UHTfAG/KPrCCLHuV+7XSqJGYMfwy
         PeUalIRZlMGh2+G7qTuZQGqEyYSxKpOCWwv7mUa44KNpsk31vn2NzA/epHDIAYhWN6LU
         aVnAZZZUL+d2YLzwUi10qE/SSpOavshcn3kLNV3uHTi24DX6PUmGThJ5C6OmhbFhm2wa
         JzFs1BKoD9qowv8XJbZACbXi1BvP2aUSHt9bOm2FqLOzOLq9sWGV62pQiUyM0/R//wDg
         BiM1JWhG7wGLO0x6viyxM45ysU+opPvgMQo8i/JjIbrgjsM0wk/7S61Nr9QMOGcbneL1
         XNCw==
X-Forwarded-Encrypted: i=1; AJvYcCX19/uIDIJ3JCZ1bKyJSIfNiVlmGgNT7QMUaKwsZBFbkljLWoMOmM4KsOeqAOAdJNqeqhubEMdRXXPm2vZ1hmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmCn2Cmr7QSvZmEbYMfXcJeoOxiqO84fySrBhrcSuIn5+E3EC
	LbFPpUalSuzpFHXQJy1h3p/ZB1ZOTUfgd1dn7C9GUrtV+G8LJDvENWlV
X-Gm-Gg: AY/fxX7ykjPqGfd7LbKpzKOpBTCLufetliPUPXdMRQCwq8kAD0R6DnusRqX+V0OqvtT
	zZrWY9SMPu0iVHRC6+1lhVyg2tcpCntvcSWNwtt9dRWyhSszTdVL5c3hiVSBJqEvETGukbgs+D4
	yPItadD5NUZpqpT6gcsKQDVksmR+jkHSF7FQlGq3yqCFfAr7iEFpQIlSObtujxxv3WkYuwj6PCp
	tVEreHryYU1ffqyc14RlI53YGKvafJEk2ew9VJe1OznDM05oMVFdAqAEAK6zgMb4/kvWYWl7ByR
	ql7OyWVWhh8Q9H0XXsXxC7OIM6sNE918sZJ6Gy6iyHEYQ28713IwQPZNGlLgzwx5bvB5bb8z63Y
	nhHWEoY/fzHFD0GRH6bhLqk9JXtHxqGs/C8tgSRO0G7mQETNaxeuz8yMEn6DdNnR8ojGR37zubD
	wek+zjlMqOjy1tT2/17mM=
X-Google-Smtp-Source: AGHT+IHbwDkZ0ZrkYZSKb3xcvqlBhmZdaEoQdezjtjNsk1jz3+5apfKEePyLYdpuFJXN8OT07eFG0Q==
X-Received: by 2002:a05:6512:3b9f:b0:595:7cb9:8e51 with SMTP id 2adb3069b0e04-59a17d1fa1dmr9400930e87.12.1766900907593;
        Sat, 27 Dec 2025 21:48:27 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185d5ee4sm8077427e87.17.2025.12.27.21.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 21:48:27 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: nfraprado@collabora.com
Cc: Tim.Bird@sony.com,
	bhelgaas@google.com,
	dan.carpenter@linaro.org,
	davidgow@google.com,
	devicetree@vger.kernel.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	shuah@kernel.org
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS 13 9300
Date: Sun, 28 Dec 2025 08:47:42 +0300
Message-ID: <20251228054804.2515185-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
References: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"Nícolas F. R. A. Prado" <nfraprado@collabora.com>:
> Add a sample board file describing the file's format and with the list
> of devices expected to be probed on the XPS 13 9300 machine as an
> example x86 platform.

And now "Dell Inc.,XPS 13 9300.yaml" became the only file in the repository,
which has space in its name:

$ find . -name '* *'
./tools/testing/selftests/devices/probe/boards/Dell Inc.,XPS 13 9300.yaml

I kindly ask you to rename file. New name should not contain space or comma
in it.

The file name in its current form breaks tools. For example, it breaks
"xargs".

For example, the following will work in "fs" directory:

stable/fs$ find . | xargs chmod -w

But it will not work in root of source tree because of this
"Dell Inc.,XPS 13 9300.yaml" file:

stable$ find . | xargs chmod -w
chmod: cannot access './tools/testing/selftests/devices/probe/boards/Dell': No such file or directory
chmod: cannot access 'Inc.,XPS': No such file or directory
chmod: cannot access '13': No such file or directory
chmod: cannot access '9300.yaml': No such file or directory

-- 
Askar Safin

