Return-Path: <linux-kselftest+bounces-43461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B587CBEC1C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434581AE02C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E21F419A;
	Sat, 18 Oct 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxbC1Xqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE61E47A5
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746063; cv=none; b=keKHBwCgbqgW1VED/j79B3+VePEJuhbL73C0qa2jiJVCdVl8/rxSLObDWpn5NrnCt/INO61NsCUXuR2WqE9LWc+LuQZ2rOB/dtyQ1IbzJ40b3CjyfxiFr4K580cEk/7X+YXE9zlSox5bCy+p3eHbGh4X382+4rNFdLjvO1ri+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746063; c=relaxed/simple;
	bh=+K5j39XpTNwLHlWGtorRqscxgPOaq/a9DZ3eNvEVcAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQ1H3M/k8Uy8bkxy25ZCDs0fdE37vrpeGdZlHD7CYZ0cIgzcT4pSXlxb10pTwBluQc5IO+Ty/XV++7HwVBLkt5lxBH/opAmSq/J4++6UKi6cL6RGXOxABLJ4Df6t55BX2YmZyst4yXL7BsPt5RCwr4E90fyXQKb5zsKBM9umXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxbC1Xqn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baf262850so2518093a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746060; x=1761350860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnxsirzJmf+9oD/SWVkkILfWOZE9umducoMflFiqRpQ=;
        b=fxbC1Xqn8W1nVGvBqnvR20qwKq5qnLQ7aKJXzkOlzYZMbt8jbveKl6biOBHq4yu4/c
         8fSeul/cLUVKsf8FnwMDV2zPCoMVM0tb8nRHdZZ2Lm2ntYPrO/A2OwuyDKLx7q7Sb43n
         sIJCqSTOm5LtNtzC+DUYgQQ6kvBER55r01PS3e4AVbGOQL1wilCSfz8sxP5AU4gXr2++
         lN2Ps/Uka90b/x5r+ZSoFs2Hj3O7uzrpWL9hApP2QKRal/YXRK5XpNx91bjfHABZgDdj
         SbJQ3AVBw/2SvSl0eQj81AWWsfpNzEsTwQUOEwYGRWkeCKTAt3IV+d1ZYbCt/Qj+Mgzp
         D6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746060; x=1761350860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnxsirzJmf+9oD/SWVkkILfWOZE9umducoMflFiqRpQ=;
        b=KxLbeqE+QFKgqz0q3dkdENplFz3U9eCj4ZsDU16uicExGwBxa3OffmzvM94SE1WiG5
         qO5ss5SkRNYsKLDoktgsV3yzVbRrEnkm5OzU1pDULlegMapbmRjFMb+dxfrg3QPjqE3S
         KyqG/AlCM2cYNnNxld8xLp7Is249goOFHSi8I94i3mjCl0NOmSHEAQIS1Qn2lnUm3tVD
         sI3JgGqTDs0qYqVnHpCoEiU/PWyHgle4SsV1qPxN75sXSJfgrusQeMx2U2+EDsTDv9gO
         +qfP45seFo8BzXCsidkOZB+IXu7GV5a1/DYgmynuHXC9IaJHoyxmfkMzd9nzvEZxB0hk
         e4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW0zaSfPppQT8qcD7pcrtzzB+2NdBhwHw6aETEFpkZrJCw1EXIjuFc5Kls9ahqYh9uGVwN9DEELPz7f2b1IDl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMxiDnNhdHgv8Unm8+nL0KKuLtVM2rWbLlOcCJBSV269VKUlM
	FjUfrzgq7yZg9JDky3aLTcUwealAMYpGOpuCR5upX98tbqyfHYci/Jk4v1vjcULac4thf9RoLTT
	BADVv+QILkg==
X-Google-Smtp-Source: AGHT+IEDeX1KBK/211Sloe9HHYyIrse9Vb0jW4j/mlSMb7ebaIyHdLdJhj4WQAl1ftyT6/JHbLuQi37Ll112
X-Received: from pjbku18.prod.google.com ([2002:a17:90b:2192:b0:33b:a383:f4df])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d85:b0:330:4a1d:223c
 with SMTP id 98e67ed59e1d1-33bcf87f421mr6072321a91.15.1760746060452; Fri, 17
 Oct 2025 17:07:40 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:02 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-11-vipinsh@google.com>
Subject: [RFC PATCH 10/21] PCI: Add option to skip Bus Master Enable reset
 during kexec
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

Add bit field 'skip_kexec_clear_master' to struct pci_dev{}. Skip
clearing Bus Master Enable bit on PCI device during kexec reboot.

Devices preserved using live update might be performing a DMA
transaction during kexec. Skipping clearing this bit allows a device to
continue DMA while live update is in progress.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/pci/pci-driver.c | 6 ++++--
 include/linux/pci.h      | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..6aab358dc27a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -513,11 +513,13 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
+	 * devices in D3cold or unknown states. Don't clear the bit
+	 * if device has explicitly asked to skip it.
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot) &&
+	    !pci_dev->skip_kexec_clear_master)
 		pci_clear_master(pci_dev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..8ce2d4528193 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -400,6 +400,8 @@ struct pci_dev {
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
 	unsigned int	skip_bus_pm:1;	/* Internal: Skip bus-level PM */
+	unsigned int 	skip_kexec_clear_master:1; /* Don't clear the Bus Master
+						      Enable bit on kexec reboot */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
 	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
 						      controlled exclusively by
-- 
2.51.0.858.gf9c4a03a3a-goog


