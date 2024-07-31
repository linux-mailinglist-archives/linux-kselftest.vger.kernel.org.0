Return-Path: <linux-kselftest+bounces-14573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B270C94365E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9B81C21C53
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AF140366;
	Wed, 31 Jul 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qptgQ/oR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49C219FF;
	Wed, 31 Jul 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453880; cv=none; b=hbPVedevfmgrgEFyskoE0Nznc6x7154QDluc+ukJXb+SDTsJ0V/ObkICoHiGJUU+12gG/CLS44ggZZMJIMM3IE7+qxeovX1Vpj0CYFczH9tUrq8wA363vh5vBPJJCMQvd5nxeOyRNFnwl2pspBWH89v+EuD4ib7jxOSU9K+lRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453880; c=relaxed/simple;
	bh=xJcYHFAV6fd0/f7i19pUzRNKY45o0cGNlETGkISQBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UzU82R9+jIqdim3k59p7KXBqVGwoiFQ0fy/YStu58/rKvsh/N1qTHGhSwHkMJQfcAnSe2LDp0eI3izd1tgvTWzGuPELIrzvxJ4TSqv34z4VlxMgElmyK5FvosIzgQkkDOq+APcU0jb4qEsoqHOpjmOeYebgM5ohtzxxsu5HGAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qptgQ/oR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753DC116B1;
	Wed, 31 Jul 2024 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453879;
	bh=xJcYHFAV6fd0/f7i19pUzRNKY45o0cGNlETGkISQBdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qptgQ/oRY3DOV92eDsBfXPhe7VkWMxBBglAeqdsS9k8s5Qp3rofN9NttRIztmVQRY
	 aErHHAgWEQ/BlqS+JeDi55hcMYR9+JBcaz/v1DiMkOOCbvzdNuMgNlmmR4NbU6CWaL
	 yQfTq8+hj353uKoX4/+gkl+h16E5TN71GKQJ2Rzr3pgIVyrO+aanm5ncasi7628LWo
	 7QZ9SodTGk8zmSRyGuA86JlEAcNZ428LlPXu7HU9hGAfL6XX9JhKJ8xk/4riv000s/
	 FnaZxdp96T2yZdYnmIFB88sweOWaA8UbJPln2Lo6AyIMGpPUL5UzS7XDEmumddAl4V
	 j6gdmYpM499ng==
Date: Wed, 31 Jul 2024 14:24:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] selftest: drivers: Add support its msi hwirq checking
Message-ID: <20240731192436.GA76176@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530012727.324611-2-jjang@nvidia.com>

[+cc Thomas]

On Wed, May 29, 2024 at 06:27:27PM -0700, Joseph Jang wrote:
> Validate there are no duplicate ITS-MSI hwirqs from the
> /sys/kernel/irq/*/hwirq.
> 
> One example log show 2 duplicated MSI entries in the /proc/interrupts.
> 
> 150: 0 ... ITS-MSI 3355443200 Edge      pciehp
> 152: 0 ... ITS-MSI 3355443200 Edge      pciehp

I don't know how ITS-MSI works, so I don't know whether it's an error
that both entries mention 3355443200.

3355443200 == 0xc8000000, which looks like it could be an address or
address/data pair or something, and it does make sense to me that if
two devices write the same MSI address/data, it should result in the
same IRQ.

It seems like maybe this is a generic issue, i.e., if this is a
problem, maybe it would affect *other* kinds of MSI too, not just
ITS-MSI?

> Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
> [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/
> 
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> ---
>  tools/testing/selftests/drivers/irq/Makefile  |  5 +++++
>  .../selftests/drivers/irq/its-msi-irq-test.sh | 20 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>  create mode 100755 tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
> 
> diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
> new file mode 100644
> index 000000000000..569df5de22ee
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS := its-msi-irq-test.sh
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh b/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
> new file mode 100755
> index 000000000000..87c88674903f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
> @@ -0,0 +1,20 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if [ -z "$(grep "ITS-MSI" /proc/interrupts)" ]; then
> +	echo "SKIP: no ITS-MSI irq."
> +	exit 4
> +fi
> +
> +# Get ITS-MSI hwirq list from /sys/kernel/irq/*/hwirq.
> +its_msi_irq_list=$(grep "ITS-MSI" /sys/kernel/irq/*/chip_name |

Is there a limit on the size of the "*" expansion here?

> +				   awk -F ':' '{print $1}' |
> +				   xargs -I {} sh -c 'cat $(dirname {})/hwirq' | sort -V)
> +
> +# Check whether could find duplicated its-msi hwirq or not.
> +if [ -n "$(echo "$its_msi_irq_list" | uniq -cd)" ]; then
> +	echo "ERROR: find duplicated its-msi hwirq."
> +	exit 1
> +fi
> +
> +exit 0
> -- 
> 2.34.1
> 

