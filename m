Return-Path: <linux-kselftest+bounces-5268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBD85F314
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C924F1F2666C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E424A04;
	Thu, 22 Feb 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvpg2Y9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1A2375F;
	Thu, 22 Feb 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590950; cv=none; b=iGHCb48rVL5YXqqTCxLGlQ7SM51HTEts8uUwzCUaIqAhCzwExLOGaaW1NFYMxBXY3bnjoEPA4wpGBaf74AMt0zwtOC5wO/CANxqghACNcY/g+oCJ7ng6lnW8EtmRga5eEc7kNqw1Dx6vqvPLw3kVse/jYMyUMbJeB/66JhzKShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590950; c=relaxed/simple;
	bh=xHwbdjmZSqPrdWn6XHlNXr764e/on4qsQLoM4hWOqrE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=uJ5M9ymhevi95eLGAmdt+BEqv+5T2wqjfqUl/SQZ/M5zvuSWaE7f8IGvdXCLm5S55Mr4SLGcbM4jNy5Xo6rsK6KixEmEgzelJVCK0Y9oPHo0nQHFbzEUZEY7JkNM288KgHiV1TyuGwToEuid5gV1cvwRQ6JAIqmfyqjr8EFJra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvpg2Y9/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d944e8f367so60603255ad.0;
        Thu, 22 Feb 2024 00:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590948; x=1709195748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHwbdjmZSqPrdWn6XHlNXr764e/on4qsQLoM4hWOqrE=;
        b=Qvpg2Y9/Qt4oyOZKSioOURFPj2E0x2OQadKvbghhL8IFb+GKZiMgGfvHf0PdwqIn/7
         4prX20dJnow8RGxmch/1mdYAy1frLDoYjyj+TftFVcDSR5zAKfyKdY7UlUrIwIZ+bm1R
         4rlhLcaloIlTckmFoDJ+ComT1K28cT+cJawkIN7cMr7Jf/iI1HgPHGbFLoDKFOwtOrEC
         YT5drpWoqTqH7M5x8inD3tMhaJbShpEuBgnv2ehcoa9IrLxS8SHMkiFzqmkqupaNV3wF
         V/95srtXGlBAwYxUuuFCAkkNzFgKYQtbWbQLscV15YhfTJV7UDQ32V6JvzAdeX1AFTyC
         2Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590948; x=1709195748;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xHwbdjmZSqPrdWn6XHlNXr764e/on4qsQLoM4hWOqrE=;
        b=dsY8HzJz5ixDQlOzQwrJ3BTSN65Sdm7AwftUed6QeQmfsy/T3pKVCukn9VszSc40WA
         ND+zlQQVWRELxcz4h4oF8H8ewmLeGqQsROfTYUeAKivsoBirg9TOu17qdyWMSl56yaCU
         Bbdj9tgKpLp6LxFTfxOxqfiwRYtjV1p0FFr1B4E7SjP4W3y9ghBaZ6exuTRspyyrXa/3
         h1FQkakcSJbFTrw4A8BfdRGHGEs0UDWFWtSleHYvwl86y7JhkqXPzAB8VvTpgrfs4VS+
         5dBYFDXJWuLnX+nXAgX698K6DMyDVb3H8pJPbbdtaLMh/rwigzE5JeibI3dBedUD5YjW
         zTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUYrZiM7LkVZgWF8T/f5uiOmuTsEqtLiYECf1Ym1aqXYyl4sEPrBFDwtsRQBTKx/Wn3joW1ZwJpQt9z5uq1H0XxxfTiUPImYe3J8y9hqyC2LDMIfm1dpqMznHezTROFYWdUkbHZR2hRHNPOXq27x4JLICLEbN12rRoshjhcjFHjFUAIdSpEgCJNG6YWUQ==
X-Gm-Message-State: AOJu0YxidKGcgAyPauFRSItWPSlT2g7tkWeGG20iHJ+Puyh2PVhLvnNH
	kK7gQ77FRMBrdOvIbFEGNZ+5E3NNzCT1jMIOV2SrZyGkV7/unIIb
X-Google-Smtp-Source: AGHT+IHm40srSL4/lTs5Lqg+0oCFJuyeZcIBshsR0LQDg4eLG87gdBMW8WlA9ifb0M6JsjcbO1sPRA==
X-Received: by 2002:a17:903:124b:b0:1d7:691e:2704 with SMTP id u11-20020a170903124b00b001d7691e2704mr24868491plh.35.1708590948183;
        Thu, 22 Feb 2024 00:35:48 -0800 (PST)
Received: from [127.0.0.1] ([106.221.232.11])
        by smtp.gmail.com with ESMTPSA id jc13-20020a17090325cd00b001db6de983d3sm9421904plb.85.2024.02.22.00.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:35:47 -0800 (PST)
Date: Thu, 22 Feb 2024 14:05:41 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: joe.lawrence@redhat.com
Cc: jikos@kernel.org, jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
	nstange@suse.de, pmladek@suse.com, shresthprasad7@gmail.com,
	shuah@kernel.org, skhan@linuxfoundation.org, zhangwarden@gmail.com
Message-ID: <10876e08-a747-4ce7-bdc9-d80b61b3ba54@gmail.com>
In-Reply-To: <88672d5a-1b12-a6f2-bf7b-8670eeddc711@redhat.com>
Subject: Re: [PATCH] Fix implicit cast warning in test_klp_state.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <10876e08-a747-4ce7-bdc9-d80b61b3ba54@gmail.com>

That sequence of steps fixed the warnings. Thank you so much!

Regards,
Shresth

