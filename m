Return-Path: <linux-kselftest+bounces-46380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2236C80301
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB8E4E5D59
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A042F3609;
	Mon, 24 Nov 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="citxw1pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D321A444
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983225; cv=none; b=kk5QGac9CHipItNXYqC+BKPfxQS9snZWL2YvoC89EOu+rN8BGoU43ycCTQQ6XI/PgdECMbUxWbk2gCKnWN4LbljuOHDSR/cEBCvpZpXdh7mbFLRHZ/Yubcv3AWB7IP7XT6UIisOrPg4yLeLi5k7HBC7NJ0rbMlohR1zEpMVz6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983225; c=relaxed/simple;
	bh=hc80IWbycNdi4bXg4cEiAnOpyHwnVUy54ihhoIQ9Mjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPfGiFFwAro6RXCPbTKCXs1nQqYEHYToWsWYboc1iY+UPjdGbI2zBjJvEhvL1ejRjhvD3PuwycDDUCOACMtsLcEgvMBHdggvnwruEAO09AXFmnn00s4SrwwaGmEzqJAi7zNZqo0xCAoES0SKaMGpv9SqSDa0FSPtNLjYE49iCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=citxw1pm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee243b98caso459821cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763983222; x=1764588022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mocyEglELKGPtUD52CXloMOUZ7FDRGa7vgCI+p7SF8c=;
        b=citxw1pm57sPEuyQXVKTGbV4nSI0rVCfyjBPjjRlK8PkodR5wwoplBmvHbfN0ph3Ry
         pKfwmW/po2GNhkFXwq0hk/QxQ9Et90d2tKkBZLH8xpVRsMpU/d1w2s0PTXrSCMTARFAZ
         Gin4bKlzS3JIablUcFowFGGWtOZBuKF+8sEEk5i5sJUzsF/ubPgZLIXKnIRUk4e9Hxya
         uT7go5lQHcG/dcKOUquWGDgWrazzwWTz5g04g+kXKPSlh6oDy4UMK4oltnZ1O/I19604
         IEfiB1fZrZkxVLXj7BPPnHNdPUoxAMUylboEOgrcGMvvLQ8jkLlN5qfBQIu82PzwcMVb
         ahrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983222; x=1764588022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mocyEglELKGPtUD52CXloMOUZ7FDRGa7vgCI+p7SF8c=;
        b=uoPt5YmBL9adnEzJyZ8JXSWu+mMllLH+D6qzoJdcD1ks4uvfskAeuuB27AqVPTL3oA
         YV9cFTdJ7rA19WLZ5ZDCU8IJ3eDjj6o/RPiUEP+Q+H5O0O7zOthigfo6lwELuZeBcC62
         6XVW1fEv6R3DbsmuCIPuVR2El/L/DhtFnLhFm+SmgqX9xZaVUqjEhCpqEHVtP8LYa5yU
         JYuadqbnspR1D59aMLs9CDe9WALljqdwY7L85KvgDHcSoLfjTf43TShl05tlaTTUvP2A
         e51deLq1/UYy+pdEr0idGG6byh9NkFm6rNwFcISP3bGoMXWea0CC+2VA6CgLbALl8bMX
         unWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkqvE+mGV9WDdX5cCA8NblnwnbCkY2hiN0ycC3+kdv4Asp2fsFk40elMEU+5hZEhpR5F0RayVCFXvVBThi3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/8+LXhQpTZ0G4gGDurnx+vrnL2o0mG6TO2/AlqJZYnwSBhpJM
	ApbOxbCPcKUVR3AVdc8bKp+K7GhFqhJP9Fed1QXBp048S6mOS+u/4muBP/PwwpAkwQXFwtL4CSg
	s2bMkk8ls3DxtJnKqiF4pXybQWIE2moI5g7OuYwK9
X-Gm-Gg: ASbGncs6HcdXOHBSFn6Q3xY606yWfNiUgfiQU8kdsAEobjit17ZYfIn93QuISc5gD5Q
	FQyscB3CHnEiIPst+MmTp559bEZMg6ynU2jIe+RuBLH0KQkn62xPiLqbgGiDbLpffDJJFPJZeK+
	RjeXzdOpAW3kUK0xCR2QvLFOpIcGzsNGUsH0CfexhkRZPIHn0hU/NjGt8z91N6K9edNt1Xl6oQ4
	YZG6Kd65VvqrWYz0SJLCqNu2inUvVyf3q9P8JrXUlmY2gJj8n2Sb6PJoLukRBQtzqouggL1sDbD
	7TcMUumMqBQtYXGCSHZbi7ixHScKr9q0MRi29g==
X-Google-Smtp-Source: AGHT+IEYKuthTgYcF0297/p1usIVRs9VHHqDLouBHoMJM+52yETF0m4V1pQX/pgjYf7S6mkSTvMr6AhBtPfm5LrpdY4=
X-Received: by 2002:ac8:5d14:0:b0:4ed:18ef:4060 with SMTP id
 d75a77b69052e-4ee60ecb032mr9204001cf.8.1763983222323; Mon, 24 Nov 2025
 03:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 24 Nov 2025 16:50:09 +0530
X-Gm-Features: AWmQ_bkS8Oy3tUmymE_QhiSNQ5Y7Ypy-hqW4oeVZiO9msJvv2pmz8CJ_FYdEbqk
Message-ID: <CAJHc60zkNOrWtzEPr00a6=fHpcW1KmGRu7Txcohe=LHnS6OL_Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] vfio: selftests: Support for multi-device tests
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:44=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> This series adds support for tests that use multiple devices, and adds
> one new test, vfio_pci_device_init_perf_test, which measures parallel
> device initialization time to demonstrate the improvement from commit
> e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
>
> This series also breaks apart the monolithic vfio_util.h and
> vfio_pci_device.c into separate files, to account for all the new code.
> This required quite a bit of code motion so the diffstat looks large.
> The final layout is more granular and provides a better separation of
> the IOMMU code from the device code.
>
> Final layout:
>
>   C files:
>     - tools/testing/selftests/vfio/lib/libvfio.c
>     - tools/testing/selftests/vfio/lib/iommu.c
>     - tools/testing/selftests/vfio/lib/iova_allocator.c
>     - tools/testing/selftests/vfio/lib/vfio_pci_device.c
>     - tools/testing/selftests/vfio/lib/vfio_pci_driver.c
>
>   H files:
>    - tools/testing/selftests/vfio/lib/include/libvfio.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/assert.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
>
> Notably, vfio_util.h is now gone and replaced with libvfio.h.
>
> This series is based on vfio/next plus Alex Mastro's series to add the
> IOVA allocator [1]. It should apply cleanly to vfio/next once Alex's
> series is merged by Linus into the next 6.18 rc and then merged into
> vfio/next.
>
> This series can be found on GitHub:
>
>   https://github.com/dmatlack/linux/tree/vfio/selftests/init_perf_test/v3
>
> [1] https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb=
.com/
>
> Cc: Alex Mastro <amastro@fb.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Josh Hilke <jrhilke@google.com>
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
>
> v3:
>  - Replace literal with NSEC_PER_SEC (Alex Mastro)
>  - Fix Makefile accumulate vs. assignment (Alex Mastro)
>
> v2: https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.c=
om/
>
> v1: https://lore.kernel.org/kvm/20251008232531.1152035-1-dmatlack@google.=
com/
>
> David Matlack (18):
>   vfio: selftests: Move run.sh into scripts directory
>   vfio: selftests: Split run.sh into separate scripts
>   vfio: selftests: Allow passing multiple BDFs on the command line
>   vfio: selftests: Rename struct vfio_iommu_mode to iommu_mode
>   vfio: selftests: Introduce struct iommu
>   vfio: selftests: Support multiple devices in the same
>     container/iommufd
>   vfio: selftests: Eliminate overly chatty logging
>   vfio: selftests: Prefix logs with device BDF where relevant
>   vfio: selftests: Upgrade driver logging to dev_err()
>   vfio: selftests: Rename struct vfio_dma_region to dma_region
>   vfio: selftests: Move IOMMU library code into iommu.c
>   vfio: selftests: Move IOVA allocator into iova_allocator.c
>   vfio: selftests: Stop passing device for IOMMU operations
>   vfio: selftests: Rename vfio_util.h to libvfio.h
>   vfio: selftests: Move vfio_selftests_*() helpers into libvfio.c
>   vfio: selftests: Split libvfio.h into separate header files
>   vfio: selftests: Eliminate INVALID_IOVA
>   vfio: selftests: Add vfio_pci_device_init_perf_test
>
>  tools/testing/selftests/vfio/Makefile         |  10 +-
>  .../selftests/vfio/lib/drivers/dsa/dsa.c      |  36 +-
>  .../selftests/vfio/lib/drivers/ioat/ioat.c    |  18 +-
>  .../selftests/vfio/lib/include/libvfio.h      |  26 +
>  .../vfio/lib/include/libvfio/assert.h         |  54 ++
>  .../vfio/lib/include/libvfio/iommu.h          |  76 +++
>  .../vfio/lib/include/libvfio/iova_allocator.h |  23 +
>  .../lib/include/libvfio/vfio_pci_device.h     | 125 ++++
>  .../lib/include/libvfio/vfio_pci_driver.h     |  97 +++
>  .../selftests/vfio/lib/include/vfio_util.h    | 331 -----------
>  tools/testing/selftests/vfio/lib/iommu.c      | 465 +++++++++++++++
>  .../selftests/vfio/lib/iova_allocator.c       |  94 +++
>  tools/testing/selftests/vfio/lib/libvfio.c    |  78 +++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   5 +-
>  .../selftests/vfio/lib/vfio_pci_device.c      | 555 +-----------------
>  .../selftests/vfio/lib/vfio_pci_driver.c      |  16 +-
>  tools/testing/selftests/vfio/run.sh           | 109 ----
>  .../testing/selftests/vfio/scripts/cleanup.sh |  41 ++
>  tools/testing/selftests/vfio/scripts/lib.sh   |  42 ++
>  tools/testing/selftests/vfio/scripts/run.sh   |  16 +
>  tools/testing/selftests/vfio/scripts/setup.sh |  48 ++
>  .../selftests/vfio/vfio_dma_mapping_test.c    |  46 +-
>  .../selftests/vfio/vfio_iommufd_setup_test.c  |   2 +-
>  .../vfio/vfio_pci_device_init_perf_test.c     | 168 ++++++
>  .../selftests/vfio/vfio_pci_device_test.c     |  12 +-
>  .../selftests/vfio/vfio_pci_driver_test.c     |  51 +-
>  26 files changed, 1481 insertions(+), 1063 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio.h
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/asse=
rt.h
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iomm=
u.h
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iova=
_allocator.h
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio=
_pci_device.h
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio=
_pci_driver.h
>  delete mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
>  create mode 100644 tools/testing/selftests/vfio/lib/iommu.c
>  create mode 100644 tools/testing/selftests/vfio/lib/iova_allocator.c
>  create mode 100644 tools/testing/selftests/vfio/lib/libvfio.c
>  delete mode 100755 tools/testing/selftests/vfio/run.sh
>  create mode 100755 tools/testing/selftests/vfio/scripts/cleanup.sh
>  create mode 100755 tools/testing/selftests/vfio/scripts/lib.sh
>  create mode 100755 tools/testing/selftests/vfio/scripts/run.sh
>  create mode 100755 tools/testing/selftests/vfio/scripts/setup.sh
>  create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_init_per=
f_test.c
>
>
> base-commit: fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7
> prerequisite-patch-id: dcf23dcc1198960bda3102eefaa21df60b2e4c54
> prerequisite-patch-id: e32e56d5bf7b6c7dd40d737aa3521560407e00f5
> prerequisite-patch-id: 4f79a41bf10a4c025ba5f433551b46035aa15878
> prerequisite-patch-id: f903a45f0c32319138cd93a007646ab89132b18c
> --
> 2.52.0.rc2.455.g230fcf2819-goog
>
Apart from a couple of minor nits in patch-6:
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

