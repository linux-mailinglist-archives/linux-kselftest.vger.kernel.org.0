Return-Path: <linux-kselftest+bounces-15429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FE953885
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8345D287E1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FB1B9B4E;
	Thu, 15 Aug 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIsAEdct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08636AF8;
	Thu, 15 Aug 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740382; cv=none; b=JSTugAtp/2dl4l5N6V9K+dIFStcLBjfjTcW0XC6hk1uqJv+R3cMg2N91I8XdgXIeP1VE95ZNqXYUkkZoyjSmM+y9CKevmc24v9vn7GqPCReHPC8sqY7LbszH2+D+mmBtBz1v4uyFOCh9NkmBvq/2XzoIam7EdFgWZC1RSMsCmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740382; c=relaxed/simple;
	bh=720GAGoLwGQkKkRvyMK3aY3Serxtc3h9lJiV0K+BedE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VA9NdbxAWnuapW0zKrBX5xw9W2PK/Cxd/D3830GzmNTcbV3b2fJYdlKIwPWeJsmO4Wocp7rMyFy9Che73uFgcybTpUKCBxXNNUjyUF8kFEOWOrFNciD2vz3CI0Ojh9DqJ+EEcLwRgVFTDxeWqW2Q19Dwp9BcepNz3V+xixTqQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIsAEdct; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201ee6b084bso9725405ad.2;
        Thu, 15 Aug 2024 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723740381; x=1724345181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQNiAcSg9ZN0/2zqUqbRE6RupMkOltmLXOfMXjko6Lc=;
        b=AIsAEdct0mNbYx0HvCYCY9DHY2WqiairrAXQbA/dise2+SL46OLvItfcNmDp1JUPw/
         h0PbmoFfdawW4IPpojxEFryjQbVIQSZVgzMpaf7uBGsufMXk9ZVulE4iU2sxytKe4RfH
         dVt2OElqHr71Gs8O5r0jdbQTGLJVdgF/9BpT37PmikDkbuW3Jrx6iNhhnVKGsgFPYbM6
         FZ4dgljJRWezqkZ6A46/szLsrJKjrLgoBbBVavNLqwjdnrmTaLh7k6sUBd+BokrvQGPb
         QtlKeRMgvPgILkW5pM3a8t+AoUBVGPV4K24hZbc6ioFoiRrsoEOhXemhrYfZP3x3U5pb
         HY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740381; x=1724345181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQNiAcSg9ZN0/2zqUqbRE6RupMkOltmLXOfMXjko6Lc=;
        b=iadUZU4TjBP3kP6ztmrB3P6GcLsXSAxOhDVQ2J8jPYvV4bhJEhtBsrVgAJ7f5Vhsqd
         SZTdRljqgWcU0SygnPS640h2RDxZUC505UfdSBQyci9uGXWy2RZ1yZCsXrEiGRnVLqGA
         BQiIvyI0Kcw6p6XxI5O12ISo67IgSyipIXDXz+qztrmHt2JlcxVx+mGBsvCDZZ/5zy0n
         GFMm6+xOazt5EQp+6I6ZotE+QzB4rGEogPZGIl+8EV8bzXd0rZQazKHz2MFyB+w1VPBp
         sOhHEtbXmq92UQdTUyzhMwYNgd8AoWz/W7bgh731OvP7QsoqrjqYH/7LQ1mP06JlIb0a
         49pg==
X-Forwarded-Encrypted: i=1; AJvYcCWc+G3SohSx0b7TDjyOXAsWkWgCzi/ZWViZWizrJBPBEBG8uZAUcCAuFeEtTPjt/BZxWDFsFsB1byxTC1Tcyz9v+tfb61QlXlk8M6dSFTcC7uArO+NMgaduNdqWtrsKD6JcfVXDiWi3alEzfROIeAd55Yzh6pGkrke2tu1czpqbLuvBS9Vz
X-Gm-Message-State: AOJu0Yxow362vhWPcxn+cWwvmt/7N98x04WwMQABHjxjacEuClTbev+z
	WMo9r85jI4Ys0RelxNAbQSsv3OBAARNhlSl/PECJJQGCDefqvzgI
X-Google-Smtp-Source: AGHT+IFs3+tFqEKdUJYLvgNTrrIN+2WdfL5DlnSs/zkJAmFw0eT/nMoTtGlQC8CsapY2Sjprm5eYlA==
X-Received: by 2002:a17:902:f9ce:b0:1fb:8aa9:e2a9 with SMTP id d9443c01a7336-20203e8f81dmr3518455ad.15.1723740380569;
        Thu, 15 Aug 2024 09:46:20 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa2dsm12162305ad.36.2024.08.15.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:46:20 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v7 net-next 2/3] selftests: net: Add on/off checks for non-fixed features of interface
Date: Thu, 15 Aug 2024 22:16:12 +0530
Message-Id: <20240815164612.1408408-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815130353.GB632411@kernel.org>
References: <20240815130353.GB632411@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 14:03:53 +0100, Simon Horman wrote:

> Hi Abhinav,
> 
> Isn't the value being read into $initial_state here already present in $VALUE?

Yes, that is correct. I will wait for a day and send v8 using $VALUE.
Thanks.
---

