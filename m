Return-Path: <linux-kselftest+bounces-18504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4C988A68
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F08282AF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BB1C232D;
	Fri, 27 Sep 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxPvMwyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9991C230A
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463139; cv=none; b=IOSZSFVjhrtJ7cGhcPiWWs87m2kyFPuQ5jE7OQZgCCwVYeckfBDtvc67X9IfGYWiZxRDVA1XHqz+C4Rn8Ao7sDfQ6WbfHyKOKdfwKeBhj0WWGlhCqzhX6LZYtuLaCWULqBrvu+4RFp3lL5Eq8SI1+VnYQK+0IFcUukfNRGjQqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463139; c=relaxed/simple;
	bh=CgVxO7j7fcIwhZ8sGJOfD3oqD56qz+Htb/d2q9B8S/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVAVQov5D1ckv1VVZUx51D/GB95Kp/r4MWLzDjeLylEULnZVwly/yL/sjprKk9gXRT2Ts2qLqevEg8UNLSqkhucZY5MPI7WdjaYvqiWLanLu/ij+1BbKlhii30tVGpUmRaWjqinCLua6kWrH/28Yed1k4N1fXCAVe2Xw4rN6Xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxPvMwyb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db61fd92a1so77502a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727463137; x=1728067937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjNTTjSP1D6OLEEAIGyE9s8gzDaTa6XxG0RsJUdZJBA=;
        b=fxPvMwyblRQ3qxDvCrQQpxwMycRjXr7B6dO49ipXVzJ/2AgSEIssr8urLu6pwOvNq5
         HrEaos/0Wx0qbZDdgx/HY6ofh1Cewqgt91JjpFUt3yNnQENa0HDeic2mpjPxNSDbW/fW
         qdoE8O4n254AB77a79oZptA7zu22IjVCdn/g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463137; x=1728067937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjNTTjSP1D6OLEEAIGyE9s8gzDaTa6XxG0RsJUdZJBA=;
        b=laeJ5JGAEAIEfMp6ntYnyjKjQuYAgMPpPDaQsejjpmA/9j6Sm58oTobMzPizN42aLO
         ZTWuGIzn3qQYpjDHbWLDBa1SbG0YVgUb7nEbsV438OvIUzxQmv0Cqy3kLJw6qyfsZN+a
         RhSTsnRFWlTG6yneUdkWh/0f9i4qFcKrbk+OEE23VufHenDLii0h3AHNsB946uhpy0I1
         OVx3FY7VMrI2nuN6ysKGGojLE09oBYcdOtk1SgMPMbkqXbyljqX5itoC8IMMZuUfJQ99
         +qOdFhh+8wmeeuL3hjnyClYL22kYfYcO0iphFJwDpItBsQ6WgwxpdFrpoRI/aCfixypi
         G/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTHSFsu+Hdfj+2FosUhTjsRYRWyLN29LPCTiF27wCeT5cCp08XWh5IJb/JGZGFhplbDqZ2ns6/GaKZ87O9UAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oAbDTM6pKj5VDLWgUy9GRINNd8Z06bfhl7z10P0G1fyK0SUv
	6rdRhVqeznt3z28cEEMUBnPJvbt3E1ZFgMcbW7v/Ia/TZ2H0Whvzpx+ax0FKmg==
X-Google-Smtp-Source: AGHT+IF0HtH1+PEmCntzA1h5vec66p92JMnSHwfX+hTVjrGe8VMsda+UKDIBB/ShNgo5UqX48lyoGQ==
X-Received: by 2002:a05:6a00:b85:b0:70d:2c09:45ff with SMTP id d2e1a72fcca58-71c636f23c9mr339784b3a.4.1727463137261;
        Fri, 27 Sep 2024 11:52:17 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71b265385fasm1922905b3a.216.2024.09.27.11.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:52:16 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/1] update mseal.rst
Date: Fri, 27 Sep 2024 18:52:08 +0000
Message-ID: <20240927185211.729207-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
 1 file changed, 136 insertions(+), 154 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


