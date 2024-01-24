Return-Path: <linux-kselftest+bounces-3453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948083AB75
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF31F2A609
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5597A71D;
	Wed, 24 Jan 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0xTF22l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383677629
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105710; cv=none; b=CSimXgQTL1pknpbXrtsOOn2h7IQdh+RdwG8v1lF847dToovjOV6JtdqPA7H+vKbWoG1OygkD0jeRjBHtznmRQIQ3QdBEn4IGkes1n8t+QfZbtR3lpl81Dmrj3uFBxgrWlvFFWDN7oHuJ0BA9syV18vcWJ2DgyoATEdqoSRVrOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105710; c=relaxed/simple;
	bh=SGkD+ZUyjCoSspeUimIEeBgNKSYYBGx6C6pkU0VbwQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oItrVcLR2lW3iLhC4r0+O0l1bgaikVOoye6B/lVF+1hsOEeAFN6U1r82/wjTNyJwMEsPD+Wf/AdsJfHdKHI2ldHiJsHomPt667XFsUZIZ8thKyRSKB77L6rOszZy5MsqR9/a/HwLY8GtJDGSN0tNgh8UrvxnOooRspCYmY+Otuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0xTF22l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso6097472a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105705; x=1706710505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzKyb050QdFrleWlKW/ZhaMWNWbmLy+2bQKgqjbFLLk=;
        b=d0xTF22lRZWhweZsQplvvic1yjcLAGbJ3NCR7aSD8wJTOGQ0hz8rbfDmjqUBV356Po
         1ir81diUxKUGkbsAiYinGwJ8JMp6zujcKw3cJCzPE2HKQhHBFK1n6r9xKEfbaX4ilhMn
         Yu9KaQaZj+oLmhFu0OJABzqE4LNRfM385fdsPhZbaBh5GDtc7wBMYUH2/Lf1XWSrABIh
         CSfy2UfzSjFWOBVXYIQl86EZutt2iH/0I/uhzylBWuAin3UtuCYF5qq1KCPunVExebef
         0d8y4hrJA56mSSMdpxk2zX7LBTFca4w/6rBtdfLz9bBthBFNM4IrprOLHTSxdv6zPGqh
         jjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105705; x=1706710505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzKyb050QdFrleWlKW/ZhaMWNWbmLy+2bQKgqjbFLLk=;
        b=Knc/9ezbFY7uI7k2CfGs0QxcObkb86OUaU2jFRgkBSvcWVWwo0PEHr7dKyTCue74pn
         02PJmC/J0VzIkveB+TkmZAHd5BQ3kBiyi4Ved8EzsmG6JVIkvGNSanMEPEH2jwHoOxNx
         DzoArdMrSgSc8gq6s9qGUCCrVE0SkTZhFnH1hM53BoSdBQZOa8UI4hXW6sCQ7QvbbNg3
         BLobZbBFanDHmecxj+59oWMXSzII2DOXprSivrdFEKY91+UYpFT8BSBIechS2X6R/7s1
         unyeeCj1ENRtlhgzg0r4MORILpalvVyzNvktIdNPbFE4J0c1SUd2UVbuLpSqSYGdsqXo
         TNSw==
X-Gm-Message-State: AOJu0YxuBJjewobdH9I5jQPf0rjcdWxVTp0r0mOMQjAdZ9ysoBi6Cp/g
	ynuH0Tp/K5Yw7jttFHivN7hIUfpWK2RdKtIqcWAGYGVjS3DqQWETLb+YpEoGN2s=
X-Google-Smtp-Source: AGHT+IH4zK/XBys58NVqE2pUFAuWshd5IS9ZBG85RmnQPNi+29iksdxduVLc0w0Xw3bMXrZi8zi+/w==
X-Received: by 2002:a17:907:75e9:b0:a30:5a6a:b600 with SMTP id jz9-20020a17090775e900b00a305a6ab600mr843245ejc.141.1706105705262;
        Wed, 24 Jan 2024 06:15:05 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:04 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 0/3] selftests/seccomp seccomp_bpf test fixes
Date: Wed, 24 Jan 2024 14:13:54 +0000
Message-ID: <20240124141357.1243457-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Here are a few fixes for seccomp_bpf tests found when testing on 
Android:

user_notification_sibling_pid_ns:
  unshare(CLONE_NEWPID) can return EINVAL so have added a check for this.

KILL_THREAD:
  This one is a bit more Android specific. 
  In Bionic pthread_create is calling prctl, this is causing the test to 
  fail as prctl is in the filter for this test and is killed when it is 
  called. I've just changed prctl to getpid in this case.

user_notification_addfd:
  This test can fail if there are existing file descriptors when the test 
  starts. It expects the next file descriptor to always increase 
  sequentially which is not always the case.
  Added a get_next_fd function to return the next expected file descriptor.

Regards,

Terry

Terry Tritton (3):
  selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
  selftests/seccomp: Change the syscall used in KILL_THREAD test
  selftests/seccomp: user_notification_addfd check nextfd is available

 tools/testing/selftests/seccomp/seccomp_bpf.c | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


