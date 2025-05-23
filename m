Return-Path: <linux-kselftest+bounces-33712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2AFAC2C49
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A963618993F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B822154E;
	Fri, 23 May 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zT0N9KZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534921931C
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043056; cv=none; b=OXKwD+AEtt6F2GVNLHby2BK5a8PcWoVVFh5m8/yc+qULxrb9CrBM52t5K3CCYvICYhm4WgqgzEqPjJBj3oSga9bhdGO3kydjOZeaoI6IPPgDS6DHGPZ5a63/CXWHuxbpvdygrdbpYJ0Ww7F5vuVKEX1edEDmBCGO6y7zqpT9E18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043056; c=relaxed/simple;
	bh=dFtrPNzibnoP5Q7a+bTOupNA6Ce+350wvfJvv0KA948=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pn3bH1CDIXFiBjnPyNwc9B/GIDuyb6R7tYe9AIOvHc4G8u0EzhI/fLR6fPMT5D8c/EjgkqsO4gU0URXa7r4iMMxv3ILGmfC+fdR4S0Wq17g/3TGXUlwBEzKczknEOmiP7YwoYBdL4NluKgcLTPDNHhxQO6hc+x1KATyXeaq5wcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zT0N9KZ7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231e059b34dso2438145ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043054; x=1748647854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=92PZ7wTBqDIDnlMIL555YPMi5xF9sVNf6yuiwxxZePE=;
        b=zT0N9KZ77ikRKD6z/9wgwwHNaiM4jIU3Z/0TnK2grXnoFidPRwR5K5/zcAUkiz5MrE
         fo8q13GobF8VrUerJmigpZLhbZ10q/se7QMsu8vaChmmFPdx2dtrcK9jwTvSOV6fjRjj
         rUZ8wuDaF0mjnmJ2Ju/aqioC4+QZwJh6JW8fVmedPeXs4scx/wJWSlhc/1QJ86B9OWib
         TSPUtmGtK5H2pzNs1nWF2NUefGUzfIx8G/bEQCU7h1CWYzTEQVNjLfK6NtLzqTvYQnBe
         18sqZE6JkFl4/MMJmF5nwxAkPz7BsEAgnI+yMTUUJoauZQueo+PAmqRigX8t9GuiUrU9
         yghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043054; x=1748647854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92PZ7wTBqDIDnlMIL555YPMi5xF9sVNf6yuiwxxZePE=;
        b=jPSEKJ4vAccAt9LdWjkVtg2QmYXwmNquvHJxwdO9tvHxOykomZssi6AzCAJNcQWhl3
         bFoK3C64D4RBCYavYwQH00vf11/dIDT4CO5AuBs4HYZSXHjUeY7vx7nFtAhOIYI8meKz
         nQ1byQ5mu1jvWOW38+TxnkmGqhywKoAVFVrRiZjkmeD9yZ3Khiin4sc1TLaJVtB3nIZr
         CWM7CrMRwRfOnaGWPWXiTtBaKXcO5fFDoi+I+NUdxen7SaZc6FORJk2Es8/CNo1qi3JL
         fG+QsKvRSSHoytcv/xbbOCe/5FPHClXWpUwo+euuqeJk9In1+uCSpPrrD+pqPG7b0Xal
         v/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXm9Hah3H736N0Vn5XK1zaBsYSSllKa9xAXC1Vj37W31nbSE5rqBwpDLfUqK5aDIGs08/4fjjcPs3PG1NYukAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfG84Fgi0LQ88oKOZi9+v+X73MCkDnPD7r+o7PJA7D1XUva98
	J/UP0EUfui2OdvA1FOMMywQHKVrkoLA6jMGbd91zG7Vtye+zecYVZ0bll7IxaMu7ANf/UNoIM3h
	Uqj/GOqOy64+PCQ==
X-Google-Smtp-Source: AGHT+IFfBPGyHh5gLz0p3XWIucvTzmBZpdUi4N3bwxhWzbLyIVEI/9mwtC+xDUgrjDTYl0NadfIAofuNLe2oUA==
X-Received: from pjbsu5.prod.google.com ([2002:a17:90b:5345:b0:30a:4874:5389])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:22e:37b8:7972 with SMTP id d9443c01a7336-23414f3aa64mr23105975ad.10.1748043054439;
 Fri, 23 May 2025 16:30:54 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:02 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-18-dmatlack@google.com>
Subject: [RFC PATCH 17/33] vfio: selftests: Enable asserting MSI eventfds not firing
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Make it possible to assert that a given MSI eventfd did _not_ fire by
adding a helper to mark an eventfd non-blocking. Demonstrate this in
vfio_pci_device_test by asserting the MSI eventfd did not fire before
vfio_pci_irq_trigger().

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 ++++++++++++
 tools/testing/selftests/vfio/vfio_pci_device_test.c  | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index ab96a6628f0e..2b96be07f182 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -2,6 +2,7 @@
 #ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
 #define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
 
+#include <fcntl.h>
 #include <string.h>
 #include <linux/vfio.h>
 #include <linux/list.h>
@@ -116,6 +117,17 @@ void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
+static inline void fcntl_set_nonblock(int fd)
+{
+	int r;
+
+	r = fcntl(fd, F_GETFL, 0);
+	VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);
+
+	r = fcntl(fd, F_SETFL, r | O_NONBLOCK);
+	VFIO_ASSERT_NE(r, -1, "F_SETFL O_NONBLOCK failed for fd %d\n", fd);
+}
+
 static inline void vfio_pci_msi_enable(struct vfio_pci_device *device,
 				       u32 vector, int count)
 {
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index b969ecdfb042..27f60cccd3a7 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -125,6 +125,7 @@ FIXTURE_TEARDOWN(vfio_pci_irq_test) {
 TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 {
 	bool msix = variant->irq_index == VFIO_PCI_MSIX_IRQ_INDEX;
+	int msi_eventfd;
 	u32 count;
 	u64 value;
 	int i;
@@ -143,8 +144,15 @@ TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 	printf("MSI%s: enabled %d interrupts\n", msix ? "-x" : "", count);
 
 	for (i = 0; i < count; i++) {
+		msi_eventfd = self->device->msi_eventfds[i];
+
+		fcntl_set_nonblock(msi_eventfd);
+		ASSERT_EQ(-1, read(msi_eventfd, &value, 8));
+		ASSERT_EQ(EAGAIN, errno);
+
 		vfio_pci_irq_trigger(self->device, variant->irq_index, i);
-		ASSERT_EQ(8, read(self->device->msi_eventfds[i], &value, 8));
+
+		ASSERT_EQ(8, read(msi_eventfd, &value, 8));
 		ASSERT_EQ(1, value);
 	}
 
-- 
2.49.0.1151.ga128411c76-goog


