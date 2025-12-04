Return-Path: <linux-kselftest+bounces-46972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10ECA2532
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 05:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 571BC300503D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 04:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259E2853F1;
	Thu,  4 Dec 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN8zRAcM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E61A9F8C
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823186; cv=none; b=Ns1BLLrf9/YfwKfKUU/HJYGT2vN86jl8cVrSULSLIZ4pBq1G/nAH95wWzMAQ4mwh7G2J/OBh1E+q7KQQgoxrlbKE+Qvc7E2lbRlHKaBCSmfO7EzID5Ur8Y6qlyavT6bJvFyRNZKhO/fPpshZUA3owRLdhyzEjtJyaGa8n6Ndu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823186; c=relaxed/simple;
	bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMdc1hv6PdBsy4L5DcrD6UG/yWjRIhWCrvgyJEudsERg5FYKRL1UGQv0dlQgfTkCnygAqR0BXxp/MV92hjFM7Y666mzLxXwcL4JDqAFPtY0uAcSelkEeqzuafpZT2tqw2UOuUD6qQNC/yQjp7Oz6mvvZraBF325P/uJt7RAdaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN8zRAcM; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640d8b78608so369813d50.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764823184; x=1765427984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=LN8zRAcM6ZWMijDqaTN14taBIPCf1WTSVN1h/+zQRsBpt0JL+HSLRnE/8L2pm7JP6G
         HD9TC0Y/zoHNYLEeBvCJHuRkWSikOSeDPLo77egmdohX0hhF97DyoWtt6gA1xZJkowv0
         /TMPxCMev9PaduTtV6gow1Tpi+z3osZgRmZ2UqZqjPCi65JErICpNHW3Ys1Q1szFMS9Z
         HbIq7QCqw0GB9EnYRACRHp7KFa0YqOjZ89Hv/g0D27wS3lN9T++2W1giRryk9DIC4yYA
         W93s4T+cZ1FA2UUt4FPMCvi26Ik7JaLek0HQEFUhJqRgL7mckEFtN7WSBcDrO79J+jOg
         c/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764823184; x=1765427984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=ieGwt1M219WqCozWMfexQyKF4McZGFrznJs3z91xZ6xmd3mt20ik4SkfQUSRwAktfh
         ut6hkFcQwwlS9hl6wbAWAhYqz0bVbKHidMpE42vyRHhs4+Z2eKvAQ7gHDyV6H4XfbFqH
         PY2uo6JeChmYvmAh8F7DdhO/JPJkBLrsyGO3X7oEg/2PJcATmcsx2P52RMw4lVjQwaVH
         zdc2JNTEYqkVMS+Rl4/mUCY2NY0x31eAgvnRDpYEGZEQgc34BpeolWaqainmhbsopLHa
         yxTt4lRgoatl1GA984gSubo63NuuHOZvNvmz4aRHSLveY+T0jJIbe/ytdYBwdlFjNdHB
         jlGg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3EvEtRZ04akJL+HpOI7fuPmJ5atpm76aBpb4Zf/aCFPi/pxKnF2xAzd1Hrgs1c0TX7ZQ8Kl1EGbj3Df58Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6NAHMvYeTHVAoi8jTLFOweM+30EyJui7m9/M/E8TbOBHPGGk
	5KhP0u5p4i2YHahgaF84hbOJHdpqu2YnonvItDWcNhoxuD5fGYVpGDly
X-Gm-Gg: ASbGncsYANn3G7Rnx7VCN/JAWXLFHOHGTZxo7DH7R9yb0w1t/Z/+NEeOu0yg2VnYLxE
	XXmVl8np0r2Xq5BtB5CpNRCKTZIlcGZ1xUoe8K+YY945bO6rltnTpV0wj2ah2OU3eCflZ09lC4I
	12+vDWpeZJJRkXhQwlcMpGwJKMWE52ZEn5ykb6NSA1Jur0DkNibRMAiXgl+nsquX8O5DlH0vzUY
	vYaLuHPFa9WcENoe5T+//RQy/irKIGdL5LShq/Fcwod3XFd9lkaFaXMzD1OZjzwIL800e787awY
	u98rHkYM9MZ6LTPlimahtU2+aA0Z5X0HwMkHz3tmLa2/LHk59NKYTcXCAhad6yFzIKSDfETPXkC
	Y2acEcFtX7r1IZtAu9QVzBigbwiHv3e0K1tL7vkcvVDvAksxPjUVG6+7UxrYhow0wlLHnEWLSIM
	nBIdlKYzDmaklnNPYR7c3LVcQhV+ILley97KTxobPfgLXUUMIUqQY=
X-Google-Smtp-Source: AGHT+IH+6A/k1eBrqPWGoOLVGIDgsAJpEnT7ttLjvCmZkGA+Win1vr4rqv9Mub3s+PQhK4zSBz7kWA==
X-Received: by 2002:a05:690e:128e:b0:63e:350c:aea4 with SMTP id 956f58d0204a3-64436fe779fmr3579945d50.32.1764823183787;
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm246719d50.16.2025.12.03.20.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: mattbobrowski@google.com,
	alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:39:14 +0800
Message-ID: <20251204043914.7580-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aTARqrMyC36CXa_L@google.com>
References: <aTARqrMyC36CXa_L@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt and Alexei,

Thanks for the feedback.

I have updated the test to use fallocate instead, which is in the allowlist of the d_path helper. I also minimized the test case while retaining the ability to reproduce the issue.

I will send the updated patch shortly. Thanks again for the review.

Best regards,
Shuran Liu

