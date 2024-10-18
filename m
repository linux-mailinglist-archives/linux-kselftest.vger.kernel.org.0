Return-Path: <linux-kselftest+bounces-20170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B59A4708
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 21:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3573D285D0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC2204939;
	Fri, 18 Oct 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDj8XJFC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C0757F3;
	Fri, 18 Oct 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280054; cv=none; b=KsJkjKvrogWN82dJhZDBhdaKR6vBvlwBPzTwgr2Q5T33Y1NN1/m5qr1gS2BaDRNlpjQKK706KH9td7CY4NwiOzsoqyU1D4DOCnV6JQ71FfEJDqj71IOg84aM5VSI5wzwDIHWVA7VmpOJk4UbSIHPinrmYOvVCh9p8kk+Q8TtaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280054; c=relaxed/simple;
	bh=PA0c7dC1ikcGJw/dBRDgPk7KxYeY0mCH5fO+eV2W+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X0rj92QTikiPs9RtozSaTcA2ROec/PNF31ihu1G4efo+9iVXHZUGB93HmJteXneM/kxTDEy3Xog4VDoO+8C12z63NStQe5cdxpHeu0bxN1llOR7e6d0gS/RUxKmE/W8PnnXmLDYIUdDhdPDExR4SpKZBdMFYDXecV/zBt5MoYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDj8XJFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49604C4CEC3;
	Fri, 18 Oct 2024 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729280053;
	bh=PA0c7dC1ikcGJw/dBRDgPk7KxYeY0mCH5fO+eV2W+Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vDj8XJFCc8hIXbVAKXDrjmZA2OdooYyLo6C5Bmap1gc7nq/Zr4H5bI2KEJJRD0wr/
	 7wvhsTXSrrYY3e9W2zPl88EYBq5Fi/73q0O9CO2n5zGgW92u2d3Mv/3ul8SeoWCQj3
	 CEi524wYbKRWxqYqfxOJz4mOanOCfxe4gAaIqVP3itTinovQVNtkuOrnXG8G01Arfv
	 DXrsO2Ng3thvlok1ifhOQwKZGnfJMswdhk+rPqwunk5nnAV2caTeEZBQHERUTIBi6z
	 j5JVauzmUKEbz/2YE1UzlcpLGM6ON7sRvLYywTwAvJV9uLjJWha/EpHOOThnl07mQh
	 TvcepjAhmQjZg==
Date: Fri, 18 Oct 2024 14:34:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, tglx@linutronix.de, mochs@nvidia.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
Message-ID: <20241018193411.GA758389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904014426.3404397-1-jjang@nvidia.com>

On Tue, Sep 03, 2024 at 06:44:26PM -0700, Joseph Jang wrote:
> Validate there are no duplicate hwirq from the irq debug
> file system /sys/kernel/debug/irq/irqs/* per chip name.
> 
> One example log show 2 duplicated hwirq in the irq debug
> file system.
> 
> $ sudo cat /sys/kernel/debug/irq/irqs/163
> handler:  handle_fasteoi_irq
> device:   0019:00:00.0
>      <SNIP>
> node:     1
> affinity: 72-143
> effectiv: 76
> domain:  irqchip@0x0000100022040000-3
>  hwirq:   0xc8000000
>  chip:    ITS-MSI
>   flags:   0x20
> 
> $ sudo cat /sys/kernel/debug/irq/irqs/174
> handler:  handle_fasteoi_irq
> device:   0039:00:00.0
>     <SNIP>
> node:     3
> affinity: 216-287
> effectiv: 221
> domain:  irqchip@0x0000300022040000-3
>  hwirq:   0xc8000000
>  chip:    ITS-MSI
>   flags:   0x20
> 
> The irq-check.sh can help to collect hwirq and chip name from
> /sys/kernel/debug/irq/irqs/* and print error log when find duplicate
> hwirq per chip name.
> 
> Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
> [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/

I don't know enough about this issue to understand the details.  It
seems like you look for duplicate hwirqs in chips with the same name,
e.g., "ITS-MSI" in this case?  That name seems too generic to me
(might there be several instances of "ITS-MSI" in a system?)

Also, the name may come from chip->irq_print_chip(), so it apparently
relies on irqchip drivers to make the names unique if there are
multiple instances?

I would have expected looking for duplicates inside something more
specific, like "irqchip@0x0000300022040000-3".  But again, I don't
know enough about the problem to speak confidently here.

Cosmetic nits:

  - Tweak subject to match history (use "git log --oneline
    tools/testing/selftests/drivers/" to see it), e.g.,

      selftests: irq: Add check for duplicate hwirq

  - Rewrap commit log to fill 75 columns.  No point in using shorter
    lines.

  - Indent the "$ sudu cat ..." block by a couple spaces since it's
    effectively a quotation, not part of the main text body.

  - Possibly include sample output of irq-check.sh (also indented as a
    quote) when run on the system where you manually found the
    duplicate via "sudo cat /sys/kernel/debug/irq/irqs/..."

  - Reword "The irq-check.sh can help ..." to something like this:

      Add an irq-check.sh test to report errors when there are
      duplicate hwirqs per chip name.

  - Since the kernel patch has already been merged, cite it like this
    instead of using the https://lore URL:

      db744ddd59be ("PCI/MSI: Prevent MSI hardware interrupt number truncation")

> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
>  tools/testing/selftests/drivers/irq/Makefile  |  5 +++
>  tools/testing/selftests/drivers/irq/config    |  2 +
>  .../selftests/drivers/irq/irq-check.sh        | 39 +++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>  create mode 100644 tools/testing/selftests/drivers/irq/config
>  create mode 100755 tools/testing/selftests/drivers/irq/irq-check.sh
> 
> diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
> new file mode 100644
> index 000000000000..d6998017c861
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS := irq-check.sh
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/irq/config b/tools/testing/selftests/drivers/irq/config
> new file mode 100644
> index 000000000000..a53d3b713728
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/config
> @@ -0,0 +1,2 @@
> +CONFIG_GENERIC_IRQ_DEBUGFS=y
> +CONFIG_GENERIC_IRQ_INJECTION=y
> diff --git a/tools/testing/selftests/drivers/irq/irq-check.sh b/tools/testing/selftests/drivers/irq/irq-check.sh
> new file mode 100755
> index 000000000000..e784777043a1
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/irq-check.sh
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This script need root permission
> +uid=$(id -u)
> +if [ $uid -ne 0 ]; then
> +	echo "SKIP: Must be run as root"
> +	exit 4
> +fi
> +
> +# Ensure debugfs is mounted
> +mount -t debugfs nodev /sys/kernel/debug 2>/dev/null
> +if [ ! -d "/sys/kernel/debug/irq/irqs" ]; then
> +	echo "SKIP: irq debugfs not found"
> +	exit 4
> +fi
> +
> +# Traverse the irq debug file system directory to collect chip_name and hwirq
> +hwirq_list=$(for irq_file in /sys/kernel/debug/irq/irqs/*; do
> +	# Read chip name and hwirq from the irq_file
> +	chip_name=$(cat "$irq_file" | grep -m 1 'chip:' | awk '{print $2}')
> +	hwirq=$(cat "$irq_file" | grep -m 1 'hwirq:' | awk '{print $2}' )
> +
> +	if [ -z "$chip_name" ] || [ -z "$hwirq" ]; then
> +		continue
> +	fi
> +
> +	echo "$chip_name $hwirq"
> +done)
> +
> +dup_hwirq_list=$(echo "$hwirq_list" | sort | uniq -cd)
> +
> +if [ -n "$dup_hwirq_list" ]; then
> +	echo "ERROR: Found duplicate hwirq"
> +	echo "$dup_hwirq_list"
> +	exit 1
> +fi
> +
> +exit 0
> -- 
> 2.34.1
> 

