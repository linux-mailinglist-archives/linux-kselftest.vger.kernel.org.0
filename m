Return-Path: <linux-kselftest+bounces-43472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980ADBEC22C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253B61AE1838
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B223925524D;
	Sat, 18 Oct 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmVv89H6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF524EA81
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746082; cv=none; b=iakOqEQkmpABXV2GdmQzCXxvk2TgdOyET+6CNOeDSVJg7p2hSVb4iGWiI/K3MP1sYbHRvxlDcqLxCrg1d0XHsmSZ42dA29/7Y09M7MnhzE8/6Ej9GEL3WFPFQN8A8pG72xGfsYD5vBESEmDrBh8QFxeS4lb8cFVFlWZ4pCJM04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746082; c=relaxed/simple;
	bh=AadBcH6XuFUx3o/uyM4DKBt13sMey6ABFLv07q0/8bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l92qTMBwNYiaLvLyzSTCwu9sBtF2UeTlgrUWvLdczkqqgDSV9ILJusJMmuZydjgYo73Vzp3T0pF9wQSzBbzSboYdj6UfKrqyQJgUzvGJjiwrRMz/WwNeygdzS8eLTkri5Ioah/tPK0kLClHCwT8XA0p4LmcNepmfV4bYqjYoQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmVv89H6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so2240527a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746080; x=1761350880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf0V49FB2cemzthaMtFIU/EunA9kfJDBrs1ERauwF5c=;
        b=HmVv89H6ag/Qjal6jKnudJV076pe8pdNfdacsyF/qqidCkLPbYJLAOef/hhR85QBRb
         lOAbqn90v8jNs78lWIBwom7ceWAsdd41xE+TSnD4iq5+vsvUy3/J+3pM1STK4tMvl/tT
         X6ZF5ZiIgwUgTdI5q1GA9jWmWwhe8nBzyrqPU85q1YTQCeFU2/RGDfYS9/9uK0poSJio
         FCX0zwsW6B2ZoJu+IUitB0wLLMfrI1kzDzwW0Bhj9v/phQfrRzGCTOgbRNkQtt310g2D
         qKeO9yhNfKjoH69dNQ/6GZSZq46ICoXb7lZjb9qf2mVs1oSPHWVFJa01P00Tnjk+i2kt
         ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746080; x=1761350880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf0V49FB2cemzthaMtFIU/EunA9kfJDBrs1ERauwF5c=;
        b=t4eqktYkWBRSG5KIAFjX+7GAaIoyZIZ4iajWIhJfuEePbsD3a1xLEsbKtPuO4SYzku
         CSSz4WquN19VK8Cb33JwCDJ/hmFc/x8NOhi2faAr2mD0ZH+EYoUv9fWuNrpcT2iYmKU6
         BQ2hT4ESO415RtCZ1q/RHSUZXSLBfnRt1J7gHJg3ivP9GUOjU2RulPjsmqoTB1quvucJ
         st9N39ZTSodTM58iN2gZauHQwNdh9I1YTjZsB+V0dF9vOJh7cl1aREAkK/MP02OPBxh8
         uguQ4uefLQHz5VA/14OTkHvWdZTaGYLLDdTj5wKsAddxIQTfLgoG3iUcQ6jdTVaUXaCm
         REKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSc4rKZrpeCu9ry8xABosFNFPG63RudVh79kXJnfFFFDtY+W69GiIyXZncEGzN00LwutWTBEHTRorUq3cuXiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBukWvY4D2I5kOaLZzPgOEwI0+PxFoMQjgcBtIyjumBy21DGQ
	Zq1VzVCH+ykPSm0lGas3Z+GCYlfqZ/qIWDVb0MR70bfSXdHtpRC4OhyAD8ZfHIzIYkDKD4h1f8S
	IixQkfhn1hA==
X-Google-Smtp-Source: AGHT+IH3PSOfb25TFSyUmjh3MfKE86e6WefuP65fW8Nk0BjyxdVOlYJQBG/sYV/zeL2CFmcYNYIQrzD32GyP
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8e:b0:334:9c41:bdcb
 with SMTP id adf61e73a8af0-334a86445ddmr6954433637.58.1760746080171; Fri, 17
 Oct 2025 17:08:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:13 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-22-vipinsh@google.com>
Subject: [RFC PATCH 21/21] vfio: selftests: Validate vconfig preservation of
 VFIO PCI device during live update
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Test preservation of a VFIO PCI device virtual config (vconfig in struct
vfio_pci_core_device{}) during the live update. Write some random data
to PCI_INTERRUPT_LINE register which is virtualized by VFIO and verify
that the same data is read after kexec.

Certain bits in the config space are virtualized by VFIO, so write to
them don't go to the device PCI config instead they are stored in
memory. After live update, vconfig should have the value same as prior
to kexec, which means vconfig should be saved in KHO and later retrieved
to restore the device.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../testing/selftests/vfio/vfio_pci_liveupdate_test.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_test.c
index 9fd0061348e0..2d80fdcb1ef7 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_test.c
@@ -15,12 +15,14 @@
 
 #define SESSION_NAME "multi_file_session"
 #define TOKEN 1234
+#define RANDOM_DATA 0x12
 
 static void run_pre_kexec(int luo_fd, const char *bdf)
 {
 	struct vfio_pci_device *device;
 	int session_fd;
 	u16 command;
+	u8 data;
 
 	device = vfio_pci_device_init(bdf, "iommufd");
 
@@ -30,6 +32,10 @@ static void run_pre_kexec(int luo_fd, const char *bdf)
 	vfio_pci_config_writew(device, PCI_COMMAND,
 			       command | PCI_COMMAND_MASTER);
 
+	vfio_pci_config_writeb(device, PCI_INTERRUPT_LINE, RANDOM_DATA);
+	data = vfio_pci_config_readb(device, PCI_INTERRUPT_LINE);
+	VFIO_ASSERT_EQ(data, RANDOM_DATA);
+
 	session_fd = luo_create_session(luo_fd, SESSION_NAME);
 	VFIO_ASSERT_GE(session_fd, 0, "Failed to create session %s",
 		       SESSION_NAME);
@@ -51,6 +57,7 @@ static void run_post_kexec(int luo_fd, const char *bdf)
 	int vfio_fd;
 	struct vfio_pci_device *device;
 	u16 command;
+	u8 data;
 
 
 	session_fd = luo_retrieve_session(luo_fd, SESSION_NAME);
@@ -74,6 +81,9 @@ static void run_post_kexec(int luo_fd, const char *bdf)
 
 	command = vfio_pci_config_readw(device, PCI_COMMAND);
 	VFIO_ASSERT_TRUE(command & PCI_COMMAND_MASTER);
+
+	data = vfio_pci_config_readb(device, PCI_INTERRUPT_LINE);
+	VFIO_ASSERT_EQ(data, RANDOM_DATA);
 	vfio_pci_device_cleanup(device);
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


