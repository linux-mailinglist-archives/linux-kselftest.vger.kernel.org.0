Return-Path: <linux-kselftest+bounces-18964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BD98EE88
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C6DB210AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2615DBBA;
	Thu,  3 Oct 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLnOunOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A915667D;
	Thu,  3 Oct 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956353; cv=none; b=SF2AFvpcLotl6sJIkUCPA+/uJqHoAH0ddZso6KcUq2E8XyQYmn0ufoFYvNV+HW4f63Ar2yTPAAtwZnNeJMVq5+N/3hJBheDPUckNI6jQ01S9ilWoAV0kbP/hTUrN2s1HVsM/gnYKGw0p8zbvPZhklv/7NHwJSVzqb33QaTuzxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956353; c=relaxed/simple;
	bh=1fCbTcu1pgESgNQrdvA97Yby6VTEWicovaJWgB9Zh10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miAGPL5DdS08Jz5sNk2Bzj29rI3au+FQPymcLMmL67TN8c5DhyfTLx6C/8kdsA1ZH2SvudodDe0M8p9A64B0ahZIKd/BUq3277Feik/IZ1gF/KZ9Cnry42PfIjUbn891ZvlKNkp28xf0/6Q5ww6I3BzdN06EBmnga/oShZTnkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLnOunOi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b64584fd4so7744265ad.1;
        Thu, 03 Oct 2024 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956351; x=1728561151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QhSmeCoAbQc+pGg78hLXelmoDp0yHim3T7Fmaqm3Rw=;
        b=mLnOunOi8Dpo9owdmvtEqquuRPChEkwVz4939+X9/yuT3lGlA9iCtK5vYLpRPDsFXG
         psr06G9u21tMPU9rcW4S7xaaE9tORI0bf02nXSbDvqKy0fk2SEelzd+mJwSWfXTZCuGb
         8dOeTpr9naaoeszlX2yCQPkQnD8zmanudFUf3FhDAcgLPI/9WfYHZh6Tn1X7syoEMeI/
         LQkzV38aggM/Y9J9G9uZiKGQXxea5MBbeN1ubs8XysyNPXkJ/47scQYCXDqn4CGnm9K/
         tMa3q7TxR+ETYTj8dUBbrTqFEVJzrm6uvXq27/nK/M26SdBrUMMXJjGVxAEpEmQsVxVk
         kuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956351; x=1728561151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QhSmeCoAbQc+pGg78hLXelmoDp0yHim3T7Fmaqm3Rw=;
        b=UfTE+ZYX5RDv4+eodPjX4TTwZtqSj2QYdc/syZ61QfqN6K2N3RV4OIGnSBQ6IqtMfg
         QR65uH8gwZF8QADge/5xcuLoz3C8TPSiqhNC6SgkhGOaHYi81g+HYMRIehJlNYFePSqa
         vVrDFbk6JHIeAxh0rCec1EluYBVUlvQjIrcxAz4G+GriMrpyQ3zrHOUwhfzMxuUOJZ70
         w8DJRpa7iiH9lePb0G/ErE5PCZliktXrq8Za/ZhiuncdhnVJK6JhMw7RaeY+dOkdrAZV
         P9nEVEDBJcKZNS6uyMFTY9ag5zaN5B9Fkt9J7A5X862I9V20MDBn9GJB6O7A1y6SoH2/
         cU5w==
X-Forwarded-Encrypted: i=1; AJvYcCWNxDdwas2lRkTcOlaCptCzrr78u90EGw+newGsDfo/CdSlRoCpvhszoFmSsG9av/zqZ+62zXdSjSE7LFJY5k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnT57JGkXPu99rlP3VW/IXMurD48CXH3DywC6T2eTutR3A+Rz0
	h4F4gOzlhxK/CCsoB8JG/clm8WwMnnl7T64+yjQ29opvbPnbsJKn
X-Google-Smtp-Source: AGHT+IFFRjNLGV0gA7B9unA7/i4GmRQ4RyZ16vS037u0JBnIO52V5UbmIQXImpUaizQRbpm+xy6Xlw==
X-Received: by 2002:a17:903:22d2:b0:20b:54cc:b339 with SMTP id d9443c01a7336-20bc59cd61fmr88410345ad.17.1727956351186;
        Thu, 03 Oct 2024 04:52:31 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4040:6e98:37bf:eafb:1e01:f1fd:54fc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca1a0dsm7722335ad.69.2024.10.03.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:52:30 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: vDSO: fix compile error for vdso_test_getrandom
Date: Thu,  3 Oct 2024 17:22:24 +0530
Message-Id: <20241003115224.7283-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002152849.111841-1-surajsonawane0215@gmail.com>
References: <20241002152849.111841-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, I ran it but faced an issue. After reading comments on a similar patch shared by Jason A. 
Donenfeld, I realized that my environment is Ubuntu 22.04 (Linux 5.15 + glibc 2.35). 
After upgrading to a newer version of glibc, the issue seems to be fixed. 
I think including <sched.h> might not be needed. I would really appreciate your advice on how to handle this.

