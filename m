Return-Path: <linux-kselftest+bounces-36646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC5AFA33F
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 08:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A87517EBE4
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD068192B90;
	Sun,  6 Jul 2025 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddFQi+S+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E211CA9;
	Sun,  6 Jul 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751782037; cv=none; b=ZniqiK4aDxP271krtekj2eov2O1Ux71Tm+7zFxP0XFyVrbPvrkqVj52D0GJNeWZdqsVUlrAF5LPgA2oREAxmzSoDJry2vLQKkOtPDDlu/eOcAvIX8fubClje3s31IEU9TN25B54Bx16KpPc9rRm+yPfUKS+V5q4uYK2nIvE1TUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751782037; c=relaxed/simple;
	bh=5sX4yn1ZkjqxHsCr/tPlBqWHMS8nxlwyGl8X8VE9gJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyrwzMnf8/7sWhdOXj3fRkEl2hbGK/M9VtXBnA3GAksAPt2Ai3qEUx6lXuDcf4EegT+IN8fKv0fY1bZKBu93QmnLz7uSvkJyg47qLyhHrB+fRKi5kb8w9H6BWHfEVlLwxXMa/W538aqSdiR2IrsC1nZ5kG339uhCBRZYjv4lPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddFQi+S+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1503829a91.1;
        Sat, 05 Jul 2025 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751782035; x=1752386835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sX4yn1ZkjqxHsCr/tPlBqWHMS8nxlwyGl8X8VE9gJ0=;
        b=ddFQi+S+6lPe1mwzd8LcqfoAby+qIczFdKq8g8ip2rAiq32Sg9W/AtYa23N+uOi93l
         U8kUJGG8x1/nE0QTtjcYmG+LBabdOBZZkOy5sv66yqYtPK7My8pUlqhUWpDZb+E3nz1D
         wrxKkomGYov1efAJm/K/LuR5dT/TclhN+ThBnRSsclCoXixTwYh+z2gJGkK4mIOp0k+F
         XQW3YoTpEheDQT8XhJCtRBgR2gowabn7uDiBSam+dvAtlMhKbp+0gngfkbwHwDUrq35W
         uftm+r7CaeIh+71q/sq0Y161Z9aB5ZGrSd66L4xXkuL4u4SfBlBakIomoQDxRfH/mV90
         01Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751782035; x=1752386835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sX4yn1ZkjqxHsCr/tPlBqWHMS8nxlwyGl8X8VE9gJ0=;
        b=bvM0DFoxlGKFcQSSDp80dUktIQwoQ8FddnnWfeklfVYVY5k9L/Gh8g2wNhA+plwAT7
         44ZeLPOsTpUnsKdEOYHbwp8aaTeJBtGv6/lzK6/iAM5oxEXWAaS7fyTxFwim9ZmmWGsu
         KGcZnqPCiQiPT2Db0XYN4A1K0JV+c39phsAWNm7D8t4C5VJxx+ayGWLv69Uuq+ULntUY
         rU5Uc9vV9gqzez+SGmXOcNyNv1bzKRBG3nISHh8oXgb/bZdGuxbF69L75a1KwIWYqlSs
         zjyR3/rFze7Pu3d6P4AbkLl8BuEkXBIMscC3ctahVaIqePXXD7M23GnLOnzrQ4WXLFcs
         k4sg==
X-Forwarded-Encrypted: i=1; AJvYcCUExRegX1hj/CJkGiuDz7OQANnKt9+fMJNIWQEGfN3j59/YJ5fhil7MjOZ2wJTypmGQ7De3zfRT+rnP5+8=@vger.kernel.org, AJvYcCWy08MLtG9Vij6y8KBDFbFWxqhhbRK5B4Ukz+mcz70tpY4uWPSnFHY+Jc7kZgjTALA+6WKKtsNIfgQ4zqNM1GVF@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7FnF8+gOI1rUEDBkA8HfVbVlnjVPiTLmfgULV2C3XRqaKgBZ
	opM0ItuAyRP1mt8D1cdsvxou5a2kDkRpTIDZilsmqv1OWDOHksA8VB2AmAb9zF57G5o=
X-Gm-Gg: ASbGnct4LpLXqI5HZdz3VLTYd+K86I9QaPgdDimcBehwpDfJ1Gi5y3pQ6UDp7Q2WXE8
	x/5HpULGBhoLQ+RfdoCApcZaXD16zbTgnZbLoYJuALaxVb6f0ZWpNzzZXj9eerztki9SxzXcs0a
	PRSZSL7dyxslas5NGDW1bM26Fg5e0VTFM4cbg7OUYYk4NHXbzCev4lmOtxVi0iC01qQzaNWGb17
	4S0HDz2zwQJyFGD0xzsstAHj/Tz+uauNXQzJjmOKAktBtqZcb1TO2YZF9rc+y+irucDPKUZU5nt
	SUTaySti/KGGCAYW/57H6KkUiJZkip3gsj8OQFHbPUwIE+emrYBp2+Hppb/lmAj0qLK/yJpCsdN
	f9ARcc5pMVRTh
X-Google-Smtp-Source: AGHT+IFN+GL2RIqK+xU1fr4Hmx6vcuYoJgZEnvyEEK9s9Wt22PCAhcqK4iczjsEV78/aavVAnxWyEw==
X-Received: by 2002:a17:90b:4990:b0:311:e4ff:1810 with SMTP id 98e67ed59e1d1-31aadcaba26mr10629868a91.3.1751782034775;
        Sat, 05 Jul 2025 23:07:14 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([111.203.200.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d755sm53136275ad.105.2025.07.05.23.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 23:07:14 -0700 (PDT)
From: "=?UTF-8?q?=E7=8E=8B=E7=82=BC?=" <lianux.mm@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E7=8E=8B=E7=82=BC?= <dev01404@linx-info.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/vm: Add tests for process_madvise()
Date: Sun,  6 Jul 2025 14:07:05 +0800
Message-ID: <20250706060705.17304-1-dev01404@linx-info.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1975f98-dbe2-4606-8a59-8ea94169ea44@lucifer.local>
References: <f1975f98-dbe2-4606-8a59-8ea94169ea44@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,
Thanks for the review and for pointing out these critical bugs.
I will fix the assertion failure in the remote_collapse test
and the resource cleanup logic that causes the script to freeze.
A new version will be sent out once this is resolved.
I'll also remember to include links to previous versions in the future.
Thanks,
Wang Lian

