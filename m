Return-Path: <linux-kselftest+bounces-31070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A8A922E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05243188668B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CA254B04;
	Thu, 17 Apr 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4LNlipi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3035973;
	Thu, 17 Apr 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908139; cv=none; b=Uzl19JD61WLu1iZ5aidbnI9OXBvsYQGCVfLqescDyLC7VmtNDH0ObxB7oj1aiET3dIlrNHtNn7R61PaaUqgSfTFGvKpQs9GgWvZe8orAQwbWXmXlYwse5ED05+gdZY8whcQ1Ur7hb6rmdgtyu6edo4SfHka7WnI+vUzgz3Huwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908139; c=relaxed/simple;
	bh=9Z7zBFITen5PF+y8xcxXkcjNm2Fxh2599HAlAnQpbdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lFwFQOM3Gsad8mWEYCyAPgIKPcudkJzemMmofI25MOoYXSmdGNl81/k3mJjEw447hCBHv/tk0MA1cJRWX8px8qV3lm9zggkcv1sMaM3AcMfWX4hw0MwbA6LICl4VLneSOTDlBha4UnUO6ThdgSJf7Uy7MG2DfEQgQx/meUCdrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4LNlipi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792AC4CEE4;
	Thu, 17 Apr 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744908138;
	bh=9Z7zBFITen5PF+y8xcxXkcjNm2Fxh2599HAlAnQpbdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b4LNlipiHMvrWTAjLoHe+ZwMoIeK2hjXpW23gk4aIrdi/420f1KjZFYcMbrCsxsYA
	 NbizB1LwKEPz7s1osOFZogR2ovTj02RQBC1VhE+Z5u8A3jntOBYK8auHEmqk2fLrcD
	 zP0JTHvRL9CILuHpJb1h6E4kDv2D8I7XSqSoNtov3mtMriQht3xUFEd7lJ4Jkirblw
	 +MzdZRPREZcem9JGuLXoKYCwqtLAUt/WDzJ6KdDYnVUBbOa1QLujt669Gw0ea/fkCO
	 Y1pBv7Y77WZQ3mU+df3USCgk3DneWDn7cmZ4DaFfyCT2WV397zrdGUICKq/TGsgRXg
	 SHGc0Od+wJ/rQ==
Date: Thu, 17 Apr 2025 11:42:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/pcie_bwctrl: Fix test progs list
Message-ID: <20250417164217.GA114940@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417124529.11391-1-ilpo.jarvinen@linux.intel.com>

On Thu, Apr 17, 2025 at 03:45:29PM +0300, Ilpo Järvinen wrote:
> The commit df6f8c4d72ae ("selftests/pcie_bwctrl: Add
> 'set_pcie_speed.sh' to TEST_PROGS") added set_pcie_speed.sh into
> TEST_PROGS but that script is a helper that is only being called by
> set_pcie_cooling_state.sh, not a test case itself. When
> set_pcie_speed.sh is in TEST_PROGS, selftest harness will execute also
> it leading to bwctrl selftest errors:
> 
>   # selftests: pcie_bwctrl: set_pcie_speed.sh
>   # cat: /cur_state: No such file or directory
>   not ok 2 selftests: pcie_bwctrl: set_pcie_speed.sh # exit=1
> 
> Place set_pcie_speed.sh into TEST_FILES instead to have it included
> into installed test files but not execute it from the test harness.
> 
> Fixes: df6f8c4d72ae ("selftests/pcie_bwctrl: Add 'set_pcie_speed.sh' to TEST_PROGS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/for-linus for v6.15, thanks, Ilpo!

> ---
> 
> I'm sorry I didn't realize this while the fix was submitted, I'm not that
> familiar with all the kselftest harness variables and the justification
> given for the fix sounded valid enough to raise any alarm bells in my
> mind that something would be off with the approach the fix patch used.
> 
>  tools/testing/selftests/pcie_bwctrl/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pcie_bwctrl/Makefile b/tools/testing/selftests/pcie_bwctrl/Makefile
> index 48ec048f47af..277f92f9d753 100644
> --- a/tools/testing/selftests/pcie_bwctrl/Makefile
> +++ b/tools/testing/selftests/pcie_bwctrl/Makefile
> @@ -1,2 +1,3 @@
> -TEST_PROGS = set_pcie_cooling_state.sh set_pcie_speed.sh
> +TEST_PROGS = set_pcie_cooling_state.sh
> +TEST_FILES = set_pcie_speed.sh
>  include ../lib.mk
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.39.5
> 

