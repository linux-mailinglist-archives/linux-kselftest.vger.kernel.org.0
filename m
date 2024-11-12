Return-Path: <linux-kselftest+bounces-21839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4C9C4C48
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 03:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BE01F21E97
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45642204959;
	Tue, 12 Nov 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5xbTv3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618519CC17;
	Tue, 12 Nov 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377627; cv=none; b=aZzZ3nsktmWEI1wKPFHis/yE5Zk8d+2m+29LHn5JTpOYjtMCYfJtCkOfO69wvq15Ink6UIKnwhycYmm0fZFscHnFPtcHpPP13fzpakpOIfx0Z/r45+8O4rxGOVnbzpgHv8IbzMxn7LlusQYQ642Bc3PNVgCDgU/w3k+x3CVTk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377627; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVYOvedO8NocAL6Mh8F/7ttXhiMkV/JCKXZceEsj5fapd2ZKJeSqy+fVd7d8Z7V8xkHFiORh8/GS4/JbCEReZXDWSO04FUravxgpZSNqlkMjc5VU1ls5p7+Jpmn4F69euBjWnLW44s+wix6idunG4vPLzOzjJG1UHLk5JzFvtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX5xbTv3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so3693588a12.1;
        Mon, 11 Nov 2024 18:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731377625; x=1731982425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PX5xbTv3MlN7gowIWJjWuiLib+AO+oEXQ1fTUxpauMHxnQPClnXQdznAHhyyu+4HtV
         U7cyuQhOeTBsozx8ltyXCDGopRfXP8cmmkKQs7dcF6Vu0BL4ydOEWhbwbOZzySkHAVzz
         NstQunn91B3lVUR5RKmStgm63ppD+sl1sSHR9GA4RCjwFrggqM9+7g9tKSIp2j64anF+
         wfkBflTzfY8OMQS9lg0fg9mNTLd0M7evMpzdd4Ubd2m0iPLFRn5cYDB9utuhA8RnZB3O
         aEdCG9A8pNSYQdBRcC/W2CMl5kWEjNCMfcBcJRj+kR/4+D1mwidq9RvUIGVWlz3lRnKX
         tOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731377625; x=1731982425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rQBaCjM5qF3R3kMwvmdfi4w3nMYUEFAI6eJNp0KPt+y8soIqI/Yp36HYMTxT5yOgy4
         qiG2ieI1dI6xabI8X9+N2u8YS4Zt1c6GffbiHm8/tbzTMkk3Cmmu/tpvBVv2sXfhMFiC
         M67wXxwx+3xYc9CfRizILlXTi9tWnPmf56xMa51vqa4nDon8sIHLKI8h/73yH7s9/k7H
         8Rh4q9ScVRdv+TMlyW3r1x3qi8pbbLttfFw2Ztzi7+QK8UH/LJQMgYJr5txY/GyogY07
         Qer/AEazZGG8IQY6IWLEp9eTZCQUGSSaPyPp1fOY2ESL3irpRmXy2An0Dg4A9cWOkNhS
         Lynw==
X-Forwarded-Encrypted: i=1; AJvYcCU5aHTWf/J8CTkvGgE+t2F4GoBCZBq3s3wMwNQfuTwaOoV5r8ti5iXeTisaRYG9fGRFXNo8NJTmssi0@vger.kernel.org, AJvYcCUD/eseBT3rHvkEF5PBinvJ48dZpX7T937ErvlzmuBYztQKaON6kr0LhmkvXW3vUteF9RukaJ6IQ+9MpQeyp1y3@vger.kernel.org, AJvYcCUidnz3NytGHVUAQGrKwD2cXaJjovAsDN+wIpzia84KrFRvZHwEl01FaJ5QdGxq3UV6e2vUDBf0g3gt9id9@vger.kernel.org, AJvYcCWeGmdk+4ATodVuZMhgZKqW4WGT03vPhWtOCAVj8cp/3UNQyx4ZjI7jKBs1fxxXSgE/3hY0FOOQDjUJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NjXhddd7iMruV6F11kc34y9OO7JanoAnRm9ULlkT9unYhg4q
	mPFdo7tUiA89YmK++DXfWZV+1DRPvXK8ttHm53lcEEspzw4gqONdftTOS5cn6/hatA==
X-Google-Smtp-Source: AGHT+IH+5UXelKsDy3oJZlypf0Kktdqo9U9iQ7oteV++YKpkDWgiAzqsABr0X0CYYwoE+B2WGNVBmQ==
X-Received: by 2002:a17:90b:52cd:b0:2e2:e597:6cd3 with SMTP id 98e67ed59e1d1-2e9b173943emr20532167a91.17.1731377625050;
        Mon, 11 Nov 2024 18:13:45 -0800 (PST)
Received: from localhost.localdomain ([119.139.196.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fee67fsm9223414a91.49.2024.11.11.18.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 18:13:44 -0800 (PST)
From: h1k0n <ybzjyhk@gmail.com>
To: charlie@rivosinc.com
Cc: ajones@ventanamicro.com,
	andy.chiu@sifive.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	evan@rivosinc.com,
	guoren@kernel.org,
	jernej.skrabec@gmail.com,
	jrtc27@jrtc27.com,
	jszhang@kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	samuel@sholland.org,
	shuah@kernel.org,
	wens@csie.org
Subject: D1 vlenb
Date: Tue, 12 Nov 2024 10:12:26 +0800
Message-Id: <20241112021227.357-1-ybzjyhk@gmail.com>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <20240911-xtheadvector-v10-3-8d3930091246@rivosinc.com>
References: <20240911-xtheadvector-v10-3-8d3930091246@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


