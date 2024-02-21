Return-Path: <linux-kselftest+bounces-5207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C72E85E47E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82031F24A54
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3383CA5;
	Wed, 21 Feb 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGA654KS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F647F7EA;
	Wed, 21 Feb 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536236; cv=none; b=Bed+v8hT8MCPRlIfBnLL1w6Q5tRdkgV8gc43RBBbznTSTNKymkaXEKqC+VGCm0Kmyr+//pH3/Sy121WbxpQcC2O2QUDGcyVNSXuo1JVqHZcy8WTxm5aeJ+G/vZYZWKivRCNuQFTyQlUYnXbyQExLXYwlz8nGylp2JNSvGlfkdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536236; c=relaxed/simple;
	bh=wfo3IqN4Mq3KWjYAejdmJ2nwaWZQJuRCWSSTiTO0wro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTEp+cwN+8d1i90JB2EbUnKChudVPAqqpaaTOlYxYfAx2uPXNXLoGllBXwdtiMgxBesk+2x0BXh/XO7sSbrm8C8wIKbD+xWbsgMI/ZX7htFnMCnjHUWbSsXs8jaNtXKAi7h1durytH/uGOn6nvOyx+CMz0jDQ+S5A2Ue8Ey/gFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGA654KS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de3141f041so4834506b3a.0;
        Wed, 21 Feb 2024 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536235; x=1709141035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfo3IqN4Mq3KWjYAejdmJ2nwaWZQJuRCWSSTiTO0wro=;
        b=MGA654KSGTHjdQEAHneNkQ6Ss10crprjbVg4M5SF8fGbQAv03wkL9s+bwgVqqyWyJk
         jGVzRVzwCfiiaGA+dOwhhg2a49vr/eqIzPVh9zPiMAYuzt0GVxeszelKyY1C0w3UdrQ7
         UV98q1X48qw+yWyDN87vor2l6aDmJqZzl6fGXc4HBzl8+sBXDZ29C7yjhUahvrKwWU9v
         nvR3lB3+8WMh3sEdMfR+lnUmXK6qvcQeJnDmg2svvZnW0bd4Fu2dZb2NLijDdwDdyxMd
         E4Yh81oUjJBM66zk8j08u27lkirSySekQg+8klhGKZV7viAroOXziRjyEEsUWLbGq/qP
         7WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536235; x=1709141035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfo3IqN4Mq3KWjYAejdmJ2nwaWZQJuRCWSSTiTO0wro=;
        b=d+4zFedWl1BQ/kFAprKyeAt+bVO1QMUdmXu/qjShwDNi/cK7oXp5XofQIo2cq1c4vr
         yianZTTRtcCfUgMIKXAZud1AY5voFMnhB31zRsDLgOL8hZ0jis7o6I6r/UvOtJRvTsA/
         hJAVlZ2rnkXBSGqM58ShxJ9lO0b9KlmGtzZxZu+irA8MQhYezLgRPmnzxe4mZd9+VFUk
         3Pf41/Gg/rsH5mUPUYh1JxKejyl5/fiysbVxoOMzGlW1UM7Dj+fF344zVdkrf2QYgTlV
         I8ffdaBzPQI3YjcrVM+Xh6p/wU6eUZ05DKTvv3Ux9PkYOPVdMC6YdOS4dm+dnnpif0S1
         itVA==
X-Forwarded-Encrypted: i=1; AJvYcCUY97ycuLRJB8s5y7m4ridtjVjNgXAStfND4zCV9RbbiFhmlOuvXqFSzZHw+FWv7XRiasYEWYDM5xGYZjKlV1Z0g/Ou18BmzOipElXoMN/98PfavYEp6/qBPaBlxnItmRY+fT9aB0l1COv/4Vc3RiVdzugnMzCkxeCdqIJTA7Gc+xoeUxgRajnBvy7ePpsVbjxmmNfWmejuWy0bJxFSEjEB/Itn
X-Gm-Message-State: AOJu0YxIxkgnaJYeACHtAmdgYi2EYL3BC1RzfqHmuTt6Iu3vMQgXYet2
	OMN5qeCECGpQY6qMapY8SDkiDZJtua3gkB95WQirRrp5upzBXPLG
X-Google-Smtp-Source: AGHT+IE59FCC/t+zMXkdlfOszaAbcfam4PoFW8ZvkAA8ellpnl6GKzpZod9gKRIYj9HKw1ZNyXXkCA==
X-Received: by 2002:a62:aa0c:0:b0:6e4:5a6c:957a with SMTP id e12-20020a62aa0c000000b006e45a6c957amr9182990pff.12.1708536234610;
        Wed, 21 Feb 2024 09:23:54 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2000:500f:a246:8a16:bee7:140f])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e324e33ab8sm8640356pfb.218.2024.02.21.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:23:53 -0800 (PST)
From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
To: oleksandr@natalenko.name
Cc: Perry.Yuan@amd.com,
	Xiaojian.Du@amd.com,
	alexander.deucher@amd.com,
	bp@alien8.de,
	deepak.sharma@amd.com,
	li.meng@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lucasleeeeeeeee@gmail.com,
	mario.limonciello@amd.com,
	nathan.fontenot@amd.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	shimmer.huang@amd.com,
	skhan@linuxfoundation.org,
	viresh.kumar@linaro.org,
	x86@kernel.org
Subject: Re: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on some CPUs
Date: Thu, 22 Feb 2024 01:19:14 +0800
Message-ID: <20240221172404.99765-1-lucasleeeeeeeee@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <3868832.mvXUDI8C0e@natalenko.name>
References: <3868832.mvXUDI8C0e@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Oleksandr,

Thanks, sent in a new patch with the recommendations highlighted by the script.

Regards,
Lucas

