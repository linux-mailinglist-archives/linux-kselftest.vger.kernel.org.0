Return-Path: <linux-kselftest+bounces-46833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41171C988BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5735341692
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EE5336EF0;
	Mon,  1 Dec 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU5Q7CCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8733346AF
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610607; cv=none; b=W2iuG61dY9OwdELzCzhcZaYHT6agAf60EzswG9ZbAriBKDlNChvbcWnlyhAwWmMF1ge5SlC4fPsFqIU4Qmm3JllHQG26/ECF3LV3whmVpEWhAtL+m99kErQxVxBNkfOd9aUY5hj3HxYvBuba0POyGbSkBcB6hFz1ovG0WRudSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610607; c=relaxed/simple;
	bh=OYq063x/kWzolRkbiS0sRgj7g8DeK/P7vo8HUfxzrvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7BZRUi2wTiGVNe6CXHeQj6hBuSiH/GWvZ5SAMZUg4Gy5Ci0+N+YDRhirno4WW6stFaV+BWm8i+oK16r7CSlfcRP8clLqTCgSibCIdHbztYzTf/1C7K/Q5p/fucLMewC2wCqF2LyqxBvspTNNitwzJhnpUv8CJX3OtgeNsfVIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU5Q7CCJ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34372216275so4570803a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764610605; x=1765215405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yOls94FUtGD6Qyq6JZRmBlpF7rbm3X6QAjMJEPTNkM0=;
        b=qU5Q7CCJFHR6Jip8eTXb1OUvXcoRmd1DbEL1PGCQvTCDbLeEGCiDNz3pSnVoCq7o8u
         IT1dUJKU3caUQMDZkEqaP8VBe5eRpybch7bzM7t+hyF06xeMbOSxlyftw6BXByKdWXWb
         mUdsx05QI/LBYGVSg+Ry35Stuw96LBIX6G+oXvuOpzN/eegg7QHZxEuMmpW1J+vzClT5
         nLJLi7j5E/a0tc1o0CpEqKKSobbmvFOZy1ktvcrgD66v9+g+8CCOTB++dbQ2xICoFLzJ
         A34r8/YorzDjFme4V7QrBJTPSi0Osj5QFSkZPivL1W9givcHR+sx5AExhOXfkEW+lO01
         DaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610605; x=1765215405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOls94FUtGD6Qyq6JZRmBlpF7rbm3X6QAjMJEPTNkM0=;
        b=Z3sGIQEoJRX6nF6sGrIAVbUIEJv8jyOBr+SK86Kvw/AKpSUFkq1FbWsVP2bRoKhm5n
         jjprFAPGgVYDOZQMIY/MzeHNf4v8k85FZCos4v0iZoCmxpkqSN4O1QuAMTpXrzHgZKoh
         fhlT42GOFc6+Erocm2OlNbYovN76f6W6gOUjsGhuVBAchvbh+27lFFV/SfQCb9MV7idw
         Z74f/Qjp3SZSk2V3bGmJfxANY34xQ62ssDc+jheKlD5GpjmHq1gMRuErfXIm4fUuSQat
         lSNzyhwKIk5ufiMI2/sEqMw89O3sHm/XZYEMS+Uu1SMdfjujY15uPzuOc+RNSr2yjVQs
         FBkw==
X-Forwarded-Encrypted: i=1; AJvYcCU48uuPxU0IuPMyRphxeVHOopD9ngJXYNK1ag9zPoPVvl3wpsK6R2CMYfAIckOY7iXV4GVjhvfdMs/ajbgkl3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEs7h38WkGgG0+MlD4+B/4ULb7G9jPOpVmLIOdFZxH3v1207BA
	NsspRLYLgZkcFMcukoWBLyKj8sgHvwIq6Ng5U8YzRNAnspQ7pQFv39ulmbn2maW3MQ==
X-Gm-Gg: ASbGnct4cmO2LifXFfA5FgmVY6KfCJLllPqMtO5bWcoCG/MrmgWMtC2WWKCMfhUfvUm
	BOeZ49FDndabecRaFgOL1+UzDqQvMiBVbG0Q+g+lNdY+hSnlI7TtIsuAkmB4pNwDrHecLCnhjYa
	5dkkKqFIcge6FUz6izt3xeWpN/DnfzxCZe1ubQyrzC2cH6zu2Wpm8r49GoCI3osT02rEB8sIwni
	r+T1Xp+i+QR7BS/tTWYbFzO6Uo2X4t3v13izL2ZxTFc5UUjjvujunMxixoe8oWS89qWNRh/j3B1
	dLq1+bvPw4lm4hCMt4gt8IWs4g9Bka5daQBDxNZrINmegWy+oeGko4dBXQN0J4Psc45QtyI05wu
	09FySPUt5bzYw8yUaGUp9BkTqpnIz7cny5Gw8wDpBawD3y1YQs7zb3e5NTnu12GoiOOlwue/dQC
	VyYIl4Vv7OV+P1xdJ9DrNhBOGPK0pYil10gEsZtaTb2JYBRNc=
X-Google-Smtp-Source: AGHT+IHxNL4zVA4YwR2Gk5dBAeB2uwQdYit3oH3bwVFcnVNWz9JhOvi5wb83c3kF4oupUBwnEmP3sQ==
X-Received: by 2002:a17:90b:4b03:b0:340:29a1:1b0c with SMTP id 98e67ed59e1d1-34733e6c8aamr43027950a91.7.1764610604811;
        Mon, 01 Dec 2025 09:36:44 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a54705csm17545241a91.2.2025.12.01.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:36:43 -0800 (PST)
Date: Mon, 1 Dec 2025 17:36:39 +0000
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
Message-ID: <aS3SJxAjVT-ZH1YT@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
 <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
 <4998497c-87e8-4849-8442-b7281c627884@linux.dev>
 <aS3RF6ROa7uZsviv@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS3RF6ROa7uZsviv@google.com>

On 2025-12-01 05:32 PM, David Matlack wrote:
> On 2025-12-01 09:16 AM, Zhu Yanjun wrote:
> > 
> > 在 2025/12/1 9:10, David Matlack 写道:
> > > On Mon, Dec 1, 2025 at 7:49 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> > > > 在 2025/11/27 20:56, Zhu Yanjun 写道:
> > > > > Hi, David
> > > > > 
> > > > > ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
> > > > > vfio-pci-core.ko] undefined!
> > > > > 
> > > > > ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > > undefined!
> > > > > ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > > undefined!
> > > > > ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
> > > > > vfio-pci-core.ko] undefined!
> > > > > ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
> > > > > undefined!
> > > > > ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
> > > > > core.ko] undefined!
> > > > > ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
> > > > > pci.ko] undefined!
> > > > > ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
> > > > > pci.ko] undefined!
> > > > > make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > > make[3]: *** [Makefile:1960: modpost] Error 2
> > > > > 
> > > > > After I git clone the source code from the link https://github.com/
> > > > > dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> > > > > 
> > > > > I found the above errors when I built the source code.
> > > > > 
> > > > > Perhaps the above errors can be solved by EXPORT_SYMBOL.
> > > > > 
> > > > > But I am not sure if a better solution can solve the above problems or not.
> > > > I reviewed this patch series in detail. If I’m understanding it
> > > > correctly, there appears to be a cyclic dependency issue. Specifically,
> > > > some functions in kernel module A depend on kernel module B, while at
> > > > the same time certain functions in module B depend on module A.
> > > > 
> > > > I’m not entirely sure whether this constitutes a real problem or if it’s
> > > > intentional design.
> > > Thanks for your report. Can you share the .config file you used to
> > > generate these errors?
> > 
> > 
> > IIRC, I used FC 42 default config. Perhaps you can make tests with it. If
> > this problem can not be reproduced, I will share my config with you.
> > 
> 
> What does "FC 42 default config" mean?
> 
> Either way I was able to reproduce the errors you posted above by
> changing CONFIG_VFIO_PCI{_CORE} from "y" to "m".
> 
> To unblock building and testing this series you can change these configs
> from "m" to "y", or the following patch (which fixed things for me):

Oops, sorry, something went wrong when I posted that diff. Here's the
correct diff:

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

 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -913,3 +914,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
        liveupdate_test_register(fh);
        return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);

