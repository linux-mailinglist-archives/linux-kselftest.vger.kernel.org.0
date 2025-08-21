Return-Path: <linux-kselftest+bounces-39441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E519B2ECD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F273A230F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA62E974E;
	Thu, 21 Aug 2025 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2C72277"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741002E266E
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750577; cv=none; b=ddWhIO5CaHXLwITMPAPSOvpz//fWZ8JbZMSf9Ng6gG1tCpdg9g4uoyU97q4us2pp9Q2dbRwH0KxOGEQv5VKOcL01uwOmgZoh7DKxmK73jPpY4iHHy26PxF4hO510TWtC/uKehHJmt6wRmR6ys5bPktypdEKCODkM7unmFPnP2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750577; c=relaxed/simple;
	bh=vURJuaTJgpJrNoJtPEWt6WiaWS4FRfHo+2y+TWkm0fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mvbuj1U7Ol/tFGHXYEVmc5B92YFN4LK1xpFg/KHmB/0E/ebYZR7ZW09dwjaa6SeG0NYls4rTdBKidFJS+yzsUn4fzahGcdJk8m/eE0shj+t4txgJUIizh9EWHy6IGefhzE/ddwJEIWfRG873RAnB9mP93bA8ovTtQ31mJDS1FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2C72277; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so1420728b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750574; x=1756355374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHTIOBYSzMnE6EOZqw7vJKgl7xxjhcrY2TbGVLNzD4g=;
        b=V2C72277vkf/x+Ezh412qvmFQc8r/81Jmo52XfaMNV24hwbnnyk82h70KTSJ0b9sCI
         BZQyxWNNNZfGej4Tvi5IzTrfE0/mIC1utn/W9IcybBdFWT6ceieYKsR8uWfBRzq7EbK4
         m0RGdE40KsPCWsjozVXcVVabGhhUw2rBMD8k4vUVQ3NeHtD0zP5gCOebrSS+3I4k8qDe
         2koPoYxWuUYQTH5n+0VN6Gc9HU9kWvg+lodvSdeX2kxq8Rdy18QEdsqWrHTBN4H7Ydmv
         l0m2I63GHQsKPw2f07yLb+KpJG12UA+JwFuzDyVKiOsXgH9vmC77LGQ7zxTh6jGQogOx
         JMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750574; x=1756355374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHTIOBYSzMnE6EOZqw7vJKgl7xxjhcrY2TbGVLNzD4g=;
        b=U7EEDUOWt8bvzm8mZJitoisGn86CFY/o4koYfcEQZfrWDu0cLVL5Pw49qXeuWIxjIl
         v+fZZ1gAPanVOoDQEoI0kSaxTFTwn+E6xLoqJlwGeDU8ILaC0VRUsauMdPevv5Zi0K1p
         9s42njaHeszaQ7Irjik/8uXPtiH88xAAay9lXAuABx/Suok2X0Aj+epg1gDcUdRDgB9Z
         /UkcNNn36VmsWqcrNQ899A+FVh0UK6e+zBNJLiCNHz3GdIug4loIw+S8w7lFstWWhml2
         mtYt0leq+3ENyl7CwomB7+Zhj7GpVtEJl9HI5YfzLLShuHEOnfwmJXlu27mLFvKm7byL
         OQ+w==
X-Gm-Message-State: AOJu0YwXhciwINGDeDUgtRnItRIy+MZTZ2AcLIoIiDd1iL0dxL6LySIJ
	/RE7cONqG+hZzvrxsA6nmPiDSyuxeutxQmCkEdHfxAIez1CuGw6HfqKVxhxpltLL1zbopmxF+Yo
	Tag5O4UCuQuEHxT4uAaRd0M8N5IXgJobAoSnhmM2HBLVikE3efulyEajDUppxtspuLCIEWoym/e
	apr0PH5wd83yKJNuV8nvkLqQNE5d0VRCefxWEQSh6W/18=
X-Google-Smtp-Source: AGHT+IEogHLnsU59K+YhiS8GmhysBJljBZUNk59MXmsUmcznnLFTw8hp+ugeBcYKsTqkVN1vpDAhUqwJkw==
X-Received: from pjbta12.prod.google.com ([2002:a17:90b:4ecc:b0:311:c197:70a4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2446:b0:243:78a:82b3
 with SMTP id adf61e73a8af0-24330ae0a9cmr1475818637.59.1755750574463; Wed, 20
 Aug 2025 21:29:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:00 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-8-sagis@google.com>
Subject: [PATCH v9 07/19] KVM: selftests: Add kbuild definitons
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add kbuild.h that can be used by files under tools/

Definitions are taken from the original definitions at
include/linux/kbuild.h

This is needed to expose values from c code to assembly code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/include/linux/kbuild.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/include/linux/kbuild.h

diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
new file mode 100644
index 000000000000..62e20ba9380e
--- /dev/null
+++ b/tools/include/linux/kbuild.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TOOLS_LINUX_KBUILD_H
+#define __TOOLS_LINUX_KBUILD_H
+
+#include <stddef.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem))
+
+#define COMMENT(x) \
+	asm volatile("\n.ascii \"->#" x "\"")
+
+#endif /* __TOOLS_LINUX_KBUILD_H */
-- 
2.51.0.rc1.193.gad69d77794-goog


