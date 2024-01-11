Return-Path: <linux-kselftest+bounces-2879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FF82B83C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 00:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7DD1C2367C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27959B78;
	Thu, 11 Jan 2024 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hshDIEv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF657870
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e898eb4432so92166077b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 15:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705017008; x=1705621808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsomZodD15xWkxeaoRTIM1MzlaSycgnV/VRy79eCePs=;
        b=hshDIEv5yJkfKCq7W4wJwWAC+pv2JQby++1Tdx/fhxAlywtl2YqQlFk/rtTv5Jl+6H
         UX/pObLanvgGfx131BK2Du7rBPOO7PLFGhFIzl65r/LUZFFkVMZUt5LlBeDDt2aiZiyl
         s+XeOxXSZBT3nJufc97wOEU230jaWRhfA5UWEPu/r5XzzL6oGuFMQLFueGwEeszDezJU
         oRIEENWRd2Ikr35TbsXCoO6UKBwmaMVy4Oywl6tAgnrbOfLHGySGswOy2hARtljtVdgR
         8BjP7LBnDj3+pRJy/aBP3zdKEfnJiB3ixLVgeAvsPUQw4ISu32SQQpWjPaBL8BnHlrBV
         scTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705017008; x=1705621808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsomZodD15xWkxeaoRTIM1MzlaSycgnV/VRy79eCePs=;
        b=nFru1y7B2nKU55RJ3hyR0kbGh6dcZf/mE4lzw8419ocvbVJin8pw6/B9FzHaHOmTRX
         uMsSZQLNGxni9lcLyUNdA5HThD7NyaUfH5vda/7+bxfOG+zitkQKIOicbeVt2yMbduWh
         pni5sxzkX7vPCuJ2WpQd1NLrj24scK8VlaarvO9W9eR2k46Nq71Zd69LJaUDdFGtn5nt
         eh1aCxYzP3vNUjiTvd0GzWzWzGHRLSDsRa/r9lcJYCfx1BhwnJxO4NukkCyapNsViQ1t
         cAP0lssWUn9VeeQdcdiCy2vAKnAI0zY1iBO/6jKyCZJWnYoKoh3CvLOFR0eHqWzP/pxG
         YoFw==
X-Gm-Message-State: AOJu0YyiAcxMyRY4P1/Ql5Bpp0S3FV9EF0vkehUgL+b3Y49GQm429YYx
	lT+dJvxGOwDvHP5O9MT+lDXxDzfdN6NrK4MW7FYr
X-Google-Smtp-Source: AGHT+IG2LXTPJcLTIYiau7dUmtdpwn1Nlgo87a6YiEzOUhDP+FmZxPkUR6QbOmME88uLRJbHFzXIjg7YlSxvcg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:848e:0:b0:5f7:9ff7:dcf6 with SMTP id
 u136-20020a81848e000000b005f79ff7dcf6mr254727ywf.4.1705017008582; Thu, 11 Jan
 2024 15:50:08 -0800 (PST)
Date: Fri, 12 Jan 2024 07:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111234948.3103511-1-davidgow@google.com>
Subject: [PATCH] MAINTAINERS: kunit: Add Rae Moar as a reviewer
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rae has been shouldering a lot of the KUnit review burden for the last
year, and will continue to do so in the future. Thanks!

Signed-off-by: David Gow <davidgow@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8efcb72ad4b..2316d89806dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11599,6 +11599,7 @@ F:	fs/smb/server/
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendanhiggins@google.com>
 M:	David Gow <davidgow@google.com>
+R:	Rae Moar <rmoar@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-- 
2.43.0.275.g3460e3d667-goog


