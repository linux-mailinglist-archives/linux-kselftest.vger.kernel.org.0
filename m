Return-Path: <linux-kselftest+bounces-45063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3AC3E855
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CFB3AD96F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A8281357;
	Fri,  7 Nov 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pX9UZxxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAC2C11C9
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493409; cv=none; b=kxE4xEfYj2O70QDkmdxxIDERvhMlXATMUy4OHyAyWZ/QZKXwuQnph0ZnqtOm8/BYtIA4WU/ZnEGzs4ZuJDO4bRpkvmR2HU6xf4ly9GGp+3MkhSOTPAK6ZX2DOk6DKqmHKjbVhK0X4PidIXaalwykw7yd8dkaD/WWbNG6BHukCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493409; c=relaxed/simple;
	bh=Gfa74bvT8g21TTG6UeYJUX49YlH6I28Q/5rLnsXNtu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyWKeTf1Nu6EhpL+2uFuw4fZGvRXOSYoplvtYMgKF00rOlxfIY+zDQA602fxx3RvRqomi5264FoxUSLjwKMkAKCX43Uj5nWUegHtLrgvE2WBUcaO3IIPzu6/J08RNhYyp1AhPzzii6VO4ywVlHgpCKwIjqD8j7hN/vVdElTfwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pX9UZxxf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-76c0ad16289so4419527b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 21:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493406; x=1763098206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gxyC8GUOhbymd0hZW1Wc7AlwN6X8GVnWJwQLTO+kr4=;
        b=pX9UZxxfciYzQ1uFrIh/3etkrl0QEdGhu3g5Ea3xruo1GWh/xrdLebeOn5l12kmhpm
         OBuuIUQkzgo4/DkewT8+ykCE0tNkxCjSHfyhT9Br0aVGcfdyyrc2JPSjcfGEBBLdzqme
         9SGz1/fFLrN/GqENL4xakl1BNwwFsvJkF1+TNYsxmSD7juRN+p9dTFHz++QW0EtmRLsd
         0S8IY8z2b6PArlfsWHkhWy5gn2YsUt9n8cPk/3DLaBpa77G3glj7VJIMh/Nst4CIwXDw
         O7xnkm31OroAtg7HKG2tVdpp5x3PbDveHlCl+1CA6Cq2qn3FrNyeISHhb1anp5VX1Hpv
         /BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493406; x=1763098206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gxyC8GUOhbymd0hZW1Wc7AlwN6X8GVnWJwQLTO+kr4=;
        b=a5Ogji//oziIVCLkqDSevBpTa2EhYXR9/X99vZKaoqAIkewPYhwAT4Boz31t/bZFLe
         Nww7Z2V8TG7px9a8jg7dJRMYMawrH9mVRA1j02KprYVBJh9Px4NLSi2rGh8+aK9iQWds
         dolw2Zx0L6SEHlruchSkHjj8oigc4rOPcPTSlIZiL1oWW9iCzXt5QOAHoaPA8Jfm7EOr
         vfN2/KcRLaVCE/an3EGr/h3uLYzcfx0EyY10suj2mVux8+2PCdrw5zCF/gINY2L1WWoq
         4A32u4Ia5tqaHAb6I+xAtv9ESE7OiNhHXzkDCU/3b6rIWy0Dbc6cl/WKTuTHzsAcHqtH
         g24g==
X-Forwarded-Encrypted: i=1; AJvYcCX2w5Eu5D1zeGe5/YTQ2XO8FcEK1VQzazfY5uwy4w0M7hob9HzrITK1rYADMrCUfedvzohazZCPU5GrWowmM/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+cFcomaDs49iIzsfSqFvTCLLgZJpciZ6ZvGblz+EtU8exHBJ
	INu1fAWef1O761kQrTX6utUndHrY5sS4koHOFjfBiD2ndE+U0rdsDL05Uq/SQUQ1CF7ywbvrlW2
	GLg==
X-Google-Smtp-Source: AGHT+IFyTML4kwjlT8XJq9ynWGzbE9ai1eUBXHm+9uVGmQAwTAKz9Wy9ddid4pLEgQKt5V9M2r2fUt9K2g==
X-Received: from ywbkl8.prod.google.com ([2002:a05:690c:5048:b0:784:9edd:65d8])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:f89:b0:787:c612:f0f6
 with SMTP id 00721157ae682-787c61305eamr15892597b3.1.1762493406390; Thu, 06
 Nov 2025 21:30:06 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:26 +0000
In-Reply-To: <20251107052926.3403265-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107052926.3403265-1-rmoar@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-6-rmoar@google.com>
Subject: [PATCH RESEND 5/5] ktap_v2: change version to 2 in KTAP specification
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare KTAP specification for the final release of version 2 by
removing "-rc" in the title. This would previously cause a Sphinx
warning.

This series represents the final version of KTAP version 2 that includes
the major addition of test metadata.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index d118119910f8..1abb30887008 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ===================================================
-The Kernel Test Anything Protocol (KTAP), version 2-rc
+The Kernel Test Anything Protocol (KTAP), version 2
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-- 
2.51.2.1041.gc1ab5b90ca-goog


