Return-Path: <linux-kselftest+bounces-46832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C47C9887D
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E8344C72
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A8336EFD;
	Mon,  1 Dec 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DAda23i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9977335571
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610338; cv=none; b=FopnR90NddNMJVSnFbg9Nfx9/ChHhqpEoF7PqCuLBDZdRJnVeGI6WzlPANNP9yG2trMLn6BTRWZy2Zj9FdSoRPyVWRGfLQhZi17R/yvmtEKQXgv/uRlG1C4P218qHouqTnZ+2pFG4gQWaJPQSf62xrclaDaDyOEoozFRrbNEsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610338; c=relaxed/simple;
	bh=VDZGToZCwGbyT+LPOSKi0X+Ra5o2pIHsXNFLFhM4doA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap6d/Ram2/cbYuTi1NtXccaUFZrU2OU7/W7EPY5NlOGHLxCnncZAMCzXOGSZr0t3suASrxKR/MUUelVH9VBSXY5ThGd6bqYQoaIFvpEg1FbiOa1jNp5SDufg677YtKlOazIFkWneDQ6+oaU8x1P5MsL6uHidZPrkGaaTZFpFmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DAda23i; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29812589890so53133925ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764610336; x=1765215136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KY4xp3ZNY6XzsRcxr8jQOIjKB1zKw6LB85WN39mV5fA=;
        b=3DAda23ifJG8etQ6AmhHyV2tOHj7xS+4A9ZWI05KXDjUjzAT890NiuhRRDfW0dCIX5
         ch/Zjvz2nHr103gB9gvsdEsJ2+HirvOCJLjO3I3xzBzQ7IZlOFkOo4YkinZwAk8aGbzc
         tThR3IE6DSGooM6mlSGCyWadnyB5OeYplMNoSNVsXasNVlfxqo2SCZ1R1a9PZTjgDQ1p
         bLFaTAAr0Rh4p49HYgI2o2Ju9bvEzqlovXYHBJbIIPkZjWenpZIT+ZkB4SaDx2Y+613x
         +zRi22Vx3GEyZ+ByyzhPulczc8xpZpWR31uQO3jIujz37MEPftagR8cqJoNuYXeeVC0w
         5xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610336; x=1765215136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY4xp3ZNY6XzsRcxr8jQOIjKB1zKw6LB85WN39mV5fA=;
        b=u6gN7TkZDK0qO6us986Gzq/6Bgydfia3pV/0WPhHyidoiVxd9BJyRIF9od/LfKOKdW
         GnBlBZ45NETdzbhudFIuZgsRDfj3bRqSUjf8y0pqcCOrjNfh0d5zM5wMIoy+p+TGEnTy
         Kd2sZqFL3RZJbxHPQ0flSThXdpkcYR4mPIgymqVXfN0uXyQPeaLdOoW/faGukb3yO2m+
         /82CJ0Xpwl3WmAuenxClHwWrI8Q8KcoS+Qk1u6T8AUwZBWjuR+8JtQxpyZVk8yvGH6sG
         nA3fjG0zGpsOlZyPsDG5tkxydIFOwkQfkuOpwSoQwT4bM57PHAly/PE2szL2V+IbiueG
         +kZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+C9z09g1EOo1JF0hV4R62EwdEVIFxwDfPLyp552SLKZVB2r8zD9g8RaN/SIUUr3kNEKu0XsyI0HQUeOKPjLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhs+bEHcgEH0PIBGtEcOhhrf2tRzcHvAxe68G6F+A61Ab/WeUg
	4RTf3i7WHJTfNLtk1DoonU10uowq5T2qu/l6iBneNwE9tr/aKqGe+YBNad2WvKQ1IQ==
X-Gm-Gg: ASbGnctbCHSixdmkQzmcDGHPAewlX4kbpMyafqlni3MZfJsEp8qRDXd4aLdJBWfnlbA
	XJEfzqxZoUWgFtHsxuWXKak6bd1gRqaHKwYbe90WUCYwuzzlrxoy3fu5hmI39L9O2+eqlDMqPZD
	bw+wwJ/LxDaF0VNoe+Todjr4dVY9quwj70CTqSReu0dO3h8AyXyJNoucuIi3JYzl0AQjFzZuc6s
	evVce28I+qnfeQwx5+V4g/inApNpEBBJid6YIpXpo3JTBswfShHvdxUIgGwh3Tpmdws0sMsDkCp
	1r5QmsMMZdHYkoRYfn5v4+IQa2t4tjXSNHLY1x5rm59G8BPF1krrne6jKuWIeuf+XaXhduNgWdv
	bjAYhxSW1+kR7huUTLfsK/jFjMgTRo20BzdJ++83bgukfNTaSfp6y/yUqiAFK+l5fvlM8hIUx1i
	0edwKXQ+NjnHhVUcrLV5oPbjht0RyyojBPLpfbVWbdgy9b9WY=
X-Google-Smtp-Source: AGHT+IGokN2bwEae7Qbklk2bN7QI5ZgncXFMn6WS0kMGjsOhcqcWPHmUhLGTZo0eFJtMt3cgT78wcw==
X-Received: by 2002:a17:902:ef45:b0:298:3aa6:c034 with SMTP id d9443c01a7336-29b6bf3bc3fmr399752055ad.32.1764610333144;
        Mon, 01 Dec 2025 09:32:13 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce416f00sm128222615ad.4.2025.12.01.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:32:11 -0800 (PST)
Date: Mon, 1 Dec 2025 17:32:07 +0000
From: David Matlack <dmatlack@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
Message-ID: <aS3RF6ROa7uZsviv@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
 <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
 <4998497c-87e8-4849-8442-b7281c627884@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4998497c-87e8-4849-8442-b7281c627884@linux.dev>

On 2025-12-01 09:16 AM, Zhu Yanjun wrote:
> 
> 在 2025/12/1 9:10, David Matlack 写道:
> > On Mon, Dec 1, 2025 at 7:49 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> > > 在 2025/11/27 20:56, Zhu Yanjun 写道:
> > > > Hi, David
> > > > 
> > > > ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
> > > > vfio-pci-core.ko] undefined!
> > > > 
> > > > ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > undefined!
> > > > ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > undefined!
> > > > ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
> > > > vfio-pci-core.ko] undefined!
> > > > ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > undefined!
> > > > ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
> > > > core.ko] undefined!
> > > > ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
> > > > pci.ko] undefined!
> > > > ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
> > > > pci.ko] undefined!
> > > > make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > make[3]: *** [Makefile:1960: modpost] Error 2
> > > > 
> > > > After I git clone the source code from the link https://github.com/
> > > > dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> > > > 
> > > > I found the above errors when I built the source code.
> > > > 
> > > > Perhaps the above errors can be solved by EXPORT_SYMBOL.
> > > > 
> > > > But I am not sure if a better solution can solve the above problems or not.
> > > I reviewed this patch series in detail. If I’m understanding it
> > > correctly, there appears to be a cyclic dependency issue. Specifically,
> > > some functions in kernel module A depend on kernel module B, while at
> > > the same time certain functions in module B depend on module A.
> > > 
> > > I’m not entirely sure whether this constitutes a real problem or if it’s
> > > intentional design.
> > Thanks for your report. Can you share the .config file you used to
> > generate these errors?
> 
> 
> IIRC, I used FC 42 default config. Perhaps you can make tests with it. If
> this problem can not be reproduced, I will share my config with you.
> 

What does "FC 42 default config" mean?

Either way I was able to reproduce the errors you posted above by
changing CONFIG_VFIO_PCI{_CORE} from "y" to "m".

To unblock building and testing this series you can change these configs
from "m" to "y", or the following patch (which fixed things for me):

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 929df22c079b..c2cca16e99a8 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,11 +2,11 @@

 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 929df22c079b..c2cca16e99a8 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,11 +2,11 @@

 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
-vfio-pci-core-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o

 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o

 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index c5b5eb509474..b9805861763a 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1386,6 +1386,7 @@ const struct file_operations vfio_device_fops = {
        .show_fdinfo    = vfio_device_show_fdinfo,
 #endif
 };
+EXPORT_SYMBOL_GPL(vfio_device_fops);

 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 69298d82f404..c7a0c9c3b6a8 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -256,6 +256,7 @@ bool liveupdate_enabled(void)
 {
        return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);

 /**
  * DOC: LUO ioctl Interface
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index fca3806dae28..9baa88966f04 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -868,6 +868,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
        luo_session_resume();
        return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);


