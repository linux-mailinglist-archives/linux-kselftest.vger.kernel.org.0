Return-Path: <linux-kselftest+bounces-32466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D74AAB26F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBE53A3D3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7D424592;
	Tue,  6 May 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wv9Dbus7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D335A74C
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485713; cv=none; b=IpulCgrsE0P72L8sSm9gxn0qwVQ7+Ck81K2VQbwuG6uaXM5oddNlTi/Ya00z8uOeoY0kDM8lY7XlzpjS4BXHnK4CW8e3D4cwbdiILPS3w/i4juRb0HYERmAsIfG/ssJUHrHxfgm2R29gmerFhSd2JsgybEQQb5sl16se1AIWeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485713; c=relaxed/simple;
	bh=o4dmr7QeNk6BMAJDX5IeyPT/JPkokyGq6C8SqU2UR/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XCjsqCXRRv9KpvWKKTpdpiGeB6utM9KRBooumhU6hTz8ImSwh2m+CzqEn3iWO+LFBNRQtjnzjKBCqp+Q6qd2JL3I69JIkqsZMEg8mngAMvSXUW+vIinwp01x5ieow7T09cXSydFDVb57C7loTGbmR+l8j911MGEhINohT0I4CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wv9Dbus7; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d90208e922so22917415ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485710; x=1747090510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9IWRogWT+IHbngw4rVJPf1yqVTJMP/POXHV9mjNlM8=;
        b=wv9Dbus73jy6Mm6xL20KyvmYpfzIX6HJsbfIBUFeLlsJpFnBc1LuN44v/oomA5FiR2
         hrTIR+hsTIC/fcDcOzHUTgPJ3csw/VXKz2pjj6vBhINPmSz58JXvnQ+kSG+ABruoVh2o
         D08giiS2eiYqPSDNAjf0B++kBzB70e7g5k6APYCVjcrX/DIgNCE/+FlTGTJb7RegqJ5u
         nPLHJUix55gJQiOxb6hYyz1ljpPgRi0fGjdhyTZxBNuS+zJ0wiDm5zNt/ZQMi+znEdPt
         aooaSY6e4xkm6+ZHGGUtTIPT3qmR8HU/SXe31XrsI9QjRquX2OClByMyMnR3Qt8B/BP6
         hufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485710; x=1747090510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9IWRogWT+IHbngw4rVJPf1yqVTJMP/POXHV9mjNlM8=;
        b=rJwGn0piaMeNfm+zIhT1jJ+2Pi2Raot4ayBXmX75cmj6XOcBtDpI7HGJuqE33pGx67
         //CLTZpaLrEb6ZbKHyg/tshuxTiTAZpQQWvNobK1Axz3gExIYN5rlifNKAcMIe3PYc66
         3t3B/kpVvoDbTDI3JbABELJ7LZB7sPueObinglDDJcol6btJXhsNY9J+n9YWfVHfnhXn
         imkJRIzW+436LXhzD6hvLsIgi4v+kWDN9Htr9fzYfKg1mUwtZVLMJMt6r7PQQ2tRxTpN
         26zxURJu8gmnolkngwM34R+7XQCIwZoMROvUS2878gXXwdSBZMxEWDCw8ygj+0Q0MFZt
         Jwyg==
X-Forwarded-Encrypted: i=1; AJvYcCV5G3sBP1Nj3VO3Ncz/irNpMTzpPtzm0hJx3dLSufwx1EcwWufksqHDLyU1K4QfLjCU03yl8puiPNM/XZHm3SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMs8zcPIxIQY2jkv28MwM7zhBFL7nfWlA4sjwS6Keoy8EP1vT
	rJ2cIte8Mw90ZfkWPzIGcHAHFg86632/y0ka8ltX+RuWnLnKBUWjD7GM2FNo9/c=
X-Gm-Gg: ASbGncvI1w5DScJnAaQw8Jfz0RTQIh1wcox056j1ryw4FYSIM+9Fm43ATRtJDq2BvYb
	CD1vfMQ1K7BDiqlDBM7uwbQZiGn5Ol+1A7NFokelmNP+Nqgk8n+4YO6h6xk4mtoG4JcdNh3BSSM
	RD2IIIvOi+L9ON3o1POIle2HgO0gc2yjMdsLuniLnqLdJQohvfMt7qSfIY+vKjjpJ3AKTtyjezZ
	jyYzaLFZvgPQmTt8JlKGKnxlKPEiBUlHzOvMgUv/T4KaPZzN4H5fDs1puc24xmMAm/shoKSAGQL
	x4Eh6qIMlvzQsSgsb61rUf9gXqDtZ0xo
X-Google-Smtp-Source: AGHT+IFpcNPaFzZ/vhh/4FSViYGaK4KRsBfwCvdYltBjqw6DGBuUksSFjecGP6VWziUl79QtWsppOA==
X-Received: by 2002:a05:6e02:1f81:b0:3d9:36bd:8c5f with SMTP id e9e14a558f8ab-3da5b2a02dcmr79548175ab.11.1746485710125;
        Mon, 05 May 2025 15:55:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aac8004sm1921031173.145.2025.05.05.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:55:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
Subject: Re: [PATCH v2 0/3] selftests: ublk: more misc fixes
Message-Id: <174648570900.1422154.9689058645460558381.b4-ty@kernel.dk>
Date: Mon, 05 May 2025 16:55:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 29 Apr 2025 16:41:02 -0600, Uday Shankar wrote:
> Fix some more minor issues in ublk selftests.
> 
> The first patch is from
> https://lore.kernel.org/linux-block/20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com/
> with a modification requested by Jens. The others are new.
> 
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: kublk: build with -Werror iff WERROR!=0
      commit: 3d6ee575d0d49be35dbb787db4d05bdf94e2cdbb
[2/3] selftests: ublk: make test_generic_06 silent on success
      commit: 254827a32118ddb171680dc2143c777cc68f2cbc
[3/3] selftests: ublk: kublk: fix include path
      commit: e371b9d3368ccb6b55fe9747be12c3107b2817b3

Best regards,
-- 
Jens Axboe




