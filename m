Return-Path: <linux-kselftest+bounces-22082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621509CD66A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 06:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D83283436
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA613C8E2;
	Fri, 15 Nov 2024 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UiovZSV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1464D
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647145; cv=none; b=Im6d4wgypNQAUUiXPIAbR3zzt2Eock5PpkVrr9LbQXWkLPJUo9o1MzDXzdIierF0jTnU4UhLRkY7GUmMF371OR3auS9I3wiWW7eN5HfmMxU2tVdBjR0yW+yzSV+s5icYU4FOG3Ymu5XFIDjkrb6ey+KrPUD5jp3O71skAfjjHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647145; c=relaxed/simple;
	bh=c3ORVDj4xX2EjDjOz6t0drjhnyf/SkihQFLgZhUuNAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j0p6LiDcPGCgrXIvIpQP/hqu1jeyPQHyUeG4ne6t19aLLgGYdOAW0C0lAHbJhf7gSb+E6Wi2sYgFv9lngVF1l+ArQg+u0SKtQopp3gaA3jP0xE5CGw+DVQCJXoieXDkhS9Ml4GacVJtJZeBBycHZs5POE3rBfnv8Hm2yVcDeK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brendanhiggins.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UiovZSV8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brendanhiggins.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so2038131276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 21:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731647143; x=1732251943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4rvEMRnJ11SYA+1F9IYW5qeaXRg5Sv6mMkA1dfT6oY=;
        b=UiovZSV8SCJRWqxngqcC4MfjmEgLU5iMbH74D24upQsA3SbJV9liMMcGPCVg8xIbsL
         m/6K2E04t+1YSDP86NXIT11aeWe1V+/Q7hFE0DwVH3OGHjSrGqrn82T2oGcNzspx5cSk
         gQwURD11e5r+Q3B4G3ovMoWF3wLyebUyyg/E9pXLLI9VphbGjiz5765iZs0bnCA+QRLr
         dBUKMQ0cTdbHBobSxJltdC2yuZM+i3Y2+85OeKeMJUhps1V0KsyUWE4o/QyfXR5uEZCa
         Zt1gSkKvqw8YH4MFaROtKJMSAMpJFWXENN6fyMBPIP9U2JWKDCrxbsuL8ydWtj+Cx8Rv
         On4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731647143; x=1732251943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4rvEMRnJ11SYA+1F9IYW5qeaXRg5Sv6mMkA1dfT6oY=;
        b=bwtOrmuNg//lJzb6J9Bz1gvZ4xGaTXsfkM1RRGxoClsTBEncjt7GyNyjLoMQlffcM0
         nViVqWiSljxuMBJumQ9zCRnKrmBi14PKQfaYTZHzyiIkskJSrQnPDzlSMZgOniYivkdU
         9YRT0u16OI3nKjcTQvq/CYMq69UiWXQavDWWg2Xobg9e2xow/Zmm4x/mxQ7v5yxjrcmo
         r2iqwQfKRJ283EWq70aN2pVdwhXcfna4q4w0OXHW6aJm+DfaYRIWWP2RjE4s5dCjzPvJ
         iSMCRveNG/WgGfZ9HzwEMphg9xsY6avTIJJt0dlnaU+Ri2II+9b9fk6AUotkoy5jsQ2g
         MxCw==
X-Forwarded-Encrypted: i=1; AJvYcCX12t9CFJzNNlpQXaf2pVtg5laC0OA8AoBAHU28zkRAA84/Z0Mn3WCBIHxtKwWiS3T9hl5FEt+iPy/g+kRkGCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zX4nyuj88mx5C96QGKBD1rcXUmU6pC8nIQa730aX/Fcj5cqQ
	QgvFO5LjvXFJNAW6JClg6E6c1oHIB8Yc95AaZD4XTZ67atobY+dyjS+Ajf7/4bB59bWnYU/qQrs
	uTUskFx+1ebOS5MJtmMm9huuC2lAG+RhO2w==
X-Google-Smtp-Source: AGHT+IEJdk96UqmXYcisBBx1j19xnc39H9bKiAQWr+GSAvkk5gGxMmObW8Nq+cE5EP9JRYJvYNib8glYYSTHsssc5Bnkgg==
X-Received: from brendan-cloud.c.googlers.com ([fda3:e722:ac3:cc00:141:be02:ac12:7acb])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6902:1b91:b0:e28:fdfc:b788 with
 SMTP id 3f1490d57ef6-e38266109b5mr1012276.9.1731647142515; Thu, 14 Nov 2024
 21:05:42 -0800 (PST)
Date: Fri, 15 Nov 2024 05:05:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115050510.56569-1-brendanhiggins@google.com>
Subject: [PATCH v1] MAINTAINERS: Update KUnit email address for Brendan Higgins
From: Brendan Higgins <brendanhiggins@google.com>
To: davidgow@google.com, rmoar@google.com, shuah@kernel.org
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	brendan.higgins@linux.dev, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"

Update Brendan's email address for the KUnit entry.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
I am leaving Google and am going through and cleaning up my @google.com
address in the relevant places. This patch updates my email address for
the KUnit entry. I am removing myself from the ASPEED I2C entry in a
separate patch.

Do note that Friday, November 15 2024 is my last day at Google after
which I will lose access to this email account so any future updates or
comments after Friday will come from my @linux.dev account.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b878ddc99f94e..d077a3deeb386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12405,7 +12405,7 @@ F:	fs/smb/common/
 F:	fs/smb/server/
 
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
-M:	Brendan Higgins <brendanhiggins@google.com>
+M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
 R:	Rae Moar <rmoar@google.com>
 L:	linux-kselftest@vger.kernel.org

base-commit: cfaaa7d010d1fc58f9717fcc8591201e741d2d49
-- 
2.47.0.338.g60cca15819-goog


